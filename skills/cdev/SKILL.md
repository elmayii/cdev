---
name: cdev
description: Use when the user invokes /cdev (with or without arguments) in a repo conditioned for continuous autonomous development — starts the work cycle adapting to the role the repo itself defines.
---

# CDev — dispatcher

Single entry point of the CDev cycle. Identify the repo's role and apply the loop that fits.

## Procedure

1. **Identify the role** by reading the repo's `CLAUDE.md` and `docs/develop/` (RECOGNITION
   document, AGENT_EXECUTION_PROTOCOL). Signals:
   - **Backend**: API/services/own schema (NestJS, Express, Django, Go...), no UI.
   - **Frontend**: consumes an external backend; verification = typecheck + builds + runtime UI
     (Playwright); touching the backend/schema is forbidden.
   - **Fullstack/other**: the CLAUDE.md will say; when in doubt, what the repo declares wins.
2. **Backend** → invoke the `cdev-backend` skill and follow its loop.
3. **Frontend** → invoke the `cdev-frontend` skill and follow its loop.
4. **Fullstack/other** → same autonomy contract as `cdev-backend`/`cdev-frontend` (work until
   blocked, blocked-but-not-idle, auto-advance, stop only at real blockages, safety gates never
   elevated) but with the repo's own mechanics: its verification sequence, its branches, its
   gates and its local skills as fixed by its `AGENT_EXECUTION_PROTOCOL.md`.
5. **No argument** = resume the plan's pending work (`SPRINTS.md` + `AGENT_PROGRESS.md` + git).
   **With argument** = use it as focus (e.g. `/cdev sprint 09`), same loop scoped to that
   objective.

## If the repo is not conditioned

No `docs/develop/` with SPRINTS/protocol → do not improvise the loop: propose conditioning it
(`bootstrap-backend` if it is a backend; `bootstrap-frontend` if it is a frontend; the generic
`cdev-bootstrap` kit otherwise) and stop there.
