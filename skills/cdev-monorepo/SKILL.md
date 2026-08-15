---
name: cdev-monorepo
description: Úsala cuando el usuario invoque /cdev-monorepo (con o sin argumentos) en un workspace multi-repo condicionado (tiene workspace/repos.yaml y docs/develop/ global) — ejecuta de forma autónoma el SYSTEM_BATCH activo coordinando en paralelo los CDev locales de los repos afectados, reconcilia estados y cierra batches con verificación global.
---

# CDev Monorepo — bucle orquestador

Equivalente global de `/cdev` para un workspace multi-repo condicionado por `bootstrap-monorepo`.
Mandato de **autonomía elevada**: trabaja hasta bloqueo real, nunca para a preguntar "¿y ahora
qué?". El workspace es la memoria: `SPRINTS.md` global = plan · `AGENT_PROGRESS.md` global =
handoff · `state.lock.json` = snapshot · el estado local vive en cada repo.

Invocación: `/cdev-monorepo` (reanudar) · `/cdev-monorepo sprint 02` · `/cdev-monorepo batch SYS-02-B01`.

## Invariante que protege todo el mecanismo

```text
Trabajo global no rompe continuidad local.
Trabajo local no rompe visibilidad global.
```

Tras una sesión de workspace, `cd repo && /cdev` debe poder continuar normal. Tras trabajo
independiente en un repo, la siguiente sesión de workspace **detecta y reconcilia** ese progreso.

## Arranque + reconciliación (cada invocación)

1. Lee en orden: `CLAUDE.md` global → `docs/develop/AGENT_EXECUTION_PROTOCOL.md` → `SPRINTS.md`
   → `AGENT_PROGRESS.md` (última entrada) → `workspace/repos.yaml` → `repo-graph.yaml` →
   `state.lock.json`.
2. Para cada repo **relevante al sprint/batch activo** (no cargues repos que no participan):
   su `CLAUDE.md`, `SPRINTS.md`, `AGENT_PROGRESS.md`, `git status/branch/log`.
3. Reconcilia. **El repo es la fuente de verdad de su estado local**: sprint renumerado, batch
   terminado fuera del workspace, commits nuevos, rama distinta, bloqueo local → el workspace
   se actualiza; jamás al revés. Divergencia (workspace dice DONE, repo dice IN_PROGRESS) →
   gana el repo. El workspace nunca falsifica estado local para cuadrar su plan.

## Bucle (repetir hasta bloqueo real)

1. **Selecciona**: primer SYSTEM_BATCH `READY`/`IN_PROGRESS` del SYSTEM Sprint `ACTIVE` — y
   todos los demás cuyo DAG los haga runnables ya (ejecución por olas, no batch a batch).
   Si un batch está `PLANNED` (referencias o sync points sin resolver) → invoca la skill
   `cdev-monorepo-planner` antes de ejecutarlo.
2. **Resuelve referencias**: cada referencia local requerida existe en el `SPRINTS.md` del repo,
   con numeración válida que respeta la secuencia local y sus `Wait-for` declarados (artefactos
   de sync del planner). Referencia rota → reparar vía planner, no improvisar.
3. **Construye el DAG** del batch/ola con los `depends_on` de sus referencias (solo referencias
   del batch; repos no referenciados no aparecen). Un ciclo en el DAG = error de planificación:
   parar ese batch y reportarlo, no desempatar a ojo.
4. **Ejecuta en paralelo por repo**: despacha un agente `monorepo-repo-runner` por cada
   referencia runnable, **en paralelo solo cuando son de repos distintos**; **un único runner
   por repo, siempre**. Dos niveles de paralelismo, y solo dos:
   - **Entre repos**: referencias sin dependencia mutua corren a la vez (olas del DAG).
   - **Dentro del repo**: los batches son SIEMPRE secuenciales (el orden local es sagrado;
     jamás dos batches del mismo repo a la vez). Lo que sí se paraleliza dentro del batch son
     **tareas heterogéneas vía subagentes del cdev local**: p.ej. un subagente investigando
     read-only en el working tree del repo productor los endpoints reales, otro inventariando
     componentes reutilizables del propio repo, y el principal construyendo — que al integrar
     consume el informe del investigador, no su imaginación. Testing funcional o búsqueda en
     fuentes externas siguen el mismo patrón. La decisión de crear esos subagentes es del
     `/cdev` local; el workspace no reparte ese trabajo.
   - **Guardrail autobloqueante** (aplica a todo subagente y al principal): ningún endpoint,
     campo, tipo o estructura cross-repo se integra sin estar confirmado por artefacto
     `Wait-for`, contrato del workspace o código real leído del repo productor. Falta la
     confirmación → se espera o se rota de tarea; inventarla "para avanzar" está prohibido.
     Los subagentes investigadores en repos vecinos son **solo lectura**: escribir en otro
     repo sigue siendo gate absoluto.
   Reglas del despacho:
   - El runner ejecuta SIEMPRE **el `/cdev` propio del repo** acotado a la referencia — nunca
     implementa por su cuenta.
   - El prompt del runner incluye: referencia (sprint/batch local), `system_batch`, contrato
     aplicable, sus `Wait-for` (qué artefacto buscar, en qué path de qué repo) y la política
     de ramas (§ abajo).
   - Runner que devuelve `WAITING` (su Wait-for no existe aún): reasigna ese slot a otra
     referencia runnable de otro repo y reintenta la que espera cuando su productor cierre —
     nunca dejes el slot ocioso si hay trabajo runnable (blocked-but-not-idle también aquí).
5. **Recoge evidencia** al terminar cada runner (no esperes a toda la ola para registrar):
   status/branch/SHA/verificación por referencia → `AGENT_PROGRESS.md` global +
   `state.lock.json` + `workspace/snapshots/` si aplica.
6. **Verifica globalmente** con `monorepo-system-tester` al nivel que el batch declara
   (L0 evidencia local · L1 contratos · L2 integración parcial · L3 end-to-end). Batch de un
   solo repo con acceptance demostrable local → L0, sin pruebas cross-repo artificiales.
7. **Cierra**:
   ```text
   SYSTEM_BATCH DONE = ALL(referencias requeridas == DONE) AND acceptance global == PASS
   ```
   Repos no referenciados no participan, no bloquean, no se abren "por si acaso".
8. **Auto-avanza**: siguiente ola runnable. Sprint de sistema completo → reporte global, Sprint
   `DONE`, promueve el siguiente `PENDING`→`ACTIVE` si corresponde, sigue. Plan agotado →
   invoca `cdev-monorepo-planner` en modo gap-analysis y deja el resultado como `PROPOSAL`
   para ratificación humana; mientras tanto ejecuta trabajo global no gateado.

## Sincronización entre repos (pull, no push — y jamás mockear)

- Toda dependencia productor→consumidor se satisface con un **artefacto en disco** (reporte
  técnico del batch productor, path declarado por el planner en el `Wait-for` de la referencia
  consumidora). El productor lo publica como parte de su acceptance; el consumidor **va a
  buscarlo** al working tree del repo productor y lo lee antes de integrar.
- Consumidor sin su artefacto: **no mockea el contrato del otro repo** para avanzar ni fabrica
  evidencia de integración — devuelve `WAITING` y el orquestador lo reprograma. (Los stubs de
  tests unitarios internos del propio repo siguen siendo legítimos; lo prohibido es fingir la
  integración cross-repo.)
- La comunicación entre agentes va SIEMPRE por disco (repos + workspace), nunca por memoria
  conversacional: cualquier runner puede morir y reanudarse leyendo el repo.

## Ramas y push (política del workspace)

- **Derivación**: la primera rama de trabajo de cada repo dentro de un SYSTEM Sprint se crea
  **desde `develop`** de ese repo; los batches siguientes encadenan según la convención del
  CDev local (típico: nueva rama desde la rama del batch anterior). El workspace no redefine
  nombres de rama locales.
- **Push: nunca automático.** Al cerrar el SYSTEM Sprint, el push de las ramas resultantes lo
  hace el humano. Si el usuario pide explícitamente "sube", se pushea **solo la rama de
  trabajo** correspondiente — nunca `develop`/`main`, nunca con `--force`.
- Merge/PR/deploy: siempre gate humano.

## Blocked-but-not-idle (global)

Referencia `BLOCKED` → SYSTEM_BATCH `BLOCKED` con razón + decisión mínima que necesita el
humano. Continúa con: otra referencia independiente del mismo batch → otro SYSTEM_BATCH sin
dependencia → otro trabajo global no gateado. Nunca marcar como terminado lo bloqueado.

## Solo se para cuando

- Ningún trabajo global no gateado queda — di qué aprobaciones desbloquearían qué.
- Un gate humano bloquea y todo depende de él.
- Producto ausente: **prohibido inventar requisitos**; pregunta abierta en DECISIONS.
- Límite de cuota: actualizar `AGENT_PROGRESS.md` + `state.lock.json`, commit del workspace,
  salir limpio. La reanudación retoma del workspace, no de memoria conversacional.

## Gates de seguridad (nunca elevados; gana siempre el más estricto)

Los gates de cada repo hijo prevalecen íntegros — este skill jamás los reduce. Una decisión
histórica documentada en un repo ("vía autorizada", DECISIONS antiguos) NUNCA cuenta como
aprobación viva de un gate en la sesión actual: el gate exige autorización humana presente. Además, a nivel
workspace: push a `main`/`develop` de cualquier repo · merge · deploy · migraciones/schema
remoto · secretos live · pagos reales · reescritura de historial · borrado de datos. Preparar
sí (drafts, comandos, manifests); ejecutar no. El workspace tampoco puede: alterar numeración
local, saltarse sprints locales por prisa del sistema, marcar DONE trabajo no demostrado, ni
convertir cambio local en global sin evidencia.
