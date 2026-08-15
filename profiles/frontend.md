# Role profile — frontend

A profile holds exactly four things, by rule: what "verified" means, what "evidence" means,
the role's hardest gate, and the self-chosen work order. It may not alter the loop, the stop
conditions, the autonomy threshold, or the gate policy — those are core. Technology names below
are **examples from one case**, never requirements.

## 1 · What "verified" means here

Per target — and **every gate is verified against the repo before it is trusted, because
frontend gates lie**:

- **Real type gate**: the command with the correct project configuration per target. A bare
  typechecker pointed at the wrong config silently checks the wrong project; a build configured
  to ignore type errors (example: `ignoreBuildErrors`) is not a gate. Try it before writing it
  down.
- **Build of every target.**
- Diff free of changes unrelated to the batch; parity between targets when shared code was
  touched.
- **Multi-target repos**: implement and validate on the main target first, then port by an
  explicit written convention — same relative path, no main-framework imports in the port,
  environment access through a wrapper, parity checked per route.

## 2 · What "evidence" means here

**Runtime evidence, mandatory before any `DONE`**: the touched flow driven in a real dev server
with its dependencies up (dev backend, test accounts), through browser automation (example:
Playwright MCP — the tool is a binding; observing real behaviour is the requirement). "It
compiles" is never evidence. If the tooling or the dev backend is unavailable and nothing else
is workable, the honest status is `BLOCKED`, never `DONE`.

## 3 · The role's hardest gate

**The consumed backend.** It is declared untouchable at conditioning: backend, schema and
migrations are coordinated outside the repo — always a human gate. Its contract (schema,
reports) is read, never invented; divergence between contract and deployed behaviour is
recorded as a blocker, not papered over.

Second, **documented version pins are load-bearing**: an exact-pinned client library (example:
an Apollo pin) whose upgrade would break call sites is written into the repo guide as a gate —
fragility cannot be inferred from a lockfile.

Typical gate list this role adds (examples, per repo): touching backend/schema/migrations ·
raising documented pins · adding new dependencies · deploy to hosting/stores · real payments ·
breaking deep/universal links.

## 4 · Self-chosen work order (when the plan runs out)

1. Documented backlog (source docs with unimplemented scope — verified in code, not assumed).
2. Documented parity/port gaps between targets.
3. Marked debt within scope and verification gaps (flows without runtime evidence, broken
   gates).
4. Draft of the next phase as `PROPOSAL` — never self-activated; continue with 1–3 meanwhile.
