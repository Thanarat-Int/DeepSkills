---
name: game-design
description: Design what makes a game fun and well-structured — design pillars, the core loop, interacting mechanics and systems, progression, in-game economy, level/encounter design, and balance — across any genre. Trigger on /game-design and proactively when designing gameplay: mechanics, rules, systems, levels, difficulty/progression curves, economy/resources, balancing, or "is this fun / how should this play / what genre". Scope: game-design owns gameplay design and balance; story/characters/dialogue/quests are game-narrative, and implementing it in an engine is game-dev.
---

# Game-design

Fun is engineered, but it's discovered by playing — not argued into existence. The game designer's job is to find the satisfying core, build systems that generate depth from simple rules, and tune the experience so the player is always in flow. Works for any genre because the principles (loop, systems, progression, balance) are universal; the genre just sets the constraints.

## Operating stance

- **Fun is found by playing, not planning.** The most beautiful design doc means nothing until the loop is played. Prototype and test the feel before committing to content.
- **Systems over content.** A good system generates endless situations; hand-authored content runs out. Design the rules that create emergent play, not just the levels.
- **Every mechanic earns its place and teaches itself.** Each mechanic must serve a design pillar and be learnable through play. Cut what doesn't; mechanics that need a manual are a design failure.
- **Balance against the player's experience.** The target is flow — never so easy it bores, never so hard it frustrates. Tune from playtest data, not from theory or your own (expert) skill.

## Workflow

### 1. Pillars & fantasy
- State the **player fantasy**: what does the player get to *feel* like? (a cunning strategist, a nimble ninja, a cozy farmer).
- Set 2–3 **design pillars** — the non-negotiable experiences the game delivers. Every later decision is judged against them.

### 2. Core loop
- Define the loop: the **verb** the player repeats, the **feedback** it gives, and the **reward** that pulls them to do it again (e.g. *shoot → enemies react/die → loot/score → upgrade → shoot harder*).
- This is the heart. If the 10-second loop isn't satisfying, no amount of content saves it.

### 3. Mechanics & systems
- Design the interacting systems (combat, movement, resources, crafting, AI) and how they combine to create **emergent depth** — interesting decisions, not just more buttons.
- Design the **economy** if there is one: sources and sinks of every resource/currency; keep it balanced so nothing trivializes or starves play.

### 4. Progression & pacing
- Design the curves: player **skill** growth (they get better) and **power** growth (the avatar gets stronger), and how unlocks/content pace out to keep the loop fresh.
- Pace intensity — peaks and rests — rather than a flat grind.

### 5. Levels & encounters
- Structure content as **teach → test → twist**: introduce a mechanic safely, test it, then combine/subvert it. Build the difficulty curve deliberately.
- Design encounters/levels that exercise the systems in new combinations.

### 6. Balance & tune
- Find and remove **dominant strategies** (one option that's always best kills decisions). Tune numbers against playtest data.
- Watch for degenerate loops, exploits, and dead choices. Iterate from observation of real players.

### 7. Document
- Capture the design (`docs/gdd.md`): pillars, core loop, systems and key numbers, progression, in tables that **game-dev** can implement and balance against.

## Hand-off
- The world/story/characters that wrap the mechanics → **game-narrative**.
- Implementing systems in an engine → **game-dev**; the menu/HUD UX → **product**.
- Validate market/genre appetite before deep build → **product** (research).
- Monetization design (IAP, economy ↔ revenue) → **monetize** (keep it fair; design owns balance).

## Operating rules
- **Prototype the loop before building content.** Prove the core verb is fun with primitives first.
- **Systems first; one new mechanic at a time, and teach it.** Depth from interaction, not from a pile of features the player can't learn.
- **No dominant strategy.** If one choice is always correct, the others are decoration — rebalance until decisions are real.
- **Balance from playtest data, not theory.** You are not the average player; watch real ones and tune to flow.
- **Every mechanic serves a pillar.** If it doesn't reinforce the fantasy/pillars, cut it — scope is the enemy of finishing.
- **Respect the player's time.** Grind, padding, and unskippable friction are design debt, not content.
