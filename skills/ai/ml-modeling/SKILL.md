---
name: ml-modeling
description: Train, fine-tune, and evaluate models for any task (computer vision like OCR/detection, NLP, tabular, time-series, etc.) — beat a simple baseline first, prefer transfer learning over training from scratch, tune against validation, and evaluate honestly on the metric that matters. Trigger on /ml-modeling and proactively when training or fine-tuning a model, choosing a model/architecture, running experiments, tuning hyperparameters, or evaluating model quality. Scope: ml-modeling owns model training and evaluation; preparing the data is data-engineering, deploying/monitoring is mlops, and building systems on top of LLMs (prompt/RAG/agents) is llm-engineering.
---

# Ml-modeling

The modeling core of the AI lab: turn prepared data into a model that actually works, for whatever the task is. The senior move is rarely to invent an architecture — it's to **start simple, stand on pretrained giants, and measure honestly**. Most "ML failures" are really evaluation failures: a model that looked great offline because the measurement lied.

## Operating stance

- **Earn the model; start with a baseline.** Before any deep net, try the dumb thing (heuristic, majority class, linear/tree model). If a complex model can't beat it, the complexity isn't justified — and often the baseline ships.
- **Transfer learning by default.** For almost every real task (vision, language, audio), fine-tune a pretrained model rather than train from scratch — faster, cheaper, and more accurate with less data. From-scratch is a last resort with a specific reason.
- **The metric must match the goal.** Accuracy on imbalanced data lies. Optimize the metric reflecting the real cost of errors (precision/recall, F1, mAP for detection, BLEU/exact-match, AUC, calibration).
- **Distrust results that are too good.** Near-perfect scores almost always mean leakage or a broken eval, not genius. Hunt the flaw before celebrating.

## Workflow

Requires prepared, correctly-split data (**data-engineering**).

### 1. Frame & baseline
- State the task, the input→output, and the **success metric** tied to the goal. Establish a **simple baseline** everything must beat to justify its cost.

### 2. Choose the approach
- Pick the simplest model class that can plausibly win. Match the family to the task (gradient-boosted trees for tabular; fine-tuned CNN/ViT or a detector like YOLO for vision; fine-tuned transformer for NLP). 
- **Prefer fine-tuning a strong pretrained model**; reach for training-from-scratch only with a clear reason.

### 3. Train
- Train with a validation loop. Tune hyperparameters **against validation, never test**. Watch the train-vs-val gap: rising val loss while train falls = overfitting → regularize, augment, get more data, or simplify.
- Use appropriate techniques (augmentation for vision, early stopping, learning-rate schedules) and **track every experiment** (config, data version, metric) for reproducibility and comparison.

### 4. Evaluate honestly
- Score on the untouched **test set, once**, with the metric from step 1. Compare to baseline — did complexity earn its place?
- Do **error analysis**: what does it get wrong, on which segments? Check fairness across groups; check calibration if probabilities are used downstream.
- Be suspicious of suspiciously good numbers → look for leakage (back to **data-engineering**).

### 5. Iterate deliberately
- Improve the biggest lever first — usually **more/better data** beats model tweaks. Change one thing at a time so gains are attributable.

## Hand-off
- Need better/more/cleaner data, or a leak suspected → **data-engineering**.
- Model is good → **mlops** to package, serve, version, and monitor it.
- The task is actually a GenAI/LLM problem (text gen, RAG, agents) → **llm-engineering**.
- Inference too slow/expensive → **operate** (and **mlops** for serving choices).

## Operating rules
- **Beat a simple baseline or don't ship.** Complexity that doesn't outperform a heuristic is cost and risk for nothing.
- **Fine-tune before training from scratch.** Stand on pretrained models; from-scratch needs a specific justification.
- **Tune on validation; the test set is used once.** Any peeking at test invalidates the result.
- **Optimize the metric that matches the cost of errors.** Accuracy on imbalanced/asymmetric problems is a lie.
- **Distrust too-good results — hunt the leak.** Near-perfect offline ≠ genius; it's usually leakage.
- **Reproducibility is non-negotiable.** Version data, seeds, configs; track experiments. One change at a time.
