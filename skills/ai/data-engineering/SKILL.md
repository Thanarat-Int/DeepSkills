---
name: data-engineering
description: Build the data foundation that any model learns from — collect, explore, clean, label, transform, version, and split data without leakage. Trigger on /data-engineering and proactively when preparing a dataset, building a data/ETL pipeline for ML, labeling data, assessing data quality, or deciding train/validation/test splits. Scope: data-engineering owns the data lifecycle that feeds models; training/evaluating models is ml-modeling, serving/monitoring is mlops, and an application's transactional DB schema is architect.
---

# Data-engineering

In machine learning, the data *is* the program. Model quality is capped by data quality long before architecture matters — and the most catastrophic, hardest-to-spot failures (leakage, bad labels) are born here, in the data pipeline. This is the discipline that makes the foundation trustworthy.

## Operating stance

- **The data is the program.** Most ML gains come from better data, not cleverer models. Invest here first; garbage in, garbage out is a law, not a warning.
- **Leakage is the silent killer.** Any information from the future or the test set bleeding into training produces dazzling offline scores and a model that fails in production. Guard the split with your life.
- **Label quality caps model quality.** A model can't be more correct than its labels. Noisy/biased labels = a noisy/biased ceiling.
- **Reproducible or it didn't happen.** Versioned data, recorded transforms, fixed seeds. A dataset you can't regenerate is an anecdote, not an asset.

## Workflow

### 1. Understand source & target
- What does the model need to learn, from what raw data, at what volume? Where does the data come from, how fresh, how will it grow?
- Define the unit of a "row/example" and what a label means.

### 2. Collect & ingest
- Assemble the raw data; build a repeatable ingestion path (not a one-off manual download). Capture provenance.

### 3. Explore & assess quality
- Profile it: distributions, missing values, **class balance**, duplicates, outliers, and **bias** (is a group over/under-represented?). Quality problems found now are cheap; found after training they're a wasted run.

### 4. Clean & transform
- Handle missing values, outliers, duplicates, inconsistent formats — deliberately, with the reasoning recorded.
- Define transforms (normalization, encoding, augmentation) but **fit them on training data only** (see split below).

### 5. Label
- Choose a labeling strategy (manual, programmatic/weak supervision, pre-labeling + review). Set quality control: clear guidelines, spot-checks, inter-annotator agreement on a sample. Track label provenance.

### 6. Split correctly (the critical step)
- Split **before** any transform is fit. Choose the split unit to prevent leakage: **by entity** (user/patient) when rows aren't independent, **temporally** for time series (train on past, test on future) — never naive random when that leaks.
- The **test set is sacred**: set aside, untouched, used once at the very end. Keep a validation set for tuning.

### 7. Version & document
- Version the dataset and the transform code together; record lineage (source → cleaning → labels → split). So an experiment is reproducible and a future model trains on a known foundation.

## Hand-off
- Data ready → **ml-modeling** to train/fine-tune/evaluate.
- The data feeds an LLM/RAG system (chunking, embeddings) → **llm-engineering**.
- Pipeline needs production scheduling/serving infrastructure → **mlops** / **ship**.
- Storing data at scale (warehouse, schema) → **architect**; privacy/consent for collected data → **legal-compliance**.

## Operating rules
- **Split before you transform; fit transforms on train only.** Scalers, encoders, vocabularies, and stats learned from the whole set leak the answer.
- **The test set is used once.** Touch it for tuning and every number afterward is a lie.
- **Choose the split unit to prevent leakage.** Random splits leak when rows are correlated (same user/time). Split by entity or time.
- **Label quality first.** Audit labels; a model can't beat its labels. Measure annotator agreement.
- **Version data and transforms together.** Reproducibility is non-negotiable; record lineage.
- **Hunt bias in the data.** Imbalance and skew become unfair models — surface it here, not after deployment.
