---
name: architect
description: Design the solution before building it — system structure, data model, and security, decided together and recorded as a lightweight ADR. Pick an approach against real alternatives, model the data from real access patterns, and design security in (threats and mitigations) up front. Trigger on /architect and proactively when work is non-trivial enough that the wrong structure is expensive to undo: a new service/subsystem, a schema or data-model choice, picking a library/framework/pattern, integrating an external system, anything touching auth/payments/sensitive data, or when the user asks "how should I structure/design/secure this?". Scope: architect owns design-time decisions across system, data, and security; building is build; pre-release security/migration verification is ship.
---

# Architect

Choose the shape of the solution — its structure, its data, and its defenses — on the cheapest medium there is: words and a diagram, before it gets expensive in code. A principal architect decides these together, because they constrain each other. Skip this for trivial changes; insist on it when undoing the decision later would hurt.

## Operating stance

- **Decisions with rationale, not diagrams for their own sake.** The output is a chosen direction and the reasoning that lets future-you understand *why* — and why not the alternatives.
- **Reversibility sets the rigor.** One-way doors (data model, public API, core dependency, auth model) deserve real deliberation; two-way doors get decided fast.
- **Design for the spec, not an imagined future.** Build for the load and requirements that exist; leave a noted seam for known future needs, don't build the future now.
- **Boring beats clever; security and data are not afterthoughts.** Prefer the well-trodden path. Model the data and the threats *now*, while it's free to change.

## Workflow

Requires a locked spec (**spec**). Run in order.

### 1. Frame the decision
- State what's being decided in one sentence and how reversible it is (one-way / two-way door).
- List the forces: acceptance criteria, scale/perf targets, existing stack, team (you + AI), deadline, budget.

### 2. Choose the approach (vs real alternatives)
- Produce 2–3 genuinely different options (include the cheapest "use what exists / do less"). For each: what it optimizes, its main cost/risk.
- Pick one. Justify why it beats the others *for this spec*, and state what would change the decision. For a heavy one-way door, spawn an independent sub-agent to argue the opposing option before committing.

### 3. Model the data (if storage is touched)
- Design from **access patterns** — the real reads/writes — not an abstract diagram. Entities, relationships, keys.
- Normalize by default (one fact, one place); denormalize only where a measured read pattern demands it, owning the consistency cost.
- Push integrity into the schema (keys, FKs, uniqueness, not-null, checks). Precise types (money = exact decimal, timestamps = explicit tz). Index the queries you actually have.
- Plan migrations expand-then-contract: add → backfill → switch → remove, so a deploy never breaks running code; reversible, with a backup before anything destructive.

### 4. Design security in
- Map assets (data, money, accounts, availability) and trust boundaries (where untrusted input crosses into trusted execution/storage).
- Enumerate the real threats at each boundary — focus on the staples: broken access control (authorize every object access), injection, spoofable auth, secret leakage, SSRF, DoS on unauth paths. Rank by likelihood × impact.
- Define concrete mitigations (prefer prevention; add detection where prevention can fail). Record accepted residual risk explicitly.

### 5. Define the shape
- Components/modules and each one's single responsibility; data flow through them; contracts/interfaces at the seams; where it can fail and how each failure is handled. Only as much as the build needs — no speculative layers.

### 6. Record the ADR
Write a short ADR to the repo (`docs/adr/NNNN-<slug>.md`):

```markdown
# ADR NNNN: <decision>
- Status: accepted   - Date: <YYYY-MM-DD>
## Context        <forces / problem>
## Decision       <what we chose, incl. key data & security choices>
## Alternatives considered   <option — why not>
## Consequences   <what it makes easy/hard, what we'll revisit and when>
```

## Hand-off
- Design done → **build** (contracts, schema, and components become the build order; abuse cases become tests).
- Pre-release security/migration verification → **ship**.
- A slow query traces to query shape later → **operate**.

## Operating rules
- **No design without a spec.** Designing for a moving target wastes the effort — go to **spec** first.
- **At least one real alternative, always.** A decision with no considered alternative is a default in disguise.
- **Right-size the rigor.** ADR for one-way doors; decide-and-move for two-way doors. Match effort to reversibility.
- **Model data from access patterns; constraints live in the schema.** A clean diagram that serves the queries badly is a bad model.
- **Authorize every object access; never trust the client.** The most common real breach is broken access control. Any client-settable value (price, role, id) is validated server-side.
- **No speculative generality.** Leave a seam and note it; don't build the abstraction you "might" need.
- **Tie every choice to a force.** "It's cleaner" is not justification; "it satisfies criterion X / fits existing Y" is.
