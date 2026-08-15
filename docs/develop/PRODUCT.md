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
