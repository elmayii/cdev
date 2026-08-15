---
name: cdev-backend
description: Úsala para ejecutar de forma autónoma el trabajo pendiente de un repo backend condicionado para CDev (tiene docs/develop/ con SPRINTS.md y AGENT_EXECUTION_PROTOCOL.md) — cuando el usuario pida correr el sprint activo, "sigue el plan", trabajo nocturno/desatendido, o invoque /cdev-backend o /cdev en un backend.
---

# CDev Backend — bucle autónomo

Bucle de ejecución continua para backends condicionados (reemplaza al watchdog
`claude-night-runner.ps1` como forma primaria de correr CDev). Invocarla es el mandato de
**autonomía elevada**: trabaja proactivamente asumiendo lo que el proyecto necesita y para
**solo ante bloqueos reales** — nunca para preguntar qué hacer a continuación.

El repo es la memoria: `SPRINTS.md` = plan · `AGENT_PROGRESS.md` = handoff · git = estado.
Los detalles específicos del repo (verificación exacta, patrones, gates propios) los fija su
`docs/develop/AGENT_EXECUTION_PROTOCOL.md`; este skill es el sistema operativo genérico y el
umbral de autonomía. Si el protocolo del repo es más estricto en *cuándo parar a preguntar*,
esta invocación explícita lo eleva; en gates de seguridad gana siempre el más estricto.

## Arranque (cada invocación/reanudación)

Lee en orden: `CLAUDE.md` → `docs/develop/AGENT_EXECUTION_PROTOCOL.md` → `SPRINTS.md` →
`AGENT_PROGRESS.md` (última entrada) → `git status` + últimos commits. Reanuda desde ahí; no
re-derives lo ya decidido.

## Bucle (repetir hasta bloqueo real)

1. **Selecciona trabajo:** primer batch `READY`/`IN_PROGRESS` del sprint `ACTIVE`, en orden
   estricto. Márcalo `IN_PROGRESS`. Rama de trabajo `cdev/sprint-<n>-batch-<n>` (nunca
   `main`/`develop`).
2. **Implementa solo ese batch.** `ponytail:ponytail` en cada paso (reutilizar antes que crear,
   diff mínimo correcto). `superpowers:test-driven-development` en lógica de dominio (state
   machines, billing, autorización). Aditivo siempre: no romper contratos vivos.
3. **Verifica** con la secuencia del repo (típico `npm run lint` → `build` → `test`). Schema
   tocado → `prisma format` + `generate`; el apply a DB remota es gate humano (blocker, no lo
   corras). Evidencia runtime = tests, no servers largos.
4. **Si algo falla:** `superpowers:systematic-debugging` — error exacto citado, grep de callers,
   causa raíz una vez donde todos enrutan, superficie mínima, re-correr el comando fallido y
   luego la secuencia completa. Nunca silenciar tests ni tapar tipos con `any` para pasar.
5. **Registra** en `AGENT_PROGRESS.md`: status honesto, hecho, ficheros, verificación
   pass/fail/not-run, blockers concretos, siguiente. No exagerar; incompleto nunca es `DONE`.
6. **Commitea el batch completo** (`feat(<fase>-sprint-<n>): ...`; inacabado útil → `wip(...)`).
7. **Cierra:** batch `DONE` solo con acceptance cumplida con evidencia
   (`superpowers:verification-before-completion`). Siguiente batch.

## Auto-avance (el umbral elevado)

- **Sprint completo** → escribe y commitea el reporte de integración del sprint (obligatorio
  antes del `DONE`), marca el sprint `DONE`, promueve el siguiente `PENDING` a `ACTIVE`, sigue.
- **Batch bloqueado (no-cuota)** → márcalo `BLOCKED` con razón + decisión mínima que necesita el
  humano, y aplica *blocked-but-not-idle*: siguiente batch con dependencias `DONE`; si no hay,
  siguiente sprint independiente de la fase.
- **Fase completa** → márcala `DONE` y **no te quedes parado**: deriva el siguiente trabajo tú
  mismo, en este orden, dentro del mapa de claridad del repo (`PRODUCT.md`; solo áreas
  DEFINIDO/PARCIAL):
  1. Backlog documentado del repo (backlog de plataforma en CLAUDE.md, ROADMAP, TODOs de docs).
  2. Backfill de tests en lógica crítica sin cobertura.
  3. Hardening/observabilidad ya prevista (health, métricas, rate limit) de forma aditiva.
  4. **Borrador de la fase siguiente** en `SPRINTS.md` como `PROPOSAL` (no `ACTIVE`): derivado de
     las fuentes de producto, listado para ratificación humana — y mientras tanto sigue con 1–3.
  Registra en `AGENT_PROGRESS.md` qué autoelegiste y por qué.

## Solo se para cuando

- Ningún trabajo no-gateado queda (ni batch, ni backlog, ni backfill) — di exactamente qué
  aprobaciones desbloquearían qué.
- Un gate de seguridad exige acción humana y todo lo demás depende de él.
- Docs contradictorios o área `AUSENTE` sin la cual no se puede seguir (pregunta abierta
  registrada; inventar producto está prohibido).
- Repo en estado inseguro.
- Límite de uso/cuota: guarda todo, actualiza `AGENT_PROGRESS.md`, commitea lo seguro
  (`wip` si hace falta), sal limpio. La reanudación (watchdog o próxima invocación) retoma del
  repo, no de la memoria conversacional.

## Gates de seguridad (nunca elevados por este skill)

Apply de schema a DB remota (`prisma db push`/`migrate deploy`) · push a `main`/`develop` ·
deploy · DDL/ops destructivas (DROP, borrado de datos) · secretos o tokens live de proveedores ·
reescribir historial git. Prepararlos sí (draft + blocker pidiendo aprobación); ejecutarlos no.
