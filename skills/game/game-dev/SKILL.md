---
name: game-dev
description: Engineer a game for real-time — take a design and story and build them in an engine: game loop and timestep, state/ECS, scenes, input, asset pipeline, holding the frame budget, and multiplayer netcode/anti-cheat. Trigger on /game-dev and proactively when implementing a game technically: game loop, physics, rendering/animation, input, scene/level systems, dialogue/quest systems, multiplayer/netcode, anti-cheat, asset pipeline, or working in a game engine (Unity/Unreal/Godot/custom). Scope: game-dev owns the technical build of a game; gameplay design/balance is game-design, story/dialogue content is game-narrative, and general (non-frame-budget) coding is build.
---

# Game-dev

The engineer of the game studio: turn the design (**game-design**) and story (**game-narrative**) into a real-time program that holds a stable frame rate. Two truths drive the work: **the frame budget is non-negotiable** (~16ms/frame at 60fps for *everything*), and **gameplay must not depend on frame rate**. Build to the design's spec; if the design isn't fun yet, that's game-design's loop to close first.

## Operating stance

- **The frame budget rules.** A spike invisible in a web app is a stutter the player feels. Performance is a constant constraint, not a late pass — watch per-frame GC allocations especially.
- **Decouple simulation from rendering.** Fixed timestep for gameplay/physics, variable for rendering. The same input must behave identically at 30fps and 144fps.
- **Authority and determinism decide multiplayer.** Decide the netcode model at design time; retrofitting it is a rewrite. Never trust the client for fairness-critical state.
- **Work with the engine's grain.** Unity/Unreal/Godot each have idioms (component model, lifecycle, asset import). Use them; don't fight them.

## Workflow

### 1. Stand up the technical foundation
- Pick the engine (or justify custom) and lean on its conventions. Set up the project (route general scaffolding/CI/VCS through **build**, with large-asset handling e.g. Git LFS).
- Implement the **game loop**: fixed timestep for simulation/physics, decoupled variable-rate rendering. Never tie gameplay to frame rate.

### 2. Build core systems from the design
- Take the mechanics/systems from **game-design** and implement them: state management & entities (component/ECS for many interacting entities, simpler OOP for small scope), scene/level loading, buffered responsive input (input → intent → action).
- Implement narrative systems from **game-narrative**: dialogue trees, quest/flag state, branching, cutscene triggers.

### 3. Asset pipeline
- Set up early: import settings, texture/audio compression, sprite atlases, naming conventions. Assets dominate a game's size and load time.

### 4. Hold the frame budget
- Profile in **ms/frame**, not totals: draw calls, overdraw, physics cost, per-frame GC allocations (a GC spike = a stutter), script update cost.
- Optimize the per-frame dominant cost — object **pooling** (avoid allocations), **batching/instancing** (fewer draw calls), **culling/LOD**. Re-measure against the budget; a stable 60fps beats a higher average with stutters. (General method: **operate**; here the metric is frame time and consistency.)

### 5. Netcode (only if multiplayer)
- Choose the model up front: authoritative server (cheat-resistant, most online games), deterministic lockstep (RTS), or P2P. 
- Handle latency: client-side prediction + server reconciliation, entity interpolation, lag compensation. **Server-authoritative for anything competitive** — never trust the client; that's the base of anti-cheat. Sync only what's needed, validate everything on the wire.

### 6. Build-loop & verify
- Implement incrementally with the usual discipline (**build**: version control, test what's testable, commit small). Playtest builds on target hardware — the real device's frame rate is the truth.

## Hand-off
- Gameplay isn't fun / needs rebalancing → **game-design** (it owns the loop and tuning).
- Story/dialogue content or branching logic design → **game-narrative**.
- General coding discipline, tests, structure → **build**; non-frame backend/load perf → **operate**.
- Live-ops backend, accounts, store, deploy → **architect** + **ship**; selling/IAP economics → **monetize**.

## Operating rules
- **Respect the frame budget always.** Profile in ms/frame; stable 60fps over higher-but-stuttery. Hunt per-frame GC allocations.
- **Decouple simulation from frame rate.** Fixed timestep for gameplay/physics — identical behavior across machines.
- **Decide netcode at design time; server-authoritative for competitive.** Authority/sync is architectural; never trust the client for fair-play state.
- **Pool, batch, cull.** The big real-time wins are avoiding per-frame allocation and cutting draw calls — not micro-optimizing logic.
- **Build to the design, don't redesign in code.** If the mechanic isn't fun or is unbalanced, that's **game-design**'s call — don't silently change the design while implementing.
- **Test on target hardware.** The editor's frame rate lies; the player's device is the truth.
