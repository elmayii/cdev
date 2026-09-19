# SPRINTS — the plan

Statuses: sprint `PENDING → ACTIVE → DONE` (+`PROPOSAL`); batch `READY → IN_PROGRESS → DONE`,
or `→ BLOCKED` (reason + minimum human decision). Exactly one sprint ACTIVE.

---

## Sprint 01 — Consolidation refactor `DONE`

Objective: eleven skills become seven, per doc 07 and the recorded decisions. Every change
justified as core / profile / binding / periphery-goes.

### B01 — Extract role profiles `DONE`

Create `profiles/backend.md` and `profiles/frontend.md`. Each contains **exactly four
sections** (doc 07 §2): what "verified" means (sequence + the traps that make gates lie), what
"evidence" means, the role's hardest gate, the self-chosen work order. Content distilled from
the current `cdev-backend`/`cdev-frontend`/`bootstrap-backend`/`bootstrap-frontend`.

**Acceptance:** both files exist; four sections each, nothing more; every statement traceable
to a current skill or doc 07 §2; language check passes.

### B02 — Consolidate the execution loop `DONE` (depends: B01)

Merge `cdev` + `cdev-backend` + `cdev-frontend` into one `cdev` skill: dispatcher resolves the
role from the repo, loads the matching profile, runs the single loop. The consumer-report rule
generalizes role-independently (doc 07 §4: publishing the contract delta where consumers look
is part of closing work when downstream consumers exist). Delete the two merged skill dirs.

**Acceptance:** one `skills/cdev/SKILL.md`; no loop text duplicated anywhere; sandbox exercise
of one backend scenario and one frontend scenario, outcomes recorded; verification sequence
checks 1–2 pass.

### B03 — Consolidate the conditioner `DONE` (depends: B01)

Merge `bootstrap-backend` + `bootstrap-frontend` over the `cdev-bootstrap` base into one
`bootstrap` skill reading the same profiles: shared two-half structure (structure + clarity),
single human gate, role deltas from `profiles/`. Cut from the default the four generated
reviewer agents and the vendored per-repo runtime skills (doc 07 §5 — unevidenced); templates
pruned accordingly. `cdev-bootstrap` folds into `bootstrap` as its template base.

**Acceptance:** one `skills/bootstrap/SKILL.md`; templates for reviewer agents and per-repo
skills removed from the default render list; sandbox exercise of one conditioning scenario;
checks 1–2 pass.

### B04 — Periphery removal + the five field rules `DONE` (depends: B02, B03)

Across the remaining skills: remove product references (Compiss, F6 paths, compiss/monorepo)
and named technologies from core rule text (examples move to profiles/templates). Add the five
field-derived rules of doc 07 §6 where they belong: wave quiescence before system verification
and aggregated verification debt → `cdev-monorepo`; fixed handoff ordering, derive-on-read for
assertions about other repos, operational-doc consistency check → `bootstrap` and `cdev`.
Demote the night-runner to an explicitly optional binding.

**Acceptance:** periphery check (protocol §3) passes; each of the five rules present, each
stated once, in the right skill; checks 1–2 pass.

### B05 — Sprint verification + report `DONE` (depends: B04)

Full verification sequence over the final skill set. Write the sprint report: what was
consolidated, what was cut, what moved to profiles — the consumer-facing contract delta for
Sprint 02.

**Acceptance:** all four protocol checks pass over `skills/` + `profiles/`; report exists in
`docs/develop/reports/s01.md`.

---

## Sprint 02 — Plugin and marketplace `DONE`

Objective: the package installable as a Claude Code plugin, from a marketplace repository.

### B01 — Plugin manifest `DONE`

`.claude-plugin/plugin.json` (name, version, description, author), schema confirmed against
current Claude Code docs, layout already in place from Sprint 01. **Acceptance:** manifest
valid; a local install (`claude plugin` tooling or documented equivalent) loads the plugin and
its 7 skills resolve profiles/templates from the plugin root.

### B02 — Marketplace repository `DONE` (depends: B01)

*Gate approved in-session (public + public, MIT, names confirmed). `elmayii/cdev` and
`elmayii/cdev-marketplace` created and pushed.*

Marketplace manifest prepared as drafts in this repo; creation of the GitHub repository and
push are a **human gate** (decisions: repo name, account, visibility). **Acceptance:** drafts
complete and documented; blocker names the exact decisions; after human approval, install from
the marketplace works.

### B03 — Install and verify `DONE` (depends: B02)

*Installed from the marketplace (scope: user). Installed copy verified complete (profiles/,
templates/, 7 skills); plain-session load lists all 7 as `cdev:*`; the nine pre-refactor
global skills retired to `.backups/global-skills-2026-08-15`.*

Install the plugin from the marketplace (or local path while B02 is gated), run one sandbox
scenario against the **installed** copy (not the working tree), record evidence.
**Acceptance:** installed skills exercise cleanly; open questions in PRODUCT.md resolved as
dated DECISIONS entries.

## Sprint 03 — Document 08, installation `DONE`

### B01 — Write document 08 `DONE`

`docs/08-installation.md`, written against the package that exists: what is actually
installed (cache layout, namespaced skills, what rides along), how to install (marketplace +
local dev), how to update (version-gated), what is deliberately not installed, and the dev-mode
workflow of this repo. README updated (documents table + "Where this stands");
`scripts/install.ps1` retired — the plugin replaces the copy-install path it implemented.
**Acceptance:** the document describes only what exists and was verified; README consistent;
language check passes.

---

## Sprint 04 — Field validation `PROPOSAL` (awaiting human ratification)

Objective: drive real work with the **installed** plugin on at least one repository that is
not this one, collecting second-product evidence. Deliberately kept `PROPOSAL`: the human
ordered the open-source strategy (S05–S08) first, 2026-08-15. Batches to be materialized by
`/cdev:cdev-planner` against the chosen target repo once a human names it.

---

## Sprint 05 — Open-source readiness `DONE`

Source: `the internal strategy document (local, gitignored)` §22 Phase 1. Gates pre-authorized
in-session (see DECISIONS 2026-08-15); external-communication acts remain human forever.

### B01 — Branch policy `DONE`

Rename `master`→`main` in `elmayii/cdev` and `elmayii/cdev-marketplace` (API; GitHub
redirects). Protect `main` in both: PR required for others, no force pushes, no deletion —
**without** `enforce_admins`, so the owner's direct commits (the loop's own convention) keep
working. Update local clones' tracking. **Acceptance:** `gh repo view` shows `main` default in
both; protection active; a local commit+push by the owner still succeeds.

### B02 — Repository metadata `DONE`

Description ("Continuous Development Framework for Coding Agents."), the nine topics from
strategy §4.1, wiki disabled, Discussions enabled (API). **Acceptance:** `gh repo view` shows
all four changed.

### B03 — Community health files `DONE`

`CONTRIBUTING.md` (branch model §15, contribution table §12 — core changes need field
evidence, field reports accepted without code), `CODE_OF_CONDUCT.md` (Contributor Covenant),
`SECURITY.md`, `CHANGELOG.md` (seeded with 0.1.0). **Acceptance:** four files exist, language
check passes, CONTRIBUTING states the RFC rule for core changes.

### B04 — Issue and PR templates `DONE`

`.github/ISSUE_TEMPLATE/{bug,feature,field-report,config}.yml` (field-report form carries the
strategy §13 template fields) + `.github/PULL_REQUEST_TEMPLATE.md`. **Acceptance:** forms
render on GitHub's new-issue page.

### B05 — Release v0.1.0 `DONE` (depends: B01–B04)

Tag `v0.1.0` on `main`, GitHub Release with the §5 notes (what CDev is, what ships, the
Claude Code binding, install, known limitations, what is experimental). **Acceptance:**
release public; `plugin.json` version and tag agree.

### B06 — Verification + report `DONE` (depends: B05)

Protocol checks + every acceptance above re-verified via `gh`; report at
`docs/develop/reports/s05.md`. **Acceptance:** all checks pass; report exists. *(One recorded
not-run: issue-form render needs a signed-in glance — see the report.)*

---

## Sprint 06 — Five-minute README `DONE`

Source: strategy §6–§10, §21, §22 Phase 2.

### B01 — Visual identity `DONE`

*Second iteration approved: the human supplied a master icon (`assets/icon.png`); its palette
was sampled (#070A16/#0045ED/#00E8E5) and its geometry (loop + checks + arrow + slash)
rebuilt as flat vectors — mark light/dark, wordmark lockups, social preview. First
(indigo/slate) proposal rejected and deleted.*

`assets/` with the wordmark SVG (`/cdev` + continuous line through verified checkpoints; no
robots/brains/sparkles). Social-preview PNG rendered from it, left prepared — uploading is
web-UI manual. **Acceptance:** SVG renders; human approves the asset (blocker until then);
PNG at the exact 1280×640 GitHub size.

### B02 — README redesign `DONE` (depends: B01 approval)

Hero + positioning, the four failure modes, lifecycle diagram, Quick Start (verified
commands), command table (§8), "which command when" by project phase (§9), method-vs-binding
statement (§10), links to docs/evidence/CONTRIBUTING. Internal state shrinks to a link to
`docs/develop/`. **Acceptance:** README contains all §22-2 items; every command shown was
executed at least once in the record; language check passes.

### B03 — Verification + report `DONE` (depends: B02)

Links resolve, render checked, report `s06.md`. **Acceptance:** checks pass; report exists.

### B04 — Official-repo cleanup `DONE` (depends: B03; appended 2026-08-15, human-agreed)

Restrict from git, keep locally in place (approach corrected by the human 2026-08-16): the
launch drafts (`docs/develop/launch/`), the launch report (`reports/s08.md`), the internal
strategy document and the `marketplace/` draft dir stay at their original paths but are
**gitignored** — removed from the branch by the cleanup commit, retained in history, never
republished; root-level `.txt` transcripts ignored by pattern. **Acceptance:** the paths exist
on disk, `git status` shows none of them, the branch carries none of them, history untouched.

---

## Sprint 07 — Community structure `DONE` (ran while S06 blocked at entry — blocked-but-not-idle)

Source: strategy §12–§14, §22 Phase 3.

### B01 — Contribution mechanics `DONE`

RFC process doc, label set created via `gh label`, initial `good first issue` candidates
drafted from the repo's own known leftovers, welcome/announcement Discussion posted via API.
**Acceptance:** labels exist; RFC doc linked from CONTRIBUTING; one Discussion live.

### B02 — Examples and showcase `DONE`

A worked example: conditioning + one loop run on a sandbox fixture, written as a walkthrough
users can replay. **Acceptance:** every command in the walkthrough replayed this sprint.

### B03 — Verification + report `DONE` (depends: B01, B02)

Report `s07.md`. **Acceptance:** checks pass; report exists.

---

## Sprint 09 — Agent internationalization `DONE`

Objective: conditioned repositories usable by any coding agent, not just Claude Code. First
externally-visible feature to flow through the public branch policy (branch → PR → main).

### B01 — AGENTS.md as the canonical repo guide `DONE`

*Closed by the human merge of PR #5 (`ec82495`, 2026-08-16); plan reconciled with git on
2026-09-19, human-approved — the handoff entry had recorded the close, the plan had not.*

**Layer: host binding + docs** (doc 07: the guide's filename is convention, not core — no RFC
required; classification recorded in DECISIONS). `AGENTS.md` becomes the guide every
conditioning renders; hosts that read another filename get a pointer (`CLAUDE.md` containing
`@AGENTS.md`). This repo migrates its own guide the same way. Skills, verifier, templates and
walkthrough read the guide by its neutral name. **Acceptance:** sandbox conditioning renders
`AGENTS.md` + pointer and `BOOTSTRAP VERIFY: PASS`; Claude Code still loads the guide through
the pointer; `claude plugin validate` passes; PR opened against `main` with the template's
evidence checklist satisfied — merging is the human act.

---

## Sprint 08 — Launch `DONE` (drafts only — every publish act is a named human decision; launch sequence also waits on S06)

Source: strategy §22 Phase 4. Copy is agent work; **publishing each post is a human act,
always** — the batch closes as prepared-with-blocker, never as posted.

### B01 — Launch copy `DONE`

Drafts in the local launch drafts (gitignored): HN (Show HN), Reddit, X thread, LinkedIn, Claude Code
community post — built on the two approved hooks ("sessions → continuous development" and the
spec-driven origin story §18–§19). **Acceptance:** one draft per channel; each ends with the
named human decision (publish or not).

### B02 — Verification + report `DONE` (depends: B01)

Report `s08.md`; sprint closes with the publish blockers listed. **Acceptance:** report
exists; blockers name each pending post.

---

## Sprint 10 — Measurable intent: gap-closing planners and status skills `ACTIVE` (ratified by the human, 2026-09-19)

Objective: a sprint's open decisions are closed with the human before each batch is written,
and progress is measurable at any time from the repository alone — engineered at read time
from the raw chain sprint → batch → handoff, never from a maintained list of requirements.
The plan's format does not change (human decision, 2026-09-19: formalized requirements must
be kept current while a feature is still being discovered, and that maintenance is what
drifts). Source: issue #8; field evidence mined from the maintainer's prompt history.

Delivery: one branch (`feat/8-status-and-gap-closing-planners`), **one commit per batch**, one
PR carrying `Closes #8` and declaring both layers (core + new skill). Merging is the human act
and additionally waits on the RFC's "accepted" summary — work proceeds on the branch meanwhile
(blocked-but-not-idle). Outward acts of this sprint (Discussion, issue, branch push, PR) were
authorized in-session on 2026-09-19; in any later session they are gates again.

### B01 — Field evidence and the RFC `IN_PROGRESS`

**Layer: docs — the prerequisite the core layer demands** (RFC + recorded field evidence).
Write `docs/develop/reports/s10-field-evidence.md`: the two habits as the record shows them.
(a) Planner gap-closing: 16 launches, 10 with a hand-written instruction, 5 spelling out the
per-batch protocol; the 2026-08-16→17 incident (bare launch, five plan files, zero questions,
rollback, the agent's own "fixed without asking"); the two other failure shapes (questions
dumped up front as prose; sprint-level questions letting a batch gap surface after writing);
the 2026-09-01 reference run (ask → write → ask → write). (b) Three-axis status: three
requests, one session, produced from in-session context (two with zero file reads), the
agent's own "derived / estimated" statement, the accepted output shape. (c) A **"not
evidenced"** section: no three-axis status in a single repo, no cold-start status ever, no
recorded hallucination incident — that concern is prospective and is stated as such.
Quotes in English marked as translated, the Spanish original in italics only for the four or
five load-bearing ones, product anonymized, pointer = date + prompt index in the local history.
Then: push the branch, open the RFC as a Discussion in **Ideas** titled `[RFC] …` following the
five template headings and linking the evidence by commit permalink; comment on #8 with the
link. `docs/community/rfc-process.md` gains the interim rule (until an RFC category exists,
RFCs go to Ideas with the `[RFC]` prefix).

**Acceptance:** the evidence file exists and every claim carries its pointer; the "not
evidenced" section exists; product-name sweep (protocol §3 patterns) over the file returns
zero; `bash scripts/validate.sh` passes (links resolve); the Discussion is live, in Ideas,
`[RFC]`-prefixed, five headings present, permalink resolving; #8 shows the linking comment;
rfc-process.md states the interim rule. Skill checks: n/a — no skill touched.

### B02 — Planners close gaps per batch, before writing `READY` (depends: B01)

**Layer: core methodology** (the RFC of B01; the PR's merge waits on its acceptance).
One new section in `skills/cdev-planner/SKILL.md` — the rule's **single home** — placed in
Mode 1 between placing the work and writing it:

- The batch grouping is shown to the human first.
- Then, for each batch in order and **before writing it**: the decisions the batch would
  otherwise fix on its own are put as questions, each with suggested answers and one marked
  recommended. Ask → record the answers → write that batch → next batch. A batch that raises
  no gap asks nothing. Permissions and tool connections the batch will need are gap sources.
- What counts as a gap is the planner's judgment — no written threshold (human decision,
  2026-09-19) — held conservatively: assume almost nothing; never ask what repository evidence
  already settles. What it judges not worth a question is still recorded as a dated assumption.
- A question closes something undecided. The human's prompt is the statement of intent: the
  planner interprets it and never hands it back for confirmation.
- Sprint-level decisions may be asked once up front; they never replace the per-batch rounds.
  Never one questionnaire for every batch, never a question about a batch already written.
- A free-text answer is an answer. Answers land in `DECISIONS.md`, dated, per batch.
- **No human present** (the planner invoked from an unattended loop): a batch with open gaps
  is written `BLOCKED`, each gap naming the minimum human decision and the suggested answer.
  Never `READY`, never carried forward on the recommendation.
- Host binding, stated as such: where the host offers a structured question tool it is used;
  otherwise numbered questions with lettered options, one batch per message.

`skills/cdev-monorepo-planner/SKILL.md` does **not** restate the rule: it points at that
section by path (resolved to the real path, the way `cdev` reaches `profiles/`), applies it per
SYSTEM_BATCH, and lists only its own gap sources — repo participation, cross-repo contract
terms, the sync-point artifact, implementation/deploy order, verification level. The two
execution loops' planner invocations are re-read for contradiction with the `BLOCKED` rule
(field rule 5). Protocol §4 gains the local line: while no workspace fixture exists, a recorded
field exercise by the human stands in for the sandbox exercise of a monorepo skill, and the
sandbox check is recorded `not-run`. `CHANGELOG.md` gains the behavior bullet.

**Acceptance:** (1) *Attended sandbox, `cdev-planner`:* conditioned fixture, an objective
spanning at least three batches of which one raises no gap, a driver answering as the human.
The recorded timeline shows the grouping first; for every gapped batch its questions — each
with two or more suggested answers and one recommended — **precede** that batch's write in
`SPRINTS.md`; the gap-free batch is written unasked; nothing reaches `SPRINTS.md` before the
first answer; `DECISIONS.md` holds the dated answers. (2) *Unattended variant:* same fixture,
no human — gapped batches are `BLOCKED` with decision + suggested answer, none `READY`.
(3) *Baseline:* the attended scenario run once against `main`'s planner, the difference
recorded. (4) The rule's text appears once: `grep` finds it in `cdev-planner` only, and a path
pointer in `cdev-monorepo-planner`. (5) Protocol checks 1–3 pass. `cdev-monorepo-planner`:
sandbox `not-run` (declared, no fixture) — its evidence is the human field exercise of B06.

### B03 — `cdev-status`: progress on three axes, engineered at read time `READY`

**Layer: new skill / capability** — read-only, does not alter the loop, so no RFC; the
required record is the dated DECISIONS entry (2026-09-19). New `skills/cdev-status/SKILL.md`:

- Requires a conditioned repo; otherwise proposes `bootstrap` and stops.
- Scope: the `ACTIVE` sprint by default; an argument names another sprint, or `all` for a
  sprint-by-sprint rollup of the project.
- Reads the raw chain, in order: repo guide → `SPRINTS.md` (the sprint's objective and every
  batch's text and state) → `DECISIONS.md` → the `AGENT_PROGRESS.md` entries of that sprint's
  batches → `git` log and status → whatever files the sprint or its batches reference
  (contracts, reports, a testing document where one exists). Where a later record changes an
  earlier decision, the newest wins and is the one cited.
- Engineers the three axes **at read time**, in this order: functional requirements (what the
  sprint's objective and batches commit the system to do) → non-functional requirements (the
  qualities and constraints they commit to) → user stories, built over the first two against
  the sprint's objective, first person, marked new or enriched. Every item cites where it
  came from. Nothing is written back: the plan holds no requirement list to maintain.
- State per item: met · partial, with an **estimated** percentage, the reason and the owning
  batch · pending, with the owning batch. Each axis carries an estimated percentage over the
  sprint's total; a method note says the items are derived and the numbers are estimates.
- Output, the shape accepted in the field: title → method note → §1 functional requirements
  (`State | Requirement`, heading with the percentage and batches X of N) → §2 non-functional
  requirements (same table) → §3 user stories grouped complete / partial / empty → executive
  reading (batches closed, the three percentages, where the remaining work converges, live
  risks: blocked batches and pending human decisions) → what is left to reach 100%.
- `since <batch|date|commit>`: reads the plan and the handoff at that point of the git history,
  applies the same item list to both states, shows "(before NN%)" and marks what changed. No
  argument, no delta. Nothing is persisted.
- An axis the repository does not support reads **"not derivable"** and names what is missing.
  It is never filled from general knowledge.
- Disagreement between plan, handoff and git is flagged, never resolved (a `DONE` whose entry
  records a `not-run` check reads "met, unverified").
- Read-only, always: it edits no file and marks no state. Something the conversation surfaces
  that belongs in the plan is the planner's job, not this skill's. No isolation machinery —
  status is a read operation inside the conversation; CDev is a procedure and does not guard
  the human against their own use of context (human decision, 2026-09-19).
- Answers in the language the human is using.

`CHANGELOG.md` gains the bullet.

**Acceptance:** (1) *Cold-start sandbox:* a conditioned fixture whose active sprint has at
least four batches in mixed states (`DONE` with handoff evidence, `DONE` with a `not-run`
check, `IN_PROGRESS`, `READY`, one `BLOCKED`) and one DECISIONS entry that changes a planned
decision; a **fresh subagent with no planning context** runs the skill. Its answer has the
three axes in the stated order; every item cites a path that exists; partials carry
percentage + reason + owning batch; the changed decision appears in its newest form citing
DECISIONS; the `not-run` item reads unverified; the executive reading is present; and
`git status` in the fixture is clean afterwards. (2) *`since`:* with a batch closed between
two fixture commits, the delta appears and the changed item is marked; without the argument
there is none. (3) *Not derivable:* a sprint carrying no non-functional signal yields that
axis as "not derivable" naming what is missing — no invented item. (4) Unconditioned repo →
proposes `bootstrap`, stops. (5) Protocol checks 1–3 pass; `claude plugin validate .` passes;
the skill lists as `cdev:cdev-status`.

### B04 — `cdev-monorepo-status`: the same three axes for a SYSTEM sprint `READY` (depends: B03)

**Layer: new skill / capability** (same record as B03). New
`skills/cdev-monorepo-status/SKILL.md`. It does **not** restate the three-axis method or the
output shape: it points at `cdev-status` by path (resolved to the real path) and adds only
what is system-level:

- Requires a conditioned workspace (`workspace/repos.yaml` + a global `docs/develop/`);
  otherwise proposes `bootstrap-monorepo` and stops.
- Scope: the `ACTIVE` SYSTEM sprint of the global `SPRINTS.md`; an argument names another.
- Sources, beyond those of `cdev-status`: the SYSTEM_BATCHes and their references, the
  contracts under `workspace/contracts/`, and — **local truth** — each affected repository's
  own `SPRINTS.md` and `AGENT_PROGRESS.md`, reached through the bidirectional references and
  read in the repository itself. Workspace↔repository divergence is flagged and the
  repository's state is the one reported. The state snapshot file never decides anything.
- Output: the three axes at system level, then one compact table — repository · its local
  batches for this SYSTEM sprint · state · blockers.
- A repository that cannot be reached reads "not derivable" for that repository, by name.
- Read-only, as B03.

`CHANGELOG.md` gains the bullet.

**Acceptance:** protocol checks 1–3 pass; `claude plugin validate .` passes; the skill lists
as `cdev:cdev-monorepo-status`; `grep` finds the three-axis method stated in `cdev-status`
only, and a path pointer here. Sandbox: `not-run` (declared — no workspace fixture); its
evidence is the human field exercise of B06.

### B05 — Live docs and version 0.2.0 `READY` (depends: B02, B03, B04)

**Layer: periphery / docs.** The surfaces that name the skill set learn there are nine:
`README.md` (command table and "which command when"), `docs/08-installation.md` (command
table), `CONTRIBUTING.md` ("the seven" → "the nine"), and `docs/09` / `docs/10` where they list
commands. Documents 01–07 are the extraction record and stay untouched; the walkthrough is not
extended (every command in it must be replayed — not worth it for a read operation). In the
**same commit**: `.claude-plugin/plugin.json` → `0.2.0` (semver per CONTRIBUTING: compatible
capabilities) and `CHANGELOG.md` gathers this sprint's bullets under `## 0.2.0`. Tag, GitHub
Release and the marketplace pin happen **after the merge, from `main`**, and are the human's —
commands left ready per the maintainer's release checklist (annotated tag, explicit push).

**Acceptance:** `grep -rn -iE '\bseven\b|7 skills'` over the live surfaces returns nothing
stale; both new commands appear in README and doc 08; `plugin.json` version and the CHANGELOG
heading agree; `bash scripts/validate.sh` and `claude plugin validate .` pass; the release
commands exist, unexecuted, in the handoff entry.

### B06 — Human field exercise of the monorepo skills `READY` (depends: B02, B04)

**Layer: field evidence** — stands in for the sandbox exercise no workspace fixture allows
(protocol §4, local line added in B02). The agent writes the script: how to load the branch
(`claude --plugin-dir <working tree>`), what to run, what to observe. The **human** runs it,
once, in their own workspace; this repository's agent never touches those repositories.
(a) `cdev-monorepo-planner` on a **throwaway objective**: does it follow the pointer into
`cdev-planner`, show the grouping, ask per SYSTEM_BATCH before writing each, with suggested
answers and a recommendation? What it wrote is then discarded with git in the workspace and
the repositories — real plans receive nothing from an unmerged skill. (b)
`cdev-monorepo-status`, cold, on the real `ACTIVE` SYSTEM sprint (read-only): three axes in
order, items citing sources, the per-repository table, local truth over the workspace's view.
The human reports back; the outcome lands in the handoff as field evidence, product
anonymized. This batch is `BLOCKED` on the human from the moment the script exists — the loop
moves on to B07's preparable parts and does not wait idle.

**Acceptance:** the script exists; the handoff entry records, per observation, what the human
saw (held / broke, quoted where it broke); any break is either fixed on the branch and
re-observed, or carried as a named blocker. The sprint does not close and the PR is not merged
without this entry.

### B07 — Sprint verification, report and the pull request `READY` (depends: B01–B06)

**Layer: docs.** Full protocol sequence over the final skill set (nine skills); sprint report
`docs/develop/reports/s10.md` — what was added, what was deliberately *not* built (the
requirement lists, the isolation machinery, the workspace fixture) and why, the verification
debt that remains (monorepo sandbox `not-run`, covered by field evidence). Pull request
against `main` from the template: What · Layer (**core**, linking the RFC, + **skill**) ·
Evidence checklist · `Closes #8`. Merge by **merge commit**, not squash — the branch carries
one commit per batch by design, as PR #5 did. Opening the PR was authorized in-session on
2026-09-19; in a later session it is prepared, not executed.

**Acceptance:** all protocol checks pass or are recorded `not-run` with their reason; the
report exists; the PR is open (or its body and command are ready, with the blocker named),
CI `validate` green on it. **Merging is the human's**, and waits on two things the PR body
names: the RFC's "accepted" summary and B06's field entry.
