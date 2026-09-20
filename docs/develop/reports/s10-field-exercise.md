# Sprint 10 — field exercise of the multi-repo skills (script for the human)

`scripts/sandbox.ps1` builds single repositories only, so the two multi-repo skills touched by
this sprint cannot be exercised in a fixture. Protocol §4 (local line, 2026-09-19): a recorded
field exercise by the human stands in. This is that exercise — one session, in your own
workspace. **This repository's agent never opens your workspace or its repositories**; it
wrote this script and will record what you report back.

Nothing here needs the branch merged or the plugin reinstalled.

## 0 · Load the branch, and prove it is the branch

In this repository: `git checkout feat/8-status-and-gap-closing-planners`.
Then, from **your workspace's** root:

```
claude --plugin-dir C:\CodeWork\ideas\cdev
```

First prompt, before anything else:

> Invoke the skill cdev:cdev-monorepo-planner and tell me two things only: the "Base directory
> for this skill" you were shown, and whether its text contains the phrase "Before writing each
> SYSTEM_BATCH".

Expected: the base directory is under this repository (not the plugin cache) and the answer is
yes. Checked from this repository on 2026-09-19 — the working tree wins over the installed
0.1.1. **If yours says otherwise, stop**: the exercise would be testing the old skill. Report
that instead; it is a finding.

## A · `cdev-monorepo-planner` on a throwaway objective

Before starting, note the state so it can be discarded: in the workspace and in each
repository the objective could touch, `git status` must be clean (stash or commit what is
yours first).

Launch it **bare** — no "ask me the questions" line. The point is whether the skill carries
what you have been typing by hand:

> /cdev:cdev-monorepo-planner — plan a small SYSTEM sprint: add a "last seen" timestamp to the
> user's profile, stored by the backend and shown in the web app.

(Any small invented objective touching two repositories works. Do not use real pending work:
an unmerged skill should not write your real plans.)

Observe, and note for each **held / broke** (quote it where it broke):

| # | What to watch |
|---|---|
| A1 | It read the single-repo planner's section (it should say so, or visibly read `cdev-planner/SKILL.md`) — the pointer was followed |
| A2 | The batch grouping was shown **before** any plan file was written |
| A3 | Questions came **per SYSTEM_BATCH**, before that batch was written — not one questionnaire up front, not after |
| A4 | Each question carried suggested answers, one marked recommended; it used the form tool |
| A5 | System-level decisions appeared among them: which repositories participate, contract terms, the sync-point artifact, order, verification level |
| A6 | It did not ask you to confirm what your prompt already said |
| A7 | A batch with nothing open was written without a question (may not occur — say so if it did not) |
| A8 | Your answers landed, dated, in the workspace's `DECISIONS.md` |

Answer two or three rounds — enough to see the rhythm — then stop it.

**Discard everything it wrote**, in the workspace and in every repository it touched:

```
git status            # see what it wrote
git checkout -- .     # tracked files back to HEAD
git clean -fd         # new files it created (review the list `git clean -nd` prints first)
```

## B · `cdev-monorepo-status`, cold, on your real SYSTEM sprint

Read-only — it runs on the real thing. **Use a fresh session** (same `claude --plugin-dir …`
command): a status produced by the session that planned or ran the sprint proves nothing about
reading the repository alone.

> /cdev:cdev-monorepo-status

Observe:

| # | What to watch |
|---|---|
| B1 | It read `cdev-status/SKILL.md` for the method — the pointer was followed |
| B2 | Three axes, in order: functional → non-functional → user stories; every item names where it came from |
| B3 | The non-functional axis holds qualities of the *system*, not the repositories' working rules |
| B4 | One percentage per axis, declared an estimate; partial items carry a percentage, a reason and the owning batch |
| B5 | The per-repository table is there: repository · local batches for this SYSTEM sprint · state · blockers |
| B6 | Local truth: it opened each affected repository's own `SPRINTS.md` / `AGENT_PROGRESS.md`; any workspace↔repository divergence is flagged and the repository's state is the one reported; it did not take a state from the snapshot file |
| B7 | Where the repositories do not support something, it says "not derivable" and names what is missing — nothing filled in from thin air. **You are the only one who can judge this**: is there any requirement or story in it that you do not recognise as yours? |
| B8 | `git status` is clean afterwards in the workspace and in every repository — it wrote nothing |
| B9 | Is it the status you used to ask for by hand? What would you change? |

Optional, if a batch closed recently: `/cdev:cdev-monorepo-status since <that batch>` — does
the "(before NN%)" delta match what you remember?

## What to report back

Per observation, **held** or **broke**, with the broken text quoted; plus B7 and B9 in your
own words. It goes into `docs/develop/AGENT_PROGRESS.md` as field evidence, product
anonymized. Anything that broke is either fixed on the branch and re-observed, or carried as a
named blocker. The sprint does not close and the pull request is not merged without this entry.
