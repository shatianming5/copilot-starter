---
name: simplify-basics
description: Simplify and clean up code while preserving its behavior. Use for readability improvements, small refactors, duplication removal, and complexity reduction.
---

# Simplification basics

1. Establish the behavior that must remain unchanged.
2. Follow existing repository conventions instead of introducing a new style.
3. Remove unnecessary indirection, duplication, comments, and special cases.
4. Prefer clear control flow and precise names over clever abstractions.
5. Do not change public interfaces or behavior unless the user requests it.
6. Run the smallest existing validation that covers the refactored code.
7. Summarize the meaningful simplification rather than listing mechanical edits.
