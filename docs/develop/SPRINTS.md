# SPRINTS — the plan

Statuses: sprint `PENDING → ACTIVE → DONE` (+`PROPOSAL`); batch `READY → IN_PROGRESS → DONE`,
or `→ BLOCKED` (reason + minimum human decision). Exactly one sprint ACTIVE.

---

## Sprint 01 — Consolidation refactor `ACTIVE`

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

### B04 — Periphery removal + the five field rules `READY` (depends: B02, B03)

Across the remaining skills: remove product references (Compiss, F6 paths, compiss/monorepo)
and named technologies from core rule text (examples move to profiles/templates). Add the five
field-derived rules of doc 07 §6 where they belong: wave quiescence before system verification
and aggregated verification debt → `cdev-monorepo`; fixed handoff ordering, derive-on-read for
assertions about other repos, operational-doc consistency check → `bootstrap` and `cdev`.
Demote the night-runner to an explicitly optional binding.

**Acceptance:** periphery check (protocol §3) passes; each of the five rules present, each
stated once, in the right skill; checks 1–2 pass.

### B05 — Sprint verification + report `READY` (depends: B04)

Full verification sequence over the final skill set. Write the sprint report: what was
consolidated, what was cut, what moved to profiles — the consumer-facing contract delta for
Sprint 02.

**Acceptance:** all four protocol checks pass over `skills/` + `profiles/`; report exists in
`docs/develop/reports/s01.md`.

---

## Sprint 02 — Plugin and marketplace `PENDING`

Objective: the package installable as a Claude Code plugin, from a marketplace repository.
Manifest (`.claude-plugin/plugin.json`), layout (`skills/ profiles/ templates/ scripts/`),
marketplace repo (creation on GitHub = human gate: name, account, visibility), install from it
and verify the installed set. Open questions in PRODUCT.md resolved as dated DECISIONS entries.

## Sprint 03 — Document 08, installation `PENDING` (blocked by Sprint 02)

Written against the package that exists: what is actually installed, how to launch, how to
update. Blocked until Sprint 02 closes.
