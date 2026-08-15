---
name: cdev-frontend
description: Use to autonomously execute the pending work of a frontend repo conditioned for CDev (it has docs/develop/ with SPRINTS.md and AGENT_EXECUTION_PROTOCOL.md) — when the user asks to run the active sprint, "follow the plan", "sigue el plan", overnight/unattended work, or invokes /cdev-frontend or /cdev on a frontend.
---

# CDev Frontend — autonomous loop

Continuous execution loop for conditioned frontends (replaces the `claude-night-runner.ps1`
watchdog as the primary way to run CDev). Invoking it is the **elevated autonomy** mandate:
work proactively assuming what the project needs and stop **only at real blockages** — never
to ask what to do next.

The repo is the memory: `SPRINTS.md` = plan · `AGENT_PROGRESS.md` = handoff · git = state.
The repo's specifics (exact commands, port convention, own gates) are fixed by its
`docs/develop/AGENT_EXECUTION_PROTOCOL.md` + `CLAUDE.md`; this skill is the generic operating
system and the autonomy threshold. If the repo's protocol is stricter about *when to stop and
ask*, this explicit invocation elevates it; on safety gates the strictest always wins.

## Start (every invocation/resumption)

Read in order: `CLAUDE.md` → `docs/develop/AGENT_EXECUTION_PROTOCOL.md` → `SPRINTS.md` →
`AGENT_PROGRESS.md` (last entry) → `git status` + recent commits. If the repo defines a
per-sprint backend contract/report (e.g. `docs/F6/reports/` in Compiss), read it **before**
starting the sprint: it is the contract; do not invent fields, and if it differs from what is
deployed on the dev backend, record it as a blockage/decision. Resume from there; do not
re-derive what was already decided.
If git shows real work not recorded in the plan (commits/WIP with no sprint or progress
entry), **reconcile first**: reflect it in `SPRINTS.md` + `AGENT_PROGRESS.md` before
continuing — repo-as-memory does not work with the plan out of sync.

## Loop (repeat until a real blockage)

1. **Select work:** first `READY`/`IN_PROGRESS` batch of the `ACTIVE` sprint, in strict order.
   Mark it `IN_PROGRESS`. Branch per the repo's convention (e.g. `claude/f6-sprint-<n>`,
   created **from the current branch**; on sprint change, new branch from the then-current
   one). Never `main`/`develop`.
2. **Implement only that batch, main target first** (web-first if there are several targets);
   the port to the secondary target follows the repo's convention (same relative path, no
   web-framework imports in the port). `ponytail:ponytail` at every step: reuse the existing
   UI kit, stores, hooks and queries before writing; no new deps; smallest correct diff.
3. **Verify before every DONE:**
   - **Real type gate** — the command the repo documents. Careful: a typecheck without the
     correct tsconfig, or a build with `ignoreBuildErrors`, is **not** a type gate.
   - **Build of every target.**
   - **MANDATORY runtime evidence** — drive the touched flow on the dev server with its
     dependencies up (dev backend, test accounts) via Playwright MCP. "It compiles" is not
     evidence. No Playwright MCP, or backend down and nothing else workable → batch `BLOCKED`,
     not `DONE`.
   - `git diff` free of changes unrelated to the batch; parity between targets if shared code
     was touched.
4. **If something fails:** `superpowers:systematic-debugging` — exact error quoted, grep the
   callers, root cause once where they all route through, minimal surface, re-run the failed
   command and then the full sequence. Never silence checks or paper over types with `any` to
   pass.
5. **Record** in `AGENT_PROGRESS.md` (newest first): honest status, what was done, files
   (main target + port counterparts), verification pass/fail/not-run per command, concrete
   blockers, next. No exaggeration; incomplete is never `DONE`.
6. **Commit the whole batch** (`feat(<phase>-sprint-<n>): ...`; useful-but-unfinished →
   `wip(...)`). Never push.
7. **Close:** batch `DONE` only with acceptance met with evidence
   (`superpowers:verification-before-completion`). Next batch.

## Auto-advance (the elevated threshold)

- **Sprint complete** → mark it `DONE`, promote the next `PENDING` to `ACTIVE` (new branch
  from the current one), read its backend report/contract if it exists, continue.
- **Batch blocked (non-quota)** → mark it `BLOCKED` with reason + the minimum decision the
  human must make, and apply *blocked-but-not-idle*: next batch whose dependencies are `DONE`;
  if none, the next sprint independent of the blockage.
- **Plan exhausted** → mark it and **do not stand still**: derive the next work yourself, in
  this order, inside the repo's clarity map (`PRODUCT.md`; only DEFINED/PARTIAL areas — if the
  repo has no map yet, approximate: defined = existing source doc + backend contract, and note
  it in `DECISIONS.md`; producing the real map is `bootstrap-frontend`'s job):
  1. Documented backlog (source docs with scope not yet implemented — verify it in code, don't
     assume it; doc TODOs, ROADMAP).
  2. Documented parity/port gaps between targets (e.g. web↔mobile audit).
  3. Marked debt (`ponytail:`/TODO within scope) and verification gaps (flows without runtime
     evidence, broken gates).
  4. **Draft of the next phase** in `SPRINTS.md` as `PROPOSAL` (not `ACTIVE`): derived from
     the product sources, ready for human ratification — and meanwhile continue with 1–3.
  Record in `AGENT_PROGRESS.md` and `DECISIONS.md` what you self-selected and why.

## It only stops when

- No ungated work remains (no batch, no backlog, no parity, no debt) — say exactly which
  approvals would unblock what.
- A safety gate requires human action and everything else depends on it.
- Contradictory docs, or an `ABSENT` area without which it cannot continue (open question
  recorded; inventing product is forbidden).
- The repo is in an unsafe state.
- Usage/quota limit: save everything, update `AGENT_PROGRESS.md`, commit what is safe (`wip`
  if needed), exit cleanly. Resumption (next invocation or watchdog) picks up from the repo,
  not from conversational memory.

## Safety gates (never elevated by this skill)

Touching the backend, GraphQL schema or migrations (coordinated outside the repo) · push to
`main`/`develop` · opening PRs · deploy (hosting/stores) · raising version pins documented as
gates in the repo's `CLAUDE.md` (e.g. Apollo in Compiss) · adding new dependencies · operating
real payments · breaking deep/universal links · live secrets or tokens · rewriting git
history. Preparing them yes (draft + blocker requesting approval); executing them no.
