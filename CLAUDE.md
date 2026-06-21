Skills are organized into bucket folders under `skills/` — together they form a lean **Elite AI Team**: 12 senior/principal-level skills, each owning one broad discipline (no narrow single-task roles), so the AI picks the right one without confusion.

- `engineering/` — take software from idea to running in production (spec → architect → build → scrutinize → ship → operate, + handoff)
- `ai/` — AI/ML lab (standby): `data-engineering`, `ml-modeling`, `mlops`, `llm-engineering`
- `game/` — game studio (standby): `game-design`, `game-narrative`, `game-dev`
- `product/` — discover, design, and measure the right product for users
- `business/` — go-to-market and economics (growth, monetize, legal-compliance)
- `productivity/` — cross-cutting comms (management-talk)

Every shippable skill must have a reference in the top-level `README.md` and an entry in `.claude-plugin/plugin.json`. Drafts or personal skills not meant to ship should be kept out of both (and out of these buckets).

Each skill entry in the top-level `README.md` must link the skill name to its `SKILL.md`. Each bucket folder has a `README.md` listing its skills with one-line descriptions linked to their `SKILL.md`.

## Design principle (keep it lean)

One skill = one broad discipline with a crisp, non-overlapping trigger. These 12 were deliberately consolidated from many narrow skills so the AI is never confused about which to use. Resist re-splitting into single-task skills; instead deepen an existing one. Each skill carries a `Scope:` line in its description to resolve any boundary ambiguity.

## Skill routing — who owns which job

| Job | Owner | Not this |
|-----|-------|----------|
| Decide what to build + lock requirements/acceptance criteria + prioritize | `spec` | — |
| Design system + data model + security; record ADR | `architect` | — |
| Scaffold a new repo, implement test-first, test strategy, refactor | `build` | `init` (only generates CLAUDE.md for an existing repo) |
| "Should this exist + does it work end-to-end" review | `scrutinize` | `code-review` (line-by-line diff bugs); `security-review` (security) |
| Production-readiness gate, deploy/infra/observability, release notes | `ship` | — |
| Debug, performance-tune, write the post-mortem | `operate` | — |
| Keep/refresh state for cross-session continuity | `handoff` | `build`/`init` (initial setup) |
| Discover, design (UX), measure (analytics), support insight | `product` | — |
| Acquisition channels, funnel, launch, marketing copy | `growth` | — |
| Pricing, packaging, and cost/unit economics | `monetize` | — |
| Privacy/terms, data-protection, licensing (not legal advice) | `legal-compliance` | — |
| Translate engineering content for leadership/stakeholders | `management-talk` | — |

Typical flow: `spec` → `architect` → `build` (→ `scrutinize`) → `ship` → `operate`, with `handoff` keeping continuity. Product/business: `product` → `growth` → `monetize`, with `legal-compliance` and `management-talk` as needed.
