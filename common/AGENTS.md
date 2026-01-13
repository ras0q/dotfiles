# Agent Guidelines

## Core Principles

### Understand context first

- Check changed files and project structure before starting
- Search docs (`*.md` in root/`docs/`/`.github/`) before implementing
- Respect documented patterns and conventions

### When in doubt, ask

- Code like Kent Beck
- Describe failures with error details before proposing solutions
- Ask before trying alternatives when stuck

## Code Standards

- **Use English for all code artifacts (comments, commits, docs)**

### Comments

- Write self-explanatory code (clear names, simple logic)
- Avoid obvious comments (`// Read file`) or history (`// fixed bug`)
- Only explain *why*, especially:
  - Non-obvious reasoning or "why not" alternative approaches
  - Workarounds, algorithms, business rules, performance tradeoffs
- Use doc comments for public symbols
- Use NOTE:/TODO:/FIXME: for callouts

### Formatting

- Use four backticks for nested Markdown code blocks
- Follow markdownlint style

### Commits

- Follow [Conventional Commits](https://www.conventionalcommits.org/): `<type>(<scope>): <subject>`
- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`
- Breaking changes: `<type>!: <subject>`
- Subject starts with lowercase, no period
- Output messages at checkpoints (don't auto-commit)
- Add trailer: `Assisted-by: {{agent name}} (model: {{model name}})`
