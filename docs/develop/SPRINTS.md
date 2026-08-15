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

## Sprint 02 — Plugin and marketplace `ACTIVE`

Objective: the package installable as a Claude Code plugin, from a marketplace repository.

### B01 — Plugin manifest `DONE`

`.claude-plugin/plugin.json` (name, version, description, author), schema confirmed against
current Claude Code docs, layout already in place from Sprint 01. **Acceptance:** manifest
valid; a local install (`claude plugin` tooling or documented equivalent) loads the plugin and
its 7 skills resolve profiles/templates from the plugin root.

### B02 — Marketplace repository `BLOCKED` (depends: B01)

*Drafts complete in `marketplace/`. Blocked on the human gate — minimum decisions: (1) create
GitHub repo `elmayii/cdev` (visibility?) and push `master`; (2) create GitHub repo
`elmayii/cdev-marketplace` from `marketplace/` contents (visibility?); (3) license for both
(none exists — third-party installs deserve one); names `cdev` / `cdev-marketplace` are
proposals, vetoable.*

Marketplace manifest prepared as drafts in this repo; creation of the GitHub repository and
push are a **human gate** (decisions: repo name, account, visibility). **Acceptance:** drafts
complete and documented; blocker names the exact decisions; after human approval, install from
the marketplace works.

### B03 — Install and verify `BLOCKED` (depends: B02)

*Also gated on its own: `plugin marketplace add` / `plugin install` modify the user's global
plugin configuration — same blast-radius class as `~/.claude/skills`. Commands prepared; the
`--plugin-dir` load test (read-only, session-scoped) already passed with all 7 skills
registered as `cdev:*`.*

Install the plugin from the marketplace (or local path while B02 is gated), run one sandbox
scenario against the **installed** copy (not the working tree), record evidence.
**Acceptance:** installed skills exercise cleanly; open questions in PRODUCT.md resolved as
dated DECISIONS entries.

## Sprint 03 — Document 08, installation `PENDING` (blocked by Sprint 02)

Written against the package that exists: what is actually installed, how to launch, how to
update. Blocked until Sprint 02 closes.
