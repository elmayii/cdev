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

Source: `docs/cdev_open_source_community_strategy.md` §22 Phase 1. Gates pre-authorized
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

## Sprint 06 — Five-minute README `PENDING` (entry batch BLOCKED)

Source: strategy §6–§10, §21, §22 Phase 2.

### B01 — Visual identity `BLOCKED`

*First proposal (wordmark light/dark + icon + social preview, indigo/slate, checkpoint line)
drafted, rasterized and **rejected by the human** without replacement direction. Minimum human
decision: state the visual direction (palette, typography, composition — or supply an asset);
then B01 regenerates and the sprint unblocks. Drafts preserved in `assets/` (wip commit).*

`assets/` with the wordmark SVG (`/cdev` + continuous line through verified checkpoints; no
robots/brains/sparkles). Social-preview PNG rendered from it, left prepared — uploading is
web-UI manual. **Acceptance:** SVG renders; human approves the asset (blocker until then);
PNG at the exact 1280×640 GitHub size.

### B02 — README redesign `READY` (depends: B01 approval)

Hero + positioning, the four failure modes, lifecycle diagram, Quick Start (verified
commands), command table (§8), "which command when" by project phase (§9), method-vs-binding
statement (§10), links to docs/evidence/CONTRIBUTING. Internal state shrinks to a link to
`docs/develop/`. **Acceptance:** README contains all §22-2 items; every command shown was
executed at least once in the record; language check passes.

### B03 — Verification + report `READY` (depends: B02)

Links resolve, render checked, report `s06.md`. **Acceptance:** checks pass; report exists.

---

## Sprint 07 — Community structure `ACTIVE` (promoted while S06 blocks at entry — blocked-but-not-idle)

Source: strategy §12–§14, §22 Phase 3.

### B01 — Contribution mechanics `DONE`

RFC process doc, label set created via `gh label`, initial `good first issue` candidates
drafted from the repo's own known leftovers, welcome/announcement Discussion posted via API.
**Acceptance:** labels exist; RFC doc linked from CONTRIBUTING; one Discussion live.

### B02 — Examples and showcase `READY`

A worked example: conditioning + one loop run on a sandbox fixture, written as a walkthrough
users can replay. **Acceptance:** every command in the walkthrough replayed this sprint.

### B03 — Verification + report `READY` (depends: B01, B02)

Report `s07.md`. **Acceptance:** checks pass; report exists.

---

## Sprint 08 — Launch `PENDING`

Source: strategy §22 Phase 4. Copy is agent work; **publishing each post is a human act,
always** — the batch closes as prepared-with-blocker, never as posted.

### B01 — Launch copy `READY`

Drafts in `docs/develop/launch/`: HN (Show HN), Reddit, X thread, LinkedIn, Claude Code
community post — built on the two approved hooks ("sessions → continuous development" and the
spec-driven origin story §18–§19). **Acceptance:** one draft per channel; each ends with the
named human decision (publish or not).

### B02 — Verification + report `READY` (depends: B01)

Report `s08.md`; sprint closes with the publish blockers listed. **Acceptance:** report
exists; blockers name each pending post.
