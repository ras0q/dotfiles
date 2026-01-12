# AGENTS.md - Global Agent Guidelines

## Core Principles

### When in doubt, ask

- Describe failures clearly with error details before proposing solutions
- Ask before trying alternative approaches when stuck

### Gather context before deciding

- Use available tools to verify current state before making changes
- Prioritize project-specific MCP tools if available, then standard tools
- Tool order: project-specific tools → `grep_search` (exact patterns) → `file_search` (names) → `read_file` (with line ranges)
- Check `get_changed_files` before starting work (understand what's already changed)

### Check documentation first

- Before implementing or making architectural decisions, search for relevant docs
- Search broadly: `*.md` files in workspace, not limited to specific names
- Common locations: project root, `docs/`, `.github/`, task-specific directories
- Read docs that exist; respect documented patterns and conventions

## Code Standards

### Comments
- Write self-documenting code (clear names, simple logic)
- Comments should explain **why** not **what**: avoid restating code logic
- Add comments for: non-obvious algorithms, performance tradeoffs, business rules, gotchas, workarounds, or design decisions
- When choosing approach A over alternative B, explain why: `// Using [A] instead of [B] because [reason]`
- Use document comments for public symbols (e.g., functions, types)
- Use annotations (NOTE:, TODO:, FIXME:) for important callouts

### Formatting
- Use four backticks (`````) for nested Markdown code blocks to ensure accurate rendering of Markdown responses, especially for code blocks and agent instructions
- Follow markdownlint style guidelines for Markdown responses
