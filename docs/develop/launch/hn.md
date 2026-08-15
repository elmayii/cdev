# Hacker News — Show HN draft

**Title:** Show HN: CDev – I made coding-agent sessions into continuous development

**URL:** https://github.com/elmayii/cdev

**First comment (post immediately after submitting):**

I tried spec-driven development. It wasn't how I wanted coding agents to work, so I built a
different method: Continuous Development.

The problem: an agent session dies — context exhausted, quota wall, window closed — and
everything it knew dies with it. The next session re-derives what was already decided, and
often decides differently. Meanwhile "done" claims pile up with no durable proof.

CDev's answer is to stop treating the conversation as memory. The repository holds the plan
(SPRINTS.md), the handoff (AGENT_PROGRESS.md) and the proof (git + recorded evidence per
check, including "not-run"). Any session — new, resumed, or a different agent — reads those
and continues. Autonomy is bounded by a clarity map: the agent may only self-select work in
areas the docs actually specify; inventing unspecified product is forbidden. Irreversible
actions (push to shared branches, schema on shared DBs, deploys, payments) are prepared, never
executed.

It wasn't designed on paper: it's extracted from six weeks of driving a real in-production
product across four repos plus an orchestrating workspace, and the docs include honest field
reports of what broke (docs/05, docs/06). The current implementation is a Claude Code plugin;
the method itself is written to be agent-independent — that portability claim is unvalidated
and marked as such.

Happy to answer anything; the most useful thing you can give me back is a field report.

---
**Human decision:** publish or not (account, timing). Not published by the agent, ever.
