# Agent execution protocol — local deltas only

The generic loop lives in the global `cdev` skill. This file holds only what is specific to this
repository.

## Verification sequence (the real one — there is no toolchain)

Run per batch, in order; record pass / fail / not-run per check in the handoff:

1. **Frontmatter check** — every `skills/*/SKILL.md` begins with `---`, has `name` and
   `description`, description starts with "Use when".
2. **Language check** — zero Spanish in skill bodies:
   `grep -rn -iE 'Úsala|verificación|sesión|también|según|además|configuración|ejecución' skills/*/SKILL.md`
   must match only line 3 (description trigger phrases).
3. **Periphery check** (applies from Sprint 01 B04 onward) — product names (`Compiss`,
   `compiss`, `F6`) must not appear anywhere in `skills/` or `profiles/`; named technologies
   (Prisma, Playwright, NestJS, Apollo, shadcn, Supabase...) may appear **only** in `profiles/`
   and `templates/`, labelled as examples, never in the consolidated core skills as rules.
4. **Sandbox exercise** — for every touched skill: build a fixture with `scripts/sandbox.ps1`,
   have a fresh subagent follow the skill against a scripted scenario, record the outcome. A
   skill change without a sandbox exercise is `not-run`, and the batch is not `DONE`.

## Branches and commits

- Batches commit **directly to `main`** — recorded override, see RECOGNITION.md. `main` is
  protected on GitHub (PR required for others, no force pushes, no deletions); the owner
  bypasses by design so this convention keeps working. Pushing `main` after a batch is part of
  the routine since the repo went public (S02); force-push and history rewriting stay gated.
- One commit per batch: `<type>(s<nn>-b<nn>): subject` (e.g. `refactor(s01-b01): extract role
  profiles`). Conditioning and doc-only commits keep plain conventional prefixes.

## Handoff log

`AGENT_PROGRESS.md`, **newest-first** — declared here so no session has to discover it (field
rule 3 of doc 07 §6). Required fields per entry: date+unit · status · what was done · files ·
verification per check (pass/fail/not-run) · blockers naming the minimum human decision · next.

## Gates (this repo)

See CLAUDE.md. In short: remote/push · marketplace repo creation · install to
`~/.claude/skills` · frozen product repos · history rewriting. Prepare, don't execute.

## Change policy (this repo obeys its own CONTRIBUTING.md — owner included)

Every series of changes — every batch — declares its **layer** and meets that layer's process
before it counts, exactly as CONTRIBUTING.md demands of external contributors:

| Layer touched | Required before the batch closes |
|---|---|
| Periphery / docs | Nothing extra — the normal verification sequence |
| Bug fix | The failure quoted as evidence in the handoff entry |
| Role profile (new or changed) | Field evidence — a sandbox exercise or field report backing the change |
| Host binding | Proposal recorded in DECISIONS → implementation → validation |
| New skill / capability | A Discussion opened first (or, pre-community, a dated DECISIONS entry with the rationale) |
| **Core methodology** | **An RFC (docs/community/rfc-process.md) + recorded field evidence. Never taste.** |

Cross-cutting, always: touched skills/profiles/templates are exercised in a sandbox fixture
(verification §4); behavior changes land in `CHANGELOG.md` and reach installed copies only via
a version bump; the planner classifies the layer at batch-writing time and the handoff entry
names it.

## Quota exit

Update `AGENT_PROGRESS.md`, commit what is safe (`wip(s<nn>-b<nn>)` if incomplete), exit clean.
Resumption reads the repo, never conversational memory.
