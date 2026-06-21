---
name: mlops
description: Get models into production and keep them working — package and serve them, version model+data+code, monitor for drift, and automate retraining and rollback. Trigger on /mlops and proactively when deploying or serving a model, setting up a model registry/versioning, monitoring a live model, handling drift/staleness, building a retraining pipeline, or managing inference latency/cost in production. Scope: mlops owns the production lifecycle of models; training/evaluating is ml-modeling, the data pipeline is data-engineering, and general app/infra deployment is ship.
---

# Mlops

A model that isn't in production delivers exactly zero value — and a model in production silently rots as the world drifts away from its training data. MLOps is the discipline that closes the loop: serve it reliably, version it so you can reproduce and roll back, and watch it so you know *before* users do when it stops working.

## Operating stance

- **A model in a notebook is worth nothing.** Value is realized only when it serves real predictions reliably. Deployment is the goal, not an afterthought.
- **Models rot — monitor or you're blind.** Unlike normal code, an ML model degrades on its own as input data drifts. Without drift monitoring you won't know it's failing until the damage is done.
- **Version everything (model + data + code).** Reproducibility and rollback depend on pinning all three. "Which model is in prod and what trained it?" must always be answerable.
- **Inference cost and latency are product constraints.** A model too slow or too expensive to run is a model you can't ship, however accurate.

## Workflow

### 1. Package
- Serialize the model with its exact dependencies and a defined **input/output contract** (schema, pre/post-processing). The same preprocessing as training must run at inference — mismatch is a top production bug.

### 2. Serve
- Choose the serving mode for the use case: real-time API, batch, or edge/on-device. Set and meet a **latency and cost budget**; plan scaling.

### 3. Version & registry
- Register each model with its version, the data version, and the training code/commit that produced it. Maintain a **known-good rollback target** at all times.

### 4. Monitor
- Track **input drift** (production data diverging from training), prediction distribution shifts, real-world outcome metrics (when ground truth arrives), plus latency/cost/errors. Alert on the way it's most likely to silently fail.

### 5. Automate the loop
- Define **retraining triggers** (scheduled, or drift/performance threshold). Build CI/CD for models. De-risk new versions with **shadow or canary** deployment (run alongside, compare) before full cutover.

### 6. Govern
- Keep lineage and reproducibility so any prediction can be traced to a model, data, and code version — essential for debugging, audits, and trust.

## Hand-off
- The model needs to be improved/retrained → **ml-modeling**; the data feeding it changed → **data-engineering**.
- Underlying app deploy, infra, environments, secrets → **ship**; inference latency tuning at the code level → **operate**.
- It's an LLM system (prompt/RAG/agent) being deployed → **llm-engineering** (which owns its own eval/guardrails) + this for the serving/monitoring.
- Serving cost is hurting margins → **monetize** (cost-control).

## Operating rules
- **Ship monitoring with the model, always.** A deployed model without drift/outcome monitoring is an incident waiting to happen silently.
- **Version model + data + code together.** If you can't reproduce or identify what's in prod, you can't debug or roll back.
- **Keep a tested rollback target.** Every deploy can be reverted to a known-good model fast.
- **Match training and inference preprocessing exactly.** Skew between the two is a classic, silent accuracy killer.
- **Canary/shadow risky model updates.** Don't cut 100% of traffic to a new model on faith; compare first.
- **Respect the latency/cost budget.** Accuracy that misses the budget isn't shippable — trade it deliberately.
