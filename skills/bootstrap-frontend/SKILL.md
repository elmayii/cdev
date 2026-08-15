---
name: bootstrap-frontend
description: Úsala cuando haya que condicionar un repo que es SOLO frontend (UI que consume backend externo) para desarrollo continuo autónomo (CDev) — repo nuevo o existente sin docs/develop/, o cuando el usuario pida "bootstrap frontend", "condicionar frontend para cdev", o verificar si un frontend está listo para que /cdev trabaje solo.
---

# Bootstrap Frontend (CDev)

Condiciona un repo frontend para ejecución autónoma con **umbral de autonomía elevado**: el
agente que luego corra `/cdev` solo parará ante bloqueos reales, nunca para preguntar "¿y ahora
qué?". Este skill tiene dos mitades obligatorias:

- **Mitad A — Estructura:** armar/verificar la maquinaria CDev adaptada a frontend.
- **Mitad B — Claridad:** auditar hasta dónde está claro *qué* hay que producir, porque el nivel
  de claridad define hasta dónde puede llegar la autonomía.

Base: reutiliza `~/.claude/skills/cdev-bootstrap/templates/*` y su `PLACEHOLDERS.md` (mismo
contrato `{{...}}`; cero `{{` sin resolver al terminar). Este skill define los **deltas frontend**
y el **perfil de autonomía** que esas plantillas no traen. Es idempotente: sobre un repo ya
condicionado actúa como auditoría (checklist de deltas abajo) y propone diffs, nunca sobrescribe
en silencio.

## Mitad A — Estructura frontend

1. **Inspecciona el repo.** Framework (Next/Vite/Astro/Expo...), gestor de paquetes, **targets**
   (¿solo web, o web + port mobile/desktop en subcarpeta?), puertos de dev server, scripts reales
   del manifest. Resuelve placeholders.
2. **Detecta el backend consumido y decláralo intocable** — el gate más importante de un frontend:
   endpoints (GraphQL/REST), cliente (Apollo/fetch/tRPC), auth (Supabase/Auth0...), env vars.
   Cambios de backend/esquema/migraciones **se coordinan fuera del repo = gate humano siempre**.
   Anota la URL del backend dev y las cuentas de prueba si existen (la verificación runtime las
   necesita). Detecta pins de versión frágiles (locks documentados tipo Apollo) y déjalos escritos
   como gate.
3. **Fija la secuencia de verificación real** — en frontend los gates engañan; verifica cada uno
   contra el repo antes de escribirlo:
   - **Gate de tipos:** el comando con el tsconfig correcto por target (un `tsc` a secas sobre un
     monorepo o un build con `ignoreBuildErrors` **no** son gate). Pruébalo.
   - **Builds por target** (web, port mobile, etc.).
   - **Evidencia runtime UI:** flujo tocado en dev server + backend dev arriba + cuentas de
     prueba, vía **Playwright MCP**. Es paso obligatorio antes de cada `DONE`. Si el Playwright
     MCP no está configurado, déjalo como requisito bloqueante escrito en el RUNBOOK, no lo omitas.
4. **Renderiza** CLAUDE.md, `docs/develop/*` (protocolo, SPRINTS, PROGRESS, ROADMAP, PRODUCT,
   ARCHITECTURE, DECISIONS, TESTING, RUNBOOK) y `.claude/agents/*` desde las plantillas.
   **Omite** `00_repo_conditioning.md.tmpl` (backend-céntrico) y las plantillas de
   `.claude/skills/*`. Las plantillas base son genéricas/backend: no basta rellenar
   placeholders — reescribe lo que choque con el rol (reglas de dominio con DB/state-machines,
   la nota que prefiere tests a dev server, trailer/modelo hardcodeado desactualizado) según
   estos deltas frontend:
   - **Rol en CLAUDE.md:** ingeniero frontend senior con autonomía; consume backend externo, no lo
     construye.
   - **Target principal primero** (web-first si hay varios): implementar y validar en el
     principal, luego portar según **convención de port** explícita (misma ruta relativa; sin
     imports del framework web en el port; env vía wrapper; paridad por ruta).
   - **Reutilizar antes que crear:** UI kit existente (shadcn/ui o equivalente), stores, hooks,
     queries; sin deps nuevas ni abstracciones especulativas.
   - **Sin pasos de DB/schema:** nada de migraciones ni seeds; la evidencia runtime es UI real
     contra el backend dev, no tests de integración de servidor.
   - **Skills de ejecución:** el bucle primario es la skill global `cdev-frontend`; no vendorices
     skills por-repo salvo que el repo necesite pasos que la global no cubra.
5. **Escribe el perfil de autonomía elevada en el protocolo** (esto es lo que legitima que
   `/cdev` no pare): en `AGENT_EXECUTION_PROTOCOL.md`, la sección de condiciones de parada debe
   decir que al agotar el plan el agente **deriva trabajo siguiente él mismo** (orden: backlog
   documentado → paridad/port entre targets → deuda marcada y gaps de evidencia runtime →
   borrador de fase siguiente como `PROPOSAL`) y solo para ante bloqueos reales o gates humanos.
   Los gates de seguridad (§ abajo) nunca se elevan.
6. **Night-runner:** renderiza `scripts/claude-night-runner.ps1` solo como opción de reanudación
   por cuota, con su directiva de skills apuntando a la global `cdev-frontend` (no a skills
   por-repo), y documenta en el RUNBOOK que el bucle primario es `/cdev` (skill `cdev-frontend`).

## Mitad B — Claridad de producto

Sin esto el umbral elevado es peligroso: autonomía ≠ inventar producto.

1. **Inventario de fuentes.** Docs de producto/spec, diseños (Figma/mocks), **contrato del
   backend** (esquema GraphQL/OpenAPI, reportes por sprint si existen), READMEs, código ya
   escrito. Ordena por autoridad.
2. **Puntúa cada área de dominio** detectada:
   - `DEFINIDO` — spec + contrato backend + criterios de aceptación derivables. El agente puede
     trabajarla solo.
   - `PARCIAL` — intención clara pero falta detalle (diseño sin contrato, contrato sin diseño).
     El agente trabaja lo claro y registra cada supuesto en DECISIONS. Un área sin contrato
     backend definido es como mucho `PARCIAL`.
   - `AUSENTE` — solo existe el nombre. Prohibido inventarla: se registra como pregunta abierta.
3. **Escribe el mapa de claridad** en `docs/develop/PRODUCT.md` (tabla área → nivel → fuente →
   preguntas abiertas; la plantilla base no trae hueco para la tabla — extiéndela). Este mapa es la frontera de la autonomía: `/cdev` solo autoelige trabajo
   dentro de DEFINIDO/PARCIAL.
4. **Deriva SPRINTS.md hasta donde la claridad alcance.** Sprint 01 `ACTIVE` con Batch 01 `READY`
   y acceptance objetiva (incluida la evidencia runtime exigida); áreas PARCIAL → batches con sus
   supuestos anotados; AUSENTE → ni sprint ni batch, solo pregunta abierta en DECISIONS.

## Gate humano (único)

Antes de escribir archivo alguno: presenta tabla de placeholders resueltos + mapa de claridad +
outline de fases/sprints. Una confirmación (o ediciones) y escribe todo. Si un archivo destino ya
existe, muestra diff y pregunta — nunca sobrescribir en silencio.

## Gates de seguridad que el bootstrap deja escritos (no negociables)

Tocar backend/esquema/migraciones · push a main/develop · abrir PR · deploy (hosting/stores) ·
subir pins de versión documentados · añadir dependencias nuevas · operar pagos en real · romper
deep/universal links · secretos/tokens live. El perfil elevado eleva el *qué trabajar*, jamás estos.

## Al terminar

Entrada inicial en `AGENT_PROGRESS.md` (bootstrap hecho, Sprint 01 ACTIVE, siguiente acción =
`/cdev`) y resumen "condicionado — cómo lanzar" apuntando al RUNBOOK. Valida: cero `{{` sin
resolver y exactamente un sprint `ACTIVE`.
