---
name: game-narrative
description: Craft a game's story and world so it serves play — premise and theme, worldbuilding, characters with arcs, plot structure for an interactive medium, dialogue, quest design, and branching choices with real consequence. Trigger on /game-narrative and proactively when writing or designing a game's story, world, lore, characters, dialogue, cutscenes, quests, or branching/choice narrative. Scope: game-narrative owns story, world, characters, and writing; gameplay systems and balance are game-design, and implementing dialogue/quest/cutscene systems in the engine is game-dev.
---

# Game-narrative

Story in games is not a novel bolted onto gameplay — it's told *through* play. The narrative designer's craft is making what the player **does** and what the story **says** reinforce each other, giving real agency while still delivering meaning. Works for any genre, from a wordless platformer's environmental story to a branching RPG epic.

## Operating stance

- **Ludonarrative harmony.** The story must not contradict the gameplay. If the tale says "peaceful hero" while the loop is "kill thousands," the player feels the lie. Align theme with mechanics.
- **Show through world and action, not exposition.** Reveal story through what the player sees, does, and discovers — environmental detail, item descriptions, consequences — not walls of text and unskippable lore dumps.
- **The player is a co-author.** In an interactive medium, agency is the point. A meaningful choice the player owns beats a beautiful scene they only watch.
- **Restraint and craft.** Build only the world the player will actually touch (the iceberg — deep foundation, small visible tip). Every line earns its place.

## Workflow

### 1. Premise & theme
- One-line **hook**: the premise that makes someone want to play. Plus the **theme** — what the game is really *about* (freedom, loss, greed) — which threads through story *and* mechanics.

### 2. Worldbuilding
- Establish the setting, its rules/logic, factions, and history — but only develop what surfaces in play. Keep a deep "iceberg" of lore; reveal the tip through the world, not a codex dump.
- Make the world internally consistent; players punish contradictions.

### 3. Characters
- For each key character (especially the player-character): **want vs need vs flaw**, and an arc. Define the player-character's role — silent avatar, voiced protagonist, or blank slate — and write to it.
- Antagonists need a believable goal, not just evil.

### 4. Structure for interactivity
- Adapt dramatic structure (setup → rising tension → climax → resolution) to nonlinear play: a clear **critical path** plus optional content. Beats that work even if the player wanders.

### 5. Quests & missions
- Each quest: a goal, stakes, and a beat that advances character/world. Side content should **reveal world or character**, not just pad. Avoid fetch quests with no narrative payoff.

### 6. Dialogue
- Give each character a distinct **voice**; keep lines tight (players skim). In branching dialogue, make options express genuinely different intents.

### 7. Branching & consequence
- Offer choices that **matter** — that change state, relationships, or outcomes. If a choice has no consequence, don't frame it as one.
- Manage complexity with hub-and-spoke / foldback structures so branches reconverge — avoid combinatorial explosion you can't finish or test.

### 8. Environmental & systemic storytelling
- Tell story through level layout, props, audio logs, item lore, and even mechanics. The strongest game stories are *experienced*, not narrated.

## Hand-off
- The mechanics/systems the story wraps → **game-design** (keep them in harmony).
- Implementing dialogue trees, quest state, cutscene/branching systems → **game-dev**.
- Localization, marketing hook, store description → **growth** / **legal-compliance** (IP/rights for any referenced material).

## Operating rules
- **Harmony first.** Never let the story contradict what the game makes the player do. Resolve the clash at design time with **game-design**.
- **Reveal through play; cut exposition.** Trust the player to discover. Lore dumps and unskippable cutscenes are the first thing to trim.
- **Choices must matter or don't offer them.** A fake choice betrays the player's agency worse than a linear path.
- **Manage branch complexity.** Use foldback/hubs; an unbounded choice tree is untestable and unfinishable.
- **Worldbuild only what's touched.** Deep iceberg, small visible tip — don't write 200 pages of lore the player never meets.
- **Every line earns its place.** Distinct voices, tight writing; the player is skimming and playing, not reading a novel.
