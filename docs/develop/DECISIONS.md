# Decisions and assumptions

Newest-first. Every assumption made under PARTIAL clarity lands here, dated.

## 2026-08-15 — Open-source strategy materialized (planner, present human authorization)

- **Order:** strategy sprints S05–S08 run before field validation; S04 stays `PROPOSAL` (not
  renumbered, not reordered — the loop only promotes `PENDING`, so S05 is naturally next).
- **Authorized in-session:** rename `master`→`main` + protect `main` in both repos (protection
  must NOT block the owner's direct commits — the loop's local convention depends on them; no
  `enforce_admins`); publish tag + Release `v0.1.0`; agent-made wordmark SVG (human approves
  the asset before it ships in the README).
- **Tooling detected:** `gh` with `repo`+`workflow` scopes covers renames, protection,
  metadata, Discussions enable, releases, Actions. Web-UI-only: social preview upload, custom
  Discussions categories (browser automation possible on request). Always human: launch posts.

## 2026-08-15 — Publishing gate approved (S02-B02/B03, present human authorization in-session)

- Both repos **public**: `elmayii/cdev`, `elmayii/cdev-marketplace`. License **MIT**.
- Plugin installed at user scope from the marketplace; the nine pre-refactor global skills
  retired to `.backups/global-skills-2026-08-15/` (restorable by moving back).
- `scripts/install.ps1` retired: the plugin supersedes the copy-install path and the
  un-namespaced collisions it produced.
- Updates are version-gated: users re-fetch only when `plugin.json` `version` changes —
  doc-only commits after an install do not reach installed copies until a bump.

## 2026-08-15 — Plugin assumptions (S02-B01, PARTIAL area — human may veto)

- **Plugin name: `cdev`.** The obvious default; skills invoke as `cdev:<name>` when namespaced.
- **Version: semver from `0.1.0`.** Pre-1.0 while document 08 does not exist.
- **Author: the repo's git identity** (elmayii).
- Marketplace repo name / account / visibility are NOT assumed — they are the S02-B02 human
  gate.

## 2026-08-15 — Sandbox findings (S01-B02)

- **RTK hook mangles npm script output** on this machine (parses passing lint output as ESLint
  JSON → false exit 1). Unattended runs in fixtures verify via `rtk proxy <cmd>` when a check's
  exit code looks wrong. Environment binding, not method.
- **Dependent batches stack branches**: merging is a human gate, so a batch depending on an
  unmerged predecessor branches from the predecessor's branch. Now written in the loop skill.

## 2026-08-15 — Conditioning decisions

- **Batches commit directly to `master`.** No remote, single operator; the no-shared-branch
  rule protects against a blast radius this repo does not have. Creating a remote or pushing
  remains a human gate. (Override recorded in RECOGNITION.md.)
- **Handoff ordering: newest-first**, fixed in the protocol (field rule 3, doc 07 §6).
- **Only core artifacts written** (doc 07 §1.2): no ROADMAP/ARCHITECTURE/TESTING/RUNBOOK —
  demoted to optional by the evidence, and this repo's operation fits in the protocol file.
- **Sandbox evidence = subagent exercise.** The "runtime" of a skill is an agent following it;
  a fresh subagent driving the touched skill in a `scripts/sandbox.ps1` fixture is this repo's
  runtime evidence.

## 2026-08-15 — Package shape (ratified by the human, recorded first in README)

- Distribution: Claude Code plugin **with marketplace entry from the start**.
- Consolidation: eleven skills → seven; loops and conditioners read `profiles/`.
- One plugin; system layer included.

## Open questions (PARTIAL areas — resolve during Sprint 02)

- Plugin name (`cdev`?), version scheme (semver from `0.1.0`?), author field.
- Marketplace repo: name, host account, visibility. Creation is a human gate.
