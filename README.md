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
| [08](docs/08-installation.md) | Installation | What is actually installed, how, and what deliberately is not — written after the package existed |

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

**Done.** Documents 01–07. The nine skills were vendored in `skills/` exactly as they ran in
production (commit `1fe0773`) — untranslated, unconsolidated, on purpose: that baseline lives in
git history and is what later changes are read against. The working tree has since been
remastered into English (commit `849c1e8`), faithful in structure, with Spanish trigger phrases
kept as secondary detection patterns. Two post-extraction skills were added directly in English:
`cdev-planner` (the monorepo planner's single-repo counterpart — materialize an objective into
local batches, or gap-analyze one repo) and `ockham` (a user-invoked presentation layer that
re-tells dense technical output in plain terms; never fires on the loop's own initiative). Two scripts support the loop: `scripts/sandbox.ps1` builds a
throwaway fixture whose `.claude/skills` is a junction to `skills/`, so a session opened inside it
runs what is being edited. (A second script, `install.ps1`, copied `skills/` into
`~/.claude/skills`; the plugin superseded it and it is gone.)

**Decided.** This repository is the source of truth for the skills; the global directory is an
installation of it. Artifacts are written in English. The product this was extracted from is
frozen and is not to be modified. And, decided 2026-08-15, the package shape:

- **Distribution is a Claude Code plugin with a marketplace entry**, from the start — namespaced
  skills (`cdev:*`), real versioning (the frozen snapshot becomes installing a version),
  installable by third parties with one command. The copy script survives only as a dev-mode
  convenience.
- **The eleven skills consolidate to seven.** One execution loop (`cdev`, dispatcher included)
  and one conditioning skill (`bootstrap`) both read role profiles — `profiles/backend.md`,
  `profiles/frontend.md`, each holding exactly the four things document 07 allows a profile.
  `cdev-planner` and `ockham` stay as they are. The role-specific rigour is preserved as data,
  not duplicated as loops.
- **One plugin, system layer included.** `cdev-monorepo`, `cdev-monorepo-planner` and
  `bootstrap-monorepo` ship in the same plugin; a single-repo user simply never invokes them.

**Shipped, 2026-08-15.** All three steps above are done, executed by the method itself — this
repository was conditioned (`docs/develop/`) and the work ran as three sprints with sandbox
evidence per batch:

1. **Consolidation refactor** — eleven skills became seven; the two loops and two conditioners
   now read `profiles/`; periphery removed; the five field-derived rules placed. Four sandbox
   exercises by fresh agents back it.
2. **Plugin and marketplace** — `cdev` 0.1.0 at `.claude-plugin/plugin.json`, published as
   [`elmayii/cdev`](https://github.com/elmayii/cdev) and served by
   [`elmayii/cdev-marketplace`](https://github.com/elmayii/cdev-marketplace); installed and
   verified (namespaced `cdev:*`, complete cache copy). MIT.
3. **Document 08** — installation, written against what was verified, not planned.

Install: `/plugin marketplace add elmayii/cdev-marketplace` →
`/plugin install cdev@cdev-marketplace`. The old copy-install script is retired; `sandbox.ps1`
remains the way changes get exercised before they count.

**Next.** Proposed, awaiting ratification (see `docs/develop/SPRINTS.md`): a field-validation
phase — drive real work with the installed plugin and collect the second-product evidence the
field reports say the method still lacks.
