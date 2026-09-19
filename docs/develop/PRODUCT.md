# Product clarity map

The "product" is the CDev package: a Claude Code plugin holding the consolidated method. The
sources of truth, in authority order: `docs/07-core-vs-periphery.md` → `README.md` ("Where this
stands") → docs 01–06 (evidence) → the current `skills/` (material to consolidate).

**This map is the boundary of self-directed work: only DEFINED and PARTIAL areas may be worked
without asking. ABSENT areas produce open questions, never batches.**

| Area | Level | Source | Open questions |
|---|---|---|---|
| Role profiles (backend, frontend) | **DEFINED** | doc 07 §2 fixes the exact four things a profile may contain; current skills hold the content | — |
| Loop consolidation (`cdev` reading profiles) | **DEFINED** | doc 07 §7; the two loops are near-identical text, deltas tabulated in doc 04 | — |
| Conditioner consolidation (`bootstrap` reading profiles) | **DEFINED** | doc 07 §7; two-half structure shared, deltas known | — |
| Periphery removal + five field rules | **DEFINED** | doc 07 §4 lists what goes; §6 states the five rules and where each came from | — |
| Plugin manifest and layout | **PARTIAL** | Layout decided (README): `skills/ profiles/ templates/ scripts/`. Manifest details unspecified | Plugin name (`cdev`?), version scheme (semver from 0.1.0?), author field |
| Marketplace repository | **PARTIAL** | Decided that it exists from the start | Repo name, host account, public/private — human decisions, and creation itself is a gate |
| Document 08 — installation | **DEFINED**, blocked | README: written against the package that exists | Blocked by Sprint 02 |
| A fullstack/third role profile | **ABSENT** | doc 07 §2: anticipated but never exercised — "should not be shipped until something runs on it" | Do not build |
| Open-source readiness (branches, metadata, release, community files) | **DEFINED** | `the internal strategy document (local, gitignored)` §2–§5, §11, §15, §22-1; gates pre-authorized in-session 2026-08-15 | — |
| Public README (five-minute comprehension) | **DEFINED** | strategy §6–§10, §22-2 | — |
| Visual identity | **PARTIAL** | strategy §21 gives direction (`/cdev` wordmark + checkpoint line, no generic AI imagery); execution assumed agent-made SVG, human approves the result | Final asset approval |
| Community structure (field reports, RFC, labels, Discussions content) | **DEFINED** | strategy §12–§14, §22-3 | Custom Discussions categories are web-UI manual |
| Planner gap closing (per batch, before writing) | **DEFINED** | Issue #8; field evidence `docs/develop/reports/s10-field-evidence.md` (S10-B01); human answers in DECISIONS 2026-09-19 | RFC acceptance gates the merge, not the work |
| Status skills — system level (`cdev-monorepo-status`) | **DEFINED** | Three field occurrences fix the request and the accepted output shape; DECISIONS 2026-09-19 | — |
| Status skills — single repo (`cdev-status`) | **PARTIAL** | No field occurrence of a three-axis status in a single repo: the shape is extrapolated from the system-level one (assumption recorded in the evidence file's "not evidenced" section) | First real use may correct the shape |
| A workspace (multi-repo) sandbox fixture | **ABSENT** | Human decision 2026-09-19: not built; field exercise stands in | Do not build unless asked |
| Launch | **PARTIAL** | strategy §22-4 fixes channels and message; copy is draftable — publishing itself is always a human act | Human publishes each post |
