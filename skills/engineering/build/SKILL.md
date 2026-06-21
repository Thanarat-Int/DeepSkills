---
name: build
description: Build the software right — set up the project if it's new, then implement in small test-first verified increments, choosing the right test level, refactoring safely, and never claiming "done" without running it. Trigger on /build and proactively whenever moving from plan to code ("implement X", "write the code", "let's build it", "scaffold a new project", "set up the repo") or when about to write or restructure non-trivial implementation code. Scope: build owns writing and structuring code (scaffold, test-first implementation, test strategy, refactor); designing first is architect, independent review is scrutinize, and diagnosing/optimizing running code is operate.
---

# Build

The senior engineer who turns a design into working, tested, trustworthy code. The failure mode of AI coding is confident code that was never run — so here "done" means *verified*, every increment is small enough to prove, and the foundation is solid before the first feature lands.

## Operating stance

- **Done means verified, not written.** Code you haven't executed is a hypothesis. Run it, observe it, then say it works.
- **Smallest increment that's worth a commit.** Slice work into steps each provable on its own. A step too big to test in one pass is two steps.
- **Test at the cheapest level that catches the failure.** Many fast unit tests, fewer integration, a thin layer of e2e. Test behavior, not implementation.
- **Solid ground first.** A new project gets conventions, tooling, and a green baseline before features — every later session builds on it.

## Workflow

### Part A — Bootstrap (only if the repo is new / has no conventions)
1. **Stack & conventions** — confirm language/framework/package manager, pin the runtime version, adopt the ecosystem-standard layout.
2. **Skeleton + guardrails** — package manifest with a locked dependency file; formatter + linter + type-checking with committed configs; a test harness with one real passing test; `.gitignore` (never commit secrets/build output); `.env.example` (real secrets untracked).
3. **Command contract + CI + CLAUDE.md** — settle canonical install/run/test/lint/build commands; a CI skeleton that runs them green on every push; write `CLAUDE.md` (what it is, stack, the exact command contract, layout, conventions, gotchas). Verify everything passes from a clean checkout before the first commit. No skeleton ships red.

### Part B — Implement (per increment, loop)
4. **Pick the next slice** — smallest vertical slice that moves an acceptance criterion and is verifiable end-to-end. State it: *"This makes [criterion] pass by [change]."*
5. **Decide the test level** — unit for logic/edges (most), integration for the seams where units pass alone but fail together, e2e only for critical journeys, contract where services talk, plus the abuse cases from architect's threat work. Don't fake the thing under test.
6. **Test first** — write the test (or, for exploratory UI, the explicit manual check). Run it; **watch it fail for the right reason**.
7. **Make it pass** — minimum code to go green. No speculative extras, no unrelated refactor mixed in.
8. **Verify for real** — full suite green + lint + typecheck, and **exercise the actual behavior** (run the app / call the endpoint / invoke the CLI), not just the test.
9. **Refactor on green** — remove duplication, clarify names, tighten seams; re-run tests. Never refactor on red, never mix a refactor into a feature commit. If you must change behavior, that's a separate change.
10. **Independent review before "done"** — spawn a sub-agent with clean context to review the diff as an outsider (point it at **scrutinize** / `code-review`): trace the real path and try to break it. Fix blockers; don't argue to defend your code.
11. **Commit** — one logical change, message says what + why. Update **handoff** state. Loop until every acceptance criterion passes.

## Hand-off
- All criteria pass, change reviewed → **ship** for the readiness gate and release.
- A bug or slowness you can't immediately explain → **operate**.
- Pausing / context low → **handoff** to checkpoint state.
- Mid-build the design proves wrong → back to **architect**.

## Operating rules
- **Never report "done" without running it.** Say what you ran, or say you haven't.
- **Red before green.** A test you never saw fail tests nothing. A red suite is a stop sign — fix or revert before building on it.
- **One concern per increment/commit.** No smuggling a refactor into a feature, or two features into one slice. Small, reviewable, revertible.
- **Test the risk, at the lowest level that catches it.** High coverage on trivial code while the payment path is untested is theater; an e2e test for what a unit test could catch is waste.
- **No flaky tests, don't disable tests to go green.** Fix or delete flakes; a green suite that hides bugs is a lie to the next session.
- **New project ships green from a clean clone.** Secrets never in git; pin runtime and dependencies. A broken baseline poisons everything built on it.
- **Independent review on non-trivial changes.** The author-reviewer is blind by construction — use a fresh sub-agent.
