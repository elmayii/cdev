# Reddit draft (r/ClaudeAI · r/ChatGPTCoding · r/ExperiencedDevs — adapt tone per sub)

**Title:** Coding agents work in sessions. I built a method that turns those sessions into
continuous development — extracted from six weeks of production use, now open source

**Body:**

Every coding agent I used had the same four failure modes: it stops when the assigned task
ends; the session dies and takes all context with it; the plan drifts away from the actual
repo; and it says "done" without durable proof.

Spec-driven development didn't fix this for me — it's a different objective. So I built CDev
(Continuous Development): the repository, not the conversation, holds the plan, the state and
the evidence. A session that dies loses nothing; the next one reads three files and git and
continues. The agent derives its next work only inside what the docs actually specify (a
"clarity map" — DEFINED/PARTIAL/ABSENT), and everything irreversible is prepared for a human,
never executed.

What makes it different from "yet another agent framework": it was extracted, not designed.
Six weeks driving a real product across four repos; the repo includes field reports of what
held *and what broke* — including a production incident caused by two contradictory runbooks
that the method now checks for.

Ships today as a Claude Code plugin (7 skills). Method written agent-independent; only this
binding exists so far, honestly labeled.

Install: `/plugin marketplace add elmayii/cdev-marketplace` →
`/plugin install cdev@cdev-marketplace`

Repo: https://github.com/elmayii/cdev — the contribution I value most is a field report: run
it on a real repo and tell me what broke.

---
**Human decision:** which subreddits, which account, publish or not.
