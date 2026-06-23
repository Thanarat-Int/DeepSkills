# Thanarat-Int Skills

Agent skills loaded by Claude Code — a reusable end-to-end toolkit for taking a project from idea to production with a single AI driver.

## Install as a plugin (recommended — any machine, any OS)

This repo is a Claude Code **plugin marketplace**. On any machine (Windows / macOS / Linux) install the whole team with two commands inside Claude Code:

```
/plugin marketplace add Thanarat-Int/DeepSkills
/plugin install thanarat-int-skills@deepskills
```

Update any time with `/plugin update`. (Private repo? Sign in to GitHub on that machine first, e.g. `gh auth login`.)

> **Needs a Claude Code build with plugin support** (e.g. the CLI). If you see `/plugin isn't available in this environment` (some IDE extensions), use the **clone + link** method below instead — same result.

### Bundled slash commands

- `/team` — show the full team: every skill, its role, and when to use it
- `/kickoff <idea>` — start a new project and run it through spec → architect → build

> Slash commands are optional everywhere — skills auto-trigger from their `description`, so just describe your task and the right teammate joins in.

## Dashboard

`dashboard/index.html` is a self-contained, **offline** visualization of the team — a quantum energy-field command center. Click any agent for its role and how to call it, filter by division, zoom/pan, and download the real `SKILL.md` files (per-division or all, as a `.zip`, behind a confirm dialog). Just open the file in any browser.

## Layout

Skills live under `skills/`, grouped into buckets:

- `engineering/` — idea → running in production
- `ai/` — AI / ML lab (data, modeling, MLOps, LLM)
- `game/` — game studio (design, narrative, dev)
- `product/` — discover, design, and measure the right product
- `business/` — go-to-market and economics (growth, monetize, legal)
- `productivity/` — cross-cutting comms

Each skill is its own directory containing a `SKILL.md` (with YAML frontmatter — `name` and `description`) and any bundled scripts or reference files.

## Install via clone + link (works everywhere, incl. IDE extensions without `/plugin`)

Clone the repo once per machine, then link every skill into `~/.claude/skills/` so they default into every project. Re-run after pulling updates.

```bash
git clone https://github.com/Thanarat-Int/DeepSkills.git
cd DeepSkills
```

**macOS / Linux / Git Bash** (symlinks):

```bash
./scripts/link-skills.sh
```

**Windows** (junctions — no admin / Developer Mode needed):

```powershell
powershell -ExecutionPolicy Bypass -File scripts/link-skills.ps1
```

To update later: `git pull` then re-run the same link script.

List every `SKILL.md` in the repo:

```bash
./scripts/list-skills.sh
```

## Reuse — deploy the team into a project

The global install already makes the whole team available in **every** project automatically — nothing to copy. Use these only when you want the team committed **into** a specific project (to share it, move to another machine, or version-lock the team with that repo). They copy every shippable skill as real files into `<project>/.claude/skills/`:

```powershell
# Windows
.\scripts\deploy-team.ps1 -TargetProject 'E:\Projects\my-new-project'
```

```bash
# macOS / Linux / Git Bash
./scripts/deploy-team.sh /path/to/my-new-project
```

As well as copying the skills, `deploy-team` writes a **team working-agreement block** into the project's `CLAUDE.md` (from `templates/CLAUDE-team-snippet.md`), so the AI follows the lifecycle proactively — no slash commands, no prompting needed. The block is fenced by `<!-- team-skills:start/end -->` markers, so re-running updates it in place without touching the rest of your `CLAUDE.md`. Pass `-SkipDirective` (PowerShell) or `--no-directive` (bash) to skip that.

Re-run any time to update a project's copy after the team changes.

> **Slash commands are optional.** Skills auto-trigger from their `description`; typing `/spec-it` only *forces* a specific one. The `CLAUDE.md` directive is what makes the team run end-to-end on its own.

## Reference — the Elite AI Team (12)

A lean team of senior/principal-level skills, each owning one broad discipline so the AI always knows which to use.

### Engineering — idea → running in production

- **[spec](./skills/engineering/spec/SKILL.md)** — Decide what to build and in what order, then lock it into a buildable spec with testable acceptance criteria (prioritization + requirements).
- **[architect](./skills/engineering/architect/SKILL.md)** — Design system structure, data model, and security together, recorded as a lightweight ADR.
- **[build](./skills/engineering/build/SKILL.md)** — Build it right: scaffold a new repo, implement in test-first verified increments, choose test levels, refactor safely; never "done" without running it.
- **[scrutinize](./skills/engineering/scrutinize/SKILL.md)** — Outsider-perspective end-to-end review of a plan, PR, or code change; traces the real code path and verifies it does what it claims.
- **[ship](./skills/engineering/ship/SKILL.md)** — Get to production and keep it healthy: deploy/infra/observability, the readiness gate with an independent audit, deliberate rollout, and release notes.
- **[operate](./skills/engineering/operate/SKILL.md)** — Keep running software healthy: diagnose bugs systematically, hunt performance bottlenecks by measurement, and write the post-mortem.
- **[handoff](./skills/engineering/handoff/SKILL.md)** — Keep project state in durable files so a fresh chat can resume: checkpoint during work, resume ritual on a new session.
### AI / ML Lab _(specialists, standby — split by discipline, handle any model/task)_

- **[data-engineering](./skills/ai/data-engineering/SKILL.md)** — Build the data foundation: collect, clean, label, transform, version, and split without leakage.
- **[ml-modeling](./skills/ai/ml-modeling/SKILL.md)** — Train/fine-tune/evaluate models for any task (CV/NLP/tabular…): baseline first, transfer learning, honest evaluation.
- **[mlops](./skills/ai/mlops/SKILL.md)** — Serve, version (model+data+code), monitor drift, automate retraining and rollback.
- **[llm-engineering](./skills/ai/llm-engineering/SKILL.md)** — Build on LLMs: prompt → RAG → fine-tune, tool-use/agents, rigorous evals and guardrails.

### Game Studio _(specialists, standby — fire only on game work)_

- **[game-design](./skills/game/game-design/SKILL.md)** — Design the fun: pillars, core loop, interacting systems, progression, economy, levels, and balance — any genre.
- **[game-narrative](./skills/game/game-narrative/SKILL.md)** — Craft story and world that serve play: premise/theme, worldbuilding, characters, dialogue, quests, meaningful branching.
- **[game-dev](./skills/game/game-dev/SKILL.md)** — Engineer it for real-time: game loop/timestep, state/ECS, scenes, asset pipeline, frame budget, multiplayer netcode/anti-cheat.

### Product & Design

- **[product](./skills/product/product/SKILL.md)** — Build the right thing for users: validate the problem, design the experience and every state, measure with honest experiments, and turn support signals into improvements.

### Business & Go-to-Market

- **[growth](./skills/business/growth/SKILL.md)** — Pick the 1–2 channels that fit, design the acquisition funnel, plan the launch, and write the words (landing pages, copy, CTAs) that make people act.
- **[monetize](./skills/business/monetize/SKILL.md)** — Price on value, package into tiers, and keep unit economics healthy by controlling the cost to serve.
- **[legal-compliance](./skills/business/legal-compliance/SKILL.md)** — Cover the legal basics (privacy/terms, data protection, licensing) and flag what needs a real lawyer. Practical risk-reduction, not legal advice.

### Productivity

- **[management-talk](./skills/productivity/management-talk/SKILL.md)** — Rewrite engineer-to-engineer content for engineering-org leadership and shape it for the channel it's going to (JIRA, Slack, async standup, email, meeting talking-points).
