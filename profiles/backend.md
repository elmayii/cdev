# Role profile — backend

A profile holds exactly four things (doc 07 §2): what "verified" means, what "evidence" means,
the role's hardest gate, and the self-chosen work order. It may not alter the loop, the stop
conditions, the autonomy threshold, or the gate policy — those are core. Technology names below
are **examples from one case**, never requirements.

## 1 · What "verified" means here

The repository's real script sequence — typical: `lint` → `build` (typecheck) → `test` — fixed
at conditioning from the scripts that actually exist, not assumed.

- **No test framework → the repo is not conditioned.** Installing the stack's framework and
  writing the first real test becomes the first batch.
- Schema touched → format and regenerate the client locally as part of verification
  (example: `prisma format` + `generate`); **applying** it is the gate below, never a
  verification step when the database is shared.

## 2 · What "evidence" means here

Tests — HTTP-level and integration tests over the touched behaviour. Not long-running servers,
not UI steps: a backend batch proves itself through its test run, recorded per check
(pass / fail / not-run).

## 3 · The role's hardest gate

**The database.** Conditioning classifies it, and the classification decides the loop's shape:

- **Remote/shared** (a connection string to a host other people use — example: Supabase, RDS):
  applying schema (`db push` / `migrate deploy`) is a **permanent human gate**. The agent edits
  schema and regenerates; the apply is prepared and left as a blocker naming the decision.
- **Local/ephemeral** (example: docker compose, sqlite): migrating is an ordinary verification
  step.

Typical gate list this role adds (examples, per repo): schema apply to the shared database ·
destructive DDL and data deletion · live provider secrets and tokens.

## 4 · Self-chosen work order (when the plan runs out)

1. Documented backlog (platform backlog in the repo guide, roadmap, doc TODOs).
2. Test backfill on critical logic without coverage.
3. Already-planned hardening/observability (health, metrics, rate limiting), additively.
4. Draft of the next phase as `PROPOSAL` — never self-activated; continue with 1–3 meanwhile.
