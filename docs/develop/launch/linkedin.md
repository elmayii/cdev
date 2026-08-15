# LinkedIn draft

I tried spec-driven development with coding agents. It wasn't how I wanted to work, so I
built my own method — and after six weeks of running it on a real production product, I've
open-sourced it.

**CDev — Continuous Development Framework for Coding Agents.**

The core problem it solves: coding agents work in sessions, and sessions die. Context runs
out, quotas hit, windows close — and everything the agent understood dies with it. Teams end
up re-explaining state to a tool that was supposed to save them time.

CDev moves planning, state and evidence out of the conversation and into the repository:

→ The plan lives in the repo, with observable acceptance criteria written before the work.
→ Every step ends recorded — including what was *not* verified. "Done" requires evidence.
→ A clarity map bounds autonomy: the agent works alone only where the product is actually
specified, and stops to ask only when a human decision is genuinely required.
→ Anything irreversible — deploys, shared branches, schema changes, payments — is prepared
for a human, never executed.

It was extracted from real use, not designed on paper: four repositories, ~27 sprints, 178
handoff entries, and field reports that document what broke as carefully as what worked.

Ships today as a Claude Code plugin; designed as an agent-independent method.

Repo, docs and a 10-minute walkthrough: https://github.com/elmayii/cdev

If you run coding agents on real work, the most valuable thing you can send back is a field
report.

---
**Human decision:** publish or not, personal vs page, timing.
