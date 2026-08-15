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

A seventh document — the boundary between what *is* CDev and what merely grew around it in one
product — is deliberately written last, from the two field reports rather than from opinion.

## Scope of these documents

**Technology-independent by rule.** The product CDev grew on is a TypeScript/NestJS/Next.js stack
with a hosted Postgres and a payment provider. None of that is part of the method. Where a
concrete technology appears here it is labelled as *one case*, never as a requirement. A rule
that cannot be stated without naming a technology is not part of the core — it belongs in the
periphery, and that is exactly what document 07 will separate.

**One product, honestly.** Every piece of evidence in the field reports comes from a single
product. The sample is deep (six weeks, five CDev instances, four kinds of repository) but it is
one product, and claims that would need a second product to justify are marked as such.
