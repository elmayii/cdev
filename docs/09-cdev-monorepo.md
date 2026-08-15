# 09 · CDev Monorepo

> What CDev Monorepo is, why it exists, and how one workspace coordinates several autonomous
> repositories without taking ownership of their implementation.

## In one sentence

**CDev Monorepo is a system-level orchestration layer over multiple independently versioned,
independently conditioned CDev repositories.**

It gives a product one place to plan cross-repository work, establish dependencies, exchange
durable handoffs and verify the complete result. Each child repository still owns its code, its
local plan, its branch history, its verification rules and its ability to run `/cdev:cdev` on its
own.

![CDev Monorepo flow: the user plans or executes through the monorepo agent, which sends dedicated prompts to each repository's own CDev agent — waiting where a dependency demands it, resuming after the producer's handoff, parallel where safe and sequential where required](../assets/cdev-monorepo-flow-dark.png)

## Why it exists

CDev first operated directly inside individual repositories. That model worked while a task
started and ended in one codebase: the repository held the plan, the agent executed its local
batches, and a later session resumed by reading the same durable state.

The model became awkward when the product was split across several repositories. A change could
require an API implementation first, then a frontend integration, perhaps followed by another
client. Working this way meant:

- opening and supervising a separate CDev session for every repository;
- deciding manually which repository could move next;
- carrying backend reports, contracts and consequences into the frontend repository by hand;
- keeping several development environments alive, with increasing resource and operational
  overhead; and
- reconstructing the system-level state from several local plans that were individually correct
  but unaware of the complete delivery.

The first implementation emerged while driving a real, in-production product distributed across
four independent repositories (the same one the field reports document). The key question was simple: if CDev could already divide work among
agents inside one repository, why could the same pattern not be applied one level higher, with a
workspace delegating work to each repository's own CDev?

That question produced CDev Monorepo. The manual sequence — finish backend work, write a report,
carry it to the frontend, continue there — became an explicit, durable coordination protocol.

## What “monorepo” means here

The name is intentionally practical, not a claim that every codebase has been merged into one Git
repository. A CDev Monorepo is more precisely a **multi-repository workspace**:

- every child keeps its own `.git`, remote, branches and release lifecycle;
- every child keeps its own CDev documents and can be worked independently;
- the workspace has its own CDev scaffolding and its own Git history for coordination artifacts;
- the workspace versions only system plans, contracts, state and decisions — never child product
  code; and
- registered child paths are excluded from the workspace's versioning.

| Layer | Owns | Does not own |
|---|---|---|
| Orchestrating workspace | System objectives, cross-repo dependencies, contracts, sync points, coordination state and global acceptance | Child implementation details or local state |
| Child repository | Product code, local sprint order, branches, tests, gates, evidence and implementation decisions | The sequencing or acceptance of the whole system |

The boundary is deliberate:

> **The workspace governs coordination. Each repository governs its implementation.**

## How it works

### 1. Condition every repository locally

Each child repository must first be able to operate with CDev by itself. Running
`/cdev:bootstrap` gives it the local plan, protocol, progress log and verification rules that
`/cdev:cdev` needs.

CDev Monorepo does not manufacture missing local knowledge. If a child has not been conditioned,
the workspace reports that gap and waits.

### 2. Condition the workspace

From the directory that contains or references the child repositories, run:

```text
/cdev:bootstrap-monorepo
```

The bootstrap discovers the real repository layout, audits each child's CDev state and creates
the coordination layer: a system plan, repository registry, dependency graph, state snapshot and
contract directory. It does not move or rewrite the child repositories.

### 3. Turn a system objective into local work

Run the planner with the outcome the product needs:

```text
/cdev:cdev-monorepo-planner <system objective>
```

The planner creates a system batch and maps it to real batches in the affected repositories. It
adopts matching local work when it already exists, preserves each repository's current order and
writes references in both directions. If one repository produces something another consumes, the
planner also defines:

- a cross-repository contract;
- a producer → consumer dependency; and
- a **sync point**: the concrete report or artifact the producer must publish and the consumer
  must read.

The planner organizes work. It never implements product code.

### 4. Execute through each repository's own CDev

Run:

```text
/cdev:cdev-monorepo
```

The orchestrator reconciles the workspace with the current state of the participating
repositories, selects the runnable system work and delegates every local reference to that
repository's own `/cdev:cdev` loop.

Independent references in different repositories may run in parallel. Work inside a single
repository remains sequential, because its local plan owns the order. Repositories that are not
referenced by the current system batch are not opened and do not block it.

### 5. Exchange durable handoffs

Repositories do not communicate through an agent's conversational memory. A producer publishes
the artifact declared by the sync point; the consumer looks for that artifact on disk and reads
it before integrating.

If the artifact does not exist yet, the consumer waits and the orchestrator moves to other
runnable work. It does not invent fields, endpoints or types, and it does not mock the adjacent
repository merely to appear unblocked.

### 6. Verify and close at system level

After the required local batches finish, the orchestrator collects their evidence and runs the
verification level declared by the system batch. The batch closes only when all required local
references are done **and** global acceptance passes.

On every later invocation, the workspace reconciles itself again. If a child repository advanced
independently, its local state wins and the workspace updates its view.

## A backend → frontend example

Suppose a feature needs a new API endpoint and a screen that consumes it.

| Step | Owner | Durable result |
|---|---|---|
| Define the complete user-visible outcome | Workspace planner | One system batch with global acceptance |
| Add the endpoint | Backend repository's CDev | Tested implementation plus a technical report describing the real contract |
| Hand off the contract | Workspace sync point | A declared artifact path, not a conversational message |
| Consume the endpoint | Frontend repository's CDev | UI integration based on the producer's actual report or code |
| Prove the feature | Workspace orchestrator | Collected local evidence plus the required system-level verification |

The workspace never writes the endpoint or the screen. It makes their order, contract, handoff
and combined acceptance explicit, then lets the repositories that own them do the work.

## The invariant

The complete mechanism protects one invariant:

```text
Global work must not break local continuity.
Local work must not break global visibility.
```

After a system run, any child repository must still be able to continue alone. After local work,
the next system run must be able to discover and reconcile it.

This is what separates CDev Monorepo from a single top-level agent that happens to edit several
folders. The orchestrator does not absorb the children's authority; it composes it.

## When to use it

Use CDev Monorepo when:

- one product spans multiple autonomous Git repositories;
- features regularly cross repository boundaries;
- each repository needs to preserve its own workflow, gates or deployment lifecycle; and
- manual agent-to-agent handoffs have become a recurring part of development.

Do not add it merely because a repository contains several packages. If one Git repository and
one local CDev can own the complete change safely, the single-repository loop is simpler.

CDev Monorepo also does not guarantee lower compute usage. It prevents irrelevant repositories
from participating and gives concurrency an explicit dependency model, but parallel local agents
still consume resources. Its primary benefit is **coherent coordination and recoverable
handoffs**, not free parallelism.

For the current entry points, see [08 · Installation](08-installation.md) and the source of
[`bootstrap-monorepo`](../skills/bootstrap-monorepo/SKILL.md),
[`cdev-monorepo-planner`](../skills/cdev-monorepo-planner/SKILL.md) and
[`cdev-monorepo`](../skills/cdev-monorepo/SKILL.md). For field evidence from the original
four-repository system, see
[06 · Field report — several repositories as one system](06-field-report-system.md).
