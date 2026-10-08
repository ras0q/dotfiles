---
name: markdown-explainer
description: Create concise, disposable Markdown notes for personal understanding, especially project overviews and processing flows. Use when a Japanese reader needs to grasp complex source material, technical findings, investigations, comparisons, plans, or the current state of a project or repository through a clear outcome, explicit logical relationships, and selective examples. Do not use for short answers, minor rewrites, exhaustive specifications, API references, or documents whose primary purpose is long-term maintenance.
---

# Markdown Explainer

Japanese translation: `SKILL.ja.md`. Follow this English file.

Write one standalone Markdown note that lets the intended reader reach a correct understanding with minimal rereading. The usual reader is the author returning to a project overview or processing flow later; the note is disposable, not a permanent project guide.

Optimize for the requested reader outcome and the supplied evidence. Do not optimize for coverage, decoration, or later maintenance unless asked.

Do not use this skill for a short chat answer, a minor rewrite, a specification, an API reference, or a document whose main job is long-term maintenance.

## Workflow

1. Inspect the request and the supplied material
2. Fix the evidence boundary and the reader contract
3. Ask only when a gap would change accuracy, scope, or usefulness
4. Keep three to seven points and order them for orientation, model, dependencies, application, and limits
5. Write the file
6. Run the validator. Review meaning only when a miss would be costly
7. Fix material problems
8. Return the path. Ask whether to open the file. Open it only after yes

Do not show planning or review notes unless asked.

## Decide before writing

Evidence is the supplied sources and the current checkout. Treat the repo as a snapshot, not a promise. Separate supported facts from inferences. Mention a commit, branch, date, or cutoff only when it is known or a reader would otherwise misread the present tense. Keep provenance to that minimum.

The reader contract is the intended reader, prior knowledge, one observable outcome, the central model, and the most likely costly misunderstanding. An outcome is something the reader can explain, locate, compare, judge, or do. Infer a safe contract when the request already supports one.

Ask in one round, at most three questions, each with two to four exclusive numbered choices and a safe default. Recommend a choice only when the material supports it. Accept answers as choice numbers. Do not ask about facts already given, harmless inferences, or style this skill already fixes. If the rest is not material, state the assumption in one line and continue.

## Shape the explanation

Keep only what the outcome needs. Headings are outline labels. Omit a section that does not move the outcome.

Heading form is fixed by section type, and the same level stays parallel:

- Title and explanation: a 体言止め noun phrase that names the topic and the point. Do not start with 「〜について」. Do not end with 「概要」 or 「はじめに」 alone
- Procedure: start with a verb
- Question: only for FAQ, or when a noun phrase would hide the actual query

Do not put a complete 「である」 sentence in a heading. That sentence is the lead.

A section is three layers: heading, one lead sentence that states the retained proposition, then supplements whose relations are visible.

After the lead, pick the form by relation:

- Three or more parallel items of the same grain: bullets
- Sequence, steps, or priority: numbered list
- Several names with roles or meanings: run-in bullets, `語: 句`
- Comparison on stable axes: a small table
- Sequence, hierarchy, dependency, state, or data flow that prose cannot show: Mermaid
- Anything else: a short paragraph

Escalate only when the relation is clear. Introduce a list or table with a complete sentence. Do not make a one-item list, a one-column table, or a blockquote used as a notice. Quote only external wording.

One idea per paragraph. Prefer one worked path over a shallow inventory. Add one example only when an abstraction, distinction, or cause would otherwise be hard to check. Name the starting state, the change, the observable result, and the link to the claim.

Drop a detail if the reader can still reach the outcome, rebuild the model, reuse the method, and avoid the likely costly mistake.

Close with three to five decision rules or capabilities only when they help later action. Do not recap the document. Omit the close when it would only repeat the body.

When the source is DDL, Flyway, or comment-heavy schema notes, treat co-released files as one change. Lead with the delta and the invariant. Reprint a post-change `CREATE TABLE`, EXPLAIN, or QPS only when the outcome is capacity or index judgment. FYI links are provenance. For history and triggers, state why they follow the parent columns. Do not re-list every column.

When the outcome is current project understanding, open with what the system does, who the reader is, and what they should be able to trace or judge. Explain the boundary before internals. Tie a part to a responsibility and a decision. Show one path from an entry point to an effect when that path teaches the next one. Prefer navigation rules over feature lists. Add setup, checks, or safety only when they serve the outcome. Explain the authorized snapshot, not a permanent handbook.

## Write the file

Write to `./tmp/notes/YYYY-MM-DD_{title}.md` after `mkdir -p ./tmp/notes/`. Use the first H2 heading for `{title}` and preserve Japanese characters. Remove Markdown markup and replace spaces or path separators with hyphens. Example: `## 認証処理の流れ` becomes `./tmp/notes/2026-09-04_認証処理の流れ.md`. Do not put the long Markdown in chat unless asked for commentary.

Output Markdown only, unless the user asks for a separate comment.

Constraints:

- No H1. The first H2 is the note title and supplies the dated filename. Then use H2 sections and H3 subsections. Do not skip a level or go past H3
- A heading is followed by body. Do not stack headings. No link in a heading
- A heading does not end with `。` or `.`. `?` only on a question heading
- Direct Japanese in plain form unless another language or style is asked
- Sentence ends with 「である」 or a verb. No sentence-final 「だ。」
- List items do not end with `。` or `.`. Keep them short and parallel
- No raw HTML, custom CSS, JavaScript, decoration, or lists nested more than two levels
- Bold only when scanning the bold text still preserves the argument
- A diagram or table has a one-sentence reading next to it. Prose remains readable without the figure
- After a blank line, end with this credit as the last non-empty line:

```
written by [markdown-explainer](https://github.com/ras0q/dotfiles/tree/main/skills/markdown-explainer)
```

Keep the subject near the verb. Do not stack 「の」 three times. Split a long 連体修飾 or turn it into a list. Prefer a verb over a nominalization. Use a demonstrative only when the antecedent is unique. Do not combine independent relations in one sentence.

After inline code, a kind noun from the source is an optional aid, not a required label. Add it only when the role would otherwise be unclear, for example `` `users` テーブル ``. Omit it when the surrounding words already make the role clear. Do not invent a kind.

Introduce a term when it is needed. Add the English form at first use when its scope differs. Do not open with a glossary unless terms are the subject.

State effect, who is affected, and the condition. Do not use unsupported evaluations such as 「重要」「本質的」「非常に」. Do not narrate the document with 「本節では」 or 「次に見ていく」.

```markdown
## 紅茶の湯温と味の関係

紅茶の味は、湯温、時間、茶葉の量で決まる。

味を変える条件は次である。

- 湯温: 抽出の強さ
- 時間: 渋みの出方
- 茶葉の量: 濃さ
```

## Check and return

From this skill directory:

```bash
python3 scripts/validate_markdown.py --check-filename <output.md>
```

Fix every validator finding first. For a draft whose filename is not the output, omit `--check-filename`.

Use one subagent only when dependencies are complex or a wrong reading would be costly. Skip it for a short note, a simple list, a short procedure, a minor rewrite, or a speed-first draft. Give the full draft, evidence, contract, model, and likely miss. Ask for at most five findings, not replacement prose. Do not ask the reviewer to check what the validator already owns.

A finding is material only when it would make the reader miss the model or the evidence boundary, drop a needed dependency, miss the outcome, misapply the method, spend substantial effort on avoidable ambiguity, or reread to find an answer that belonged in the lead sentence. Revise only those findings.

If no subagent is available, do the same pass yourself without claiming independence.

Return the output path and a brief summary. The document lives at that path.
