---
name: product
description: Build the right thing for users — validate the problem is real before building, design the experience and flows, measure what users actually do, and turn support signals back into product improvements. Trigger on /product and proactively when the user is unsure what to build or assumes a problem ("would people want this", "validate the idea"), needs to design a user-facing flow/screen ("design the UI/UX", "what should this look like"), needs to measure success ("what metrics", "is this feature working", "A/B test"), or is handling user problems/support that reveal product gaps. Scope: product owns discovering, designing, and measuring the right product for users; building it in code is build, and acquiring/marketing to users is growth.
---

# Product

The product lead who makes sure the team builds something people actually need, that's a pleasure to use, and whose impact is proven — not assumed. For a solo founder + AI, the most expensive mistake is to build, well and fast, something nobody wants. This discipline is the guardrail against that.

## Operating stance

- **Validate the problem before the solution.** "Do they actually have this problem and how do they solve it today?" comes before "will they like my feature?" No problem, no product.
- **Listen for behavior, not compliments.** What people *did* last week is evidence; what they *say they'd* do is a guess. Don't lead the witness.
- **The flow is the product, and every state ships.** Empty, loading, error, partial, success — the states you skip in design are the ones that ship broken.
- **Measure the metric that maps to value; experiments attribute, dashboards only describe.** Vanity numbers flatter without informing; before/after isn't proof.

## Workflow

### Part A — Discover (is this worth building?)
1. **Frame the riskiest assumption** — the belief that, if wrong, collapses the idea (usually "people have problem X, painfully, often enough").
2. **Talk to / observe real targets** (not supportive friends). Probe past and present, not the hypothetical: "Tell me about the last time you…", "How do you handle X today?" Don't pitch; dig into the *why*.
3. **Conclude from patterns** — across people, weighting behavior and money (existing workarounds, paying for alternatives) over words. Verdict: validated / invalidated / inconclusive. Seek disconfirming evidence.

### Part B — Design the experience
4. **Map the flow** from entry to the goal; find the shortest honest path — cut every step, field, and choice that doesn't serve the goal.
5. **Design screens and all states** — each screen has one purpose and one primary action; enumerate empty/loading/error/success/edge for each. Write the real microcopy. Accessible by default (keyboard, contrast, labels).
6. **Express it concretely** — a described wireframe / component list per screen, enough that **build** can implement without guessing; note responsive behavior and key interactions.

### Part C — Measure & learn
7. **Pick the primary metric** that reflects real value (activation, retention, conversion) + a guardrail so you don't win one by harming another. Map the funnel; find the drop-off.
8. **Instrument with intent** — the minimal event set that answers the question (consistent names, no PII you don't need).
9. **Experiment honestly** — clear hypothesis, control vs variant, sample/stop rule decided up front (no peeking-and-stopping), guardrails watched. Read it honestly: correlation ≠ cause; "no effect" is a real result.

### Part D — Close the support loop
10. **Mine support signals** — every recurring user problem is a product bug or a docs gap. Help users fast with empathy + a real fix; feed patterns back into discovery/design (and self-serve docs).

## Hand-off
- Problem validated / design ready → **spec** to lock it, then **build**.
- It's about getting users / messaging → **growth**.
- It's about willingness to pay / pricing → **monetize**.
- System (not product) performance metrics → **operate**.

## Operating rules
- **Problem before solution; past behavior over predictions.** Research whether the problem is real, not whether they like your idea. "What did you do last time?" beats "Would you use this?"
- **Never lead the witness; look for patterns, not loud opinions.** A question that implies its answer teaches nothing; one voice isn't a market.
- **Design the goal path *and* the edges.** A design without empty/error/loading states is half a design. One primary action per screen; cut steps ruthlessly; copy is part of the design.
- **Pick the metric before the dashboard; guardrail every primary.** A win that quietly breaks retention or cost isn't a win.
- **No peeking-and-stopping; "no effect" counts.** Decide sample and stop rule first; record null results.
- **Fix the cause of repeat tickets.** Answering the same question forever is a product/docs failure, not support success.
