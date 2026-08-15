---
name: cdev-frontend
description: Úsala para ejecutar de forma autónoma el trabajo pendiente de un repo frontend condicionado para CDev (tiene docs/develop/ con SPRINTS.md y AGENT_EXECUTION_PROTOCOL.md) — cuando el usuario pida correr el sprint activo, "sigue el plan", trabajo nocturno/desatendido, o invoque /cdev-frontend o /cdev en un frontend.
---

# CDev Frontend — bucle autónomo

Bucle de ejecución continua para frontends condicionados (reemplaza al watchdog
`claude-night-runner.ps1` como forma primaria de correr CDev). Invocarla es el mandato de
**autonomía elevada**: trabaja proactivamente asumiendo lo que el proyecto necesita y para
**solo ante bloqueos reales** — nunca para preguntar qué hacer a continuación.

El repo es la memoria: `SPRINTS.md` = plan · `AGENT_PROGRESS.md` = handoff · git = estado.
Los detalles específicos del repo (comandos exactos, convención de port, gates propios) los fija
su `docs/develop/AGENT_EXECUTION_PROTOCOL.md` + `CLAUDE.md`; este skill es el sistema operativo
genérico y el umbral de autonomía. Si el protocolo del repo es más estricto en *cuándo parar a
preguntar*, esta invocación explícita lo eleva; en gates de seguridad gana siempre el más estricto.

## Arranque (cada invocación/reanudación)

Lee en orden: `CLAUDE.md` → `docs/develop/AGENT_EXECUTION_PROTOCOL.md` → `SPRINTS.md` →
`AGENT_PROGRESS.md` (última entrada) → `git status` + últimos commits. Si el repo define un
contrato/reporte de backend por sprint (p.ej. `docs/F6/reports/` en Compiss), léelo **antes** de
empezar el sprint: es el contrato; no inventes campos, y si difiere de lo desplegado en el backend
dev, regístralo como bloqueo/decisión. Reanuda desde ahí; no re-derives lo ya decidido.
Si git muestra trabajo real no registrado en el plan (commits/WIP sin sprint ni entrada de
progreso), **reconcilia primero**: refléjalo en `SPRINTS.md` + `AGENT_PROGRESS.md` antes de
seguir — el repo-como-memoria no funciona con el plan desincronizado.

## Bucle (repetir hasta bloqueo real)

1. **Selecciona trabajo:** primer batch `READY`/`IN_PROGRESS` del sprint `ACTIVE`, en orden
   estricto. Márcalo `IN_PROGRESS`. Rama según convención del repo (p.ej. `claude/f6-sprint-<n>`,
   creada **desde la rama actual**; al cambiar de sprint, nueva rama desde la entonces actual).
   Nunca `main`/`develop`.
2. **Implementa solo ese batch, target principal primero** (web-first si hay varios targets);
   el port al target secundario sigue la convención del repo (misma ruta relativa, sin imports del
   framework web en el port). `ponytail:ponytail` en cada paso: reutiliza UI kit, stores, hooks y
   queries existentes antes de escribir; sin deps nuevas; diff mínimo correcto.
3. **Verifica antes de cada DONE:**
   - **Gate de tipos real** — el comando que documenta el repo. Ojo: un typecheck sin el tsconfig
     correcto o un build con `ignoreBuildErrors` **no** son gate de tipos.
   - **Build de cada target.**
   - **Evidencia runtime OBLIGATORIA** — prueba el flujo tocado en el dev server con las
     dependencias arriba (backend dev, cuentas de prueba) vía Playwright MCP. "Compila" no es
     evidencia. Sin Playwright MCP o backend caído y nada más trabajable → batch `BLOCKED`, no `DONE`.
   - `git diff` sin cambios ajenos al batch; paridad entre targets si tocaste código compartido.
4. **Si algo falla:** `superpowers:systematic-debugging` — error exacto citado, grep de callers,
   causa raíz una vez donde todos enrutan, superficie mínima, re-correr el comando fallido y luego
   la secuencia completa. Nunca silenciar checks ni tapar tipos con `any` para pasar.
5. **Registra** en `AGENT_PROGRESS.md` (lo más reciente arriba): status honesto, hecho, ficheros
   (target principal + homólogos del port), verificación pass/fail/not-run por comando, blockers
   concretos, siguiente. No exagerar; incompleto nunca es `DONE`.
6. **Commitea el batch completo** (`feat(<fase>-sprint-<n>): ...`; inacabado útil → `wip(...)`).
   Nunca push.
7. **Cierra:** batch `DONE` solo con acceptance cumplida con evidencia
   (`superpowers:verification-before-completion`). Siguiente batch.

## Auto-avance (el umbral elevado)

- **Sprint completo** → márcalo `DONE`, promueve el siguiente `PENDING` a `ACTIVE` (nueva rama
  desde la actual), lee su reporte/contrato backend si existe, sigue.
- **Batch bloqueado (no-cuota)** → márcalo `BLOCKED` con razón + decisión mínima que necesita el
  humano, y aplica *blocked-but-not-idle*: siguiente batch con dependencias `DONE`; si no hay,
  siguiente sprint independiente del bloqueo.
- **Plan agotado** → márcalo y **no te quedes parado**: deriva el siguiente trabajo tú mismo, en
  este orden, dentro del mapa de claridad del repo (`PRODUCT.md`; solo áreas DEFINIDO/PARCIAL —
  si el repo aún no tiene mapa, aproxima: definido = doc fuente + contrato backend existentes, y
  déjalo anotado en `DECISIONS.md`; generar el mapa real es trabajo de `bootstrap-frontend`):
  1. Backlog documentado (docs fuente con alcance aún no implementado — verifícalo en código, no
     lo asumas; TODOs de docs, ROADMAP).
  2. Brechas de paridad/port entre targets documentadas (p.ej. audit web↔mobile).
  3. Deuda marcada (`ponytail:`/TODO dentro de scope) y gaps de verificación (flujos sin
     evidencia runtime, gates rotos).
  4. **Borrador de la fase siguiente** en `SPRINTS.md` como `PROPOSAL` (no `ACTIVE`): derivado de
     las fuentes de producto, listo para ratificación humana — y mientras tanto sigue con 1–3.
  Registra en `AGENT_PROGRESS.md` y `DECISIONS.md` qué autoelegiste y por qué.

## Solo se para cuando

- Ningún trabajo no-gateado queda (ni batch, ni backlog, ni paridad, ni deuda) — di exactamente
  qué aprobaciones desbloquearían qué.
- Un gate de seguridad exige acción humana y todo lo demás depende de él.
- Docs contradictorios o área `AUSENTE` sin la cual no se puede seguir (pregunta abierta
  registrada; inventar producto está prohibido).
- Repo en estado inseguro.
- Límite de uso/cuota: guarda todo, actualiza `AGENT_PROGRESS.md`, commitea lo seguro
  (`wip` si hace falta), sal limpio. La reanudación (próxima invocación o watchdog) retoma del
  repo, no de la memoria conversacional.

## Gates de seguridad (nunca elevados por este skill)

Tocar backend, esquema GraphQL o migraciones (se coordinan fuera del repo) · push a
`main`/`develop` · abrir PR · deploy (hosting/stores) · subir pins de versión documentados como
gate en el `CLAUDE.md` del repo (p.ej. Apollo en Compiss) · añadir dependencias nuevas ·
operar pagos en real · romper deep/universal links · secretos o tokens live · reescribir
historial git. Prepararlos sí (draft + blocker pidiendo aprobación); ejecutarlos no.
