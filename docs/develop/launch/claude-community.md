# Claude Code / coding-agent communities draft (Discord #showcase, forums)

**CDev — turn Claude Code sessions into continuous development** (open source, MIT)

Just shipped: a plugin that conditions any repo so Claude Code can work it unattended across
sessions — the repo itself holds the plan, the handoff and the evidence, so a dead session
loses nothing and the next one resumes by reading.

7 skills, installed in one go:

```
/plugin marketplace add elmayii/cdev-marketplace
/plugin install cdev@cdev-marketplace
```

- `/cdev:bootstrap` — conditions the repo (audits your real verification gates — it runs
  them, and flags the ones that lie), maps how well-specified your product actually is, and
  derives a plan that reaches exactly as far as your docs do.
- `/cdev:cdev` — the loop: batch by batch, per-check evidence, honest BLOCKED states that
  name the exact human decision needed, never pushes/deploys on its own.
- `/cdev:cdev-planner`, `/cdev:ockham`, plus an optional multi-repo orchestration layer.

Extracted from six weeks driving a production product across 4 repos — the docs include field
reports of what broke, and the method only changes on field evidence (that's the contribution
model too).

10-minute walkthrough: https://github.com/elmayii/cdev/blob/main/docs/community/walkthrough.md

Field reports welcome — no code required.

---
**Human decision:** which communities, which account, publish or not.
