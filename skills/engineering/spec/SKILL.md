---
name: spec
description: Decide WHAT to build and in what ORDER, then lock it — prioritize ideas/requests against the goal, then turn the chosen one into a buildable spec with scope and testable acceptance criteria, before any code. Trigger on /spec and proactively whenever the user starts new work from an underspecified ask ("build X", "add Y", "I want an app that…"), has more to do than time ("what should I work on", "prioritize", "what's next"), or when a request would otherwise go straight to coding without agreed success criteria. Scope: spec owns deciding and locking the work (prioritization + requirements); designing the solution is architect, and building it is build.
---

# Spec

The most expensive code is the code that builds the wrong thing, or the right thing in the wrong order. This is the principal-PM discipline: choose the few things worth doing now, then define "done" so precisely that the rest of the team can execute without guessing.

## Operating stance

- **Focus is the scarcest resource.** For a solo founder + AI, time and attention run out long before ideas do. Saying no to almost everything is the job. Finish a few things; don't start ten.
- **Prioritize against the goal, not enthusiasm.** Rank by impact on the current outcome (revenue, retention, validation), not by what's newest or most fun.
- **Acceptance criteria are the deliverable.** A spec without testable, observable criteria is a wish. If you can't write a test or a manual check for it, it isn't a criterion.
- **Lock scope, not implementation.** Capture *what* and *why*; leave *how* to architect and build. Cut scope rather than guess at it.

## Workflow

### Part A — Prioritize (when there's more than one candidate)
1. **Anchor on the goal** — state the single most important outcome for this period.
2. **List the candidates** — features, fixes, debt, experiments, business tasks; get them out of your head into one list.
3. **Score** — for each, estimate impact on the goal × effort, plus dependencies and risk. Favor high-impact/low-effort wins and high-uncertainty items that need cheap early validation.
4. **Cut & sequence** — pick the few for **Now** (what you can actually finish), order by dependency and risk, and write down what you're explicitly **not** doing. Park the rest as **Next** / **Later**.

### Part B — Lock the spec (for the chosen item)
5. **Restate the goal** in one sentence: *"This lets [user] do [action] so that [outcome]."* If you can't, it's too vague — resolve before continuing.
6. **Surface the unknowns** — ask only the questions whose answers change what gets built: who/trigger, exact input → expected output, what's out of scope, data created/read/updated/deleted, failure behavior, the non-functional limits that matter *now*, and the done-signal in production. Batch the questions; if told "you decide," make the call and record it as an assumption.
7. **Write it** — keep it to a screen or two:

```markdown
# Spec: <name>
## Problem      <who hurts, why now>
## Goal         <one-sentence success outcome>
## In scope     <bullets>
## Out of scope (this iteration)   <bullets>
## Acceptance criteria
- [ ] Given <context>, when <action>, then <observable result>.   (each testable)
## Constraints & assumptions   <stack, deadline, decisions made for the user>
## Open questions   <blockers + what unblocks them>
```

8. **Confirm & lock** — show it, get explicit confirmation or edits, resolve blocking open questions (or scope them out). Save to the repo (`docs/specs/<name>.md`). The acceptance criteria become the definition of done for build and the gate for ship.

## Hand-off
- Non-trivial design needed → **architect**.
- Greenfield or spec locked and ready to code → **build** (criteria become the tests).
- Day-to-day state across sessions → **handoff**.

## Operating rules
- **No code before a locked spec.** Only exception: an explicit, timeboxed spike to reduce uncertainty — labeled as such, with the spec written after.
- **Criteria must be observable.** "Works well / is fast / user-friendly" are not criteria. Convert to a number, behavior, or check.
- **Keep "Now" small enough to finish.** An overcommitted solo+AI team ships a pile of 80%-done work, which is 0% shipped.
- **Say no in writing.** An explicit "not now" list prevents scope creep and re-litigated decisions.
- **Record decisions made for the user.** Every assumption is something they can still veto — make it visible.
- **Re-rank with evidence, not attachment.** When data contradicts the plan, change the plan; don't march a dead roadmap off a cliff.
