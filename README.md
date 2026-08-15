# CDev — Continuous Development

A method for running coding agents **unattended over weeks**, where the repository — not the
conversation — holds the plan, the state and the proof.

An agent session dies. It runs out of context, hits a quota wall, gets closed, or simply ends.
Everything it knew dies with it. CDev's answer is to stop treating the conversation as memory:
the plan lives in `SPRINTS.md`, the handoff lives in `AGENT_PROGRESS.md`, the truth lives in git.
Any session — a new one, a resumed one, a different agent entirely — reads those three and
continues. Nothing is "remembered"; everything is read.

On top of that, CDev answers the question that makes unattended work actually possible: **when is
the agent allowed to decide for itself, and when must it stop?** It answers it with an explicit
autonomy threshold, a clarity map that marks which parts of the product the agent may choose work
in, and a set of safety gates that no invocation can ever lower.

## Status

This repository is an **extraction in progress**. The method was not designed on paper — it grew
out of roughly six weeks of continuous use (2026-07-03 → 2026-08-15) driving a real,
in-production product across four independent repositories plus an orchestrating workspace. The
documents here distill that experience before the method is refined, translated and packaged.

What exists today, and what these documents are extracted from:

| | |
|---|---|
| Skills in use | 9 (conditioning · execution · multi-repo orchestration) |
| Repositories driven | 4, all different in kind, plus 1 orchestrating workspace |
| Local sprints executed | ~27, across 5 CDev instances |
| Handoff entries written | 178 |
| Cross-repo contracts | 7 |

## Documents

| # | Document | Question it answers |
|---|---|---|
| [01](docs/01-origin.md) | Origin | What pain this came from, what was tried first, and why it was abandoned |
| [02](docs/02-model.md) | Model | The ideas the whole method rests on |
| [03](docs/03-mechanics.md) | Mechanics | How it actually operates: artifacts, loop, states, resumption |
| [04](docs/04-skills.md) | Skills | What each skill is for, when it fires, what it reads and writes |
| [05](docs/05-field-report-repo.md) | Field report — single repo | Four real repositories, four different cases: what held and what broke |
| [06](docs/06-field-report-system.md) | Field report — multi-repo | Coordinating four repos as one system: what held and what broke |
| [07](docs/07-core-vs-periphery.md) | Core and periphery | What *is* CDev, what is a role profile, what is a host binding, and what does not ship — derived from 05 and 06, not from taste |

An eighth document, on installation, is written after the package exists — describing what is
actually installed, not what it was planned to be.

## Scope of these documents

**Technology-independent by rule.** The product CDev grew on is a TypeScript/NestJS/Next.js stack
with a hosted Postgres and a payment provider. None of that is part of the method. Where a
concrete technology appears here it is labelled as *one case*, never as a requirement. A rule
that cannot be stated without naming a technology is not part of the core — it belongs in the
periphery, and that is exactly what document 07 will separate.

**One product, honestly.** Every piece of evidence in the field reports comes from a single
product. The sample is deep (six weeks, five CDev instances, four kinds of repository) but it is
one product, and claims that would need a second product to justify are marked as such.

---

## Where this stands

*Written so a session that starts here, with no prior context, can continue. The method's own
first rule applied to itself.*

**Done.** Documents 01–07. The nine skills are vendored in `skills/` exactly as they ran in
production (commit `1fe0773`) — untranslated, unconsolidated, on purpose: that baseline is what
later changes are read against. Two scripts support the loop: `scripts/sandbox.ps1` builds a
throwaway fixture whose `.claude/skills` is a junction to `skills/`, so a session opened inside it
runs what is being edited; `scripts/install.ps1` copies `skills/` into `~/.claude/skills` as a
frozen snapshot, backing up whatever it replaces.

**Decided.** This repository is the source of truth for the skills; the global directory is an
installation of it. Artifacts are written in English. The product this was extracted from is
frozen and is not to be modified.

**Next, in order.**

1. **Refactor the skills** against document 07: English throughout, no product-specific
   references, periphery removed, the five field-derived rules added. Its first decision is the
   one 07 leaves open with evidence on both sides — consolidate to roughly four parameterized
   skills, or keep nine discoverable ones. Every change gets exercised in a sandbox fixture before
   it counts.
2. **Package and install**, then use the installed snapshot for real work.
3. **Document 08 — installation**, written against the package that exists.

**Open, to decide at step 2.** Whether "installable" means the copy script that exists today
(works for one machine) or a proper plugin with its own manifest and marketplace entry (needed if
anyone else installs it).
