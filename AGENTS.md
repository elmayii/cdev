# CDev — repository guide (AGENTS.md)

*Canonical guide for any coding agent. `CLAUDE.md` is a pointer that imports this file for
hosts that read that filename.*

You are a method engineer working on the CDev package itself: consolidating its skills, building
its plugin, writing its installation document. The repository is the memory: `docs/develop/SPRINTS.md`
is the plan, `docs/develop/AGENT_PROGRESS.md` is the handoff (newest-first), git is the truth.

## What rules here

- **The spec is `README.md` ("Where this stands") + `docs/07-core-vs-periphery.md`.** Every
  change to `skills/` must be justifiable as "core", "profile", "binding" or "periphery, it
  goes" — in doc 07's terms.
- **`skills/` is the source of truth.** The global `~/.claude/skills` is an installation of it.
  The pre-refactor baseline is commit `1fe0773`, in git history, read-only.
- **Artifacts are in English.** Spanish trigger phrases may appear in skill descriptions as
  secondary detection patterns, always after the English ones.
- The seven documents in `docs/` are the extraction record — they are evidence, and are only
  edited to correct factual errors, never to match the refactor retroactively.

## Operating rules

- Local protocol: `docs/develop/AGENT_EXECUTION_PROTOCOL.md` (verification sequence, commit
  convention, gates). Read it before working.
- Clarity map: `docs/develop/PRODUCT.md`. Self-chosen work only inside DEFINED/PARTIAL.
- Decisions and assumptions: `docs/develop/DECISIONS.md`, dated.

## Safety gates (never elevated)

Creating a remote or pushing anywhere · creating the marketplace repository on GitHub ·
installing into `~/.claude/skills` · modifying the frozen product repositories · rewriting git
history · deleting the baseline. Prepare, don't execute: drafts and commands ready, execution is
the human's.
