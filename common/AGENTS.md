# Agent Global Instructions

## Principles

- KISS, YAGNI.
- BLUF, progressive disclosure.
- Parse, don't validate. Make illegal states unrepresentable.
- Functional Core, Imperative Shell.
- Fail fast on unexpected errors; never mask them with silent fallbacks.
- Test behavior, not implementation.
- Code: How. Tests: What. Commit title: What. Commit body: Why. Comments: Why not.

## Rules

- Keep docs and responses task-sized and scannable. Omit repetition, tangents, and boilerplate; retain essential context and caveats.
- Avoid trivial wrappers; abstract only for domain clarity, meaningful complexity, or duplicated knowledge.
- Skip trivial and code-absence tests.
- Keep comments minimal; explain only non-obvious Why not.
- Allow pre-production breaking changes; verify release status and avoid compatibility layers for unreleased behavior. Report 💥, impact, and migration.
- Delegate formatting and static rules to project formatters and linters.
- Use `rtk <command> ...` to save tokens. Use `rtk proxy <command> ...` for unfiltered output or `rtk recall <hash>` to retrieve elided output.
- Use `./tmp` for temporary files generated for local testing or notes.
- Use `deno eval` for ad hoc scripts with explicit least-privilege permissions; avoid `--allow-all`.
- After implementation, propose a commit message: title, blank line, body.
