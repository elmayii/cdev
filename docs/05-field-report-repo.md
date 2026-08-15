# 05 · Field report — a single repository

> What actually happened when the method met four real repositories. Four different kinds of
> repository, four different answers to the same questions: what does *proof* mean here, what is
> irreversible here, and how much may the agent decide.
>
> Everything below is taken from the repositories' own plans, handoff logs and git history.
> Where a statement is inference rather than record, it says so.

## The four cases at a glance

| | **A · mature backend** | **B · two-target frontend** | **C · greenfield panel** | **D · site conditioned from above** |
|---|---|---|---|---|
| State at conditioning | Running in production, years of code | Brownfield, two targets in one repo | Empty (after a discarded first concept) | Existing, unconditioned |
| Conditioned on | 2026-07-03 | 2026-07-03 | 2026-08-03 | 2026-08-07 |
| Conditioned by | Backend conditioning | Frontend conditioning | Frontend conditioning | Frontend conditioning, **triggered by a system batch** |
| Sprints executed | 13 | 7 | 5 | 2 |
| Handoff entries | 60 | 70 | 27 | 7 |
| Commits (total / plan-tagged) | 206 / 67 | 316 / 30 | 54 / 43 | 84 / 12 |
| Working branches | 17 | 12 | 22 | 5 |
| Test framework at start | Present, **1 test in the whole repo** | **None at all** | None (repo was empty) | None |
| Hardest gate | Applying schema to a shared database | The consumed backend + a fragile version pin | None of its own — it is a pure client | Deploys of a public site |
| Autonomy actually used | Elevated, unattended | **Supervised** — no unattended runs | Elevated | Elevated, scoped by the system batch |

The last row is the one worth pausing on: **the same method ran at two different autonomy levels
inside the same product**, decided per repository, and both worked. Autonomy is a dial that
conditioning sets, not a property of the method.

---

## Case A — a mature backend with a shared database

The repository the generic kit broke on, and therefore the one that taught the most.

**What conditioning had to do differently.** Reading the repo produced a list of contradictions
with the kit's assumptions, each of which became a written override: the repo was not greenfield,
so "conditioning" was not *build the service* but *pay down platform debt already documented*;
the database was shared and remote, so applying schema could not be a verification step; the repo
already had a better guide than the one the kit would have written, so the kit was forbidden from
overwriting it; the kit's universal audit-everything pattern did not exist here and was not to be
invented.

That list is the origin of the **recognition document**, and the fact that a second repository
independently needed the same kind of document on the same day is the evidence that it belongs in
the method rather than in one project's folder.

**What the loop had to respect.** Eleven architectural patterns extracted from the code (how
modules are shaped, which side reads and which writes, additive-only contract changes, where
authorization lives, which refactors are explicitly unwelcome). This is the difference between an
agent that produces code and an agent that produces code that looks like it belongs — and it is
information no template can carry, because it only exists in the repository.

**The test story.** The repository entered CDev with **one** test file in the entire source tree.
Test backfill became a standing item in the self-chosen work order, and every new batch was
required to ship with tests. Six weeks later a single system-level verification records
**38 suites / 380 tests** passing as the routine gate of one batch. Nothing about that was a
separate testing initiative; it was the loop's acceptance rule applied 67 times.

**What broke.** The gate that mattered most — *applying schema is a human decision* — held, but
its neighbours did not always: a configuration switch documented in one runbook as forbidden was
described in another runbook as a required deploy step, and the second one was followed. The
incident that produced (a production toggle that made inventory invisible for six days, found
only when a human noticed a symptom) is not a failure of the loop but of the **artifacts**: two
documents in the same repository disagreed, and nothing in the method forces them to agree.
*Inference:* a conditioned repository needs a cheap consistency check over its own operational
documents, because the loop trusts them.

## Case B — a frontend with two targets in one repository

**The shape.** One repository, one product, two runtimes: a web application and a port of it for
mobile, sharing conventions but not frameworks. For coordination purposes this is **one unit** —
its internal parity is its own business — and that decision is what kept the workspace from
sprouting a "mobile agent" and a "web agent" with a synchronization problem between them.

**Verification when there is no test framework.** There was none, and none was added. Proof was
redefined, explicitly, as: a type check *run with the correct project configuration*, a build per
target, and **runtime evidence of the touched flow driven in a real browser against a live
backend**. Conditioning had to write down two traps in so many words, because both had already
produced false confidence: running the type checker without pointing it at the right
configuration silently checks the wrong project, and the web build was configured to ignore type
and lint errors — so "the build passed" proved nothing at all.

This is the clearest instance of a principle in the model: **the verification sequence is
per-repository and must be verified before it is trusted.** A gate that lies is worse than no
gate, because the loop stops looking.

**Port convention as method.** Work is done and validated in the main target first, then ported by
an explicit, written mapping (same relative path, framework-specific imports removed, environment
access through a wrapper). Parity gaps between targets became a *category of self-chosen work* in
this repo's priority order — the loop can pick up parity debt when the plan runs dry, because the
audit of gaps is a document it can read.

**Supervised, not unattended.** This repository chose to run without a watchdog and to commit only
when asked. Same skills, same loop, lower dial.

**What broke.** Two things, both recorded rather than hidden. Version pins turned out to be load
bearing: a client library pinned to an exact version, upgrading it would break dozens of call
sites, and the pin had to be written into the repo's guide as a gate — the loop cannot infer
fragility from a lockfile. And this repo is the one the workspace registry still describes with a
gap it no longer has (see cross-cutting lessons).

## Case C — a greenfield panel built from zero

**The shape.** An internal panel with no backend of its own: a pure client of the API in case A,
using the same identity provider, with **security living entirely in the backend**. Conditioning
recorded that as the defining constraint — every role check in this repository is user experience,
never a barrier.

**A reboot inside the record.** This repository had previously hosted a different concept (its own
database layer and schema). That concept was discarded, and the repo re-conditioned from scratch.
What is interesting for the method is that the discarding is *written down in the guide* — "if you
find references to the old concept in old commits, ignore them; the current docs are the only
truth" — because an agent reading git history would otherwise resurrect it. **Repo-as-memory means
the repo must also record what stopped being true.**

**Building from nothing.** The first batch of the first sprint was the scaffold itself. Five
sprints and 54 commits later the panel had authentication, a generic paginated table serving every
list, role-gated actions, billing operations and the inventory views. Roughly ten days, unattended
between check-ins. This is the case that shows conditioning is not only for existing code: the
clarity map was derived from an onboarding document and a pair of contract reports, and the plan
went exactly as far as those documents reached.

**A ceiling instead of an invention.** Its documentation carries an explicit list of things the
backend does not offer, marked *do not build*. When the loop exhausted planned work, that list
prevented it from inventing an API to consume. Clarity mapping in its most useful form is often
this — writing down what is *absent* so the agent does not fill the gap.

## Case D — a repository conditioned from the layer above

**The shape.** A public marketing site that was registered in the workspace while explicitly
**unconditioned**, and participated in nothing until it was conditioned.

**Why it matters.** The coordination layer's rule — *never invent a child's CDev* — was exercised
for real. The workspace registered the repo, marked it as not conditioned, adjusted its own
verification script so that unconditioned repos are not required to have the machinery (they are
simply barred from participating), and only then, as part of a system batch, ran the proper
conditioning skill on it. Two sprints of real work followed within days.

The alternative — the orchestrator improvising a plan for a repo it had never read — is exactly the
failure mode the rule exists to prevent, and the record shows the rule holding under time
pressure.

---

## What held across all four

1. **Repo-as-memory survived every session boundary.** 178 handoff entries across five CDev
   instances, and resumption never required a human to explain the state. This is the load-bearing
   claim of the whole method and it is the one with the most evidence behind it.
2. **The batch is the right unit.** Small enough to finish and prove before a session ends, big
   enough to be worth a branch and a commit. Nothing in six weeks argued for a different size.
3. **Blocked-but-not-idle produced most of the throughput.** Nearly every blockage in the record is
   an external dependency — a credential, a human decision, a third-party console — and in each
   case the loop moved to other work rather than stopping. Blocked units were, without exception,
   marked blocked rather than quietly closed.
4. **Gates held.** Across four repositories and six weeks, the irreversible operations
   (shared-database schema application, publishing to shared branches, deploys, live credentials,
   real payments) were consistently prepared and left to a human.
5. **Role-aware conditioning was necessary.** The two roles differ in exactly the places document
   04 lists, and those places are where confident-but-wrong work would otherwise have happened.

## What broke, and what it teaches

1. **Conventions the method left unfixed diverged immediately.** The handoff log's ordering is the
   clearest example: three repositories write newest-first, two append at the end. Nothing broke,
   but it means an agent must *discover* the convention in each repo. The lesson generalizes:
   anything the method leaves to taste will diverge across repositories, so anything that
   resumption depends on should not be left to taste.
2. **Even the recognition document's name diverged** — the same artifact, invented twice on the
   same day, ended up with two different names in two languages. Strong evidence that it was
   needed and equally strong evidence that it was never formalized.
3. **The registry ages.** The workspace still describes case B with a gap ("no root guide file")
   that the repository has since closed. Nothing consumes that field for decisions, which is why
   it went unnoticed for weeks — but a stale registry is exactly the kind of artifact an agent will
   eventually trust. *Inference:* registry fields should either be derived on read or verified by
   the same script that verifies the rest.
4. **Documents inside one repository can contradict each other, and the loop believes them.** Case
   A's production incident came from two operational documents disagreeing about the same switch.
   The loop's honesty rules protect against *unproven claims*; they do not protect against
   *inconsistent instructions*.
5. **Verification levels degrade quietly when a gate blocks them.** Several units closed with their
   local work done and evidence recorded, but the system-level check marked blocked, waiting on a
   human-only step. That is the honest outcome — and it accumulates: a run of such closures leaves
   a plan that looks finished and a system that was never verified end to end. Something has to
   make that debt visible, and nothing currently does.
