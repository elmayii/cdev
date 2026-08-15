# CDev — Open-Source Readiness, Community & Visibility Strategy

**Repository:** https://github.com/elmayii/cdev  
**Date:** 2026-08-15  
**Positioning:** **Continuous Development Framework for Coding Agents**

---

## 1. Executive summary

CDev already has enough technical substance to be presented publicly as a serious open-source project, but the repository still looks more like a recently published internal development repository than a project prepared to receive users and contributors.

The immediate objective should therefore not be “promote CDev harder”, but:

> **Turn the repository into a clear public product, then build the community around it.**

The strategy should follow this sequence:

1. Make the repository open-source ready.
2. Make CDev understandable in less than five minutes.
3. Create clear contribution and community mechanisms.
4. Launch the concept publicly.
5. Use real adoption and field reports to evolve the method.

The central positioning should remain:

> **CDev — Continuous Development Framework for Coding Agents**

And the core public message:

> **Coding agents work in sessions. CDev turns those sessions into continuous development.**

---

# 2. Current state of the public repository

The repository is already public and distributed under MIT, but several elements expected from a mature open-source project are still missing.

Important current observations:

- The default branch is still `master`.
- `master` is currently the only branch.
- The main branch is not protected.
- The repository has no public description.
- It has no GitHub topics.
- GitHub Discussions is disabled.
- There are no GitHub Releases.
- There are no Git tags.
- The plugin declares version `0.1.0`, but that version does not yet exist as a GitHub release/tag.
- There is no `CONTRIBUTING.md`.
- There is no `CODE_OF_CONDUCT.md`.
- There are no issue templates.
- There is no pull request template.
- The current README still contains too much internal development state.

The repository is technically meaningful, but its public interface needs to be redesigned.

---

# 3. Changes already identified

These are the changes already considered necessary.

| Change | Priority | Recommendation |
|---|---:|---|
| Rename `master` to `main` | High | Do it in both `cdev` and `cdev-marketplace` |
| Define a branch policy | High | Document it in `CONTRIBUTING.md` |
| Rewrite `README.md` | High | Make it a product/community entry point |
| Add usage recommendations | High | Explain when each part of CDev should be used |
| Create a visual identity / icon | Medium | Important for recognition and distribution |
| Add a command table | High | Expose the real commands directly in the README |
| Explain project lifecycle phases | High | Users should recognize their situation before choosing a command |
| Improve Markdown visual hierarchy | Medium | Use icons, diagrams and tables where they improve comprehension |

All of these should remain in the plan.

---

# 4. Additional changes required

## 4.1 GitHub metadata and discoverability

CDev should have a clear GitHub repository description.

Recommended description:

> **Continuous Development Framework for Coding Agents.**

Recommended topics:

- `continuous-development`
- `coding-agents`
- `claude-code`
- `agent-skills`
- `autonomous-development`
- `developer-tools`
- `software-engineering`
- `multi-repo`
- `ai-agents`

Also recommended:

- Add a social preview image.
- Add the CDev logo.
- Add a documentation/homepage URL when available.
- Avoid maintaining a GitHub Wiki unless it has a clear role.
- Keep the repository documentation as the primary source of truth.

---

# 5. Releases and versioning

This should be fixed before public promotion.

The plugin already declares:

```text
0.1.0
```

But the repository currently has no public release history.

The first official release should therefore be:

```text
v0.1.0
```

The release notes should explain:

- What CDev is.
- What the first release includes.
- The current Claude Code binding.
- The available skills.
- Installation.
- Known limitations.
- What is still experimental.

Recommended version model:

```text
v0.1.x   bug fixes / documentation / small corrections
v0.2.0   new compatible capabilities
v0.x     iterative field validation
v1.0.0   stable public contract
```

Also add:

```text
CHANGELOG.md
```

The public release flow should eventually look like:

```text
main
  ↓
version bump
  ↓
tag vX.Y.Z
  ↓
GitHub Release
  ↓
plugin distribution
```

---

# 6. README: change its purpose

The current README contains valuable historical and technical information, but too much of it is internal.

It currently explains things such as:

- extraction progress;
- internal decisions;
- specific commits;
- refactoring history;
- completed sprints;
- upcoming internal phases.

That information should not disappear, but it should no longer dominate the public landing page.

The README has one primary job:

> **Explain what CDev is, why someone should care, how to install it and how to start using it.**

---

# 7. Recommended README narrative

## Hero

Logo + project name.

```text
CDev
Continuous Development Framework for Coding Agents
```

Short explanation:

> Turn coding-agent sessions into a continuous, resumable development process that keeps working while context exists and stops when human decisions are actually required.

Badges:

- Version
- License
- GitHub stars
- Claude Code plugin
- Documentation / community when available

---

## Why CDev?

Use the four original failure modes:

- The agent stops after finishing the assigned task.
- The session dies and takes context with it.
- The plan drifts away from the actual repository.
- The agent says “done” without durable proof.

Then connect them:

> CDev moves planning, state and evidence out of the conversation and into the repository.

---

## Simple CDev loop

A visual explanation should appear very early.

```text
Condition
   ↓
Plan
   ↓
Execute
   ↓
Verify
   ↓
Record
   ↓
Continue
   ↘
    Stop only when real human context is required
```

A proper diagram can later replace this ASCII version.

---

## Quick Start

Show the verified installation immediately.

```text
/plugin marketplace add elmayii/cdev-marketplace
/plugin install cdev@cdev-marketplace
```

Then one minimal first-use example.

---

# 8. Command table

The README should expose the commands directly.

| Command | Purpose |
|---|---|
| `/cdev:bootstrap` | Prepare one repository for CDev |
| `/cdev:cdev-planner` | Turn an objective into executable work or analyze gaps |
| `/cdev:cdev` | Run continuous development in a conditioned repository |
| `/cdev:ockham` | Re-explain dense technical output in simpler language |
| `/cdev:bootstrap-monorepo` | Prepare a workspace that coordinates several repositories |
| `/cdev:cdev-monorepo-planner` | Plan and analyze work across repositories |
| `/cdev:cdev-monorepo` | Execute coordinated work across conditioned repositories |

The README should explain the commands, but the detailed technical reference should remain in documentation.

---

# 9. Explain CDev by project phase

Users should not need to understand the internal skill architecture before using CDev.

The documentation should answer:

> **Where am I in the project, and what do I do next?**

Recommended lifecycle:

## Phase 1 — Existing repository

You have a repository but it is not prepared for continuous autonomous work.

Use:

```text
/cdev:bootstrap
```

Goal:

> Condition the repository.

---

## Phase 2 — Objective or product documentation exists

You know what you want to build, but the work is not yet structured for execution.

Use:

```text
/cdev:cdev-planner
```

Goal:

> Materialize the objective into executable work or identify missing clarity.

---

## Phase 3 — Work is ready

The repository is conditioned and the plan contains executable work.

Use:

```text
/cdev:cdev
```

Goal:

> Let the agent work continuously through the available safe work.

---

## Phase 4 — The current plan ends

CDev can derive additional work only within the clarity and rules already recorded in the repository.

It should not invent unspecified product areas.

---

## Phase 5 — Human decision required

CDev should stop only for real blockers such as:

- missing context;
- contradictory documentation;
- absent product definition;
- irreversible action;
- required human authorization;
- unsafe repository state.

Blocked work should not automatically stop all other independent work.

---

## Phase 6 — The product spans multiple repositories

Use the multi-repository layer:

```text
/cdev:bootstrap-monorepo
/cdev:cdev-monorepo-planner
/cdev:cdev-monorepo
```

The coordination layer should coordinate repositories without taking away their local autonomy.

---

# 10. CDev as method vs current implementation

This distinction should be explicit.

Recommended statement:

> **CDev is the method. The current reference implementation is a Claude Code plugin.**

This is strategically important.

The CDev methodology should not be defined by:

- Claude Code slash command syntax;
- one plugin format;
- PowerShell;
- one agent vendor;
- one operating system.

The current implementation can be Claude Code-specific while the conceptual method remains portable.

Avoid claiming:

> “Works with every coding agent.”

until that is actually implemented and validated.

Instead say:

> **Designed as a coding-agent-independent method. Currently shipped as a Claude Code plugin.**

This keeps future bindings open for tools such as Codex, OpenCode, Cursor or others without claiming unsupported compatibility.

---

# 11. Community health files

Create the standard open-source community layer.

Recommended structure:

```text
CONTRIBUTING.md
CODE_OF_CONDUCT.md
SECURITY.md
CHANGELOG.md

.github/
├── ISSUE_TEMPLATE/
│   ├── bug.yml
│   ├── feature.yml
│   ├── field-report.yml
│   └── config.yml
│
└── PULL_REQUEST_TEMPLATE.md
```

Potential later additions:

```text
.github/CODEOWNERS
.github/workflows/
```

These files make the repository easier to contribute to and reduce the amount of manual explanation required from maintainers.

---

# 12. Contribution model based on CDev itself

CDev should not simply accept arbitrary skills and functionality.

The contribution model can reuse CDev's own conceptual architecture:

- Core
- Profiles
- Host bindings
- Periphery

Recommended contribution rules:

| Contribution type | Recommended process |
|---|---|
| Documentation / small fixes | Pull request |
| Bug fix | Issue or direct PR with evidence |
| New profile | PR + evidence from real use |
| New host binding | Proposal + implementation + validation |
| New skill/capability | Discussion first |
| Core methodology change | RFC + field evidence |
| Field report | Accepted even without code changes |

This creates an important project principle:

> **The CDev core should not change because an idea sounds good. It should change because field evidence shows that the method needs to change.**

That principle matches how CDev itself was originally extracted.

---

# 13. Field Reports as a community primitive

Field reports should become one of the distinctive features of the CDev community.

Instead of requiring every contributor to write code, users should be able to contribute evidence.

Recommended field report template:

```text
Project type
Repository type
Coding agent
CDev version
Duration using CDev
Number of sprints/batches
Longest unattended run
Number of resumptions
Blockers encountered
Human interventions
Verification strategy
What worked
What broke
Unexpected behaviour
Suggested improvement
```

Possible future section:

```text
Community Field Reports
```

Benefits:

1. Creates useful public content.
2. Produces evidence about the methodology.
3. Converts users into contributors.
4. Makes regressions and patterns easier to identify.
5. Builds a public dataset of real agent-development behaviour.

The natural community objects of CDev could therefore become:

> **Field Reports · Profiles · Bindings · Examples · Integrations**

---

# 14. GitHub Discussions

Enable GitHub Discussions early.

Recommended categories:

```text
📢 Announcements
💬 General
❓ Q&A
💡 Ideas
🧪 Field Reports
🧩 Profiles & Bindings
📐 RFCs
```

Recommended rule:

> **Discussion = conversation.**  
> **Issue = actionable work.**

Do not open too many communication channels immediately.

In particular, Discord is probably unnecessary at the beginning.

The community should first concentrate around GitHub.

Discord becomes useful once there is enough real-time interaction that GitHub Discussions starts feeling too slow.

---

# 15. Branch strategy

Both repositories should move from:

```text
master
```

to:

```text
main
```

Recommended branch model:

```text
main
│
├── feat/*
├── fix/*
├── docs/*
├── refactor/*
├── community/*
└── chore/*
```

Optional issue linkage:

```text
feat/123-add-codex-binding
fix/145-bootstrap-verification
docs/151-improve-lifecycle-guide
```

`main` should mean:

> **Latest stable development state.**

Recommended protections for `main`:

- Pull request required.
- No force pushes.
- No branch deletion.
- Required checks once CI exists.
- Review conversations resolved before merge.
- Squash merge as the default merge strategy for external contributions.

---

# 16. CI and validation

CDev's own repository should follow the same philosophy it asks users to follow:

> **Evidence over assertion.**

A contribution should not be accepted just because it looks correct.

Initial GitHub Actions could validate:

- plugin manifest;
- version consistency;
- expected skill/profile structure;
- unresolved placeholders;
- broken links;
- Markdown issues;
- test/sandbox scripts;
- installation fixture;
- eventually real integration tests.

The exact checks should only be added where they are deterministic and useful.

---

# 17. Public differentiation

CDev needs a clear category and a clear boundary.

## Spec Kit

Category:

> **Spec-Driven Development**

Its main thesis is that specifications should drive implementation.

---

## AI DevKit

Category:

> Control plane / operating layer for multiple coding agents.

It focuses on areas such as:

- shared configuration;
- agent supervision;
- memory;
- cross-agent communication;
- reusable engineering skills;
- verification workflows.

---

## Omnigent

Category:

> Meta-harness / orchestration platform for AI agents.

It focuses more strongly on:

- agent runtimes;
- multi-agent orchestration;
- sandboxing;
- policies;
- sessions;
- remote collaboration.

---

## CDev

Recommended category:

> **Continuous Development Framework for Coding Agents**

Recommended positioning:

> CDev is not another coding agent and not an agent control plane. It is a development method that lets a coding agent keep working across sessions, derive the next safe work from the repository, prove what it finishes, and stop only when real human context is required.

This allows CDev to coexist with agent frameworks and control planes rather than having to replace them.

---

# 18. Origin story: “Spec-driven didn't fit how I wanted to work”

This should be part of CDev's public story.

It gives the project a personal and understandable reason for existing.

Recommended framing:

> **I tried spec-driven development. It wasn't how I wanted coding agents to work, so I built my own method: Continuous Development.**

The important distinction is not:

> “Spec-driven development is bad.”

It is:

> “Spec-driven development did not solve the way I wanted agents to work.”

The desired behaviour was different:

- Keep developing after one task ends.
- Survive session boundaries.
- Resume from repository state.
- Find the next safe unit of work.
- Verify work before declaring it done.
- Stop only when genuine human information or authorization is necessary.

That eventually became CDev.

---

# 19. A stronger origin narrative

A longer version suitable for README, article or launch material:

> **Spec-driven development wasn't the way I wanted to work with coding agents, so I built my own method.**
>
> I didn't want an agent that only followed a sequence of spec → tasks → implementation → stop.
>
> I wanted an agent that could keep developing, survive context loss, resume from the repository, find the next safe work, prove what it finished, and only stop when it genuinely needed a human.
>
> That became **CDev — Continuous Development**.

Short version:

> **I tried spec-driven development. It wasn't how I wanted coding agents to work, so I built Continuous Development.**

---

# 20. Conceptual contrast: Spec-Driven vs Continuous Development

This can be useful for explaining CDev without attacking another methodology.

### Spec-Driven Development

> Make the specification drive implementation.

### Continuous Development

> Make the repository capable of sustaining development continuously.

That contrast is simple enough to become part of CDev's external communication.

It should be presented as a difference in objectives, not a declaration that one method invalidates the other.

---

# 21. Visual identity

CDev should have a visual identity before a broad launch.

Avoid generic AI imagery:

- robots;
- brains;
- sparkle icons;
- generic hexagons;
- neural-network imagery.

The visual should represent:

> **Continuous development.**

Potential concepts:

- development loop;
- git branch;
- checkpoints;
- verification nodes;
- continuous movement;
- `/cdev` as a recognizable wordmark.

One possible conceptual direction:

```text
/cdev
```

combined with a continuous line moving through several verified checkpoints.

The same visual language should work for:

- GitHub avatar;
- README;
- social preview;
- plugin identity;
- X / LinkedIn posts;
- future website;
- presentation slides.

---

# 22. Recommended execution plan

## Phase 1 — Open-source readiness

Do before public promotion.

1. Rename `master` → `main` in `cdev`.
2. Rename `master` → `main` in `cdev-marketplace`.
3. Protect `main`.
4. Add repository description.
5. Add GitHub topics.
6. Publish `v0.1.0`.
7. Create GitHub Release `v0.1.0`.
8. Add `CHANGELOG.md`.
9. Add `CONTRIBUTING.md`.
10. Add `CODE_OF_CONDUCT.md`.
11. Add `SECURITY.md`.
12. Add issue templates.
13. Add pull request template.
14. Enable GitHub Discussions.

---

## Phase 2 — Make CDev understandable in five minutes

1. Redesign README.
2. Add logo / visual identity.
3. Add one-sentence positioning.
4. Explain the four original problems.
5. Add simple CDev lifecycle diagram.
6. Add Quick Start.
7. Add command table.
8. Add “Which command should I use?” section.
9. Add project lifecycle recommendations.
10. Explain method vs Claude Code binding.
11. Add link to field evidence.
12. Add link to community/contributing.

---

## Phase 3 — Build the community structure

1. Create Field Report template.
2. Create RFC process.
3. Define Core / Profile / Binding contribution rules.
4. Define repository labels.
5. Add `good first issue`.
6. Create initial Discussions.
7. Publish examples/showcases.
8. Invite early external users to submit field reports.

---

## Phase 4 — Launch

Only after the repository is prepared.

Recommended channels:

1. GitHub
2. Hacker News
3. Reddit
4. X
5. LinkedIn
6. Claude Code / coding-agent communities

The launch should not be framed as:

> “I made some Claude Code skills.”

The stronger message is:

> **Coding agents work in sessions. CDev turns those sessions into continuous development.**

Another strong launch hook:

> **I tried spec-driven development. It wasn't how I wanted coding agents to work, so I built a different method: Continuous Development.**

---

# 23. Community funnel

The repository should deliberately move people through four stages:

```text
Visitor
  ↓
User
  ↓
Participant
  ↓
Contributor
```

### Visitor → User

Needs:

- clear README;
- good positioning;
- fast installation;
- simple first use.

### User → Participant

Needs:

- Discussions;
- Q&A;
- Field Reports;
- examples;
- roadmap visibility.

### Participant → Contributor

Needs:

- clear contribution rules;
- issue templates;
- RFC process;
- profile/binding contribution paths;
- small `good first issue` tasks.

### Contributor → Maintainer / community leader

Later:

- ownership of profiles;
- bindings;
- documentation areas;
- field report review;
- RFC facilitation.

The community should be designed around this progression rather than around star count alone.

---

# 24. Final recommendation

The next milestone for CDev should not be “get visibility”.

It should be:

> **Make CDev ready to deserve visibility.**

The technical foundation already exists.

The next layer to build is the public interface around it:

- clear identity;
- clear README;
- clear installation;
- clear lifecycle;
- clear contribution model;
- clear release history;
- visible evidence;
- a place for community discussion.

The strongest differentiator should remain the methodology itself:

> **Continuous Development Framework for Coding Agents**

And the project should use its own history as evidence:

> CDev did not start as a theoretical framework. It emerged from trying to make coding agents continue working safely across real repositories and real session boundaries.

The long-term opportunity is larger than a Claude Code plugin.

If the methodology proves portable, the plugin becomes only the first host binding of a broader Continuous Development ecosystem.
