---
name: fix-root-causes
description: Address underlying causes and structural obstacles in bug fixes, recurring problems, and design decisions rather than stopping at symptom relief.
---

# Fix Root Causes

Make the smallest sufficient change to the causes or structure preventing the desired outcome.

1. Establish the goal, the gap from current behavior, and constraints. Inspect the implementation and usage; separate evidence from hypotheses.
2. Trace the mechanisms or assumptions producing that gap. For design decisions, compare options and tradeoffs without assuming the existing design is defective.
3. Change the part responsible for the underlying issue. Redesign when necessary, but avoid speculative abstractions and scope expansion.
4. Verify the desired outcome and existing required behavior with concrete examples or appropriate tests. Distinguish observed results from predicted design benefits.

Briefly report the reasoning, why the change addresses the issue, validation results, and remaining uncertainty. When immediate mitigation is needed, identify the unresolved cause and follow-up work.
