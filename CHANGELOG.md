# Changelog

All notable changes to the CDev plugin are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow semver. Installed
copies update only when the version changes.

## [0.1.1] — 2026-08-15

### Fixed

- `templates/develop/SPRINTS.md.tmpl` shipped with damaged encoding (BOM + mojibake
  em-dashes); a literal render produced corrupted headers. Re-encoded clean UTF-8. Found by
  replaying the public walkthrough against the installed copy.
- `templates/PLACEHOLDERS.md` declared a `{{BRANCH_PREFIX}}` default that disagreed with the
  loop skill's (`claude/…` vs `cdev/sprint-<nn>-batch-<nn>`) — two shipped documents
  contradicting each other about the same switch, the exact incident class the method's own
  consistency rule exists for. Unified on the loop's default.

### Added

- `docs/community/walkthrough.md` — replay-validated first-use walkthrough.
- `docs/community/rfc-process.md` — the RFC process with its field-evidence bar.
- Community layer: CONTRIBUTING, CODE_OF_CONDUCT, SECURITY, issue forms (field report
  included), PR template, labels.
- Visual identity (`assets/`): master icon, flat vector marks, wordmark lockups, social
  preview.
- Public README: positioning, the four failure modes, the loop, quick start, command table,
  lifecycle guide, evidence tables.

### Removed

- Internal working material (launch drafts, strategy notes, stale marketplace draft) moved
  out of the public tree.

## [0.1.0] — 2026-08-15

First public release.

### Added

- The seven skills, namespaced `cdev:*`: `bootstrap`, `cdev`, `cdev-planner`, `ockham`,
  `bootstrap-monorepo`, `cdev-monorepo`, `cdev-monorepo-planner`.
- Role profiles (`profiles/backend.md`, `profiles/frontend.md`) — exactly four things each.
- Conditioning template base (`templates/`) with its placeholder contract.
- The method's documentation (`docs/01`–`08`), extracted from six weeks of production use
  across four repositories plus an orchestrating workspace.
- Distribution via the `cdev-marketplace` plugin marketplace.

### Known limitations

- One host binding: Claude Code. The method is designed agent-independent; only this binding
  exists and is validated.
- Field evidence comes from a single product (deep, but one). Second-product validation is
  the next planned phase.
- Support scripts are PowerShell (Windows-first development environment).
- The `fullstack` role has no profile — deliberately, until something real runs on one.
