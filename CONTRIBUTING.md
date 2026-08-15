# Contributing to CDev

CDev is a method extracted from field evidence, and it changes the same way it was built:

> **The core does not change because an idea sounds good. It changes because field evidence
> shows the method needs to change.**

## What to contribute, and how

| Contribution | Process |
|---|---|
| Documentation, small fixes | Pull request |
| Bug fix | Issue or direct PR, with evidence of the failure |
| New role profile | PR + evidence from real use (a field report) |
| New host binding (another agent/OS) | Proposal → implementation → validation |
| New skill or capability | Open a Discussion first |
| Core methodology change | RFC + field evidence |
| **Field report** | Always welcome — no code required (see the issue template) |

Field reports are the community's primary evidence object: what held, what broke, how long
unattended, how many resumptions. The method's own documents (`docs/01`–`08`) were built from
exactly that material.

## Repository layout

- `skills/` — the seven Claude Code skills (the current host binding).
- `profiles/` — role profiles: exactly four things each (what "verified" means, what
  "evidence" means, the hardest gate, the self-chosen work order). Never a different loop.
- `templates/` — the conditioning render base (`PLACEHOLDERS.md` is the contract).
- `docs/` — the method: origin, model, mechanics, field reports, core-vs-periphery,
  installation.
- `docs/develop/` — this repository's own CDev machinery (it drives itself).

## Branch model

`main` is the latest stable development state, protected (PR required, no force pushes, no
deletions). Branch from `main`:

```
feat/*   fix/*   docs/*   refactor/*   community/*   chore/*
```

Optionally link the issue: `feat/123-add-codex-binding`. External contributions merge by
squash.

## Ground rules for changes

- **Evidence over assertion.** A change to skills or profiles gets exercised in a sandbox
  fixture (`scripts/sandbox.ps1`) before it counts; say what you ran and what happened.
- **Core / profile / binding / periphery.** Every change should be justifiable in document
  07's terms. Technology-specific material belongs in profiles or bindings, never in core
  rule text.
- Artifacts are written in English.
- Validate the plugin with `claude plugin validate .`.

## Releases

Semver. `v0.1.x` fixes and docs · `v0.2.0` compatible capabilities · `v1.0.0` stable public
contract. Changes land in `CHANGELOG.md`; installed copies update only on version bumps.
