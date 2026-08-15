# Changelog

All notable changes to the CDev plugin are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow semver. Installed
copies update only when the version changes.

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
