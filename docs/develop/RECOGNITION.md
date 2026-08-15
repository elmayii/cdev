# Recognition — what this repository actually is

*Written before any machinery, as the method requires. Overrides to the generic kit are listed
explicitly.*

## The repo

The extraction and packaging repository of the CDev method itself. It contains prose (`docs/`,
the seven documents), the skills as artifacts (`skills/`), two support scripts (`scripts/`), and
a sandbox fixture area (`sandbox/`). It is **not** a software project: no build, no test
framework, no runtime.

## Overrides to generic conditioning assumptions

| Generic assumption | Reality here | Override |
|---|---|---|
| Verification = lint/build/test | No toolchain exists | Verification is defined in the protocol: frontmatter checks, language/periphery greps, sandbox exercise of touched skills |
| Working branch per batch, never shared branches | No remote, single operator, all 6 existing commits go straight to `master` | Batches commit directly to `master`; creating a remote or pushing is a human gate |
| Runtime evidence via tests or UI | The "runtime" of a skill is an agent following it | Evidence = a fresh subagent exercising the touched skill inside a sandbox fixture, its outcome recorded |
| Render the full template kit | Most templates are greenfield-backend-shaped and do not apply | Only the core artifacts of doc 07 §1.2 are written |
| Product docs are the clarity source | The "product" is the package; its spec is `README.md` + `docs/07-core-vs-periphery.md` | Clarity map derives from those two |

## Untouchable

- The production baseline (commit `1fe0773`) — read-only history, never rewritten.
- The product repositories CDev was extracted from — frozen, out of scope.
- `~/.claude/skills` (the global installation) — writing to it is a human gate, even though
  `install.ps1` backs up.
