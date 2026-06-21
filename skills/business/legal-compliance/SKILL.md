---
name: legal-compliance
description: Cover the legal and compliance basics a software product needs — privacy policy and terms, data-protection duties (GDPR/CCPA/PDPA), licensing of dependencies and content, and obvious regulatory traps — and know when to escalate to a real lawyer. Trigger on /legal-compliance and proactively when handling personal/payment/health data, adding auth or accounts, using third-party code/content/AI output, preparing to launch publicly, or when the user asks "do I need a privacy policy / terms", "is this GDPR-compliant", "can I use this library/asset", "what are the legal risks". Scope: this gives practical, non-lawyer guidance and checklists to reduce risk and flag what needs counsel — it is not legal advice and does not replace a qualified lawyer.
---

# Legal-compliance

The boring paperwork that, skipped, becomes the existential risk. A solo founder won't have in-house counsel — so the job here is to handle the obvious basics correctly, avoid the well-known traps, and clearly flag the moments that genuinely need a real lawyer. **This is practical risk-reduction, not legal advice.**

## Operating stance

- **Reduce obvious risk, flag the rest.** Most products share the same baseline needs (policies, data handling, licensing). Cover those competently; escalate anything novel, high-stakes, or regulated to a qualified lawyer.
- **Data is a liability, not just an asset.** Every piece of personal data you collect is something you must protect, justify, and sometimes delete on request. Collect less and the legal surface shrinks.
- **Licenses are binding contracts.** "It's on the internet" is not permission. Code, images, fonts, and content each come with terms — using them wrong is infringement.
- **Jurisdiction matters.** Obligations depend on where you and your users are. Don't assume one country's rules apply everywhere; flag cross-border cases.

## Workflow

### 1. Map the legal surface
- What data do you collect (especially personal, payment, health, biometric, children's)? From users in which regions?
- What third-party code, content, assets, and APIs do you use, and under what licenses?
- What do you claim publicly (marketing claims, guarantees) and what do users agree to?

### 2. The baseline documents
- **Privacy Policy** — what you collect, why, how it's stored/shared, user rights, contact. Required the moment you collect personal data.
- **Terms of Service** — the rules of use, liability limits, acceptable use, termination, governing law.
- **Cookie/consent notice** — if you track or use cookies/analytics in regulated regions.
- Use reputable templates as a starting point, tailor them to what you actually do, and have them reviewed before high-stakes launches.

### 3. Data-protection duties
- Apply the common principles (GDPR/CCPA/PDPA share most): collect only what you need, state the purpose, get consent where required, secure it, honor access/deletion requests, and report breaches.
- Minimize: don't collect data you can't justify. Don't keep it longer than needed.
- Note special-category data (health, biometric, children) and cross-border transfers as **escalate-to-lawyer** triggers.

### 4. Licensing & IP
- Check each dependency's license (MIT/Apache/BSD are permissive; GPL/AGPL are copyleft with obligations — AGPL especially for hosted services). Confirm your usage complies.
- Verify rights for images, fonts, audio, and content (license or original). Watch AI-generated content ownership/usage terms.
- Make sure you actually own or license your own brand assets (name, logo) — check for trademark conflicts before investing in a brand.

### 5. Spot the high-risk traps
- Regulated domains (finance, health, crypto, gambling, children) carry heavy specific rules — flag loudly for counsel.
- Payment handling → use a PCI-compliant processor (Stripe etc.); don't store raw card data.
- Marketing/claims → no false or unsubstantiated claims; honor refund/consumer-protection rules.

### 6. Record and escalate
- Keep a `docs/legal/` note: what data you handle, your policies, your dependency licenses, and an explicit list of **open questions for a lawyer**.
- State clearly which items are handled and which require professional legal review before launch.

## Hand-off
- Data collection/retention touches the schema, and security of that data → **architect**.
- Marketing claims need to be truthful → **growth**.
- Payment/pricing flows → **monetize**.

## Operating rules
- **This is not legal advice.** Provide practical guidance and checklists; for anything regulated, high-value, or novel, the output is "get a lawyer for this," not a ruling.
- **Don't ship without a privacy policy and terms** once you collect personal data or take payment.
- **Collect the minimum.** Every extra data field is extra liability. Justify each one.
- **Verify every license.** No dependency or asset goes in without confirming its terms allow your use — copyleft and commercial-use limits especially.
- **Never store raw payment cards.** Delegate to a compliant processor.
- **Flag jurisdiction and regulated domains loudly.** When users span regions or the domain is regulated, escalate rather than guess.
