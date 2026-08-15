# 06 · Field report — several repositories as one system

> What happened when four independently-owned repositories had to deliver one product. The
> coordination layer ran for nine days at the time of writing; short, but dense enough to break
> in instructive ways.
>
> As in document 05, everything is taken from the workspace's own plan, log, contracts and state
> file. Inference is labelled.

## The numbers

| | |
|---|---|
| Repositories coordinated | 4 (one API, two clients, one public site) |
| System sprints | 3 |
| System batches | 27 (10 · 9 · 8) |
| Local references declared by the system plan | 31 |
| Back-references written inside the children's own plans | 66 |
| Cross-repo contracts | 7 |
| Declared sync points | 9 |
| Coordination entries in the system handoff log | 14 |
| Workspace commits | 53 |

The workspace's git holds **planning, contracts, state and decisions — and no product code at
all**. The children keep their own git, their own remotes and their own branches; the workspace
excludes them from its own versioning entirely. That separation is what lets a child be opened
alone, with no workspace in sight, and still work.

## What the layer actually does

Five mechanisms carry the whole thing.

### References, not commands

A system batch does not describe work. It **points at work** that exists in a child's own plan,
with a status and a dependency. And the child's plan points back at the system batch. The 31/66
figures above are that principle practiced: every system unit resolves to real, locally-numbered
batches, and every affected local batch says why it exists.

The rule that keeps it honest is *adopt rather than duplicate*: when a repository already has a
batch that does what the system needs, the planner adopts it as the reference instead of creating
a parallel one. Two numbering systems, deliberately never merged; the system layer never
renumbers, reorders or forces a local sprint.

### Participation is declared, not inferred

There is a dependency graph of the system, and it is explicitly **advisory** — it informs
planning, it does not decide who takes part. Participation comes only from the references a batch
declares. Repos not referenced do not participate, do not block, and are not opened "just in
case". In practice this is what kept a four-repo system from turning every change into a
four-repo event: of 27 batches, most touch one or two repositories.

### Producer → consumer synchronization by artifact, pulled

Every producer→consumer dependency declares a **sync point**: a concrete file the producer
publishes as part of its own acceptance, at a path the consumer is told to look for. The consumer
goes and reads it before integrating. If it is not there yet, the consumer reports *waiting* and
the orchestrator gives its slot to other runnable work.

Two prohibitions make it work, and both were written after being needed:

- **No mocking the other repo's contract to keep moving.** Unit-level stubs inside a repo remain
  legitimate; fabricating the neighbour's shape is not.
- **No inventing endpoints, fields or types that have not been read from the producer's real
  artifact or code.** Investigation inside a neighbouring repository is read-only; writing into
  another repo is an absolute gate.

Communication between agents happens **through disk**, never through a conversation, for the same
reason the whole method exists: any of them may die at any moment.

An example, from the contract that produced this document's neighbour: an approval endpoint in
the API plus its consumer view in the panel, with the sync point being the API's own client-facing
report, and an invariant written into the contract itself — *the approval marks review state; it
never overrides the plan limits*. Six days later a production incident tested exactly that
invariant, and it had held: the approval was correct, and the failure was elsewhere. A contract
that survives contact with an incident is the strongest evidence available that it was written at
the right level.

### Waves, with exactly two levels of parallelism

Runnable references from **different** repositories execute in parallel, in waves of the
dependency graph, one runner per repository. Inside a repository, batches are **always
sequential** — local order is sacred. The only parallelism inside a batch is heterogeneous
subtasks (a read-only investigator in a neighbouring repo while the main agent builds), and that
decision belongs to the child's own loop, not to the workspace.

Each runner runs **the repository's own loop**, scoped to a reference. It never implements on its
own authority. That single rule is what stops the coordination layer from slowly reimplementing
four repositories' worth of local rules, badly.

### Levelled verification

Every system batch declares how much proof it needs, from *consume the children's own local
evidence*, through *check contracts without running anything*, through *run only the affected
components and exercise the real interaction*, up to *full end-to-end*. A single-repo batch is not
forced to invent cross-repo tests.

This is the mechanism that made system-level verification affordable at all. Without it, every
batch would have demanded the whole system running, and in practice nothing would have been
verified.

### Reconciliation on every start

Before selecting any work, the layer re-reads each relevant child — plan, log, branch, commits —
and **updates itself to match**. Divergence resolves toward the repository, always. The workspace
never rewrites a child's state to make its own plan look consistent.

Its state snapshot file is explicitly a *photograph*, not a source of truth: closing a batch reads
the children, not the snapshot.

## What broke

### Parallel runners raced on shared working trees

The most concrete failure. Batches closed with their local references done and evidence recorded,
but the system-level check marked **blocked by a race between working trees** — the verifier tried
to exercise a running system while runners were still moving branches underneath it. The
workaround was re-verification afterwards, sometimes by a human.

*Inference, and the most actionable finding in this document:* parallelism across repositories and
system-level runtime verification are **mutually exclusive phases**, and the method currently
treats them as if they compose. A wave must quiesce before the system is exercised. Isolated
working copies per runner would also solve it, at a cost.

### Verification debt accumulates silently

Several batches ended as *references done, system verification blocked* — waiting on a
human-only step such as a payment console or a live credential. Each individual outcome is
honest. Their sum is a plan that reads as finished and a system that was never exercised
end to end. The status vocabulary can express it per batch but nothing aggregates it, so the debt
is invisible unless someone reads all 27 entries.

### Statuses go stale between sessions

The plan contains a reference marked blocked with the note *"out of date, re-verify"*, and the
registry still describes one repository with a gap it has since closed. Reconciliation covers the
children's plans; it does not cover the workspace's own older statements about them. *Inference:*
anything the workspace asserts about a child should be either re-derived on read or checked by the
verification script.

### Blockage is the normal state of a coordination layer

Across the plan, blocked units are a third as frequent as completed ones. Almost all of them are
external — a credential, a console, a human decision, a third-party account. That is not a defect;
it is what coordination *is* at the boundary of a real product. But it does mean the layer's value
depends almost entirely on **blocked-but-not-idle** being real: without it, this layer would have
spent most of its life waiting.

## What the layer is actually for

Its output is not code — it never writes any. Its output is:

- a plan in which cross-repo work exists as *real, locally-owned batches*;
- contracts written before the work, at a level that survives contact with reality;
- evidence collected from the children and kept where the system can be judged;
- and the guarantee that after all of it, **each repository can still be opened alone and
  continued**.

That last one is the acceptance criterion of the whole layer. Everything else it does is
negotiable; that is not.
