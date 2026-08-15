# Agent progress — handoff log

Newest-first. Required fields: date+unit · status · done · files · verification
(pass/fail/not-run per check) · blockers (minimum human decision) · next.

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
