---
name: cdev-bootstrap
description: Use to condition a fresh repo for continuous autonomous development from a folder of source docs. Reads the docs, derives a conditioning + first-draft sprint plan, and writes CLAUDE.md, docs/develop/*, .claude agents+skills, the night-runner watchdog, logs and gitignore into the target repo.
---

# CDev Bootstrap

Condition a target repo for continuous autonomous development (CDev) from a folder of source
documentation. This skill renders the bundled `templates/*.tmpl` into the target repo, resolving
every `{{PLACEHOLDER}}` (contract in `PLACEHOLDERS.md`).

## When to use

The user has a repo (often fresh) plus a folder of product/spec docs and wants the full
autonomous-execution scaffolding so agents can plan and build it batch by batch.

## Inputs

- **Target repo:** the current working directory (resolve to `{{PROJECT_DIR}}`).
- **Docs folder:** a path the user gives (e.g. `docs/04_leftzero_product/`). If not given, ask.

## Procedure (one todo per step)

1. **Read the docs.** Read every file in the docs folder. Summarize: what the product is
   (one line), its scope authority order, and its natural build areas/modules.
2. **Inspect the repo.** Detect stack and resolve every placeholder per `PLACEHOLDERS.md`:
   read `package.json`/`pnpm-lock.yaml`/`pyproject.toml`/`go.mod` for stack + package manager +
   scripts; detect a DB (prisma/ schema, migrations) for `{{DB_VERIFY}}`; host shell/OS for
   `{{SHELL}}`; `pwd` for `{{PROJECT_DIR}}`. Default to Node/TS values when ambiguous.
3. **Derive the conditioning plan.** Map the product into phased conditioning (scaffold →
   persistence/state → domain spine → feature phases) suited to the detected stack. This fills
   `{{DOMAIN_AREAS}}` and the phase bodies of the conditioning template.
4. **Derive a first-draft SPRINTS.md.** Turn the conditioning phases/areas into Sprint 01 +
   batches, each with objective acceptance criteria. Sprint 01 `Status: ACTIVE`, Batch 01
   `Status: READY`; later sprints as titled placeholders.
5. **Human gate.** Present the resolved placeholder table + the derived phase/sprint outline.
   Get ONE confirmation (or edits) before writing any file. This is the only approval gate.
6. **Render & write.** Substitute placeholders into every `templates/*.tmpl` and write to the
   target repo (strip the `.tmpl` suffix), creating directories as needed:
   - `templates/CLAUDE.md.tmpl` -> `CLAUDE.md`
   - `templates/00_repo_conditioning.md.tmpl` -> `docs/00_repo_conditioning.md`
   - `templates/develop/*.tmpl` -> `docs/develop/*`
   - `templates/claude/agents/*.tmpl` -> `.claude/agents/*`
   - `templates/claude/skills/<name>/SKILL.md.tmpl` -> `.claude/skills/<name>/SKILL.md`
   - `templates/scripts/claude-night-runner.ps1.tmpl` -> `scripts/claude-night-runner.ps1`
   - append `templates/gitignore-additions.txt` to `.gitignore` (create if absent)
   - create empty `logs/runs/` (write a `.gitkeep`)
   If a target file already exists, show a diff and ask before overwriting. Never clobber
   silently.
7. **Seed handoff.** Write the first `docs/develop/AGENT_PROGRESS.md` entry: bootstrap done,
   Sprint 01 ACTIVE / Batch 01 READY, next action = launch the runbook.
8. **Report.** Print a "conditioned — how to launch" summary pointing at the rendered
   `docs/develop/AUTONOMOUS_RUNBOOK.md`.

## Rules

- Resolve placeholders in order: inspect repo -> infer from docs -> ask the human. Never leave a
  `{{...}}` unresolved.
- Do not invent stack facts. If you cannot detect the package manager or verify commands, ask.
- The human gate (step 5) is mandatory even when everything resolved cleanly.
- After writing, the user can validate with `verify-bootstrap.ps1` (see README).
