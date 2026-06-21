---
name: monetize
description: Make the business work financially — price on the value delivered, package into tiers, and keep unit economics healthy by controlling the cost to serve. Trigger on /monetize and proactively when the user asks "how do I make money from this", "what should I charge", "pricing model / tiers", "free vs paid", "why is my cloud bill high", "is this affordable to scale", or "what will this cost at N users". Scope: monetize owns revenue (pricing, packaging) and cost (infra/unit economics) together; getting users is growth, willingness-to-pay evidence comes from product (research), and code-level speedups are operate.
---

# Monetize

Revenue minus cost to serve is whether the business lives. Price captures a fraction of the value you create, so it must track that value — and the cost of delivering it must stay below it as you grow. Most founders under-price out of fear and ignore the bill until it eats the margin. This is the discipline that keeps the economics sound.

## Operating stance

- **Price on value, not cost.** What is solving this problem worth to the customer? Cost-plus pricing leaves money on the table; under-pricing is the most common, hardest-to-undo mistake.
- **Revenue should scale with value; cost should not.** As a customer gets more value they should pay more (usage, seats, tiers). Meanwhile the cost to serve each one should fall or hold — or growth amplifies losses.
- **Packaging steers buyers as much as price.** What's in which tier moves decisions more than the numbers.
- **Watch the unbounded cost.** The catastrophic bill is the runaway one — an unthrottled paid API, a leaked key, an unbounded job. Guardrails beat bill shock.

## Workflow

### Part A — Price & package
1. **Quantify the value** — the outcome (time saved, money made, risk avoided) and roughly what it's worth. Identify the **value metric** that grows with benefit (per seat / usage / transaction / outcome); price rides it.
2. **Choose the model** — subscription (ongoing value), usage-based (variable consumption), one-time (owned tool), freemium (broad funnel, upsell), transaction fee (marketplace). State why it fits; treat any free tier as a deliberate acquisition cost that must convert.
3. **Design 2–4 tiers** around segments (casual → power → business); put each segment's must-have where its willingness to pay sits; anchor so the target tier looks obvious; don't give away the highest-value feature for free.
4. **Set the numbers** anchored to value and alternatives (including "do nothing" / "build it themselves"). When unsure, get evidence (**product** research: what do they pay today?) and lean higher than instinct.

### Part B — Control cost to serve
5. **See the bill** — break spend by line item; find the few that dominate (compute, egress, storage, a chatty paid API). Establish **cost per unit** (per user / transaction) as the metric to track.
6. **Cut waste & right-size** — idle/over-sized resources, unused infra, expensive egress, over-broad logging, dev/staging left on. Match resources to real load (autoscale, serverless for spiky, committed pricing for steady). Best savings-to-effort first.
7. **Put up guardrails** — billing alerts/budgets, spend limits and rate limits on paid APIs, timeouts and max-retries, locked-down keys.

### Part C — Confirm the economics
8. **Check the loop** — value/revenue per customer exceeds cost to serve, with margin; lifetime value beats acquisition cost (with **growth**). Forecast at target scale before a growth push. Record model, tiers, and unit-economics target (`docs/pricing.md`, `docs/costs.md`); revisit with evidence, grandfather existing customers fairly.

## Hand-off
- Cost is driven by slow code / bad query shape → **operate** (or **architect** for design).
- Need willingness-to-pay evidence or conversion-by-tier metrics → **product**.
- Driving signups and the pricing-page words → **growth**.
- Regulated billing / tax / contracts → **legal-compliance**.

## Operating rules
- **Value-based, not cost-plus; don't under-price out of fear.** It's easier to discount than to raise.
- **Make revenue scale per customer.** A model that can't grow per-customer caps the whole business.
- **Know cost per unit, not just the total.** A rising total can be fine; a rising cost-per-user is a leak that scaling magnifies.
- **Right-size and cap every unbounded cost.** Idle capacity is money burned; set billing alerts and spend/rate limits on day one, not after the surprise.
- **Don't scale broken economics.** If serving a user costs more than they're worth, fix that before pouring on growth.
- **Package for segments; revisit with evidence.** Tiers move buyers more than the raw number; protect existing customers when pricing changes.
