---
name: manage-context-files
description: Create and refresh minimal repo-local context and requested notes under `./tmp/`. Use at repository task start, after plan changes, after validation, when context or notes are requested, or when inspecting another GitHub repository.
---

# Context Schemas

Run `mkdir -p ./tmp/{contexts,notes}/`. Keep only concise current facts, not transcripts. Because `./tmp` is globally ignored, exclude it from normal diff review.

## `README.md`

Store durable repository-wide context. Update only when it changes.

```yaml
---
updated: YYYY-MM-DD HH:mm:ss
---
```

## `{branch}-{context}.md`

Use a short unique context name. At task start, delete `closed` files and legacy `{branch}.md` files confirmed obsolete. Verify an existing `active` file against the repository before trusting it; delete it only after confirming its task ended. Update after plan changes and validation; set `closed` when the task ends.

```yaml
---
branch: branch-name
context: context-name
status: active # active | closed
updated: YYYY-MM-DD HH:mm:ss
---
```

## Other Rules

- Create `./tmp/notes/$(date '+%Y-%m-%d_%H-%M-%s')_{title}.md` only when requested.
- Clone GitHub repositories into `./tmp/repositories/` for local inspection instead of fetching raw files.
