# Walkthrough — condition a repository and run the loop

A ten-minute, replayable first use of CDev on a toy repository. Every command below was
executed against the installed plugin (v0.1.0) before being written down.

## 0 · Prerequisites

```
/plugin marketplace add elmayii/cdev-marketplace
/plugin install cdev@cdev-marketplace
```

## 1 · A toy repository

Any small repo works. The one this walkthrough was validated on:

```text
bookmarks/
├── package.json        # scripts: lint/build are echo stubs, test is a fake that exits 1
├── src/links.js        # export function saveLink(url) { return { url } }
├── docs/product.md     # one well-specified area, one ambiguous, one absent — on purpose
└── .git                # main + develop, one commit
```

The deliberate flaws matter: a fake test gate and an uneven spec are exactly what
conditioning must catch.

## 2 · Condition it

Open a Claude Code session in the repo:

```
/cdev:bootstrap
```

What happens: the skill inspects the repo, resolves the role (backend here), audits every
declared gate by *running* it — the echo `lint`/`build` and the failing `test` get flagged as
gates that lie — writes the recognition document, scores the spec into a clarity map
(DEFINED / PARTIAL / ABSENT), and derives a plan that reaches exactly as far as clarity does.
The ABSENT area becomes an open question, never a batch.

**One human gate:** it shows you the resolved placeholders + clarity map + sprint outline and
asks once. Confirm, and it writes the repo guide (`AGENTS.md`, plus the host's pointer file)
+ `docs/develop/`, validates, and commits.

Expected result: `BOOTSTRAP VERIFY: PASS`, one conditioning commit, Sprint 01 `ACTIVE` whose
Batch 01 is *make the verification gates real* — a repo without honest gates is not
conditioned, so repairing them is the first work, and no later batch may close before it.

## 3 · Run the loop

```
/cdev:cdev
```

What happens: the loop reads the plan and the handoff, takes Batch 01 on its own branch
(`cdev/sprint-01-batch-01`), replaces the fake scripts with real ones, writes the first real
test, and proves the gates are honest — including demonstrating that breaking the code makes
them fail. It records per-check evidence in `docs/develop/AGENT_PROGRESS.md` (pass / fail /
not-run), commits the batch, and continues to the next one until real work runs out or a
human decision is genuinely required. It never pushes, merges or deploys — those are yours.

## 4 · Inspect what it did

```
git log --oneline -3        # conditioning commit + batch commit
git branch                  # the batch branch, main/develop untouched
npm test                    # the gate is real now
```

And read `docs/develop/AGENT_PROGRESS.md` — the handoff log is the product: any future
session (or any other agent) resumes from it by reading, not remembering.

## Notes

- If a token-filtering shell hook (e.g. RTK) wraps your npm commands, gate auditing can
  misreport exit codes; verify gates through the hook's raw-passthrough mode.
- Developing CDev itself? `scripts/sandbox.ps1` builds throwaway fixtures like this one, wired
  to the working tree instead of the installed copy — dev mode only.
