# 02 · Model

> The ideas the method rests on. Mechanics — files, commands, states — are document 03; this is
> what those mechanics are *for*. If CDev is ever ported to a different agent, a different
> harness or a different file layout, this is the part that must survive intact.

---

## 1. The repository is the memory

The conversation is not state. It is not durable, not shared, and not verifiable. Everything an
agent must know to continue is written into the repository, in three places with three different
jobs:

| Artifact | Holds | Answers |
|---|---|---|
| The **plan** | Sprints, batches, acceptance criteria, statuses | *What is to be done, in what order, and what counts as finished* |
| The **handoff log** | One honest entry per meaningful step | *What actually happened, what was verified, what is blocked* |
| **Git** | Branches, commits, diffs | *What is true right now* |

The rule that makes it work: **resumption is not remembering, it is reading.** A session that has
lost all context must be able to open those three and continue without asking a human what was
going on. Anything an agent "knows" that is not in one of them is, by definition, lost — so it
must be written down before it can be relied on.

Two consequences that look like small process details and are not:

- **Every step ends written down**, even a failed or abandoned one. An unrecorded step did not
  happen, and the next session will redo it or, worse, contradict it.
- **When the log and the code disagree, the code wins** — and the log is corrected. The handoff
  log is a record of reality, never a wish about it.

## 2. Conditioning precedes autonomy

A repository is not ready for unattended work because an agent is capable. It is ready when the
machinery is *in it*: the plan, the log, the operating protocol, the verification sequence that
actually gates quality here, and the list of things no agent may do.

Conditioning is therefore a distinct, gated, one-off act — **read the real repository, then write
the machinery into it** — and it has two halves that are equally mandatory:

- **Structure** — what the loop will do here: how work is verified in *this* repo, which branch
  convention, which gates.
- **Clarity** — how much of the product is actually specified (§3). Skipping this half is what
  makes autonomy dangerous rather than useful.

The corollary that cost real time to learn: **a generic template cannot condition a repository it
has not read.** Conditioning starts by recognizing the repo — its patterns, its real quality
gates, its irreversible operations — and recording where the generic assumptions must be
overridden. A conditioning that renders templates without that step produces a plan for a
repository that does not exist.

## 3. The clarity map bounds autonomy

Autonomy is not permission to invent the product. An agent that runs out of planned work and
starts deciding what the product should be is worse than an agent that stops.

So every conditioned repository carries a map of **how well-specified each area of the product
is**, scored from the sources that exist — specs, contracts, designs, code:

| Level | Meaning | What the agent may do |
|---|---|---|
| **DEFINED** | Spec plus derivable acceptance criteria | Work it alone, without asking |
| **PARTIAL** | Intent is clear, detail is ambiguous | Work the clear part; record every assumption as a decision |
| **ABSENT** | Only the name exists | **Nothing.** Record an open question. Inventing it is forbidden |

This map is the boundary of self-directed work: when the plan is exhausted, the agent may only
choose new work inside DEFINED and PARTIAL. It converts "how autonomous should the agent be?"
from a feeling into a property of the documentation — and it makes the answer improvable: to
widen autonomy, specify more.

## 4. An explicit autonomy threshold, with explicit stop conditions

"Work autonomously" is not an instruction until both halves are written down: what the agent
decides for itself, and what makes it stop. CDev writes both.

**It decides for itself:** which batch is next in the declared order; how to implement it; how to
diagnose a failure; when a sprint is finished; and — when the plan runs out — what the next work
is, derived in a fixed priority order from documented backlog, gaps in verification, marked debt,
and finally a *proposal* for the next phase that a human must ratify before it becomes active.

**It stops only when:** no ungated work remains anywhere (and it must say precisely which
approvals would unblock what); a safety gate requires a human and everything else depends on it;
the documentation contradicts itself or the needed area is ABSENT; the repository is in an unsafe
state; or the usage quota ends — in which case it saves, records, commits what is safe, and exits
cleanly.

Between those two lists sits the rule that does most of the work in practice:

> **Blocked but not idle.** A blocked unit is marked blocked, with the reason and the *minimum
> decision a human must make*, and the agent moves to the next unit whose dependencies are met.
> Blocked work is never quietly marked done, and a blockage never becomes an excuse to stop.

Note what "blocked" must contain. Not "waiting on human" — the specific decision needed. A
blocker that does not name the decision is a blocker that cannot be cleared without a meeting.

## 5. Safety gates are never elevated

Some actions are not reversible by an agent, and no instruction — including an explicit
invocation of maximum autonomy — may lower them. The elevated threshold raises *what to work on*,
never *what may be executed*.

The gate list is per repository, because irreversibility is per repository. What is universal is
the shape:

- **Anything with blast radius outside the working branch** — publishing to shared branches,
  merging, deploying, rewriting history.
- **Anything irreversible on shared state** — applying schema to a database other people use,
  destructive data operations.
- **Anything that moves real money or touches live credentials.**

Three rules keep the list honest:

1. **Prepare, don't execute.** The agent may write the migration, the command, the manifest — and
   must leave the execution to a human, as a blocker that names the decision.
2. **The strictest wins.** When two layers both have gates (a repo and an orchestrator above it),
   the union applies. A coordination layer may never relax a child's gate.
3. **A past authorization is not a present one.** A decision recorded months ago ("this path was
   approved") is history, not a live approval. Gates require present human authorization.

## 6. Evidence over assertion

A unit of work is finished when its acceptance criteria are met **and the proof is recorded** —
not when the agent believes it is finished.

This forces three habits that are unnatural for a language model:

- **The verification sequence is defined per repository, and it must be the real one.** A build
  configured to ignore type errors is not a type gate. A check that passes because it silently
  skipped is not a check. Conditioning verifies the gates before writing them down.
- **`not-run` is a legitimate, required status.** The handoff log records pass, fail *and*
  not-run per check. An agent that omits what it did not run is not reporting, it is persuading.
- **Runtime evidence is not the same as compilation.** Where the deliverable is observable
  behaviour, "it builds" is not proof — and if the evidence cannot be produced, the honest
  outcome is *blocked*, never *done*.

The same principle applied to diagnosis: when something fails, find the root cause once, where
all callers route through, instead of patching the symptom the report happened to name. Silencing
a check to make a step pass is the exact inverse of this principle, and is prohibited outright.

## 7. In a multi-repo system, truth is local and coordination is global

When one product spans several independently-owned repositories, the temptation is a central
plan that commands them. That inverts ownership and breaks the first idea — each repo stops being
able to continue on its own.

CDev splits authority instead:

| Authority | Owner |
|---|---|
| System objective, which repos participate, cross-repo contracts, system acceptance | The **workspace** |
| Local plan, implementation state, branches, commits, local verification | The **repository** |

From which everything else follows:

- **Divergence resolves toward the repository.** If the workspace believes a unit is done and the
  repo says otherwise, the repo is right and the workspace reconciles. The coordination layer
  never rewrites local state to make its own plan look consistent.
- **The coordination layer does not implement.** It dispatches work to each repository's own
  loop, scoped to a reference. Its output is planning, evidence and verification.
- **Numbering stays independent.** System-level and repo-level plans are two sequences that never
  merge, and a system batch never renumbers or reorders a repo's own plan.
- **Participation is explicit.** A system unit depends only on the references it declares. Repos
  that are not referenced do not participate, do not block, and are not opened "just in case".
- **References are bidirectional.** The system points at a local batch, and the local batch names
  the system unit — so a repository opened alone, with no workspace in sight, still knows why that
  work exists.
- **Dependencies are satisfied by artifacts on disk, pulled not pushed.** A consumer waits for a
  file the producer publishes as part of its own acceptance, and goes looking for it. Agents never
  hand each other state through a conversation, because any of them may die at any moment.
- **Fabricating a cross-repo contract is forbidden.** A consumer without its artifact does not
  invent the shape to keep moving, and does not fake integration evidence: it waits, and the
  orchestrator gives its slot to other runnable work.

---

## The shortest statement of the model

> Write the plan, the state and the proof into the repository. Say exactly how much the agent may
> decide, and bound it by how well the product is actually specified. Say exactly what it may
> never execute, and never lower that line. Accept nothing as finished without recorded evidence.
> When several repositories form one product, coordinate above them without ever taking their
> truth away from them.
