# 08 · Installation

> What is actually installed, how, and what deliberately is not. Written after the package
> exists — every statement below was executed and verified on 2026-08-15, none is a plan.

## What the package is

A single Claude Code plugin, `cdev` (semver, currently `0.1.0`), served by its own
marketplace. One repository holds the package (`github.com/elmayii/cdev` — this repository);
a second, minimal one holds the marketplace manifest (`github.com/elmayii/cdev-marketplace`).
Both public, MIT.

The plugin root ships four load-bearing directories, and they all travel together:

| Directory | Role |
|---|---|
| `skills/` | The seven entry points (auto-discovered by the host) |
| `profiles/` | The role profiles the loop and the conditioner read |
| `templates/` | The render base for conditioning, with its placeholder contract |
| `scripts/` | The bootstrap verifier and the sandbox fixture builder |

Skills locate the profiles and templates at `../../` from their own base directory, resolved
through the real path. This works identically in the working tree, through a sandbox junction,
and in the installed cache — verified in all three.

## Installing

Inside Claude Code:

```
/plugin marketplace add elmayii/cdev-marketplace
/plugin install cdev@cdev-marketplace
```

The same is available headless: `claude plugin marketplace add elmayii/cdev-marketplace` and
`claude plugin install cdev@cdev-marketplace`. The install is user-scoped and lands as a
complete copy of the plugin root at:

```
~/.claude/plugins/cache/cdev-marketplace/cdev/<version>/
```

## What you get

Seven skills, namespaced by the plugin name:

| Invocation | What it is |
|---|---|
| `/cdev:bootstrap` | Condition one repository (recognition-first, both halves, human gate) |
| `/cdev:cdev` | The execution loop — dispatcher plus single loop reading the role profiles |
| `/cdev:cdev-planner` | Single-repo planning: materialize an objective, or gap-analyze |
| `/cdev:ockham` | User-invoked plain-language re-telling of dense output |
| `/cdev:bootstrap-monorepo` | Condition a multi-repo workspace (never touches the children) |
| `/cdev:cdev-monorepo` | The orchestrating loop over conditioned repositories |
| `/cdev:cdev-monorepo-planner` | Cross-repo planning and gap analysis |

The namespace is the point: un-namespaced copies in `~/.claude/skills` collide with anything
sharing a name; `cdev:*` cannot.

## What is deliberately not installed

- **No reviewer/runner agents, no per-repo runtime skills.** Unevidenced in six weeks of field
  use (document 07 §5). Their templates ship in `templates/claude/` and render only if a
  conditioning asks for them.
- **No watchdog as a primary.** The night-runner template renders on request only; continuity
  is a property of the repository, not of a live process.
- **Nothing into `~/.claude/skills`.** The copy-install script this repository used before the
  plugin existed (`install.ps1`) is retired; the plugin supersedes it.

## Updating

Updates are **version-gated**: an installed copy re-fetches only when `plugin.json`'s
`version` changes. Publishing a fix therefore means: bump the version, push, and users run
`/plugin marketplace update cdev-marketplace` (Claude Code also refreshes marketplaces on its
own schedule). Commits that do not bump the version — docs, planning artifacts — never reach
installed copies.

## Developing the package

This repository is the source of truth; the installation is a snapshot of it.

- `claude --plugin-dir <repo-root>` loads the working tree live; `/reload-plugins` picks up
  edits without restarting.
- `scripts/sandbox.ps1 [-Name x] [-Role backend|frontend]` builds a throwaway fixture whose
  `.claude/skills` is a junction into the working tree — the way every change here gets
  exercised by a fresh agent before it counts.
- `claude plugin validate .` checks the manifest.

## Uninstalling

`/plugin uninstall cdev@cdev-marketplace`, and `/plugin marketplace remove cdev-marketplace`
if the marketplace itself is no longer wanted. Repositories conditioned by the plugin keep
working from their own `docs/develop/` — the machinery lives in the conditioned repo, which is
rather the whole idea.
