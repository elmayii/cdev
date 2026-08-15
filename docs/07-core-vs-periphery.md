# 07 · Core and periphery

> The boundary: what *is* CDev, and what merely grew around it in one product.
>
> This document is written last on purpose. It is derived from documents 05 and 06 — from what
> actually held or broke — rather than from taste. It is what makes the refactor reviewable: every
> later change to the skills should be justifiable as "this is core", "this is a profile", "this is
> a binding" or "this is periphery, it goes".

---

## How the boundary was decided

Four tests. A rule is **core** only if it passes all four.

| Test | Question | Fails if |
|---|---|---|
| **Independence** | Can it be stated without naming a technology, framework or vendor? | It needs "Prisma", "Playwright", "Stripe" to make sense |
| **Evidence** | Did its presence prevent a recorded failure, or did its absence cause one? | It is merely reasonable, and nothing in six weeks depended on it |
| **Portability** | Does it survive a different agent, harness or operating system? | It only means something inside one tool's affordances |
| **Singularity** | Is it stated once, in one home, and not derivable from something already in the core? | It restates another rule, or exists in two places at once |

Everything that fails at least one test still has a place — just not in the core:

- **Role profile** — real and necessary, but *parameterized*: it differs per kind of repository and
  can be expressed as data the core reads.
- **Host binding** — real and necessary to ship, but tied to a particular agent or OS. It must be
  isolated so a port is a rewrite of one layer, not of the method.
- **Periphery** — it came from one product. It does not ship.

---

## 1 · The core

### 1.1 The invariants

These twelve are the method. Everything else in this repository exists to serve them.

| # | Invariant | Test it passes on |
|---|---|---|
| 1 | **The repository is the memory.** Plan, handoff and git hold everything needed to continue; the conversation holds nothing | 178 handoff entries, and resumption never required a human to explain the state |
| 2 | **Resumption is reading, not remembering.** A new session and a resumed one do the same thing | The watchdog became optional the moment this was true |
| 3 | **Conditioning precedes autonomy**, and it has two mandatory halves: structure and clarity | Every repo that ran unattended had both; the one that entered without them was barred from participating until conditioned |
| 4 | **Recognize before you write.** Conditioning reads the real repository and records where generic assumptions must be overridden | Invented twice independently, on the same day, in two repositories |
| 5 | **The clarity map bounds self-directed work.** DEFINED / PARTIAL / ABSENT; inventing an ABSENT area is forbidden | A repo with a written "do not build" ceiling did not invent an API to consume when its plan ran out |
| 6 | **The autonomy threshold is explicit**, and so are the stop conditions | Without them "work autonomously" is not an instruction |
| 7 | **Blocked but not idle.** A blockage marks one unit, names the human decision required, and moves the loop on | Most throughput in the record; nearly every blockage was external |
| 8 | **Gates are never elevated**, the strictest wins, prepare-don't-execute, and a past authorization is not a present one | Six weeks, four repositories, no irreversible action taken by an agent |
| 9 | **Evidence over assertion.** `DONE` requires recorded proof, per check, including `not-run` | The only defence against the failure that is invisible until it is expensive |
| 10 | **The verification sequence is per repository, and must be verified before it is trusted** | A build ignoring type errors and a type check pointed at the wrong project both produced false confidence |
| 11 | **Root cause once, where all callers route through**; never silence a check to pass | |
| 12 | **The batch is the unit**: one branch, one commit, one acceptance, one log entry, finishable before a session dies | Nothing in six weeks argued for a different size |

### 1.2 The artifacts

Core means: the role is required, and it has exactly one writer. Filenames are convention.

| Artifact | Why it is core |
|---|---|
| Plan (`SPRINTS.md`) | Invariant 1. Without it there is no "what is next" to read |
| Handoff log (`AGENT_PROGRESS.md`) | Invariant 1 and 9. The only durable record of what was actually proven |
| Local protocol (`AGENT_EXECUTION_PROTOCOL.md`) | Holds **only** the repo's deltas: its real verification sequence, branch convention, gates. The generic loop must not be copied into it |
| Clarity map (`PRODUCT.md`) | Invariant 5. It is the boundary itself |
| Decisions (`DECISIONS.md`) | Where assumptions made under PARTIAL clarity are recorded. Without it, PARTIAL work is indistinguishable from invention |
| Repo guide (`CLAUDE.md` or equivalent) | The entry point that names the role, the rules and the gates |
| Recognition document | Invariant 4 |

**Demoted to optional** — they exist in the current kit and nothing in the record depended on
them: `ARCHITECTURE.md` and `ROADMAP.md` (orientation, duplicated from the guide), and the
conditioning-plan document, which is greenfield-shaped and was already skipped outright by
frontend conditioning.

### 1.3 The system layer

Core, but only when a product spans several independently-owned repositories.

| Rule | Why it is core |
|---|---|
| **Local truth, global coordination.** Divergence resolves toward the repository, always | The layer's whole legitimacy |
| **The coordination layer does not implement.** It dispatches each reference to the repository's own loop | What stops it from reimplementing four repos' rules badly |
| **References are bidirectional** | 31 declared, 66 back-references written. A child opened alone still knows why the work exists |
| **Two independent numberings**; the system never renumbers or reorders a local plan | |
| **Adopt rather than duplicate** existing local work | |
| **Participation is declared, not inferred.** The dependency graph is advisory | Most of 27 batches touched one or two repos, not four |
| **Sync points: artifacts on disk, pulled by the consumer** | Agents die; conversations do not survive them |
| **Never fabricate a cross-repo contract** — wait or rotate instead | |
| **Two levels of parallelism only**: across repositories, and heterogeneous subtasks inside a batch. Batches within a repository are always sequential | |
| **Verification is levelled and declared per batch** | The only thing that made system verification affordable |
| **Reconciliation before selection**, every start | |
| **The workspace holds no product code** | What lets each child be opened alone |
| **`DONE` = all required references DONE **and** system acceptance PASS** | |

Two current workspace artifacts do **not** pass the tests:

- **The state snapshot file** (`state.lock.json`) — explicitly a photograph, never the decider;
  closing a batch re-reads the children. It restates what reconciliation derives, so it fails
  singularity. Keep it as a cache if it earns its place; never let a decision read it.
- **The dependency graph** as a *file* is fine, but it is advisory by design. It is core as an
  input to planning, not as an authority.

---

## 2 · Role profiles

Necessary, and not method. The two execution loops are near-identical text; what genuinely
differs fits in a table. That table is a **profile**, and a profile may contain exactly four
things:

1. **What "verified" means here** — the sequence, and the traps that make a gate lie.
2. **What "evidence" means here** — tests, or observed runtime behaviour, or both.
3. **The role's hardest gate** — the shared database, the consumed backend, a fragile version pin.
4. **The self-chosen work order** used when the plan runs out.

A profile may **not** contain: a different loop, different stop conditions, a different autonomy
threshold, or a weaker gate policy. If a proposed profile needs any of those, either the core is
wrong or the profile is not a profile.

Two profiles exist with evidence behind them (backend, frontend). A third — a repository that is
both — was anticipated in the dispatcher but never exercised, and should not be shipped as a
profile until something runs on it.

---

## 3 · Host bindings

Everything here is required to ship and none of it is the method. Isolating it is what makes a
port to another agent a rewrite of one layer instead of a rewrite of CDev.

| Binding | Tied to |
|---|---|
| Skill file format and frontmatter, the discovery directories, slash-command invocation | One agent product |
| Subagent dispatch (the repo-runner, the system tester) | One agent product's subagent model |
| Browser-automation tooling as the source of runtime evidence | One tool integration. The *requirement* — observe real behaviour — is core; the tool is not |
| References to external skill packages for debugging, testing and verification discipline | Convenient composition, not part of the method |
| PowerShell scripts: the watchdog, the bootstrap verifiers, the installer | One operating system |
| The `{{PLACEHOLDER}}` template contract | An implementation choice for rendering, not a rule |

The **conditioning self-check** is the interesting case: the PowerShell script is a binding, but
what it checks — no unresolved placeholders, exactly one active sprint, references pointing at
real units — is invariant 3 made executable, and belongs to the core in whatever language.

---

## 4 · Periphery — does not ship

| Thing | Why it is out |
|---|---|
| Everything product-specific in the driven repositories: go-live runbooks, deploy documents, production inboxes, release notes | Product artifacts that accumulated in `docs/develop/` because it was a convenient place |
| Named technologies anywhere in the skills: ORM commands, framework module patterns, a payment provider, a specific UI kit | Fails independence. They belong in a profile as *examples*, or nowhere |
| The port map, test accounts, service ports and startup order | One product's environment. The *requirement* to declare how the system is run is core; the values are not |
| The night-runner watchdog as the primary way to run | Already demoted in practice: continuity is a property of the repository, not of a live process |
| Vendored per-repo runtime skills (`execute-sprint`, `verify-feature`, `update-progress`, `debug-failure`) | The duplication that drifted and forced centralization. The global loop covers all four |
| The Spanish wording of six of the nine skills | An accident of who wrote them |
| Phases as a required grouping above sprints | One product's milestone naming. Optional at most |
| The greenfield conditioning-plan template | Written for a product that no longer exists; frontend conditioning already skips it |

### The consumer report — generalize, do not cut

One convention deserves promotion rather than deletion. The producing repository publishes a
document describing what changed for its consumers, as part of the batch's acceptance. In this
product it was called a frontend integration report; in the system layer the same object appears
as the **sync point** a consumer pulls.

They are one idea: **if a repository has downstream consumers, closing work includes publishing
the contract delta where consumers will look.** That is core. The template, the folder name and
the audience are periphery.

---

## 5 · Unproven — cut unless evidence appears

Two things ship today with no evidence of use, and evidence against.

**The four generated reviewer agents** (`sprint-runner`, `code-reviewer`, `architect-reviewer`,
`test-engineer`). Across the four repositories' handoff logs and decision records they appear once
each — the signature of the bootstrap entry that lists what was created, not of use. And **two of
the four repositories never received them at all and ran six weeks without noticing**. Meanwhile
the loops delegate the same jobs to external skills for debugging, test-first work and
verification discipline.

They are not obviously wrong; they are unevidenced. The honest treatment is to cut them from the
default conditioning and let anything that needs them ask for them, rather than to write four
agent files into every repository forever because the first kit did.

**The `PROPOSAL` state** for an agent-drafted next phase. It exists in the vocabulary and appears
once in six weeks. The rule behind it is sound and cheap — an agent may draft the next phase but
may never activate it — so it stays, but as a rule, not as machinery that needs its own tooling.

---

## 6 · What the field added

Five rules the method does not currently have, each earned by a specific failure in documents 05
and 06. These are core: they pass all four tests, and each has a recorded incident behind it.

1. **A wave must quiesce before the system is verified.** Cross-repo parallelism and system-level
   runtime verification do not compose: runners moving branches underneath a verifier produced
   blocked checks and re-verification by hand. Either the wave finishes first, or runners work in
   isolated copies.
2. **Verification debt must be aggregated, not just recorded.** Closing units as *references done,
   system verification blocked on a human gate* is individually honest and collectively a lie: the
   plan reads finished over a system never exercised end to end. Something must sum it and show it.
3. **Anything resumption depends on must be fixed by the method, not left to taste.** The handoff
   log's ordering diverged across five instances within weeks. Nothing broke, but every agent must
   now *discover* the convention. Whatever is left optional will diverge — so either the method
   fixes it or conditioning writes the choice down explicitly.
4. **Assertions about another repository must be derived on read or verified.** The registry still
   describes a repository with a gap it closed weeks ago. It went unnoticed because nothing
   consumed it — which is exactly why an agent will eventually trust it.
5. **Operational documents inside one repository must not contradict each other, and conditioning
   must check.** The most expensive incident in six weeks came from two runbooks in the same repo
   disagreeing about one switch; the loop believed the wrong one and production inventory went
   invisible for six days. The honesty rules protect against unproven claims. They do nothing
   against inconsistent instructions, and the loop trusts instructions.

---

## 7 · What this implies for the package

Not a decision — the shape is chosen in the refactor. But the boundary above makes one shape
obvious, and it is worth stating so the next step starts from evidence rather than from scratch:

```
core/         the twelve invariants, the artifacts, the loop, the system-layer rules
profiles/     backend, frontend — four things each, nothing more
bindings/     skill format, subagents, scripts, template rendering
```

Which suggests the consolidation that was parked earlier: **one execution loop reading a role
profile, one conditioning skill reading the same profiles, and the system layer as a separate,
optional pair** — because a single-repo user should never have to install orchestration they will
not use. Nine skills become roughly four, and the duplication that this document keeps finding —
two near-identical loops, two near-identical conditioners, role deltas declared both in a skill
and in each repo's protocol — stops being shipped.

The counter-argument deserves recording too: nine discoverable entry points are easier to invoke
and to explain than four parameterized ones, and consolidation risks losing the role-specific
rigour that documents 05 and 06 show was load-bearing. That trade is the first decision of the
refactor, and it now has evidence on both sides.
