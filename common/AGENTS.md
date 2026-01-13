# AGENTS.md - Global Agent Guidelines

## Core Principles

### Understand context before acting

- Check changed files before starting work to understand what's already modified
- Check project structure and architecture if unclear
- Before implementing or making architectural decisions, search for relevant documentation:
  - Search broadly: `*.md` files across the workspace
  - Common locations: project root, `docs/`, `.github/`, task-specific directories
  - Read and respect documented patterns and conventions

### When in doubt, ask

- Code like Kent Beck
- Describe failures clearly with error details before proposing solutions
- Ask before trying alternative approaches when stuck

## Code Standards

### Comments

- Write self-explanatory code: use clear names and simple logic so that most code does not require comments.
- Avoid obvious comments that restate what the code does (e.g., `// 1. Read text from file.`, `// Loop through array`).
- Do NOT add comments describing changes or history (e.g., `// removed unneeded process`, `// fixed bug`). Code should reflect only its current state; use version control for history.
- Only add comments to explain *why* something is done a certain way, especially when:
  - The reasoning is not apparent from the code itself
  - An alternative approach was considered but not chosen (explain "why not")
  - A workaround or non-obvious algorithm is necessary
  - Business rules or performance tradeoffs are involved
- When choosing approach A over alternative B, explain why: `// Using [A] instead of [B] because [reason]`
- Use document comments for public symbols (e.g., functions, types, classes).
- Use annotations (NOTE:, TODO:, FIXME:) for important callouts.

### Formatting

- Use four backticks (````) for nested Markdown code blocks to ensure accurate rendering of Markdown responses, especially for code blocks and agent instructions
- Follow markdownlint style guidelines for Markdown responses

## Commit Guidelines

### Conventional Commits

- Follow [Conventional Commits](https://www.conventionalcommits.org/) specification for commit messages
- Format: `<type>(<scope>): <subject>` (in English) followed by optional body and footer
- Common types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`
- For breaking changes, append `!` before the colon: `<type>(<scope>)!: <subject>`
- Output commit messages at appropriate checkpoints during implementation (do not execute commits automatically)
- Include `Assisted-by: {{agent name}} (model: {{model name}})` trailer in commit message body

