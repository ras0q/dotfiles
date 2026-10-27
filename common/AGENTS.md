# Agent Global Instructions

## Principles

- KISS, YAGNI.
- BLUF, progressive disclosure.
- Parse, don't validate. Make illegal states unrepresentable.
- Functional Core, Imperative Shell.
- Fail fast on unexpected errors; never mask them with silent fallbacks.
- Code: How. Tests: What. Commit title: What. Commit body: Why. Comments: Why not.

## Rules

- Keep docs and responses task-sized and scannable. Omit repetition, tangents, and boilerplate; retain essential context and caveats.
- Avoid trivial wrappers; abstract only for domain clarity, meaningful complexity, or duplicated knowledge.
- Avoid over-testing and unnecessary duplication. Use existing project tests as a reference and choose the smallest scope that provides meaningful confidence.
- Keep comments minimal; explain only non-obvious Why not.
- Allow pre-production breaking changes; verify release status and avoid compatibility layers for unreleased behavior. Report 💥, impact, and migration.
- Delegate formatting and static rules to project formatters and linters.
- Use `rtk <commands...>` to save tokens.
- Use `./tmp` for temporary files generated for local testing or notes.
- Batch independent necessary commands into a single tool call to reduce round trips.
- After implementation, propose a commit message in English: title, blank line, body.
