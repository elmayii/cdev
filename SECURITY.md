# Security Policy

## What a vulnerability means here

CDev ships instructions (skills, profiles, templates) that drive coding agents with elevated
autonomy. A security issue is anything that could make a conditioned agent cross a safety
gate it should not: executing irreversible operations, leaking credentials, pushing to
protected branches, escaping prepare-don't-execute. Template or script injection that alters
gate behavior counts.

## Reporting

Report privately via [GitHub Security Advisories](https://github.com/elmayii/cdev/security/advisories/new)
— do not open a public issue for an exploitable problem. Include the skill/template involved,
the scenario, and what the agent did or could do.

Expect an acknowledgement within a week. Fixes ship as a patch release (`v0.1.x`) with the
advisory credited unless you prefer otherwise.

## Scope notes

- The method itself instructs agents to prepare, never execute, gated actions; reports that an
  agent *followed* those rules are field reports, not vulnerabilities.
- Supported version: the latest release. Older versions are not patched.
