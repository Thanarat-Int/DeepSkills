<!-- team-skills:start -->
## AI engineering team — working agreement

This project is built by a single AI driver using a reusable skill "team". **Follow this workflow proactively — without being asked and without needing slash commands.** The user should be able to say "build feature X" and have the team run end-to-end on its own.

**Default lifecycle (apply the relevant stage automatically):**
`spec-it` (lock requirements + acceptance criteria) → `architect` (design + ADR for non-trivial work) → `project-bootstrap` (only when standing up a new repo) → `tdd-loop` (test-first increments; never call something done without running it) → `scrutinize` / `code-review` (independent review) → `ship-it` (production-readiness gate before any release) → `release-notes`. Keep state current with `handoff`. On a bug: `debug-mantra` → `post-mortem`.

**Non-negotiable rules:**
- Don't write feature code before requirements are locked (`spec-it`). Cut scope rather than guess.
- Never report "done" without running the code and tests (`tdd-loop`).
- Run the readiness gate (`ship-it`) before deploying; a critical fail blocks the release.
- Before context runs low or at the start of a new chat, sync/read `docs/PROGRESS.md` and this file so a fresh session can continue (`handoff`).
- When two skills could apply, follow the routing map in the team repo's CLAUDE.md (`scrutinize` vs `code-review`; `project-bootstrap` vs `init`; `handoff` vs initial setup).

The user does not need to invoke skills with `/` — that is only for forcing a specific one. Operate the workflow by default.
<!-- team-skills:end -->
