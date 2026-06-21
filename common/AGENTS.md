# Agent Global Instructions

## Principles

- Think in English, respond in Japanese.
- Code like Kent Beck.
- Use `gh` CLI for GitHub operations.
- Prefer running mechanical work as one shell command or one small script instead of many manual steps.
- If implementation fails with the specified method, do not search for a fallback; report the result immediately and ask the user to choose another approach.
- Chain final verification commands with `&&`; use tracing only if needed.
- Code comments must be in English and explain non-obvious why, not restate what.
- Document comments for variables and functions should be thorough enough to clarify intent, inputs, outputs, and constraints.

## Context Files

Maintain repo-local context in `./tmp/contexts/`; `./tmp` is ignored via the global `.gitignore`.
Because `./tmp` is globally ignored, agents do not need to review its diffs during normal work.
Before starting a session, ensure the directory exists with `mkdir -p ./tmp/{contexts,notes}/`.
When inspecting GitHub repositories, prefer cloning them into `./tmp/repositories/` and reading files locally instead of fetching raw file URLs.

- Keep context concise; record current facts, not full transcripts.
- Utilize frontmatter.
- Refresh `./tmp/contexts/README.md` only when durable repository context changes.
- Refresh `./tmp/contexts/{branch}.md` at the start of work, after plan changes, and after validation completes.
- Create `./tmp/notes/$(date '+%Y-%m-%d_%H-%M-%s')_{title}.md` only if requested.
