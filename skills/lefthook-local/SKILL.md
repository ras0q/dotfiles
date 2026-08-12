---
name: lefthook-local
description: >-
  Configure project-local Git hooks by writing lefthook-local.yml from repository
  structure and tooling. Use when setting up lefthook local hooks, lefthook-local.yml,
  personal pre-commit/pre-push hooks, AI agent hooks (Cursor/Claude/Codex/Copilot via ai:),
  or per-project git hook overrides. Assumes lefthook is installed. Edits only lefthook-local.yml.
---

# Lefthook Local Hooks

Write or update `lefthook-local.yml` at the repository root so the user gets personal Git hooks without changing shared project config.

## Hard boundaries

- **Edit only** `lefthook-local.yml` (or `.lefthook-local.yml` when the main config uses a leading dot).
- Do **not** create or modify any other file.
- Assume `lefthook` is on PATH. Do not install lefthook.
- You may **read** project files and existing lefthook config to infer commands.
- After writing the config, run `lefthook install` if hooks are not yet wired.

## Workflow

1. Identify the repository root.
2. Read existing `lefthook.yml` (if any) to learn hook names and jobs to override or extend.
3. Inspect project structure and documented scripts/Makefile targets to determine which checks to run.
4. Write `lefthook-local.yml` using the standard notation below.
5. Run `lefthook install`.
6. Summarize what was configured. Remind the user that `lefthook-local.yml` should stay out of version control (global gitignore).

## Standard notation

Use `jobs` under Git hook names. This is the default form — do not use other lefthook syntax unless the user's request requires it.

```yaml
pre-commit:
  parallel: true
  jobs:
    - name: <job-name>
      run: <command> {staged_files}
      glob: "<file-pattern>"
      stage_fixed: true  # only when the command modifies files

pre-push:
  jobs:
    - name: <job-name>
      run: <command>
```

Allowed job fields in this skill: `name`, `run`, `glob`, `stage_fixed`, `root`.

- File: `lefthook-local.yml` at repo root (mirror dot prefix of main config if present).
- Local config merges with main config; local values take precedence.
- Use the same job `name` as main config when overriding; use a new `name` when adding jobs.
- Use `{staged_files}` in pre-commit `run` commands.
- Set `root:` only for monorepo subdirectories.
- Choose `run` values from commands the project already defines — do not invent tooling.

## AI agent hooks

When the user wants Cursor / Claude / Codex / Copilot hooks, use the `ai:` key to map provider events to custom hook names, and define those hooks with `jobs`:

```yaml
ai:
  cursor:
    <event>: <hook-name>

<hook-name>:
  jobs:
    - run: <command>
```

Event names must match the target provider's hook schema (e.g. Cursor uses camelCase like `stop`, `preToolUse`). Read before writing:

- https://lefthook.dev/configuration/ai/

`lefthook install` generates provider settings (e.g. `.cursor/hooks.json`) from this config. The agent does not edit those files directly.

## Extended syntax

For anything beyond the notation above (`commands`, `skip`, `exclude_tags`, `group`, `{cmd}`, etc.), read the official docs before writing:

- https://lefthook.dev/configuration/
- https://lefthook.dev/configuration/ai/
- https://lefthook.dev/examples/lefthook-local

Use `lefthook dump` to verify the merged result when overriding an existing main config.
