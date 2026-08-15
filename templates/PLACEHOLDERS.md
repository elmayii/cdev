# Placeholder contract

Every template uses `{{NAME}}`. Resolution order: inspect repo -> infer from docs -> ask human.
A successful render leaves zero `{{` in target files.

| Placeholder | Meaning | Default / how resolved |
|---|---|---|
| `{{PROJECT_NAME}}` | Human project name | repo/folder name, confirmed |
| `{{PROJECT_DIR}}` | Absolute path of target repo | cwd at bootstrap |
| `{{ONE_LINER}}` | One sentence: what the project is | derived from docs overview |
| `{{STACK}}` | Runtime/framework summary | inspect manifest; default Node + TypeScript |
| `{{PACKAGE_MANAGER}}` | pnpm/npm/yarn/pip/go… | lockfile decides; no lockfile → the stack's plainest default (npm for Node) |
| `{{VERIFY_SEQUENCE}}` | Ordered verify commands (one per line) | from scripts/manifest; default install/typecheck/lint/test/build |
| `{{DB_VERIFY}}` | Optional local-DB infra startup and/or migration/verify commands (e.g. `docker compose up -d` then `pnpm db:migrate`) | present only if a DB is detected; else empty |
| `{{SOURCE_DOCS}}` | Authority-ordered docs table (markdown) | enumerate docs folder + infer order |
| `{{DOMAIN_AREAS}}` | Modules/areas to build (list) | derived from docs structure |
| `{{SHELL}}` | Shell for the runbook | host shell; default PowerShell on Windows |
| `{{MODEL}}` | Watchdog model | default `opus` |
| `{{EFFORT}}` | Watchdog effort | default `high` |
| `{{BRANCH_PREFIX}}` | Working-branch prefix | default `cdev/sprint-<nn>-batch-<nn>` (must match the loop skill's default) |
| `{{SKILL_DIRECTIVE}}` | Skills the watchdog injects | default ponytail + superpowers (TDD/systematic-debugging/verification) + repo runtime skills |
| `{{SPRINT_01_TITLE}}` | Title/name of the first sprint | derived in procedure step 4 |
| `{{BATCH_01_TITLE}}` | Title/name of Sprint 01's first batch | derived in procedure step 4 |
| `{{BATCH_01_TASKS}}` | Task list items for Batch 01 (one per line) | derived in procedure step 4 |
| `{{BATCH_01_ACCEPTANCE}}` | Acceptance criteria for Batch 01 (one per line) | derived in procedure step 4 |
| `{{LATER_SPRINT_TITLES}}` | Placeholder title for Sprint 02+ (pending) | derived in procedure step 4 |
| `{{ROADMAP_SPRINT_LIST}}` | Ordered list of sprints with titles/goals | derived in procedure step 3/4 |
| `{{ARCHITECTURE_NOTES}}` | Module structure, layer diagram, tech notes | derived in procedure step 3/4 |
| `{{INITIAL_DECISIONS}}` | First-pass decisions with dates and rationale | derived in procedure step 3/4 |
| `{{CLARITY_MAP_ROWS}}` | Clarity-map table rows: area → DEFINED/PARTIAL/ABSENT → source → open questions | Half B scoring |
| `{{RECOGNITION_SUMMARY}}` | What the repo actually is, one paragraph | Half A step 1 |
| `{{RECOGNITION_PATTERNS}}` | Real architecture patterns extracted from the code | Half A step 1 |
| `{{RECOGNITION_OVERRIDES}}` | Table rows: generic assumption → reality here → override | Half A step 1 |
| `{{RECOGNITION_UNTOUCHABLE}}` | List of things no agent may modify here | Half A step 1 |
| `{{ROLE}}` | The repo's role (backend / frontend / other) plus its one-line consequence | role resolution |
| `{{EVIDENCE_RULES}}` | What a `DONE` must prove here, and with which tooling | profile §2 materialized |
| `{{ARCHITECTURE_RULES}}` | The repo's real architecture/domain rules | recognition document |
| `{{SAFETY_GATES}}` | This repo's gate list (core shape + role's typical gates, concrete) | profile §3 materialized |
| `{{SELF_CHOSEN_ORDER}}` | Priority order for self-derived work when the plan runs out | profile §4 materialized |
