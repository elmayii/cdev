# 10 · Usage recommendations

> Practical model and effort choices for running CDev in Claude Code. These are field
> recommendations, not requirements of the method — and they belong to the **current host
> binding** (document 07's terms): the method itself is model- and vendor-independent; this
> page names one vendor's models on purpose and ages accordingly.

## The short recommendation

- Use **Claude Opus 5**, or the current Opus-class model, as the default for ordinary
  single-repository CDev work.
- Use **Claude Fable 5** for CDev Monorepo and other long-running coordination work.
- Use `high` for specific, well-bounded work, `xhigh` for planning, and `max` for demanding
  execution.
- Reserve `ultracode` for large executions that contain genuinely parallel workstreams.

## Selection table

| CDev workload | Recommended model | Effort or mode | Use it when |
|---|---|---|---|
| Single-repository execution | Claude Opus 5, or the current `opus` alias | `high` | The batch is clear and local verification is well defined. This is the normal starting point for `/cdev:cdev`. |
| Single-repository planning | Claude Opus 5 | `xhigh` | The planner must reconcile requirements, architecture, dependencies or ambiguous acceptance before producing local batches. |
| Bounded CDev Monorepo work | Claude Fable 5 | `high` | The objective is specific, the affected repositories are known and the contracts are already clear. |
| CDev Monorepo planning | Claude Fable 5 | `xhigh` | The work requires system decomposition, repository participation, contracts, sync points and a dependency graph. |
| Demanding CDev Monorepo execution | Claude Fable 5 | `max` | A long-running system batch needs the deepest reasoning and verification, and latency or usage is secondary to correctness. |
| Large parallel system execution | Claude Fable 5 | `ultracode` | The objective contains several substantive, independent workstreams that benefit from dynamic orchestration. |

## Why the recommendation changes by scope

Single-repository CDev already has a narrow authority boundary: one repository, one local plan,
one verification protocol and one ordered batch stream. An Opus-class model provides enough
agentic coding ability for most of that work without paying the coordination cost of the most
capable long-running model on every batch.

CDev Monorepo has a different reasoning burden. It must preserve several local truths while
maintaining one system view, decide what can run concurrently, enforce producer → consumer order,
reconcile independent repository progress and judge global acceptance. Fable 5 is recommended for
that orchestration layer because it is designed for harder, longer-running agentic work.

## Effort and `ultracode` are different controls

`high`, `xhigh` and `max` are model effort levels. Higher effort allows deeper reasoning but
usually increases latency and usage. The recommended progression is therefore task-shaped:

1. Start with `high` for a concrete, limited batch.
2. Use `xhigh` when the primary job is planning or resolving system structure.
3. Use `max` when executing a difficult, high-consequence batch where verification quality is
   more important than speed.

`ultracode` is not a model and is not a level above `max`. It is a Claude Code execution mode
that sends `xhigh` effort to the model and additionally enables dynamic workflow orchestration.
Use it for wide execution with real parallelism, not automatically for every monorepo session.
CDev Monorepo already supplies the repository dependency model; extra orchestration is useful
only when the selected work can divide cleanly without violating that order.

## These are defaults, not compatibility rules

CDev itself is model-independent. A repository remains conditioned through its documents,
contracts and evidence even when the execution model changes. Model availability, aliases,
latency and cost also change over time, so these recommendations should be evaluated against
representative CDev batches rather than treated as permanent guarantees.

This guidance was last reviewed on **2026-08-15**. Claude Code currently exposes `opus` and
`fable` model aliases, the effort levels shown above, and `ultracode` as a separate mode. See the
official [Claude Code model configuration](https://code.claude.com/docs/en/model-config) and
[Claude model selection guidance](https://platform.claude.com/docs/en/about-claude/models/choosing-a-model).
