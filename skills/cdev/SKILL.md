---
name: cdev
description: Úsala cuando el usuario invoque /cdev (con o sin argumentos) en un repo condicionado para desarrollo continuo autónomo — arranca el ciclo de trabajo adaptándose al rol que el propio repo define.
---

# CDev — dispatcher

Punto de entrada único del ciclo CDev. Identifica el rol del repo y aplica el bucle que toque.

## Procedimiento

1. **Identifica el rol** leyendo `CLAUDE.md` del repo y `docs/develop/` (RECOGNITION/
   RECONOCIMIENTO, AGENT_EXECUTION_PROTOCOL). Señales:
   - **Backend**: API/servicios/schema propio (NestJS, Express, Django, Go...), sin UI.
   - **Frontend**: consume backend externo; verificación = typecheck + builds + runtime UI
     (Playwright); prohibido tocar backend/esquema.
   - **Fullstack/otro**: el CLAUDE.md lo dirá; ante duda, gana lo que declare el repo.
2. **Backend** → invoca la skill `cdev-backend` y sigue su bucle.
3. **Frontend** → invoca la skill `cdev-frontend` y sigue su bucle.
4. **Fullstack/otro** → mismo contrato de autonomía de `cdev-backend`/`cdev-frontend` (trabajar
   hasta bloqueo, blocked-but-not-idle, auto-avance, solo parar ante bloqueos reales, gates de
   seguridad nunca elevados) pero con la mecánica del propio repo: su secuencia de verificación,
   sus ramas, sus gates y sus skills locales tal como los fija su `AGENT_EXECUTION_PROTOCOL.md`.
5. **Sin argumento** = reanudar el trabajo pendiente del plan (`SPRINTS.md` + `AGENT_PROGRESS.md`
   + git). **Con argumento** = úsalo como foco (p.ej. `/cdev sprint 09`), mismo bucle acotado a
   ese objetivo.

## Si el repo no está condicionado

No hay `docs/develop/` con SPRINTS/protocolo → no improvises el bucle: propone condicionarlo
(`bootstrap-backend` si es backend; `bootstrap-frontend` si es frontend; el kit `cdev-bootstrap`
genérico si no) y para ahí.
