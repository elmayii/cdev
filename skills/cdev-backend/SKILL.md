---
name: cdev-backend
description: Use to autonomously execute the pending work of a backend repo conditioned for CDev (it has docs/develop/ with SPRINTS.md and AGENT_EXECUTION_PROTOCOL.md) — when the user asks to run the active sprint, "follow the plan", "sigue el plan", overnight/unattended work, or invokes /cdev-backend or /cdev on a backend.
---

# CDev Backend — autonomous loop

Continuous execution loop for conditioned backends (replaces the `claude-night-runner.ps1`
watchdog as the primary way to run CDev). Invoking it is the **elevated autonomy** mandate:
work proactively assuming what the project needs and stop **only at real blockages** — never
to ask what to do next.

The repo is the memory: `SPRINTS.md` = plan · `AGENT_PROGRESS.md` = handoff · git = state.
The repo's specifics (exact verification, patterns, own gates) are fixed by its
`docs/develop/AGENT_EXECUTION_PROTOCOL.md`; this skill is the generic operating system and the
autonomy threshold. If the repo's protocol is stricter about *when to stop and ask*, this
explicit invocation elevates it; on safety gates the strictest always wins.

## Start (every invocation/resumption)

Read in order: `CLAUDE.md` → `docs/develop/AGENT_EXECUTION_PROTOCOL.md` → `SPRINTS.md` →
`AGENT_PROGRESS.md` (last entry) → `git status` + recent commits. Resume from there; do not
re-derive what was already decided.

## Loop (repeat until a real blockage)

1. **Select work:** first `READY`/`IN_PROGRESS` batch of the `ACTIVE` sprint, in strict order.
   Mark it `IN_PROGRESS`. Working branch `cdev/sprint-<n>-batch-<n>` (never `main`/`develop`).
2. **Implement only that batch.** `ponytail:ponytail` at every step (reuse before creating,
   smallest correct diff). `superpowers:test-driven-development` on domain logic (state
   machines, billing, authorization). Always additive: don't break live contracts.
3. **Verify** with the repo's sequence (typical `npm run lint` → `build` → `test`). Schema
   touched → `prisma format` + `generate`; the apply to a remote DB is a human gate (blocker,
   don't run it). Runtime evidence = tests, not long-running servers.
4. **If something fails:** `superpowers:systematic-debugging` — exact error quoted, grep the
   callers, root cause once where they all route through, minimal surface, re-run the failed
   command and then the full sequence. Never silence tests or paper over types with `any` to
   pass.
5. **Record** in `AGENT_PROGRESS.md`: honest status, what was done, files, verification
   pass/fail/not-run, concrete blockers, next. No exaggeration; incomplete is never `DONE`.
6. **Commit the whole batch** (`feat(<phase>-sprint-<n>): ...`; useful-but-unfinished →
   `wip(...)`).
7. **Close:** batch `DONE` only with acceptance met with evidence
   (`superpowers:verification-before-completion`). Next batch.

## Auto-advance (the elevated threshold)

- **Sprint complete** → write and commit the sprint's integration report (mandatory before the
  `DONE`), mark the sprint `DONE`, promote the next `PENDING` to `ACTIVE`, continue.
- **Batch blocked (non-quota)** → mark it `BLOCKED` with reason + the minimum decision the
  human must make, and apply *blocked-but-not-idle*: next batch whose dependencies are `DONE`;
  if none, the phase's next independent sprint.
- **Phase complete** → mark it `DONE` and **do not stand still**: derive the next work
  yourself, in this order, inside the repo's clarity map (`PRODUCT.md`; only DEFINED/PARTIAL
  areas):
  1. The repo's documented backlog (platform backlog in CLAUDE.md, ROADMAP, doc TODOs).
  2. Test backfill on critical logic without coverage.
  3. Already-planned hardening/observability (health, metrics, rate limit), additively.
  4. **Draft of the next phase** in `SPRINTS.md` as `PROPOSAL` (not `ACTIVE`): derived from
     the product sources, ready for human ratification — and meanwhile continue with 1–3.
  Record in `AGENT_PROGRESS.md` what you self-selected and why.

## It only stops when

- No ungated work remains (no batch, no backlog, no backfill) — say exactly which approvals
  would unblock what.
- A safety gate requires human action and everything else depends on it.
- Contradictory docs, or an `ABSENT` area without which it cannot continue (open question
  recorded; inventing product is forbidden).
- The repo is in an unsafe state.
- Usage/quota limit: save everything, update `AGENT_PROGRESS.md`, commit what is safe (`wip`
  if needed), exit cleanly. Resumption (watchdog or next invocation) picks up from the repo,
  not from conversational memory.

## Safety gates (never elevated by this skill)

Schema apply to a remote DB (`prisma db push`/`migrate deploy`) · push to `main`/`develop` ·
deploy · destructive DDL/ops (DROP, data deletion) · live provider secrets or tokens ·
rewriting git history. Preparing them yes (draft + blocker requesting approval); executing
them no.
