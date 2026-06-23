---
description: Start a new project and run it through the lifecycle (spec → architect → build)
argument-hint: [what you want to build]
---

The user wants to kick off a new project: **$ARGUMENTS**

If the line above is empty, first ask one or two crisp questions to capture the goal and who it's for — then continue.

Drive the project through the team's lifecycle, invoking the right skill at each stage and confirming with the user before moving to the next:

1. **spec** — turn the idea into a locked spec: scope, what to build first, and testable acceptance criteria.
2. **architect** — once scope is agreed, design the system, data model, and security; record a short ADR.
3. **build** — implement the first slice test-first and run it for real before calling anything done.

Pull in other teammates as the work calls for them — `scrutinize` for review, `ship` to release, `operate` to debug, `product`/`growth`/`monetize` for product & go-to-market. Move one stage at a time; don't skip ahead without the user's go-ahead.
