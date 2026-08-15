# RFC process

Core methodology changes need more than a good idea — they need field evidence. This is how a
change to the core (the twelve invariants, the loop, the artifact roles, the system-layer
rules) gets proposed and decided.

## When an RFC is required

| Change | RFC? |
|---|---|
| Docs, fixes, periphery | No — PR |
| New role profile | No — PR with a field report as evidence |
| New host binding | No — proposal + implementation + validation |
| New skill/capability | Discussion first; RFC only if it alters the loop |
| **Anything that changes the core** | **Yes** |

## The process

1. **Open a Discussion in the RFC category.** State: the rule you want to change or add, the
   recorded incident(s) that motivate it (link field reports — yours or others'), and the
   smallest version of the change.
2. **Evidence bar:** the method's own precedent (docs/07 §6) — every core rule added so far
   traces to a specific recorded failure. "It would be cleaner" does not clear the bar;
   "here is the handoff entry where this broke" does.
3. **Discussion runs until the shape stabilizes.** The maintainer summarizes: accepted,
   rejected, or needs-more-field-evidence.
4. **Accepted → issue + PR.** The PR touches the core text once, in one home (the singularity
   test), updates affected skills/profiles, and exercises the change in a sandbox fixture.
5. The RFC Discussion stays as the permanent record; DECISIONS-style, dated.

## Template

```
## Rule (current → proposed)
## Field evidence (links to reports/handoffs/incidents)
## Smallest change that fixes it
## What it would have prevented, concretely
## Cost (what gets stricter/slower for everyone)
```
