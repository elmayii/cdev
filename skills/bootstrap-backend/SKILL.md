---
name: bootstrap-backend
description: Use when a repo that is backend ONLY (API, services, DB) must be conditioned for continuous autonomous development (CDev) — a new repo or an existing one without docs/develop/, or when the user asks to "bootstrap backend", "condition a backend for cdev", "condicionar backend para cdev", or to prepare a backend so /cdev can work alone.
---

# Bootstrap Backend (CDev)

Conditions a backend repo for autonomous execution with an **elevated autonomy threshold**: the
agent that later runs `/cdev` will stop only at real blockages, never to ask "now what?". This
skill has two mandatory halves:

- **Half A — Structure:** build/verify the CDev machinery adapted to a backend.
- **Half B — Clarity:** audit how far it is clear *what* must be produced, because the level of
  clarity defines how far autonomy may reach.

Base: reuses `~/.claude/skills/cdev-bootstrap/templates/*` and its `PLACEHOLDERS.md` (same
`{{...}}` contract; zero unresolved `{{` at the end). This skill defines the **backend deltas**
and the **autonomy profile** those templates do not carry.

## Half A — Backend structure

1. **Inspect the repo.** Stack (manifest/lockfile), framework (NestJS/Express/Fastify/Django/
   Go...), ORM and schema (prisma/, migrations/), package manager, shell. Resolve placeholders.
2. **Detect the DB and classify it** — this decides the most important gate:
   - **Remote/shared** (Supabase, RDS, connection string to an external host): applying schema
     (`db push`/`migrate deploy`) = **human gate, always**. The agent edits schema + `generate`,
     and leaves the apply as a blocker.
   - **Local/ephemeral** (docker compose, sqlite): migrating is part of normal verification.
3. **Fix the verification sequence** from the repo's real scripts (typical:
   `lint` → `build` (typecheck) → `test`). No test framework → install the stack's one and make
   Batch 01 = first real test; a CDev backend without a test gate is not conditioned.
4. **Render** CLAUDE.md, `docs/develop/*` (protocol, SPRINTS, PROGRESS, ROADMAP, DECISIONS,
   TESTING, RUNBOOK), `.claude/agents/*` and `.claude/skills/*` from the templates, with these
   backend deltas:
   - **Role in CLAUDE.md:** senior backend engineer with autonomy; additive mandate (don't break
     live contracts: optional fields, add-only enums, new endpoints versioned).
   - **Module pattern** of the detected framework as an architecture rule (e.g. NestJS:
     module/controller/resolver/service + repositories).
   - **Read/write separation** if GraphQL+REST coexist (REST writes, GraphQL reads) — only if
     the repo already practices it; do not impose it on a pure REST repo.
   - **No UI steps**: no Playwright/web builds; runtime evidence is tests (HTTP/integration),
     not long-running background servers.
   - **Per-sprint deliverable:** integration report for consumers (frontend/mobile/partners)
     mandatory before marking a sprint DONE (SPRINT_FRONTEND_REPORT template).
5. **Write the elevated autonomy profile into the protocol** (this is what legitimizes `/cdev`
   not stopping): in `AGENT_EXECUTION_PROTOCOL.md`, the stop-conditions section must say that
   when the plan runs out the agent **derives the next work itself** (order: documented
   backlog → test backfill → hardening/observability → draft of the next phase as a proposal)
   and stops only at real blockages or human gates. Safety gates (§ below) are never elevated.
6. **Night-runner:** render `scripts/claude-night-runner.ps1` as a quota-resumption option, but
   document in the RUNBOOK that the primary loop is the `cdev-backend` skill.

## Half B — Product clarity

Without this the elevated threshold is dangerous: autonomy ≠ inventing product.

1. **Source inventory.** Enumerate product/spec docs (and READMEs, schema, code if the repo
   already exists). Order by authority.
2. **Score every detected domain area**:
   - `DEFINED` — spec + derivable acceptance criteria. The agent may work it alone.
   - `PARTIAL` — intent is clear, detail is ambiguous. The agent works the clear part and
     records every assumption in DECISIONS.
   - `ABSENT` — only the name exists. Inventing it is forbidden: recorded as an open question.
3. **Write the clarity map** in `docs/develop/PRODUCT.md` (table area → level → source → open
   questions). This map is the boundary of autonomy: `/cdev` only self-selects work inside
   DEFINED/PARTIAL.
4. **Derive SPRINTS.md as far as clarity reaches.** Sprint 01 `ACTIVE` with Batch 01 `READY`
   and objective acceptance; PARTIAL areas → batches with their assumptions noted; ABSENT →
   neither sprint nor batch, only an open question in DECISIONS.

## Human gate (single)

Before writing any file: present the table of resolved placeholders + clarity map + phase/
sprint outline. One confirmation (or edits) and write everything. If a target file already
exists, show the diff and ask — never overwrite silently.

## Safety gates the bootstrap leaves written (non-negotiable)

Schema apply to a remote DB · push to main/develop · deploy · destructive DB operations ·
live secrets/tokens · data deletion. The elevated profile raises *what to work on*, never these.

## On finishing

Initial entry in `AGENT_PROGRESS.md` (bootstrap done, Sprint 01 ACTIVE, next action = `/cdev`)
and a "conditioned — how to launch" summary pointing at the RUNBOOK.
