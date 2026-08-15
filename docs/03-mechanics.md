# 03 · Mechanics

> How the method actually operates: what exists on disk, what the loop does, how work is
> structured and how a dead session is resumed. Document 02 is why; this is what.

---

## 1. What conditioning leaves in a repository

Names are the convention used in practice, not a requirement of the model. What matters is that
each role exists exactly once and has a single writer.

| Artifact | Role | Written by |
|---|---|---|
| Repo guide (`CLAUDE.md` or equivalent) | Who the agent is here, architecture rules, gates, pointers. The first thing read | Conditioning; humans afterwards |
| `docs/develop/AGENT_EXECUTION_PROTOCOL.md` | **Local deltas only**: the exact verification sequence, branch convention, repo-specific gates. The generic loop lives in the skill, not here | Conditioning |
| `docs/develop/SPRINTS.md` | The plan: sprints → batches → acceptance criteria → statuses | Conditioning, then the loop |
| `docs/develop/AGENT_PROGRESS.md` | The handoff log: one entry per meaningful step | The loop, every step |
| `docs/develop/PRODUCT.md` | The clarity map (DEFINED / PARTIAL / ABSENT) — the boundary of self-directed work | Conditioning; updated when specs arrive |
| `docs/develop/DECISIONS.md` | Decisions taken and assumptions made, dated | The loop, when it decides something non-obvious |
| `docs/develop/TESTING.md` | What verification means here, and what evidence is required | Conditioning |
| `docs/develop/ARCHITECTURE.md`, `ROADMAP.md` | Operational summaries for orientation | Conditioning |
| `docs/develop/AUTONOMOUS_RUNBOOK.md` | How a human launches, monitors and stops a run | Conditioning |
| Recognition document | What the real repo is, and where the generic assumptions had to be overridden | Conditioning, before writing anything else |

Two files carry the load. **`SPRINTS.md` is the plan and `AGENT_PROGRESS.md` is the truth about
it**; everything else is orientation. If only two files survived, the method would still work.

## 2. How work is structured

```
phase            optional grouping of sprints (a milestone; not all products need it)
└── sprint       a coherent objective; exactly ONE is ACTIVE at a time
    └── batch    the unit of execution: one branch, one commit, one acceptance, one log entry
```

The batch is the load-bearing unit. It is sized to be **finishable and provable in one sitting**,
because a unit that cannot be finished before a session dies can never be recorded as finished.
Every batch carries acceptance criteria written *before* the work, in observable terms — not "the
endpoint is implemented" but "this call returns this shape and this test proves it".

**Exactly one sprint is ACTIVE.** More than one is a planning error and the verification script
that ships with conditioning treats it as such: with two active sprints, "what is next" stops
being answerable by reading, which breaks resumption.

### States

**Sprint:** `PENDING → ACTIVE → DONE` (plus `PROPOSAL` for a phase the agent drafted and a human
has not yet ratified — it can never become ACTIVE on the agent's own authority).

**Batch:** `READY → IN_PROGRESS → DONE`, or `→ BLOCKED` at any point.

```
READY ──────► IN_PROGRESS ──────► DONE          (acceptance met, with recorded evidence)
                   │
                   └────────────► BLOCKED       (reason + the minimum human decision required)
```

`BLOCKED` is not a pause of the run — it is a pause of *that batch*. The loop moves on (§4).

## 3. The loop

**Start — every invocation, including every resumption.** Read, in order: the repo guide → the
local protocol → the plan → the last handoff entries → `git status` and recent commits. Resume
from there. Do not re-derive what was already decided.

If git shows real work that the plan does not know about — commits or a working tree with no
corresponding batch or log entry — **reconcile first**. A plan that has drifted from the code
poisons every decision taken after it, and repo-as-memory does not function while the two
disagree.

**Then, until a real blockage:**

1. **Select** the first `READY`/`IN_PROGRESS` batch of the ACTIVE sprint, in strict declared
   order. Mark it `IN_PROGRESS`. Create the working branch per the local convention — never a
   shared branch.
2. **Implement only that batch.** Reuse before writing; smallest correct diff; additive by
   default so that live contracts do not break.
3. **Verify** with the repository's real sequence. Steps whose blast radius exceeds the working
   branch are prepared, not executed (§6).
4. **On failure, diagnose before fixing**: cite the exact error, find every caller, fix the root
   cause once where they all route through, then re-run the failed command *and* the full
   sequence. Never silence a check to make a step pass.
5. **Record** in the handoff log (§5). Honest status; incomplete is never `DONE`.
6. **Commit** the whole batch on its branch. Useful-but-unfinished work commits as work in
   progress rather than being lost.
7. **Close**: `DONE` only when acceptance is met *with evidence*. Next batch.

## 4. Auto-advance — the part that makes it unattended

The loop does not end when a unit ends.

| Situation | What happens |
|---|---|
| Batch done | Next batch of the sprint |
| Batch blocked | Mark `BLOCKED` with reason + the minimum human decision; move to the next batch whose dependencies are met; if none, the next independent sprint |
| Sprint done | Produce whatever the repo requires on sprint close (e.g. a report for downstream consumers), mark `DONE`, promote the next `PENDING` to `ACTIVE`, continue |
| Plan exhausted | Derive the next work in a **fixed priority order**, staying inside DEFINED/PARTIAL areas of the clarity map: documented backlog → verification and coverage gaps → marked debt → a `PROPOSAL` for the next phase awaiting human ratification. Record what was self-chosen and why |

The priority order matters more than it looks. Without it, "derive your own work" degenerates
into the agent doing whatever it finds most interesting, and the run becomes unreviewable.

## 5. The handoff entry

One entry per meaningful step. Newest-first or append-at-end is a repository choice — **but it
must be one of them, declared, and never mixed**, since resumption depends on finding the latest
entry quickly.

Required fields, because each one answers a question the next session will otherwise have to ask
a human:

| Field | Question it answers |
|---|---|
| Date and unit | *Where am I in the plan?* |
| Status | *Is this finished, in progress or blocked?* |
| What was done | *What changed?* |
| Files touched | *Where do I look?* |
| Verification, **per check: pass / fail / not-run** | *What is actually proven?* |
| Blockers, each naming the decision required | *What do I need a human for?* |
| Next | *What do I do first when I wake up?* |

The `not-run` column is the one that makes the log trustworthy. Omitting a check the agent did
not run turns a report into an argument.

## 6. Branches, commits and publishing

- Work happens on a **working branch per batch**, following the repository's convention. Shared
  branches are never written to directly.
- One commit per batch, with the unit in the message, so the plan and the history can be read
  against each other.
- **Publishing is a gate, always.** Pushing to shared branches, opening pull requests, merging
  and deploying are human acts. The agent prepares them.

## 7. Resumption

There is no special resume path. A session that died mid-batch and a brand-new session do the
same thing: run the start sequence (§3), find the last entry, look at git, continue.

That is the whole point of the model, and it is also the test of it: **if resuming requires a
human to explain anything, the previous session did not record enough.** Two habits keep that
true — exiting cleanly on a quota wall (save, record, commit what is safe) and never leaving a
batch `IN_PROGRESS` in the plan when the working tree says otherwise.

## 8. Invariants

The short list a conditioned repository must always satisfy. Violations are planning bugs, not
style issues:

1. Exactly one `ACTIVE` sprint.
2. Every batch has acceptance criteria that are observable.
3. `DONE` implies recorded evidence, per check.
4. `BLOCKED` implies a named human decision.
5. The plan agrees with git, or the discrepancy is being reconciled right now.
6. No unresolved placeholders left by conditioning.
7. Self-chosen work lies inside DEFINED or PARTIAL areas of the clarity map.
