---
name: ship
description: Get the change to production and keep it healthy — set up deploy/infrastructure and observability, run the production-readiness gate, deploy deliberately, then write the release notes. Trigger on /ship and proactively when releasing ("deploy", "ship it", "go to production", "cut a release", "push live"), when asked "is this ready for prod", when setting up CI/CD, infrastructure, environments, or monitoring/alerting, or when a release needs a changelog/version. Scope: ship owns getting to prod and the infra/observability that runs it; building features is build, and diagnosing/fixing a live incident is operate.
---

# Ship

The gate and the launchpad between "works on my machine" and "running in production where it can hurt real users." Shipping is a deliberate, checked decision — set up how it runs and how you'll see it break, prove it's ready, roll it out safely, and tell people what changed. The cost of a bad deploy is paid by users and by future-you at 3am.

## Operating stance

- **A gate, not a ceremony.** Unmet critical items block the release. The checklist has teeth or it's theater.
- **Reversibility is the safety net.** Before "will it work?", answer "if it doesn't, how fast can we undo it?" A release you can't roll back is a bet, not a deploy.
- **You can't operate what you can't see.** Logging, metrics, and an alert on the most likely failure are part of shipping, not a later nicety.
- **Self-certification is the trap.** The builder is the worst judge of whether it's safe — bring independent eyes.

## Workflow

### 1. Confirm it's actually done
- Every acceptance criterion passes, verified by running it (**build**), not asserted. The change has had independent review (**scrutinize**/`code-review`) — if not, do that first.

### 2. Infrastructure & observability are in place
- Deploy path exists and is repeatable: environments defined, config/secrets managed per environment (in a secret store, never in the repo; every new var in `.env.example` and set in the target), infra reproducible (scripted / IaC, not hand-clicked).
- Observability covers the change: logs at the right level for new paths, metrics/health checks, and an **alert for the way this is most likely to fail**. You must be able to tell if it breaks in prod.

### 3. Run the readiness checklist
For each item: pass / fail / N-A with a reason. No blanks.
- **Correctness** — full suite green; lint + typecheck clean; real user path exercised.
- **Security** — run `security-review` on the diff; no secrets in code/logs; authz on every new entry point; deps free of known critical CVEs.
- **Data & migrations** — backward-compatible, tested on a prod-like copy, reversible or with a recovery plan; no destructive op without a backup.
- **Rollback** — the exact procedure is written and known to work; risky changes sit behind a feature flag.
- **Performance & limits** — no obvious N+1 / unbounded query / blowup at real data volume; timeouts and rate limits on external calls.

### 4. Independent readiness audit
- Spawn a sub-agent with clean context as the release auditor: give it the diff, spec, and checklist; ask it to find the reason this deploy pages someone tonight (the unhandled failure, missing rollback, unset env var). Treat findings as blocking until triaged.

### 5. Go / no-go, then deploy deliberately
- **Go** only if every critical item passes and rollback is real. Otherwise **no-go** with the exact blockers and what unblocks each — a no-go with a clear list is a success.
- Roll out the safest way the platform allows (staged / canary / off-peak). Watch logs, metrics, and alerts through the rollout. If signals go bad, **execute the rollback** — don't debug in prod while users bleed.

### 6. Release notes
- Derive from the actual commit range. Group by Breaking / Added / Changed / Fixed / Security; breaking changes lead, with the migration step. Recommend the SemVer bump (MAJOR breaking / MINOR feature / PATCH fix). Write outcomes in the reader's language, prepend to `CHANGELOG.md`, keep tag and version in sync.

## Hand-off
- Something broke in prod → roll back, then **operate** (diagnose, fix, write the post-mortem).
- Need a non-technical version for stakeholders → **management-talk**.
- State to record for the next session → **handoff**.

## Operating rules
- **Critical fail = no ship.** Convenience never overrides a failed critical item; accept a risk only in writing, with the user's say-so.
- **No rollback, no deploy.** Can't undo it fast? Add a flag, a backup, or a tested revert first.
- **Verify the environment, not just the code.** Most prod incidents are config/secret/migration mismatches — check what's actually set in the target.
- **Ship with eyes on.** Watch the deploy live; shipping is done when the change is healthy under real traffic, not when the pipeline goes green.
- **Never fabricate release notes.** Every line traces to a real change in the range; breaking changes are never buried.
- **A no-go is a success.** Catching an unready release is the whole point of the gate. Never rubber-stamp to look fast.
