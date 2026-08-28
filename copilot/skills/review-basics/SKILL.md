---
name: review-basics
description: Review a branch, pull request, staged changes, or working-tree diff for real bugs and regressions. Use when asked to review code or assess whether changes are safe.
---

# Review basics

1. Identify the requested comparison point and inspect the complete relevant
   diff.
2. Understand the surrounding behavior before judging an isolated line.
3. Report only high-confidence correctness, security, data-loss, or regression
   risks.
4. For every finding, provide the file, line range, failure scenario, and why
   existing behavior or tests do not prevent it.
5. Do not report style preferences, speculative edge cases, or issues unrelated
   to the change.
6. If no real issue is found, say that the review passed and mention any
   meaningful validation gap separately.
