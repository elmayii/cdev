# Decisions and assumptions

Newest-first. Every assumption made under PARTIAL clarity lands here, dated.

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
