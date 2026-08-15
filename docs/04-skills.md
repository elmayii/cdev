# 04 · Skills

> What each piece of the package is for, when it fires, what it reads and what it writes.
> This is the technical reference of the current shape — the shape *as used*, not yet the
> refined one. Where the current shape duplicates itself, this document says so and leaves the
> resolution to document 07.

Nine skills in three families:

| Family | Skills | Job |
|---|---|---|
| **Conditioning** | `cdev-bootstrap` · `bootstrap-backend` · `bootstrap-frontend` · `bootstrap-monorepo` | Make a repository (or a workspace) fit to be worked unattended. Runs once |
| **Execution** | `cdev` · `cdev-backend` · `cdev-frontend` | Do the work, batch after batch, until a real blockage. Runs continuously |
| **Orchestration** | `cdev-monorepo` · `cdev-monorepo-planner` | Coordinate several conditioned repositories as one system. Runs continuously, above them |

A rule that spans all three: **the loop is global, the specifics are local.** A skill holds the
operating system; the repository holds its own verification sequence, branch convention and
gates. Vendoring a copy of the loop into a repository is the exception that must justify itself.

---

## Conditioning

### `cdev-bootstrap` — the template base

**Purpose.** The original portable kit: render a complete CDev machinery into a target repo from
a folder of product documents. 21 templates plus 4 support files, with a placeholder contract
(`{{...}}`, zero unresolved at the end) and a verification script.

**Reads.** The product docs folder; the repo's manifest, lockfile, scripts, database presence,
host shell.

**Writes.** Repo guide, conditioning plan, `docs/develop/*`, reviewer agents, runtime skills, the
watchdog script, `.gitignore` additions, a seeded first handoff entry.

**Today it is the base, not the entry point.** The role-aware skills below reuse its templates and
placeholder contract and override what does not fit their role. Its own procedure still assumes a
greenfield repository, which is exactly the assumption that produced the split (document 01).

### `bootstrap-backend` / `bootstrap-frontend` — role-aware conditioning

Same two-half structure, different deltas.

**Half A — structure.** Inspect the repo, then write the machinery *adapted to what was found*:

- Backend: classify the **database**. Shared/remote → applying schema is a permanent human gate
  and the agent may only prepare it. Local/ephemeral → migrating is an ordinary verification step.
  Fix the verification sequence from real scripts; if there is no test framework, installing one
  and writing the first real test becomes the first batch — a backend without a test gate is not
  conditioned.
- Frontend: declare the **consumed backend untouchable** (schema and migrations are coordinated
  outside the repo). Then verify the gates *before* writing them down, because frontend gates lie:
  a type check run with the wrong project config, or a build configured to ignore type errors, is
  not a gate. Runtime evidence through real UI is mandatory before any `DONE`; if the tooling for
  it is missing, that is a written blocking requirement, not an omission.

**Half B — clarity.** Inventory the product sources, order them by authority, score every domain
area DEFINED / PARTIAL / ABSENT, write the clarity map, and derive the plan only as far as clarity
reaches. ABSENT areas produce open questions, never batches.

**Gate.** One human confirmation before writing anything, on a presented table of resolved
placeholders plus the clarity map plus the sprint outline. Existing files are diffed and asked
about, never silently overwritten.

**Honest duplication.** These two skills share their structure, their gate, their clarity half and
most of their wording. What genuinely differs is a handful of deltas — which is precisely the
material for document 07.

### `bootstrap-monorepo` — conditioning the coordination layer

**Purpose.** Turn a folder that happens to contain several independent repositories into a
workspace that coordinates them, **without touching the children**.

**Phases.** Discover child repositories where they actually are (the layout is respected, repos
are never moved) → audit each one's CDev state (`READY` / `PARTIAL` / `NOT_CONDITIONED`) → derive
the system map → scaffold the workspace → give the workspace its own git → take an initial state
snapshot.

**The rule that defines it.** A child found `NOT_CONDITIONED` is a blocker, not a task: the
workspace recommends the right conditioning skill and waits. **The global bootstrap never invents
a child's CDev.**

**Writes.** Workspace guide, `docs/develop/*` at system level, a repository registry, a dependency
graph, a state lock file, a contracts folder, the two workspace agents, a verification script.

---

## Execution

### `cdev` — the dispatcher

**Purpose.** One entry point. Identify what kind of repository this is — from its own guide and
docs, not from a guess — and hand off to the loop that fits. If the repo is not conditioned, it
does not improvise a loop: it proposes conditioning and stops.

**Argument handling.** No argument means *resume whatever the plan says is pending*. An argument
scopes the same loop to a target ("sprint 09").

### `cdev-backend` / `cdev-frontend` — the loops

Both implement document 03: start sequence, batch loop, auto-advance, stop conditions, gates.
Invoking either **is** the elevated-autonomy mandate — work proactively, stop only at real
blockages, never stop to ask what to do next.

Where they actually differ:

| | Backend | Frontend |
|---|---|---|
| Verification | Lint → build → tests; schema formatting/generation local, **applying it is a gate** | Real type gate per target → build per target → **mandatory runtime evidence through the UI** |
| Evidence of "it works" | Tests, not long-running servers | The touched flow driven in a dev server with its dependencies up |
| Multiple targets | Not applicable | Main target first, then port by an explicit convention, parity checked |
| Hardest gate | Shared database | The consumed backend, and version pins documented as fragile |
| Self-chosen work order | backlog → test backfill → hardening → next-phase proposal | backlog → parity gaps between targets → marked debt and missing runtime evidence → next-phase proposal |

Everything else — start sequence, selection, blocked-but-not-idle, honest recording, one commit
per batch, stop conditions, "the strictest gate wins" — is **identical text**. Two loops exist
because two role profiles exist, not because the loop differs.

---

## Orchestration

### `cdev-monorepo-planner` — the planning brain

**Purpose.** Turn a system objective into executable system batches, and find what is missing.
**It never implements code.**

**Mode 1 — materialize an objective.** Define the system batch with an observable objective, the
repos affected (and explicitly those not affected), system acceptance and required verification
level. Then read each affected repo's own plan and place work **respecting local order**: adopt
existing work that already matches rather than duplicating it; append to the active sprint if it
fits; otherwise put it in the next pending local sprint — never renumber, never force a local
sprint active. Write **bidirectional references**. Write a **contract** when the batch touches an
interface between repos. Build the dependency graph. Declare a **sync point** for every
producer→consumer dependency: the concrete artifact the producer publishes as part of its own
acceptance, and the path the consumer will go looking for. Promote to `READY` only when every
required reference exists and every sync point is declared.

**Mode 2 — gap analysis.** Sweep workspace and repos for half-integrated features (done on one
side, unconsumed on the other), contract divergence, CDev health (unconditioned repos, repos with
no active sprint, stale local blocks, unreconciled divergence), asymmetries across a domain, and
coordination debt. Output is a table of candidates with evidence, each becoming a draft system
batch. **Findings not derivable from evidence are not invented** — they become open questions.

### `cdev-monorepo` — the orchestrating loop

**Purpose.** The system-level equivalent of `cdev`. Reconcile, select, dispatch, collect evidence,
verify, close, advance.

**The invariant it protects:**

```
Global work must not break local continuity.
Local work must not break global visibility.
```

After a workspace session, opening a child repo alone and running its own loop must still work.
After independent work inside a child, the next workspace session must detect and reconcile it.

**Dispatch.** One agent per runnable reference, and that agent runs **the repository's own loop**,
scoped to the reference — it never implements on its own authority. Parallelism has exactly two
levels: across repositories (independent references run together, one runner per repo, in waves of
the dependency graph) and inside a batch (heterogeneous subtasks such as read-only investigation
in a neighbouring repo). **Batches within one repository are always sequential** — local order is
sacred.

**Waiting.** A runner whose sync-point artifact does not exist yet returns *waiting*; its slot goes
to other runnable work and it is retried when its producer closes. It does not mock the other
repo's contract to keep moving.

**Closing.**

```
system batch DONE = ALL(required references DONE) AND system acceptance PASS
```

Verification is levelled — from consuming the repos' own evidence, through contract checking and
partial integration, up to full end-to-end — and **each batch declares the level it needs**, so a
single-repo batch is not forced to invent cross-repo tests.

---

## Generated agents

Conditioning writes agents into the repository or workspace; they are dispatched by the loops, not
by the human.

| Agent | Where | Job |
|---|---|---|
| `sprint-runner` | Repo | Execute a batch under the local protocol |
| `code-reviewer` · `architect-reviewer` · `test-engineer` | Repo | Adversarial review and test authorship on demand |
| `monorepo-repo-runner` | Workspace | The bridge: run one repository's own loop for one reference and bring back evidence |
| `monorepo-system-tester` | Workspace | Run the verification level a system batch declares and record pass / fail / blocked |

---

## How they compose

```
                    ┌─ bootstrap-backend ─┐
   not conditioned ─┼─ bootstrap-frontend ┼─► conditioned repo ──► /cdev ──┬─► cdev-backend
                    └─ cdev-bootstrap ────┘                                └─► cdev-frontend
                                                                                    │
   several conditioned repos ──► bootstrap-monorepo ──► workspace                   │
                                                            │                       │
                                        cdev-monorepo-planner ──► system plan       │
                                                            │                       │
                                              /cdev-monorepo ──► repo-runner ───────┘
                                                            └──► system-tester
```

Read bottom-right to top-left, the whole package is one sentence: **conditioning makes a
repository able to be worked alone; the loop works it; the orchestration layer composes several
of them without taking that ability away.**
