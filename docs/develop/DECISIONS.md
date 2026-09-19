# Decisions and assumptions

Newest-first. Every assumption made under PARTIAL clarity lands here, dated.

## 2026-09-19 — Sprint 10 planned: gap-closing planners + status skills (planner, human present)

Planned by closing gaps with the human batch by batch, through the host's question form —
the behavior the sprint encodes. Human answers, per unit:

- **Sprint.** S09 reconciled to `DONE` as the branch's first commit (PR #5 had merged; the
  plan had not caught up). Layers: planner change = **core** (RFC + field evidence); status
  skills = **new skill** (this entry is the required record; read-only, the loop is
  untouched, so no RFC). One issue (#8), one branch, one PR, one commit per batch. Outward
  acts (issue, Discussion, branch push, PR) **authorized for this session only**.
- **B01.** Evidence lives in a repo file, linked from the RFC by commit permalink. Quotes in
  English marked translated, Spanish original only for the load-bearing few, product
  anonymized. No RFC category exists → Ideas with an `[RFC]` prefix, and rfc-process.md says
  so. Work proceeds on the branch; the **merge** waits on the RFC's "accepted" summary.
- **B02.** No human present → the batch is written `BLOCKED` with each gap's decision and
  suggested answer; never `READY`, never carried on the recommendation. What counts as a gap:
  **the planner's judgment, no written threshold** — held conservatively. The rule lives once,
  in `cdev-planner`; `cdev-monorepo-planner` points at it by path. A question closes
  something undecided: the human's prompt is the intent and is never handed back for
  confirmation.
- **Monorepo skills' evidence.** No workspace fixture will be built. A recorded **field
  exercise by the human** stands in for the sandbox (protocol §4 gains the line; sandbox is
  recorded `not-run`), gathered once, in its own batch (B06), on a throwaway objective whose
  output is discarded — real plans receive nothing from an unmerged skill.
- **The plan's format does not change** (reverses the planner's first draft, which had a
  per-sprint block of ID'd requirements and user stories with per-batch coverage). Human's
  reasoning: sprints and batches already carry the intent in free form; a formalized list
  must be kept current while a feature is still being discovered, and that maintenance is
  what drifts. Consistent with doc 07: it would restate the plan (singularity) where field
  rule 4 says derive on read. Nothing new is asked of the planner beyond gap closing; the
  execution loop is untouched — status reads SPRINTS → DECISIONS → AGENT_PROGRESS, newest
  wins. If field use shows decision changes going unrecorded, that is a future RFC with its
  own evidence.
- **B03.** Percentages are **estimates**, as accepted in the field, labelled as such. Delta
  comes from git on request (`since`), nothing persisted. Default scope: the `ACTIVE` sprint.
  **No isolation machinery**: status is a read operation inside the conversation; CDev is a
  procedure and does not guard the human against their own use of context.
- **B04.** System-level axes plus one compact line per repository.
- **B05.** Version bump to 0.2.0 rides inside the PR; tag, release and marketplace pin after
  the merge, from `main`, by the human.

Planner's own assumptions (not asked — judged derivable; the human may veto):
axis order functional → non-functional → user stories (the human's 2026-09-19 statement
supersedes the August order); `cdev-monorepo-status` points at `cdev-status` by path, by
analogy with the planners' single-home answer; PR merges by merge commit, not squash, to
keep one commit per batch (PR #5 precedent); the walkthrough is not extended.

Finding recorded, not acted on: the monorepo skills have never been sandbox-exercised in this
repository, and S01-B04 closed `DONE` with sandbox `not-run` over skill changes, against
protocol §4's letter. Standing verification debt; B06's field evidence is the first proof
any monorepo skill here will have.

## 2026-08-16 — AGENTS.md is the canonical repo guide (S09-B01, human-directed)

- **Layer: host binding + docs.** Doc 07 §1.2 already says the guide's filename is convention
  ("CLAUDE.md or equivalent") — renaming the convention is not a core change; no RFC needed.
- `AGENTS.md` chosen because it is the cross-agent standard (Codex, Cursor, Jules, Zed…).
  Claude Code keeps working through a pointer `CLAUDE.md` containing `@AGENTS.md` — the import
  mechanism is proven (this machine's own global config uses it).
- Conditioning renders both files; the verifier requires both (it ships with the Claude
  binding). Optional binding templates (night-runner, runbook) keep their CLAUDE.md mentions —
  they run under Claude Code, where the pointer exists.
- First feature to flow through the public branch policy: `feat/agents-md-guide` → PR → main.

## 2026-08-16 — The repo obeys its own contribution policy (human-directed)

From now on every series of changes, including the owner's, is classified against
CONTRIBUTING.md's layer table and meets that layer's process — core changes need an RFC plus
recorded field evidence even when the maintainer writes them. Encoded in the protocol's
"Change policy" section; the planner assigns the layer when writing batches.

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
