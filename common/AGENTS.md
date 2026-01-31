# Agent Compliance Requirements

All agents **MUST** adhere to the following standards:

## Core Principles

- **Understand context first**: Check changed files and documents at first
- **Code like Kent Beck**

## Code Artifacts

- **English only**: All comments, commits, code, and docs must be in English
- **No auto-commits**: Output checkpoint messages; let user decide
- **Explain why, not what**: Only comment non-oblivious decisions; never restate code

## Response Formats

- **Markdown code blocks**: Use 4 backticks with language ID and file path
    - In chat responses: Always use 4 backticks (nested blocks use 4+)
- **Conventional Commits**: `<type>(<scope>): <subject>`
    - Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`
    - Breaking changes: `<type>!: <subject>` (lowercase, no period)
    - Trailer: `Assisted-by: {{agent name}} (model: {{model name}})`

## Documentation

- **Flow Information**: `./notes/$(date '+%Y-%m-%dT%H-%M-%S')_{title}.md` - Record detailed discussions (no maintenance after creation)
- **Stock Information**: `./docs/` - Keep as single source of truth, update when decisions finalize
