---
name: debugging-basics
description: Diagnose and fix reproducible bugs, crashes, failing tests, and performance regressions. Use when something is broken, throwing, failing, or unexpectedly slow.
---

# Debugging basics

1. Reproduce the reported behavior with the smallest reliable command or input.
2. Read the error, failing assertion, logs, and directly involved code before
   proposing a fix.
3. Trace one causal chain from the observed failure to its source.
4. Form a concrete hypothesis and identify what evidence would disprove it.
5. Fix the root cause without broad catches, silent fallbacks, or unrelated
   refactoring.
6. Run the smallest existing validation that covers the failure.
7. Report the cause, fix, and remaining uncertainty.

Do not guess when the repository can answer the question.
