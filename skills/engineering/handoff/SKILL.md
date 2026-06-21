---
name: handoff
description: Keep project state in durable files so a brand-new chat (a fresh AI with zero memory of past sessions) can resume work correctly — checkpoint progress to docs/PROGRESS.md and refresh CLAUDE.md during work, and run a resume ritual at the start of a new session. Trigger on /handoff and proactively when context is running low, when wrapping up a work session, when the user says "save state / continue later / pick up where we left off", or at the START of a new chat on an existing project before doing any work. Scope: handoff maintains and updates state for cross-session continuity; it does not scaffold a new repo or do the initial CLAUDE.md creation (use build).
---

# Handoff

A new chat starts from zero — it remembers nothing the last session knew. Continuity is not memory; it is **state written to files the next session will read**. This skill is the glue between chats: write enough down that any fresh AI can walk in and continue without the user re-explaining the project.

## Operating stance

- **Chat is volatile; the repo is durable.** Anything that matters and lives only in the conversation is already lost. If the next session needs it, it goes in a file.
- **Write for a stranger with zero context.** The reader is a fresh AI that knows nothing about today. No "as discussed", no pronouns pointing at vanished messages. State it standalone.
- **Current state over history.** The handoff answers "where are we, what's next, what's blocked" — not a diary of everything done. Git already holds the history.
- **Truth, not optimism.** Record what actually works and what's actually broken. A handoff that overstates progress sends the next session building on sand.

## Two modes

### Mode A — Checkpoint (during / ending a session)
Run when context is filling, when pausing, or after a meaningful milestone.

1. **Update `docs/PROGRESS.md`** — the living state of the work:
   ```markdown
   # Progress — <project / feature>
   _Updated: <YYYY-MM-DD>_

   ## Current goal
   <the spec/feature being built right now, link to docs/specs/…>

   ## Status
   <what works and is verified · what's in progress · what's stubbed/fake>

   ## Next steps
   1. <the very next concrete action, specific enough to start cold>
   2. …

   ## Blocked / open questions
   - <blocker — what it needs to unblock>

   ## Key decisions & gotchas (this session)
   - <decision + why · trap the next session would hit>
   ```
2. **Update `CLAUDE.md`** if anything durable changed — new command, new convention, new dependency, changed layout. CLAUDE.md is what loads automatically next time; keep it true.
3. **Commit** work in progress (or note explicitly why it's uncommitted and where it sits). Uncommitted work is invisible to the next session.
4. **Record cross-project facts to memory** — decisions/context not derivable from the code that should survive even a repo move.
5. **Leave the very next step at the top of "Next steps"** — concrete enough that a cold start can begin in one read.

### Mode B — Resume (start of a new chat on an existing project)
Run **before doing any work** when picking up an existing project.

1. **Read the durable state, in order:** `CLAUDE.md` → `docs/PROGRESS.md` → the active spec in `docs/specs/` and relevant `docs/adr/` → recent `git log` and `git status`.
2. **Reconstruct and state the situation** in a few lines: what the project is, what the current goal is, what's done vs in progress, and what the next step is.
3. **Reconcile docs against reality** — does `git status`/the code match what PROGRESS claims? If they disagree, trust the code, say so, and fix the doc. Stale state is worse than none.
4. **Confirm the next action with the user**, then continue — typically into **build** for the next slice.

## Hand-off
- Resumed and ready to build → **build**.
- Resuming revealed scope is unclear → **spec** to re-lock before building.

## Operating rules
- **If it's not in a file, it didn't happen.** Decisions, state, and next steps live in the repo, not the chat. Verbal-only context dies with the session.
- **Next step must be cold-startable.** "Continue the feature" is useless. "Add validation to `POST /orders` per criterion 3, test in `orders_test`" is a handoff.
- **Keep CLAUDE.md honest.** It auto-loads, so a wrong line there misleads every future session. Update it the moment a command/convention/layout changes.
- **Don't let PROGRESS drift from git.** On resume, the working tree is the source of truth; rewrite the doc to match before trusting it.
- **Checkpoint before the context runs out, not after.** A handoff written while you still have context is accurate; one reconstructed from a near-full window is guesswork.
- **Record state, not a narrative.** The next session needs the map and the next move, not the story of how you got here.
