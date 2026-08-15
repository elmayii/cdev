# X (Twitter) thread draft

**1/**
Coding agents work in sessions. Sessions die.

I spent 6 weeks making agents survive that — driving a real production product across 4
repos — and extracted the method. It's open source now: CDev, Continuous Development.

github.com/elmayii/cdev

**2/**
The four failures every agent user knows:
- stops when the task ends
- session dies, context dies with it
- plan drifts from the repo
- "done" with no proof

One root cause: the agent's state lives in the conversation. Conversations aren't durable,
shared, or verifiable.

**3/**
CDev's move: the repository is the memory.

Plan → SPRINTS.md
State → AGENT_PROGRESS.md (per-check evidence, "not-run" included)
Truth → git

Resumption is not remembering. It's reading. Any session, any agent, continues from cold.

**4/**
Autonomy without inventing product: a clarity map scores every area DEFINED / PARTIAL /
ABSENT. The agent self-selects work only where the docs reach. Absent = open question, never
a batch.

And the irreversible stuff — push, deploys, schema, money — is prepared, never executed.

**5/**
I tried spec-driven development first. Not bad — different objective.

Spec-driven: make the spec drive implementation.
Continuous: make the repository able to sustain development across sessions.

I wanted the second one, so I built it.

**6/**
Today it ships as a Claude Code plugin (7 skills, one command to install). The method is
written agent-independent; that portability is unvalidated and labeled as such — the docs
include field reports of what broke, not just what worked.

Best contribution: run it, file a field report.

---
**Human decision:** publish or not, timing, whether to tag anyone.
