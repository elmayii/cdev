---
name: bootstrap-backend
description: Úsala cuando haya que condicionar un repo que es SOLO backend (API, servicios, DB) para desarrollo continuo autónomo (CDev) — repo nuevo o existente sin docs/develop/, o cuando el usuario pida "bootstrap backend", "condicionar backend para cdev" o preparar un backend para que /cdev trabaje solo.
---

# Bootstrap Backend (CDev)

Condiciona un repo backend para ejecución autónoma con **umbral de autonomía elevado**: el
agente que luego corra `/cdev` solo parará ante bloqueos reales, nunca para preguntar "¿y ahora
qué?". Este skill tiene dos mitades obligatorias:

- **Mitad A — Estructura:** armar/verificar la maquinaria CDev adaptada a backend.
- **Mitad B — Claridad:** auditar hasta dónde está claro *qué* hay que producir, porque el nivel
  de claridad define hasta dónde puede llegar la autonomía.

Base: reutiliza `~/.claude/skills/cdev-bootstrap/templates/*` y su `PLACEHOLDERS.md` (mismo
contrato `{{...}}`; cero `{{` sin resolver al terminar). Este skill define los **deltas backend**
y el **perfil de autonomía** que esas plantillas no traen.

## Mitad A — Estructura backend

1. **Inspecciona el repo.** Stack (manifest/lockfile), framework (NestJS/Express/Fastify/Django/
   Go...), ORM y schema (prisma/, migrations/), gestor de paquetes, shell. Resuelve placeholders.
2. **Detecta la DB y clasifícala** — esto decide el gate más importante:
   - **Remota/compartida** (Supabase, RDS, connection string a host externo): aplicar schema
     (`db push`/`migrate deploy`) = **gate humano siempre**. El agente edita schema + `generate`,
     y deja el apply como blocker.
   - **Local/efímera** (docker compose, sqlite): migrar es parte de la verificación normal.
3. **Fija la secuencia de verificación** desde los scripts reales del repo (típico:
   `lint` → `build` (typecheck) → `test`). Sin framework de tests → instalar el del stack y dejar
   Batch 01 = primer test real; un backend CDev sin gate de tests no queda condicionado.
4. **Renderiza** CLAUDE.md, `docs/develop/*` (protocolo, SPRINTS, PROGRESS, ROADMAP, DECISIONS,
   TESTING, RUNBOOK), `.claude/agents/*` y `.claude/skills/*` desde las plantillas, con estos
   deltas backend:
   - **Rol en CLAUDE.md:** ingeniero backend senior con autonomía; mandato aditivo (no romper
     contratos vivos: campos opcionales, enums solo-añadir, endpoints nuevos versionados).
   - **Patrón de módulo** del framework detectado como regla de arquitectura (p.ej. NestJS:
     module/controller/resolver/service + repositorios).
   - **Separación lectura/escritura** si hay GraphQL+REST (REST escribe, GraphQL lee) — solo si
     el repo ya la practica; no la impongas a un repo REST puro.
   - **Sin pasos de UI**: nada de Playwright/builds web; la evidencia runtime son tests (HTTP/
     integración), no servers largos en background.
   - **Entrega por sprint:** reporte de integración para consumidores (frontend/mobile/partners)
     obligatorio antes de marcar un sprint DONE (plantilla SPRINT_FRONTEND_REPORT).
5. **Escribe el perfil de autonomía elevada en el protocolo** (esto es lo que legitima que
   `/cdev` no pare): en `AGENT_EXECUTION_PROTOCOL.md`, la sección de condiciones de parada debe
   decir que al agotar el plan el agente **deriva trabajo siguiente él mismo** (orden: backlog
   documentado → backfill de tests → hardening/observabilidad → borrador de fase siguiente como
   propuesta) y solo para ante bloqueos reales o gates humanos. Los gates de seguridad (§ abajo)
   nunca se elevan.
6. **Night-runner:** renderiza `scripts/claude-night-runner.ps1` como opción de reanudación por
   cuota, pero documenta en el RUNBOOK que el bucle primario es la skill `cdev-backend`.

## Mitad B — Claridad de producto

Sin esto el umbral elevado es peligroso: autonomía ≠ inventar producto.

1. **Inventario de fuentes.** Enumera docs de producto/spec (y READMEs, schema, código si el repo
   ya existe). Ordena por autoridad.
2. **Puntúa cada área de dominio** detectada:
   - `DEFINIDO` — spec + criterios de aceptación derivables. El agente puede trabajarla solo.
   - `PARCIAL` — intención clara, detalle ambiguo. El agente trabaja lo claro y registra cada
     supuesto en DECISIONS.
   - `AUSENTE` — solo existe el nombre. Prohibido inventarla: se registra como pregunta abierta.
3. **Escribe el mapa de claridad** en `docs/develop/PRODUCT.md` (tabla área → nivel → fuente →
   preguntas abiertas). Este mapa es la frontera de la autonomía: `/cdev` solo autoelige trabajo
   dentro de DEFINIDO/PARCIAL.
4. **Deriva SPRINTS.md hasta donde la claridad alcance.** Sprint 01 `ACTIVE` con Batch 01 `READY`
   y acceptance objetiva; áreas PARCIAL → batches con sus supuestos anotados; AUSENTE → ni sprint
   ni batch, solo pregunta abierta en DECISIONS.

## Gate humano (único)

Antes de escribir archivo alguno: presenta tabla de placeholders resueltos + mapa de claridad +
outline de fases/sprints. Una confirmación (o ediciones) y escribe todo. Si un archivo destino ya
existe, muestra diff y pregunta — nunca sobrescribir en silencio.

## Gates de seguridad que el bootstrap deja escritos (no negociables)

Apply de schema a DB remota · push a main/develop · deploy · operaciones DB destructivas ·
secretos/tokens live · borrado de datos. El perfil elevado eleva el *qué trabajar*, jamás estos.

## Al terminar

Entrada inicial en `AGENT_PROGRESS.md` (bootstrap hecho, Sprint 01 ACTIVE, siguiente acción =
`/cdev`) y resumen "condicionado — cómo lanzar" apuntando al RUNBOOK.
