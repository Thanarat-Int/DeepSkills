---
name: llm-engineering
description: Build reliable systems on top of large language models — prompt design, retrieval-augmented generation (RAG), tool-use/agents, fine-tuning, and rigorous evals plus guardrails. Escalate capability in cost order: prompt → RAG → fine-tune. Trigger on /llm-engineering and proactively when building with LLMs (chatbots, assistants, agents), doing prompt engineering, RAG/retrieval, tool-use/function-calling, fine-tuning an LLM, evaluating LLM output, or handling hallucination/guardrails/prompt-injection. Scope: llm-engineering owns GenAI/LLM systems; training classic or vision/NLP models from data is ml-modeling, data pipelines are data-engineering, and serving/monitoring infra is mlops.
---

# Llm-engineering

Modern AI engineering is mostly building *systems around* an LLM, not training one. The model is a powerful but unreliable component — non-deterministic, prone to hallucinate, sensitive to phrasing. The craft is engineering reliability around it: ground it in real data, constrain it with tools and validation, and **prove it works with evals instead of vibes**.

## Operating stance

- **The LLM is a component, not the system.** Engineer around its failure modes (hallucination, drift, injection) with retrieval, validation, and fallbacks — don't trust raw output.
- **Escalate in cost order: prompt → RAG → fine-tune.** Most problems are solved by a better prompt or giving the model the right context. Fine-tuning is the expensive last resort, justified only when prompt+RAG provably fall short.
- **Evaluate or you're flying blind.** Outputs are non-deterministic; "it looked good in my three tries" is not evidence. Build an eval set and measure changes against it.
- **Ground to fight hallucination.** A model answering from its weights guesses; a model answering from retrieved, cited sources can be checked. Prefer grounded answers.

## Workflow

### 1. Frame the task & choose the approach
- Define the job and how you'll judge success. Pick the cheapest sufficient approach: **prompt-only** → add **RAG** (if it needs knowledge it doesn't have) → add **tools/agents** (if it needs to act) → **fine-tune** (only if behavior/format/style can't be achieved otherwise).
- Default to the latest capable models; for Claude/Anthropic specifics (model ids, tool-use, caching, token limits) consult the `claude-api` skill rather than guessing.

### 2. Prompt design
- Clear role and instructions, the necessary context, few-shot examples for hard cases, and an explicit **output format** (often structured/JSON for downstream use). Make failure modes explicit ("if unsure, say so").

### 3. RAG (when it needs knowledge)
- Build the retrieval pipeline (chunk → embed → index → retrieve) — chunking and retrieval quality matter more than the model. Feed retrieved context and instruct the model to answer **from it and cite**; handle "not in the context."

### 4. Tools / agents (when it needs to act)
- Define tools with crisp schemas and descriptions. Keep agent control flow as simple as the task allows (a fixed pipeline beats a free-roaming agent when it fits). Put **guardrails on actions** — validate arguments, limit blast radius, require confirmation for irreversible steps.

### 5. Fine-tune (last resort)
- Only when prompt+RAG provably fall short. Needs quality examples (**data-engineering**) and a measured gain on the eval set over the prompt+RAG baseline.

### 6. Evaluate
- Build an **eval set** of representative inputs with expected behavior. Combine automatic checks (exact match, rubric scoring, LLM-as-judge with care) and human review. **Run it on every prompt/model change** — prompt edits silently regress; pin model versions because model updates change behavior.

### 7. Guardrails, safety & cost
- Validate/parse outputs before use; never execute or trust them blindly. Defend against **prompt injection** (especially with RAG/tools on untrusted input), filter PII, handle refusals. Manage **cost & latency**: right-size the model, cache, batch, cap tokens, watch per-call spend.

## Hand-off
- Needs a trained classic/CV/NLP model (not an LLM) → **ml-modeling**; the data/embeddings pipeline at scale → **data-engineering**.
- Deploying and monitoring the service (latency, cost, drift in usage) → **mlops** / **ship**.
- It's an autonomous multi-step agent product → keep control flow simple here; serve via **mlops**.
- Anthropic/Claude API details (params, caching, tool format) → `claude-api` skill.

## Operating rules
- **Prompt + RAG before fine-tuning.** Don't pay to train when context engineering solves it.
- **Build an eval set; no vibes-only changes.** Measure every prompt/model change against it — LLM changes regress silently.
- **Ground and cite to cut hallucination.** Prefer answers from retrieved sources the user can verify.
- **Never trust LLM output blindly.** Validate/parse it; guard tools and actions; confirm irreversible steps.
- **Defend against prompt injection.** Treat retrieved/user content as untrusted; it can hijack instructions.
- **Pin model versions and watch cost/latency.** Model updates change behavior; tokens are money — cache, batch, right-size.
