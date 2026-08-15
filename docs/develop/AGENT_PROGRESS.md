# Agent progress — handoff log

Newest-first. Required fields: date+unit · status · done · files · verification
(pass/fail/not-run per check) · blockers (minimum human decision) · next.

---

## 2026-08-16 · Docs 09 + 10 integrated (human-supplied) · DONE

**Done:** Two human-supplied documents joined the series: `docs/09-cdev-monorepo.md` (the
multi-repo layer; the human's flow diagram `assets/cdev-monorepo-flow-dark.png` embedded) and
`docs/10-usage-recommendations.md` (model/effort defaults — contrast applied: explicitly
labeled host-binding guidance per doc 07; content verified against the known Claude Code
surface: aliases, effort levels, ultracode-as-mode all check out). README gained the
"Microservices and multi-repo products" section with the diagram, the three monorepo commands
and a link to 09, plus rows 09/10 in the documents table. Consistency fix in 09: the product
name was anonymized to match docs 01–08's "one product, honestly" rule — flagged to the human,
revertible.

**Files:** docs/09-cdev-monorepo.md, docs/10-usage-recommendations.md,
assets/cdev-monorepo-flow-dark.png (now tracked), README.md, CHANGELOG.md.

**Verification:** links — pass (all resolve) · language — pass · product-name sweep — pass.

**Blockers:** none.

---

## 2026-08-16 · S06-B04 correction · DONE — restrict, don't relocate

**Done:** Human corrected the cleanup approach: the internal material must stay at its
original paths, restricted from git — not relocated. Restored from `scratch/` to
`docs/develop/launch/`, `docs/develop/reports/s08.md`,
`docs/cdev_open_source_community_strategy.md`, `marketplace/`; all added to `.gitignore`
(plus root `*.txt`). They remain out of the branch (removed by `cc1d44a`), remain in history,
and now live untracked in place. Live wording re-pointed ("local, gitignored").

**Verification:** `git status` shows none of the restored paths — pass · paths exist on
disk — pass · branch clean — pass.

**Blockers:** none. Untracked note: `assets/cdev-monorepo-flow-dark.png` appeared (added by
the human, not by the loop) — awaiting their intent before tracking it.

**Next:** unchanged — the standing human items below.

---

## 2026-08-15 · S06 complete · DONE — identity approved, README public, repo cleaned

**Done (B01, second iteration):** the human supplied the master icon; palette sampled via
System.Drawing (#070A16/#0045ED/#00E8E5), geometry rebuilt as flat vectors (marks, wordmark
lockups, social preview), rasterized with sharp-cli, **approved in-session**.
**Done (B02):** public README per strategy §22-2; 13/13 internal links verified; internal
state reduced to a link. **Done (B03):** report `reports/s06.md`. **Done (B04, appended,
human-agreed):** internal material out of the public tree to local `scratch/` — launch
drafts, launch report, strategy document, stale marketplace draft (transcripts were already
gone from the root); live artifacts (SPRINTS, PRODUCT) re-pointed; historical records
untouched; git history untouched. CHANGELOG 0.1.1 updated (identity + README + removals).

**Verification:** links 13/13 — pass · language — pass · identity approval — pass (human,
in-session) · cleanup acceptance — pass (none of the moved items remain; zero live citations
of missing paths).

**Blockers:** none. **No PENDING sprint remains — plan exhausted.** Standing human items:
social-preview upload (Settings, `assets/social-preview.png`) · avatar upload (`icon.png`) ·
signed-in glance at the issue chooser · `gh release create v0.1.1` (CHANGELOG ready) ·
publish decisions per launch draft (in `docs/develop/launch/` (local, gitignored)) · ratify Sprint 04 + name the
target repo.

**Next:** whichever the human decides; the natural one is releasing v0.1.1 so installed
copies get the fixed templates.

---

## 2026-08-15 · S08 complete · DONE — loop stops: only human decisions remain

**Done (B01):** Five launch drafts in `docs/develop/launch/` (HN, Reddit, X, LinkedIn, Claude
communities), each on the two ratified hooks, each honest about one-product evidence and
unvalidated portability, each ending with the named publish decision. Nothing posted.
**Done (B02):** Report `s08.md`. Also prepared: **v0.1.1** — plugin.json bumped, CHANGELOG
entry (encoding fix, branch-prefix unification, community layer); the GitHub Release act is
prepared-not-executed.

**Files:** docs/develop/launch/*.md (5), docs/develop/reports/s08.md, CHANGELOG.md,
.claude-plugin/plugin.json.

**Verification:** drafts exist with named decisions — pass · language check — pass ·
version/CHANGELOG agree — pass · nothing published — pass (that is the check).

**STOP — no ungated work remains.** Exactly which approvals unblock what:
1. **Visual direction** (palette/typography/composition or an asset) → unblocks S06-B01 →
   B02 README → B03, and with it the launch sequence.
2. **Signed-in glance** at github.com/elmayii/cdev/issues/new/choose → clears the one
   standing not-run.
3. **`gh release create v0.1.1`** (command in s08.md) → publishes the patch release.
4. **Per-channel publish decisions** (5 drafts) → executes the launch, after S06.
5. **Ratify Sprint 04** (field validation) + name the target repo → the next development
   phase.

**Next:** whichever of the five the human decides first.

---

## 2026-08-15 · S07-B03 · DONE — Sprint 07 `DONE`, Sprint 08 promoted

**Done:** Report `docs/develop/reports/s07.md` including the verification-debt aggregate
(one standing not-run: the issue-form render glance). All S07 acceptance re-checked. Sprint 08
(launch copy) promoted while S06 stays blocked at entry on the visual-direction decision.

**Verification:** language check — pass · reports exist — pass · one ACTIVE sprint — pass.

**Blockers:** carried: S06 visual direction (human) · issue-form glance (human).

**Next:** S08-B01 — launch copy drafts + v0.1.1 patch preparation.

---

## 2026-08-15 · S07-B02 Examples and showcase · DONE

**Done:** Public walkthrough at `docs/community/walkthrough.md`, validated by a fresh subagent
replaying it end-to-end against the **installed** plugin copy: bootstrap `BOOTSTRAP VERIFY:
PASS` (conditioning commit `502b993` in the fixture), Batch 01 `DONE` with gates proven
honest (`3718918`; lint/build/test real, exit-1 demonstrated on broken input). Replay
friction fixed at the root: `templates/develop/SPRINTS.md.tmpl` was mojibake (BOM +
double-encoded em-dashes from an earlier PowerShell rewrite) — rewritten clean UTF-8, no
other template affected (grep clean); `{{BRANCH_PREFIX}}` contract default unified with the
loop skill's (`cdev/sprint-<nn>-batch-<nn>`) — two shipped defaults disagreeing is the exact
incident class field rule 5 exists for, found by our own replay.

**Files:** docs/community/walkthrough.md (new), templates/develop/SPRINTS.md.tmpl,
templates/PLACEHOLDERS.md.

**Verification:** replay of every walkthrough command — pass (subagent evidence) · mojibake
sweep — pass (zero matches) · language check — pass.

**Blockers:** none. Note: template fixes change shipped behavior → v0.1.1 patch release is
due; prepared, release act pending (see next entries).

**Next:** B03 — sprint verification + report.

---

## 2026-08-15 · S07-B01 Contribution mechanics · DONE

**Done:** RFC process doc (`docs/community/rfc-process.md`: evidence bar = docs/07 §6
precedent, Discussion-based, template included), linked from CONTRIBUTING. Label set created
(field-report, profile, binding, core-rfc — read back via `gh label list`). Three
`good first issue`s filed from recorded leftovers (issues #1 template slot, #2 optional
placeholders, #3 first CI workflow — each with fix shape + verify steps). Welcome Discussion
live in Announcements: https://github.com/elmayii/cdev/discussions/4 (install, links, the
field-report ask, the Discussion-vs-Issue rule).

**Files:** docs/community/rfc-process.md (new), CONTRIBUTING.md (link).

**Verification:** labels exist — pass · RFC doc linked — pass · one Discussion live — pass ·
issues created — pass (#1–#3).

**Blockers:** none.

**Next:** B02 — walkthrough (replay running against the installed copy).

---

## 2026-08-15 · S06-B01 Visual identity · BLOCKED — S07 promoted (blocked-but-not-idle)

**Done (draft):** wordmark light/dark SVG, icon 512, social preview 1280×640 (strategy §21
direction: `/cdev` + continuous line through verified checkpoints, no AI clichés). Rasterized
to PNG (sharp-cli after Playwright hung three times — tool swapped, not retried blindly) and
presented. **Rejected by the human without replacement direction.**

**Blocker (minimum human decision):** state the visual direction — palette, typography,
composition, references — or supply an asset. B01 regenerates on receipt; S06-B02/B03 chain
behind it.

**Files:** assets/*.svg + *.png (wip-committed so the drafts are not lost).

**Verification:** SVG renders — pass (PNG inspected) · PNG at 1280×640 — pass · human
approval — **fail (rejected)**.

**Field note for the method:** a sprint whose entry batch blocks leaves no workable batch in
the ACTIVE sprint; resolved by demoting S06 to PENDING and promoting the independent S07 —
keeps the one-ACTIVE invariant while honoring blocked-but-not-idle. Worth a rule if it
recurs.

**Next:** S07-B01 — contribution mechanics.

---

## 2026-08-15 · S05-B05 + B06 · DONE — Sprint 05 `DONE`, Sprint 06 promoted

**Done (B05):** Release `v0.1.0` published (tag on main, §5-shaped notes: what CDev is, what
ships, the binding, install, limitations, experimental). Tag matches `plugin.json`.
**Done (B06):** Aggregate verification: GitHub community profile health 100%; contents API
lists the four issue forms; frontmatter/language checks pass; exactly one ACTIVE sprint.
Report at `docs/develop/reports/s05.md`.

**Verification:** release — pass (public, tag v0.1.0) · community profile — pass (100%) ·
protocol checks — pass · **issue-form render — not-run** (chooser page requires sign-in;
community-profile flag reads false — one signed-in human glance at
github.com/elmayii/cdev/issues/new/choose settles it; recorded honestly, does not block).

**Blockers:** none blocking. Pending human glance: the issue chooser (above).

**Next:** S06-B01 — visual identity (wordmark SVG; asset approval is the human gate).

---

## 2026-08-15 · S05-B04 Issue and PR templates · DONE

**Done:** `.github/ISSUE_TEMPLATE/{bug,feature,field-report,config}.yml` +
`PULL_REQUEST_TEMPLATE.md`. The field-report form carries all strategy §13 fields; the feature
form forces the layer question (core → RFC); config routes conversations to Discussions
("Discussion = conversation, Issue = actionable work"); the PR template embeds the
evidence-over-assertion checklist.

**Files:** the five under `.github/`.

**Verification:** YAML parse — see next entry after push · files pushed — with this commit ·
render on GitHub's chooser — verified post-push (recorded in B06 if flagged).

**Blockers:** none.

**Next:** B05 — release v0.1.0.

---

## 2026-08-15 · S05-B03 Community health files · DONE

**Done:** CONTRIBUTING.md (contribution table §12 with the RFC-for-core rule, branch model
§15, evidence-over-assertion ground rules, repo layout), CODE_OF_CONDUCT.md (Contributor
Covenant 2.1), SECURITY.md (gate-crossing defined as the vulnerability class, private
advisories), CHANGELOG.md (seeded with 0.1.0 including known limitations).

**Files:** CONTRIBUTING.md, CODE_OF_CONDUCT.md, SECURITY.md, CHANGELOG.md.

**Verification:** four files exist — pass · language check — pass · RFC rule stated in
CONTRIBUTING — pass.

**Blockers:** none.

**Next:** B04 — issue and PR templates.

---

## 2026-08-15 · S05-B02 Repository metadata · DONE

**Done:** `elmayii/cdev`: description set, the nine strategy topics added, wiki disabled,
Discussions enabled. `elmayii/cdev-marketplace`: description + two topics, wiki disabled.
Owner-push evidence from B01 confirmed (8881b71 landed on protected main).

**Files:** none in-repo (GitHub metadata) + this record.

**Verification:** read-back via `gh repo view` — pass (description exact, 9/9 topics,
hasDiscussionsEnabled true, hasWikiEnabled false).

**Blockers:** none.

**Next:** B03 — community health files.

---

## 2026-08-15 · S05-B01 Branch policy · DONE — Sprint 05 promoted ACTIVE

**Done:** `master`→`main` renamed via API in `elmayii/cdev` and `elmayii/cdev-marketplace`
(GitHub redirects old refs). Protection applied to both `main`s: PR required for others,
`allow_force_pushes` false, `allow_deletions` false, conversation resolution required,
`enforce_admins` false — the owner's direct-commit convention (this repo's recorded override)
keeps working. Local clone renamed and retracking `origin/main`. Protocol + RECOGNITION
updated: convention is now direct commits to `main`, routine push after each batch.
One failure mid-batch, root-caused: PS 5.1 pipe mangled the protection JSON (HTTP 400 twice);
fixed once at the source by sending the JSON via file from bash, both PUTs succeeded.

**Files:** docs/develop/{AGENT_EXECUTION_PROTOCOL,RECOGNITION,SPRINTS,AGENT_PROGRESS}.md.

**Verification:** rename — pass (`main` returned for both) · protection — pass (flags read
back: force-push disabled, deletion disabled, enforce_admins false) · owner direct push —
this very commit's push is the test (recorded pass in the next entry if it lands).

**Blockers:** none.

**Next:** B02 — repository metadata.

---

## 2026-08-15 · Planning (cdev-planner) · DONE — S05–S08 materialized

**Done:** Strategy doc (`docs/cdev_open_source_community_strategy.md`) read and materialized.
Gap analysis: 7 gaps with evidence (stale clarity map, version-without-tag, master default,
missing metadata/community files, README as internal landing, S04 unratified). Human decided
in-session: strategy before field validation; rename+protect both repos authorized (owner
bypass preserved); v0.1.0 release authorized; agent-made wordmark with human approval of the
asset. Sprints 05–08 written `PENDING` with observable acceptance; S04 stays `PROPOSAL`
untouched (no renumbering). Clarity map gained six rows; tooling/permissions recorded in
DECISIONS (gh scopes cover almost all of Phase 1; social preview and Discussions categories
are web-manual; launch posts always human).

**Files:** docs/cdev_open_source_community_strategy.md (committed as source),
docs/develop/{SPRINTS,PRODUCT,DECISIONS,AGENT_PROGRESS}.md.

**Verification:** invariants — pass (zero ACTIVE sprints right now; the loop promotes S05 on
its next run; one-ACTIVE-max holds) · language check — pass · planner-implements-nothing —
pass.

**Blockers:** none for S05. Standing human acts ahead: wordmark approval (S06-B01), social
preview upload, each launch post (S08).

**Next:** `/cdev:cdev` — the loop promotes Sprint 05 and starts B01 (branch policy).

---

## 2026-08-15 · S03-B01 Document 08 · DONE — Sprint 03 `DONE`, plan exhausted

**Done:** `docs/08-installation.md` written against the verified reality of Sprint 02 (install
path, cache layout, the seven namespaced skills, what deliberately does not install, update
semantics, dev-mode workflow, uninstall). README: documents table gains row 08; "Where this
stands" now records the three steps as shipped with links to both public repos.
`scripts/install.ps1` retired (superseded by the plugin). **Plan exhausted** → per the
self-chosen order, Sprint 04 "Field validation" drafted as `PROPOSAL` (drive a real repo with
the installed plugin; second-product evidence) — awaiting human ratification, never
self-activated.

**Files:** docs/08-installation.md (new), README.md, docs/develop/SPRINTS.md; deleted
scripts/install.ps1.

**Verification:** language check — pass · README↔doc consistency (install.ps1 mentioned only
as retired) — pass · describes-only-what-was-verified — pass (every command in doc 08 was
executed this session).

**Blockers:** none. Stop: plan exhausted; the only remaining item is a `PROPOSAL` that
requires human ratification.

**Next:** if Sprint 04 is ratified — name the target repository and materialize its batches
with `/cdev:cdev-planner`.

---

## 2026-08-15 · S02-B02 + S02-B03 · DONE — Sprint 02 `DONE`

**Done:** Gate approved in-session (both repos public, MIT, install + retire old skills).
LICENSE written; manifest gained `license` + `repository`. `elmayii/cdev` created and pushed
(full history); `elmayii/cdev-marketplace` created from the drafts and pushed. Marketplace
added, plugin installed (scope: user). **Installed-copy verification:** cache
`~/.claude/plugins/cache/cdev-marketplace/cdev/0.1.0/` contains profiles/, templates/, all 7
skills, docs — the sibling-directory doubt is resolved: everything inside the plugin root is
copied, so `../../profiles/` resolves in the installed layout. Plain-session load (no
--plugin-dir) lists all 7 skills as `cdev:*`. The nine pre-refactor global skills moved to
`.backups/global-skills-2026-08-15/`; `~/.claude/skills` is now empty.

**Files:** LICENSE, .claude-plugin/plugin.json, marketplace/ (published),
docs/develop/{SPRINTS,DECISIONS}.md, docs/develop/reports/s02.md.

**Verification:** repo push — pass (both) · marketplace add + install — pass · installed-copy
completeness — pass · plain-session namespaced load — pass (7/7) · old-skills retirement —
pass (9 moved, backup kept).

**Blockers:** none. **Sprint 02 DONE; Sprint 03 (document 08) promoted to ACTIVE.**

**Next:** S03-B01 — write docs/08-installation.md against what was just verified.

---

## 2026-08-15 · S02-B01 Plugin manifest · DONE / S02-B02 · BLOCKED / S02-B03 · BLOCKED

**Done (B01):** `.claude-plugin/plugin.json` (name `cdev`, 0.1.0, per DECISIONS assumptions).
`claude plugin validate .` → pass (one benign warning: root CLAUDE.md is the repo's own guide,
not plugin context). Live load test `claude --plugin-dir . -p` → all 7 skills registered as
`cdev:*`. The stale global install (`~/.claude/skills`, pre-refactor nine) coexists
un-namespaced — the collision the plugin namespacing was chosen to solve; refreshing it is
part of the gate below.

**B02 blocked (drafts done):** `marketplace/` holds `.claude-plugin/marketplace.json` + README,
ready to become the `cdev-marketplace` repo. Minimum human decisions: create GitHub repos
`elmayii/cdev` + `elmayii/cdev-marketplace` (visibility each), license, veto/confirm names.
Prepared commands: `gh repo create elmayii/cdev --public --source . --push` · new repo from
`marketplace/` contents.

**B03 blocked:** `plugin marketplace add` / `plugin install` touch the user's global plugin
config — gated like any shared-state write. Open verification for B03: confirm the
marketplace-install copy includes `profiles/` and `templates/` (docs ambiguous; `--plugin-dir`
proves nothing about copy semantics).

**Verification:** manifest validate — pass · plugin-dir load — pass (7/7 namespaced) ·
frontmatter/language/periphery — pass (unchanged since S01-B05) · marketplace install —
not-run (gated).

**Blockers:** the S02-B02/B03 human gate above. Nothing else is workable: Sprint 03 depends on
Sprint 02; self-chosen scan finds only gated work. **Stop condition reached: a safety gate
requires a human and everything else depends on it.**

**Next:** on gate approval — push, create marketplace, install, run B03's installed-copy
sandbox scenario, then Sprint 03 (document 08).

---

## 2026-08-15 · S01-B05 Sprint verification + report · DONE — Sprint 01 `DONE`

**Done:** Full static pass green (frontmatter 7/7 · language 0 · product names 0 · tech names
in core skills 0 · no placeholders outside templates). Bootstrap re-exercised on the rewritten
templates: `BOOTSTRAP VERIFY: PASS`, zero unresolved placeholders, fake test gate caught,
clarity boundary exact, conditioning committed in the fixture. Re-exercise friction fixed:
package-manager default now lockfile-driven (npm plainest for Node), lying lint/build gates
now force a first-batch repair or written blocker (profile §1), bootstrap commit branch made
explicit, gitignore-additions tied to the night-runner render, SPRINTS template double-bullet
removed. Sprint report published at `docs/develop/reports/s01.md` — the contract delta for
Sprint 02. **Sprint 01 DONE; Sprint 02 (plugin + marketplace) promoted to ACTIVE** with three
batches (manifest → marketplace repo [human gate] → install and verify).

**Files:** docs/develop/reports/s01.md (new), templates/PLACEHOLDERS.md,
templates/develop/SPRINTS.md.tmpl, profiles/backend.md, skills/bootstrap/SKILL.md,
docs/develop/SPRINTS.md.

**Verification:** all four protocol checks — pass (sandbox: 4 recorded exercises total).

**Blockers:** none at sprint level. Known gate ahead: S02-B02 marketplace repo creation
(decisions: repo name, GitHub account, visibility).

**Next:** S02-B01 — plugin manifest.

---

## 2026-08-15 · S01-B04 Periphery removal + the five field rules · DONE

**Done:** Product references gone (last `compiss` mention removed from bootstrap-monorepo;
dead `cdev-backend`/`cdev-frontend` and old bootstrap names re-pointed to the consolidated
skills). Root-cause template surgery: `AGENT_EXECUTION_PROTOCOL.md.tmpl` rewritten as
**deltas-only** (it was a full copy of the generic loop — exactly what doc 07 forbids; the
pnpm hardcodes, model trailer and ghost artifact roster all died with it) and `CLAUDE.md.tmpl`
rewritten generic (was one-case prose about a different product). Five new placeholders for
profile materialization (ROLE, EVIDENCE_RULES, ARCHITECTURE_RULES, SAFETY_GATES,
SELF_CHOSEN_ORDER). Optional render list completed (ROADMAP, ARCHITECTURE homed). Five field
rules placed: wave quiescence → cdev-monorepo §verify; verification-debt aggregation →
cdev-monorepo global report (cdev-planner already had the local case); fixed handoff ordering →
already done in B02/B03 (protocol template + bootstrap default + loop reads the declaration);
derive-on-read → bootstrap-monorepo registry + cdev-monorepo reconciliation; operational-doc
consistency check → bootstrap recognition step.

**Files:** skills/{bootstrap,bootstrap-monorepo,cdev-monorepo}/SKILL.md,
templates/CLAUDE.md.tmpl, templates/develop/AGENT_EXECUTION_PROTOCOL.md.tmpl,
templates/PLACEHOLDERS.md.

**Verification:** periphery check — pass (product names: 0 anywhere; tech names in core
skills: 0) · language check — pass · frontmatter check — pass (7/7) · sandbox — not-run
(wording-level changes; B05 re-exercises nothing but re-runs all static checks).

**Blockers:** none.

**Next:** B05 — full verification + sprint report.

---

## 2026-08-15 · S01-B03 Consolidate the conditioner · DONE

**Done:** Single `skills/bootstrap/SKILL.md` (recognition-first, both halves, profiles
materialized into the conditioned repo's protocol, reviewer agents + per-repo skills out of the
default render, conditioning commits itself at the end). `bootstrap-backend`,
`bootstrap-frontend` and `cdev-bootstrap` deleted; `templates/` moved to the package root
(greenfield conditioning-plan template deleted), `verify-bootstrap.ps1` moved to `scripts/` and
aligned to the core artifact set. Sandbox exercise (`sandbox/cond-be`, fresh subagent): the
deliberately-broken test gate was caught and became Batch 01 with gate-honesty acceptance; the
clarity map landed exactly on the DEFINED+PARTIAL boundary; ABSENT area got an open question,
no batch. Friction fixes applied: real-path resolution wording, RECOGNITION template created,
PRODUCT template got the clarity-map slot, PROGRESS template flipped to newest-first, verify
script no longer follows the skills junction, profiles cover the no-DB case and non-HTTP
evidence, dangling doc-07 citations dropped.

**Files:** skills/bootstrap/SKILL.md (new); deleted skills/{bootstrap-backend,
bootstrap-frontend,cdev-bootstrap}/; templates/* (moved + PROGRESS/PRODUCT edited,
RECOGNITION.md.tmpl new, PLACEHOLDERS extended); scripts/verify-bootstrap.ps1;
profiles/{backend,frontend}.md; sandbox/cond-be/ (fixture, gitignored).

**Verification:** frontmatter check — pass (7/7) · language check — pass · sandbox
conditioning scenario — pass (verify script FAIL was a false positive of the junction scan,
fixed) · periphery check — not-run (B04).

**Blockers:** none. Deferred to B04 (periphery sweep): CLAUDE.md.tmpl one-case prose and its
ghost-artifact roster, protocol template's hardcoded pnpm sequence and Co-Authored trailer,
ARCHITECTURE/ROADMAP templates' place in the render lists, gitignore-additions tied to the
night-runner.

**Next:** B04 — periphery removal + the five field rules.

---

## 2026-08-15 · S01-B02 Consolidate the execution loop · DONE

**Done:** Single `skills/cdev/SKILL.md`: dispatcher + one loop reading `profiles/` (real-path
resolution through junctions); `cdev-backend` and `cdev-frontend` deleted. Consumer-report rule
generalized role-independently. Exercised in two sandbox fixtures by fresh subagents:
**backend** (`sandbox/loop-be`) closed its whole sprint — 2 batches DONE, mid-batch failure
root-caused at the single caller, honest per-check recording, gates intact; **frontend**
(`sandbox/loop-fe`) correctly ended `BLOCKED` (runtime evidence impossible), named the minimum
human decision, flagged the fixture's lying gates, applied blocked-but-not-idle. Friction fixes
applied from the exercises: real-path profile resolution wording, RECOGNITION-if-present,
lying-gate-at-runtime rule, stacked branches for dependent batches, zero-padded branch default,
DECISIONS.md full path.

**Files:** skills/cdev/SKILL.md; deleted skills/cdev-backend/, skills/cdev-frontend/;
sandbox/loop-be/, sandbox/loop-fe/ (fixtures, gitignored).

**Verification:** frontmatter check — pass (7/7) · language check — pass · sandbox backend
scenario — pass (sprint closed honestly) · sandbox frontend scenario — pass (blocked honestly)
· periphery check — not-run (applies at B04).

**Blockers:** none. Environment note for unattended runs recorded in DECISIONS (RTK hook
mangles npm output; `rtk proxy` gives truthful exit codes).

**Next:** close B03 when its sandbox exercise reports; then B04.

---

## 2026-08-15 · S01-B01 Extract role profiles · DONE

**Done:** `profiles/backend.md` and `profiles/frontend.md` created, each exactly the four
sections doc 07 §2 allows, with a header stating what a profile may not contain. Content
distilled from cdev-backend/cdev-frontend/bootstrap-backend/bootstrap-frontend; technology
names labelled as examples. The unexercised fullstack profile was not created (ABSENT area,
"do not build").

**Files:** profiles/backend.md, profiles/frontend.md, docs/develop/SPRINTS.md.

**Verification:** section count — pass (4/4 each) · language check — pass (zero matches) ·
frontmatter check — not-run (profiles are data, not skills) · sandbox — not-run (consumed by
B02/B03 exercises).

**Blockers:** none.

**Next:** B02 — consolidate the execution loop into one `cdev` reading the profiles.

---

## 2026-08-15 · Conditioning · DONE

**Done:** Repository conditioned for its own method. Recognition written first; core artifacts
only (doc 07 §1.2). Sprint 01 (consolidation refactor, 5 batches) ACTIVE with B01 READY;
Sprints 02 (plugin+marketplace) and 03 (doc 08) PENDING. Human gate passed: design presented
and approved in-session ("Condiciona y arranca").

**Files:** CLAUDE.md, docs/develop/{RECOGNITION,AGENT_EXECUTION_PROTOCOL,PRODUCT,SPRINTS,
DECISIONS,AGENT_PROGRESS}.md

**Verification:** frontmatter check — not-run (no skill touched) · language check — pass
(remaster verified this session) · periphery check — not-run (applies from B04) · sandbox —
not-run (no skill touched).

**Blockers:** none.

**Next:** B01 — extract `profiles/backend.md` + `profiles/frontend.md`.
