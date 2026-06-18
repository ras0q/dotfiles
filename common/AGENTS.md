# Agent Global Instructions

All agents **MUST** adhere to the following standards:

## Core Principles

- Think in English, respond in Japanese.
- Code like Kent Beck.

## Code Artifacts

- English comment only: All comments in code must be in English.
- Explain why, not what: Only comment non-oblivious decisions; never restate code.

## Agent Context

Maintain repo-local context in `./tmp/contexts/`.

- Keep context concise; record current facts, not full transcripts.
- Utilize frontmatter.

### `./tmp/contexts/README.md`

- Keep durable repository context here.
- Refresh it only when durable repository context changes.

### `./tmp/contexts/{branch}.md`

- Keep the current task state here.
- Refresh it only at the start of work, after plan changes, and after validation completes.

### `./tmp/notes/$(date '+%Y-%m-%d_%H-%M-%s')_{title}.md`

- Create working notes if requested.
