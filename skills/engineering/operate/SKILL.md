---
name: operate
description: Keep running software healthy — diagnose bugs systematically, hunt performance bottlenecks by measurement, and turn fixed incidents into a post-mortem that prevents recurrence. Trigger on /operate and proactively when something is broken/throwing/failing or a stack trace is pasted, when something is slow or won't scale ("optimize", "it's laggy", "reduce load"), or after a fix lands and the incident should be written up ("post-mortem", "root cause", "document this fix"). Scope: operate owns diagnosing, fixing, and optimizing running code plus the incident record; building new features is build, and deploy/infra/rollback is ship.
---

# Operate

The SRE who keeps the system alive: find why it broke, make it fast, and make sure the same fire never starts twice. Discipline beats guessing — reproduce before theorizing, measure before optimizing, and record what was learned before closing the ticket.

## Operating stance

- **Reproduce before you theorize.** A bug you can't trigger on demand, you can't fix with confidence. A baseline you didn't measure, you can't optimize.
- **Falsify, don't confirm.** Form one hypothesis and try to *disprove* it. The fix you reach for first is usually the symptom, not the cause.
- **One bottleneck dominates.** Performance follows the few-big-costs rule — find the single dominant cost; shaving the rest buys nothing.
- **An incident isn't closed until it can't recur.** The fix stops the bleeding; the post-mortem stops the next one.

## Workflow

### Part A — Debug (something is broken)
1. **Reproduce** — get a reliable, minimal repro. State the exact steps and the expected-vs-actual.
2. **Trace the fail path** — follow the actual code path from symptom backward: entry → calls → branch taken → state → the point it goes wrong. Read the unchanged code around it; bugs hide at the seams.
3. **Falsify the hypothesis** — state the suspected cause in one sentence, then find the cheapest test that would *prove it wrong*. Only when you can't falsify it do you trust it.
4. **Fix the cause, not the symptom** — make the smallest change that addresses the root. Add a test that fails before the fix and passes after, so it can't regress.

### Part B — Optimize (something is slow)
5. **Set the budget** — the metric and target (p95 latency, throughput, memory) at a stated load. No finish line, no hunt.
6. **Baseline on real-scale data** — reproduce the slowness at representative volume (problems hide at 10 rows, appear at 1M). Measure; this is what every change is judged against.
7. **Profile to the dominant cost** — use a profiler/query analyzer; don't guess. Look for N+1, missing index/full scans, work in a loop, serial work that could batch, repeated computation, oversized payloads, blocking I/O on the hot path.
8. **Fix one thing, re-measure** — change the single biggest cost, measure again under the same conditions. Met the target → stop and lock it with a benchmark. Not met → the bottleneck moved; profile again.

### Part C — Post-mortem (after a notable fix lands)
9. **Write the record** (requires reliable repro, known cause, validated fix) to `docs/postmortems/`: what happened + impact, the root cause and mechanism, the fix, how it was validated, and **how it slipped through** (the gap in tests/review/monitoring) with the concrete prevention. Engineer-audience, blameless, specific.

## Hand-off
- The cause is a wrong design/data shape → **architect**.
- The fix is a real feature/behavior change → **build** (as its own change).
- Prevention means a new test gate or alert → fold into **build** / **ship**.
- State to record across sessions → **handoff**.

## Operating rules
- **No fix without a repro.** Guessing at a bug you can't trigger produces fake fixes that mask the real one.
- **Falsify your hypothesis.** Default to "I'm wrong until I can't disprove it." The obvious cause is often the symptom.
- **Fix the root, add the regression test.** A fix with no test is an invitation for the bug to return.
- **No baseline, no perf claim.** Never assert "faster" without a before/after number under the same conditions; profile, don't predict; one change at a time; stop at the target.
- **Don't trade correctness for speed.** A faster wrong answer is worthless — keep tests green.
- **Close incidents with a post-mortem, blamelessly.** The point is the prevention, not the culprit; no repro + cause + validated fix → don't write fiction.
