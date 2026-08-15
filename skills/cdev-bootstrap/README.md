# cdev-bootstrap — Continuous Development bootstrap kit

A portable Claude Code skill that conditions a fresh repo for continuous autonomous development
from a folder of source docs. One folder carries the whole CDev experience.

## Install

- **Per project:** copy this `cdev-bootstrap/` folder into the target repo's `.claude/skills/`.
- **Global (recommended):** copy it into `~/.claude/skills/cdev-bootstrap/` — then
  `/cdev-bootstrap` is available in every repo without copying.

Claude Code only auto-discovers skills under `.claude/skills/` (project) or `~/.claude/skills/`
(global). A folder anywhere else is not discovered.

## Use

1. Put your source docs in the target repo (e.g. `docs/<product>/`).
2. Invoke `/cdev-bootstrap` (or ask Claude to use the cdev-bootstrap skill), naming the docs folder.
3. Review the resolved placeholders + derived sprint outline at the human gate; confirm.
4. The skill writes: `CLAUDE.md`, `docs/00_repo_conditioning.md`, `docs/develop/*`,
   `.claude/agents/*`, `.claude/skills/*`, `scripts/claude-night-runner.ps1`, `.gitignore`
   additions, `logs/runs/`, and a first-draft `docs/develop/SPRINTS.md`.
5. Launch per the rendered `docs/develop/AUTONOMOUS_RUNBOOK.md`.

## What it produces

The same machinery this kit was extracted from: a conditioning contract, an operational
`CLAUDE.md`, the autonomous execution engine (`docs/develop/`), reviewer agents + runtime
skills (`.claude/`), the night-runner watchdog and a `logs/` convention.

## Verify

After a bootstrap, run `verify-bootstrap.ps1` (PowerShell) to confirm no unresolved `{{...}}`
placeholders remain and `SPRINTS.md` has exactly one `Status: ACTIVE` sprint.

## Notes

- Stack-agnostic with Node/TS defaults pre-filled.
- Watchdog is PowerShell-only for now.
- Assumes account-level skills (superpowers, ponytail) are installed; it references, not vendors them.
