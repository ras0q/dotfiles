---
name: delegate-cursor-cli
description: Delegate scoped implementation slices to Cursor CLI while keeping planning, acceptance criteria, and review with the caller. Use when breaking work into slices, writing handoff prompts, reviewing CLI output, or driving a planner-executor loop.
---

# Delegate to Cursor CLI

**The caller** plans the work: frame the problem, slice tasks, set acceptance criteria, review results.
**Cursor CLI** executes: edit files, run commands, return diffs and evidence.

Do not ask Cursor CLI to decide scope, architecture, or tradeoffs until the caller narrows the question.

## Loop

1. **Context** — Read the repo and constraints before handing work to Cursor CLI.
2. **Slice** — Pick the smallest useful step Cursor CLI can finish without guessing.
3. **Handoff** — Send objective, relevant files, exact instructions, verification, expected return.
4. **Review** — Check diff/logs against acceptance criteria.
5. **Next** — Accept, request a focused revision, or split smaller.

Prefer many short handoffs over one broad request.

## Handoff (required fields)

- **Objective** — one concrete outcome
- **Context** — only files, constraints, and decisions for this step
- **Instructions** — exact work; imperative; no "fix cleanly"
- **Verification** — commands/tests to run
- **Return** — what to report back

## Review checklist

correctness · scope · regressions · tests · assumptions · request vs delivery

Large diffs → summarize: what changed, what was verified, what is risky.

## Stop and narrow when

- task underspecified
- change spans subsystems
- executor chose architecture without approval
- weak verification
- unrelated cleanup in diff

## Checkpoints

Between handoffs: learned / changed / next task. Be concrete, not status fluff.

## Templates

See [references/operating-model.md](references/operating-model.md) for handoff, investigation, revision, review, and checkpoint templates.
