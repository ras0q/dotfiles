---
name: cute
description: Guidance for working on Cute, the shell-based CLI task runner that discovers Markdown headings with sh, shell, bash, or zsh code blocks and executes them as tasks. Use when Codex edits, reviews, tests, documents, or reasons about the Cute repository, including the cute script, shell completions, GitHub Action, Nix packaging, README task examples, or Markdown task parsing behavior.
---

# Cute

## Workflow

Start by checking `git status --short`, then read the relevant project docs or notes before editing. Treat existing uncommitted files as user-owned.

Keep Cute small: prefer shell built-ins and standard Unix tools, avoid new runtime dependencies, and keep wrapper files thin around the main `cute` script.

Preserve the supported task model:

- Discover `.md` and `.markdown` files up to the selected depth.
- Treat Markdown headings followed by `sh`, `shell`, `bash`, or `zsh` fenced blocks as tasks.
- Use slug matching and exact heading matching.
- Ignore example blocks that begin with `$`.
- Support direct execution, sourcing, and shell integration files.

## Validation

Run the smallest useful checks for the touched surface:

- `bash tests/run-test.sh` for behavior and snapshots.
- `sh -n cute` after editing the main script.
- `bash -n cute.bash tests/run-test.sh` after editing Bash files.
- `zsh -n cute.plugin.zsh` after editing zsh integration when zsh is available.
- `fish -n functions/cute.fish` after editing fish integration when fish is available.

If snapshots change, inspect the diff before updating them.
