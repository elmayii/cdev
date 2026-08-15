# 01 · Origin

> What pain CDev came from, what was tried before it, and why each attempt was abandoned.

## The pain

Four failures, all of them ordinary, all of them fatal to unattended work.

**The agent stops to ask.** Not because something is dangerous, but because the batch it was
given ended. A human who wanted to come back to finished work comes back to a question. The cost
is not the answer — it is that nothing happened while the answer was pending.

**The session dies and takes everything with it.** Context exhausted, quota hit, window closed.
Whatever the agent understood about the plan, the decisions and the half-finished work is gone.
The next session starts by re-deriving what was already decided, and often re-decides it
differently.

**The plan drifts from reality.** A plan that lives in a document nobody updates describes a
project that no longer exists. Worse, an agent reading it will confidently build against a state
that is three sprints old.

**"Done" without proof.** The most expensive failure. An agent reports a batch complete because
the code compiles, or because it believes it wrote the right thing. The claim is unverifiable
later, and it silently poisons every decision built on top of it.

These four are one problem seen from four sides: **the agent's state lives in the conversation,
and the conversation is not durable, not shared, and not verifiable.**

## The first answer, and why it was not enough

The first attempt was a **conditioning kit**: one portable skill (`cdev-bootstrap`) carrying 21
templates and 4 support files that wrote a whole machinery into a target repo — an operating
protocol, a sprint plan, a handoff log, reviewer agents, runtime skills, a watchdog script and a
`.gitignore` convention. Read a folder of product docs, resolve placeholders, render everything,
hand the repo over to an agent.

The idea was right and survives to this day: **the machinery is written into the repo, and the
repo is the memory.** The execution had three problems that only appeared on contact with real
repositories.

### The kit assumed a repository that did not exist

The templates were extracted from one greenfield project and quietly carried its shape: a
brand-new repo, a local one-command database, a specific product domain, universal audited state
transitions. The first mature repo it met contradicted almost every assumption — a running
production backend, a *shared remote* database where applying a schema is irreversible for other
people, an existing and better `CLAUDE.md` the kit would have overwritten, and no test framework
at all.

The fix was not to patch the templates. It was to write a **recognition document** first: read
the real repo, list its actual patterns, and record explicitly where the generic kit's
assumptions had to be overridden before rendering anything. That document — written for two
repositories independently — is where the *role* idea came from. What a backend needs conditioned
and what a frontend needs conditioned are not the same thing, and no amount of placeholder
substitution closes that gap:

- A backend's hardest gate is **the database**: whether applying a schema is a normal verification
  step or an irreversible human decision changes the entire loop.
- A frontend's hardest gate is **the truth of its type check and the existence of runtime
  evidence**: a build that ignores type errors is not a gate, and "it compiles" is not proof that
  a screen works.

So the single kit split into **role-aware conditioning** — one entry point per kind of
repository — over a shared template base.

### The watchdog was the wrong primary

Surviving a quota wall was originally a **PowerShell watchdog** that relaunched the agent every 30
minutes. It worked, and it was the wrong center of gravity: it made continuity a property of the
host machine (one OS, one shell, a process that must stay alive) instead of a property of the
repository.

The insight that replaced it: if the repo really is the memory, then **resumption is just
starting again and reading**. Any session, any operator, any machine. The watchdog survives as an
optional convenience for unattended overnight runs; the primary way to run CDev is to invoke the
loop and let it read the repo. That demotion is the sharpest evidence that the model is right —
the moment the repo became a real memory, the process babysitter stopped being necessary.

### Per-repo skills duplicated the method

Early conditioning vendored runtime skills into each repository. Every repo got its own copy of
"execute a sprint", "verify a feature", "update progress". Four repos meant four divergent copies
of the same method, and a fix to the loop had to be applied four times — or, in practice, once and
forgotten three times.

The correction: **the loop is global, the specifics are local.** A single global skill holds the
operating system — the cycle, the autonomy threshold, the stop conditions. Each repository holds
only what is genuinely its own: its exact verification commands, its branch convention, its
gates, written in its own protocol file. A per-repo skill is now the exception that must justify
itself, not the default.

## The second answer: coordination was not the same problem

Six weeks in, the product spanned four independent repositories — an API, two very different
clients, and a public site — each with its own git, its own remote, its own sprint numbering, and
its own working CDev. Features stopped fitting inside one repo. A single user-visible change
needed a backend endpoint, two clients consuming it, and proof that the whole path worked.

Two obvious approaches were rejected before the third was built:

- **Merge the repositories.** Rejected: it destroys four working autonomies to solve a
  coordination problem, and the repos have independent lifecycles and deploys.
- **Have one agent drive everything from above.** Rejected: it makes the orchestrator the author
  of local work, which duplicates every local rule badly and leaves each repo unable to continue
  on its own.

What was built instead is a **coordination layer that never implements**. It plans system-level
batches, points them at *references* to real batches inside each repo's own plan, dispatches each
reference to that repo's own loop, and verifies the result at the system level. The rules that
make it safe are all corollaries of one sentence — *the repository owns its own truth* — and are
the subject of document 06.

## Timeline

| Date | Event |
|---|---|
| 2026-07-03 | First two repositories conditioned the same day: a mature backend and a two-target frontend. Recognition documents written for both |
| 2026-07 | Role-aware conditioning splits out of the single kit; the execution loop moves from per-repo skills to global ones |
| 2026-08-03 | A third repository, greenfield, conditioned and scaffolded from zero by the frontend conditioning skill |
| 2026-08-07 | The orchestrating workspace is bootstrapped over the (by then) four repositories |
| 2026-08-07 | The fourth repository, until then unconditioned, is conditioned *as part of a system batch* — the coordination layer refusing to invent a child's CDev |
| 2026-08-15 | Development paused to extract the method. These documents |

## What the origin says about the method

Three of the four corrections above are the same correction: **push state and specifics down into
the artifact that survives — the repository — and keep only the operating system above it.**
Templates that assumed a repo failed; a recognition step that reads the real repo worked. A
watchdog that kept a process alive was replaceable; a handoff file that keeps state was not.
Vendored per-repo copies of the loop drifted; a global loop plus local specifics did not.

The fourth correction — coordination as a non-implementing layer — is the same idea applied one
level up: the workspace holds coordination and nothing else, because everything else already has
a durable home.
