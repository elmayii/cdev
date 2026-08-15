---
name: bootstrap-frontend
description: Use when a repo that is frontend ONLY (UI consuming an external backend) must be conditioned for continuous autonomous development (CDev) — a new repo or an existing one without docs/develop/, or when the user asks to "bootstrap frontend", "condition a frontend for cdev", "condicionar frontend para cdev", or to check whether a frontend is ready for /cdev to work alone.
---

# Bootstrap Frontend (CDev)

Conditions a frontend repo for autonomous execution with an **elevated autonomy threshold**: the
agent that later runs `/cdev` will stop only at real blockages, never to ask "now what?". This
skill has two mandatory halves:

- **Half A — Structure:** build/verify the CDev machinery adapted to a frontend.
- **Half B — Clarity:** audit how far it is clear *what* must be produced, because the level of
  clarity defines how far autonomy may reach.

Base: reuses `~/.claude/skills/cdev-bootstrap/templates/*` and its `PLACEHOLDERS.md` (same
`{{...}}` contract; zero unresolved `{{` at the end). This skill defines the **frontend deltas**
and the **autonomy profile** those templates do not carry. It is idempotent: on an already
conditioned repo it acts as an audit (delta checklist below) and proposes diffs, never
overwrites silently.

## Half A — Frontend structure

1. **Inspect the repo.** Framework (Next/Vite/Astro/Expo...), package manager, **targets**
   (web only, or web + mobile/desktop port in a subfolder?), dev server ports, real manifest
   scripts. Resolve placeholders.
2. **Detect the consumed backend and declare it untouchable** — a frontend's most important
   gate: endpoints (GraphQL/REST), client (Apollo/fetch/tRPC), auth (Supabase/Auth0...), env
   vars. Backend/schema/migration changes **are coordinated outside the repo = human gate,
   always**. Note the dev backend URL and test accounts if they exist (runtime verification
   needs them). Detect fragile version pins (documented locks, Apollo-style) and leave them
   written as a gate.
3. **Fix the real verification sequence** — frontend gates lie; verify each one against the
   repo before writing it down:
   - **Type gate:** the command with the correct tsconfig per target (a bare `tsc` over a
     monorepo, or a build with `ignoreBuildErrors`, is **not** a gate). Try it.
   - **Builds per target** (web, mobile port, etc.).
   - **Runtime UI evidence:** the touched flow on the dev server + dev backend up + test
     accounts, via **Playwright MCP**. It is a mandatory step before every `DONE`. If the
     Playwright MCP is not configured, leave it as a written blocking requirement in the
     RUNBOOK; do not omit it.
4. **Render** CLAUDE.md, `docs/develop/*` (protocol, SPRINTS, PROGRESS, ROADMAP, PRODUCT,
   ARCHITECTURE, DECISIONS, TESTING, RUNBOOK) and `.claude/agents/*` from the templates.
   **Skip** `00_repo_conditioning.md.tmpl` (backend-centric) and the `.claude/skills/*`
   templates. The base templates are generic/backend: filling placeholders is not enough —
   rewrite whatever clashes with the role (domain rules with DB/state-machines, the note
   preferring tests over dev server, the outdated hardcoded trailer/model) per these frontend
   deltas:
   - **Role in CLAUDE.md:** senior frontend engineer with autonomy; consumes an external
     backend, does not build it.
   - **Main target first** (web-first if several): implement and validate on the main target,
     then port per an explicit **port convention** (same relative path; no web-framework
     imports in the port; env via wrapper; parity per route).
   - **Reuse before creating:** existing UI kit (shadcn/ui or equivalent), stores, hooks,
     queries; no new deps, no speculative abstractions.
   - **No DB/schema steps:** no migrations, no seeds; runtime evidence is real UI against the
     dev backend, not server integration tests.
   - **Execution skills:** the primary loop is the global `cdev-frontend` skill; do not vendor
     per-repo skills unless the repo needs steps the global one does not cover.
5. **Write the elevated autonomy profile into the protocol** (this is what legitimizes `/cdev`
   not stopping): in `AGENT_EXECUTION_PROTOCOL.md`, the stop-conditions section must say that
   when the plan runs out the agent **derives the next work itself** (order: documented
   backlog → parity/port between targets → marked debt and runtime-evidence gaps → draft of
   the next phase as `PROPOSAL`) and stops only at real blockages or human gates. Safety gates
   (§ below) are never elevated.
6. **Night-runner:** render `scripts/claude-night-runner.ps1` only as a quota-resumption
   option, with its skills directive pointing at the global `cdev-frontend` (not per-repo
   skills), and document in the RUNBOOK that the primary loop is `/cdev` (skill
   `cdev-frontend`).

## Half B — Product clarity

Without this the elevated threshold is dangerous: autonomy ≠ inventing product.

1. **Source inventory.** Product/spec docs, designs (Figma/mocks), **backend contract**
   (GraphQL/OpenAPI schema, per-sprint reports if they exist), READMEs, code already written.
   Order by authority.
2. **Score every detected domain area**:
   - `DEFINED` — spec + backend contract + derivable acceptance criteria. The agent may work
     it alone.
   - `PARTIAL` — intent is clear but detail is missing (design without contract, contract
     without design). The agent works the clear part and records every assumption in
     DECISIONS. An area without a defined backend contract is at most `PARTIAL`.
   - `ABSENT` — only the name exists. Inventing it is forbidden: recorded as an open question.
3. **Write the clarity map** in `docs/develop/PRODUCT.md` (table area → level → source → open
   questions; the base template has no slot for the table — extend it). This map is the
   boundary of autonomy: `/cdev` only self-selects work inside DEFINED/PARTIAL.
4. **Derive SPRINTS.md as far as clarity reaches.** Sprint 01 `ACTIVE` with Batch 01 `READY`
   and objective acceptance (including the required runtime evidence); PARTIAL areas → batches
   with their assumptions noted; ABSENT → neither sprint nor batch, only an open question in
   DECISIONS.

## Human gate (single)

Before writing any file: present the table of resolved placeholders + clarity map + phase/
sprint outline. One confirmation (or edits) and write everything. If a target file already
exists, show the diff and ask — never overwrite silently.

## Safety gates the bootstrap leaves written (non-negotiable)

Touching backend/schema/migrations · push to main/develop · opening PRs · deploy
(hosting/stores) · raising documented version pins · adding new dependencies · operating real
payments · breaking deep/universal links · live secrets/tokens. The elevated profile raises
*what to work on*, never these.

## On finishing

Initial entry in `AGENT_PROGRESS.md` (bootstrap done, Sprint 01 ACTIVE, next action = `/cdev`)
and a "conditioned — how to launch" summary pointing at the RUNBOOK. Validate: zero unresolved
`{{` and exactly one `ACTIVE` sprint.
