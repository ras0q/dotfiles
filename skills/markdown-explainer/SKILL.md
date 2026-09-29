---
name: markdown-explainer
description: Create concise, standalone Markdown documents that help Japanese readers understand complex source material, technical findings, investigations, comparisons, plans, or the current state of a project or repository. Use for human-facing explanations and onboarding overviews that need a clear reader outcome, explicit logical relationships, and selective examples. Do not use for short answers, minor rewrites, exhaustive specifications, API references, or documents whose primary purpose is long-term maintenance.
---

# Markdown Explainer

Create a standalone explanation that gives the intended reader a correct understanding with minimal reading effort.

Optimize for the reader's requested outcome and the current supplied evidence. Do not optimize for exhaustive coverage, visual novelty, or future maintainability unless the user requests them.

## Workflow

1. Inspect the request and supplied material
2. Establish the evidence boundary and reader contract
3. Resolve only material uncertainties
4. Select and order the essential points
5. Write the Markdown
6. Review independently only when it materially reduces risk
7. Correct material problems and return the document
8. After writing a file, ask whether to open it with the default application

Do not expose planning or review notes unless requested.

## Establish the evidence boundary

Determine which supplied sources and checked-out state govern the explanation. Treat repository content as a current snapshot rather than a promise about future behavior.

Distinguish facts supported by the supplied material from inferences. State a commit, branch, date, or other cutoff only when it is supplied, discoverable from the authorized sources, or necessary to prevent a material misunderstanding.

Do not turn evidence provenance into a long preamble. Mention only the boundary needed for the reader to interpret the document correctly.

## Establish the reader contract

Determine:

- Intended reader
- Relevant prior knowledge
- Observable outcome after reading
- Central model or claim that supports that outcome
- Most likely consequential misunderstanding

An observable outcome states what the reader should be able to explain, locate, compare, judge, or perform. Prefer a concrete capability over a broad goal such as “understand the project.”

Infer the contract when the request and supplied material support one materially safe interpretation.

## Resolve material uncertainties

Ask before drafting only when missing information could materially change accuracy, scope, or usefulness. Typical blockers include missing required sources, conflicting source authority, materially different readers or outcomes, ambiguous scope, and an unspecified cutoff for time-sensitive claims.

Ask all unresolved questions in one compact round:

- Ask one to three questions
- Give each question two to four numbered, mutually exclusive choices
- Include a safe agent-selected default when possible
- Mark a recommendation only when the supplied material supports it
- Let the user answer with the choice numbers alone

Do not ask about established facts, harmless inferences, or stylistic choices fixed by this skill. If remaining uncertainty is not material, state any consequential assumption briefly and continue.

## Design the explanation

Use only the points necessary for the observable reader outcome, normally three to seven. Order them so the orientation, central model, dependencies, concrete application, and limitations become clear when relevant. Do not turn this sequence into a fixed heading template.

Headings are outline labels, not restated body sentences. Omit sections that do not advance the reader outcome.

Choose heading form by section type, and keep the same form for all headings at one level:

- Document title (first heading) and explanation sections: a noun phrase that names the topic and the point, in 体言止め. Do not start with 「〜について」or end with a generic word such as 「概要」or 「はじめに」alone
- Procedure sections: start with a verb
- Questions: only for FAQ, or when a noun phrase would hide the reader's actual query

Do not write a complete 「である」sentence as a heading. Put that proposition in the first sentence after the heading.

Begin each major section with the retained proposition as the first sentence. Then support it with reasons, conditions, evidence, or examples. Make causal and logical relationships explicit.

Keep one idea per paragraph. Move a second idea to the next paragraph or to a list. Use a list when three or more items are parallel.

Prefer one reusable method or worked path over an inventory of shallow facts. When an important abstraction, distinction, or causal claim would otherwise be hard to verify, add one concrete example that names:

- Initial situation
- Operation or change
- Observable result
- Relationship to the preceding claim

Prefer one worked example over several shallow examples. Do not add an example when the claim is already concrete and immediately observable.

When several similarly dense paragraphs would sustain reading load, insert one structural break: a short proposition, a concrete example, a compact list, a comparison table, or a Mermaid diagram. Use variation only when it reduces reading effort.

Remove a detail when omitting it would not prevent the reader from:

- Reaching the observable outcome
- Reconstructing the central model
- Applying the demonstrated method
- Avoiding a likely consequential mistake

End with three to five retained propositions only when they improve recall, judgment, or later action. Write them as decision rules or capabilities, not as a summary of the document's progression. If the outcome is an operation, state what the reader can do. Omit the closing list when it would only repeat the body.

### Schema and migration sources

When the source is DDL, Flyway, or comment-heavy schema notes:

- Treat co-released migrations as one change, not one file per section
- Lead with the delta and the invariant the reader must keep (amount, state, ownership)
- Reprint a post-change `CREATE TABLE`, EXPLAIN plan, or expected QPS only when the reader outcome is capacity or index judgment
- Treat FYI links as provenance, not as the central model
- For history tables and triggers, state why they must follow the parent columns. Do not re-list every column

## Explain a current project or repository

When the requested outcome is current project understanding or onboarding:

- Establish within the opening what the project does, who the explanation is for, and what the reader should be able to trace or judge after reading
- Explain the system boundary before internal components
- Tie each directory, module, or component to a responsibility and a decision the reader may need to make
- Show one representative path from an entry point to its observable effect when it teaches how to investigate similar paths
- Prefer navigation rules and dependency relationships over exhaustive lists of features, providers, endpoints, or exceptions
- Include setup, verification, safety constraints, or completion criteria only when they contribute to the requested reader outcome
- Keep advanced operational and domain details out unless they are required to explain the central model or prevent a consequential mistake

Do not assume that an onboarding document must become a permanent reference. Explain the authorized current state and make the snapshot boundary clear enough for the immediate purpose.

## Write the Markdown

Write the explanation to `./tmp/notes/YYYY-MM-DD_{title}.md`. Run `mkdir -p ./tmp/notes/` first. Do not substitute long Markdown in chat when this skill applies.

Output path rules:

- Prefix with the current local date in `YYYY-MM-DD_` format
- Use a short kebab-case `{title}` describing the subject
- Example: `./tmp/notes/2026-09-04_tea-steeping-temperature.md`

Output Markdown only unless the user requests separate commentary.

After writing the file, ask the user whether to open it with the default application. If they agree, open it with the OS default handler. Do not open it without confirmation.

Apply these constraints:

- Do not use H1. Start with an H2 title, then H2 sections and H3 subsections. Do not skip levels or go deeper than H3
- Follow a heading with body text. Do not stack headings
- Do not put a link in a heading
- Do not end a heading with `。` or `.`. Use `?` only on a question heading
- Use direct Japanese in plain form unless another language or style is requested
- End sentences with 「である」or a verb. Do not use sentence-final 「だ。」
- Do not end Markdown list items with `。` or `.`
- Do not use raw HTML, custom CSS, JavaScript, decorative elements, or lists nested beyond two levels
- Use tables only for comparison across stable axes
- Use Mermaid only when it materially clarifies sequence, hierarchy, dependency, state, or data flow
- Place a one-sentence reading of a diagram or table immediately before or after it
- Keep surrounding prose understandable without rendered diagrams
- Use bold sparingly. Scanning only the bold text must not distort the argument
- End the document with the credit line below, as the last non-empty line, after a blank line

Credit line, verbatim:

```
written by [markdown-explainer](https://github.com/ras0q/dotfiles/tree/main/skills/markdown-explainer)
```

Avoid ambiguous referents, omitted subjects that obscure meaning, long noun chains, and sentences that combine independent logical relationships. Keep the subject near the verb. Do not stack 「の」three or more times. Split a long 連体修飾 clause or turn it into a list. Prefer a verb over a nominalization. Use a demonstrative only when the antecedent is unique. Keep list items short and parallel; do not use a list as a container for long sentences.

Introduce terminology when needed and include an English term at first use when its scope differs from the Japanese translation. Do not begin with a large glossary unless terminology is itself the subject.

State effects, affected parties, and conditions instead of unsupported evaluations such as 「重要」「本質的」「非常に」.

Remove narration about document progression, such as 「本節では」 or 「次に見ていく」. State propositions about the subject instead. Do not announce 「まず結論から述べると」. Putting the answer in the first sentence is enough.

Write like this, not like a packed clause:

```markdown
## 単語だけ
紅茶

## 完結文は本文へ
紅茶の味は湯の温度で決まる。

## 説明見出し
紅茶の湯温と味の関係

紅茶の味は湯の温度で決まる。

## 手順見出し
茶葉を計って湯を注ぐ
```

## Review selectively

Before semantic review, run the bundled deterministic validator against file output:

```bash
python3 scripts/validate_markdown.py --check-filename <output.md>
```

Resolve the script path relative to this skill directory. Correct every reported violation before requesting semantic review. For temporary drafts whose filename is not part of the output, omit `--check-filename`.

Use one subagent only when the draft has complex dependencies or supports a high-consequence judgment and an independent comprehension review would materially reduce risk. Skip review for short explanations, simple lists or procedures, minor rewrites, and speed-prioritized drafts.

Give the reviewer the complete draft, evidence boundary, reader contract, central model, and likely misunderstanding. Ask for at most five concrete findings, not replacement prose.

Do not ask the reviewer to inspect H1 absence, H2 start, heading depth, heading punctuation, heading links, stacked headings, raw HTML, list-item punctuation, sentence-final 「だ。」, the credit line, or output filename. The bundled validator owns those mechanical checks.

Treat an issue as material only when it could cause the reader to:

- Misunderstand the central model or evidence boundary
- Miss a necessary dependency
- Fail to reach the observable outcome
- Apply the demonstrated method incorrectly
- Spend substantial effort resolving avoidable ambiguity
- Reread a sentence or hunt for an answer that should have been in the first sentence after a heading

Do not treat stylistic preferences, optional enhancements, or missing reference detail as material.

Revise only supported material findings and preserve unaffected content. If no subagent is available, perform the same review as a separate second pass without claiming independence.

## Final check

Before returning the document, verify the mechanical constraints and confirm that:

- The bundled validator passes
- The opening establishes one clear reader outcome and central model
- The evidence boundary is accurate and no unsupported current-state claim remains
- No necessary logical dependency is missing
- Every section advances the reader outcome
- Headings form a noun-phrase or verb-phrase outline, and first sentences carry the propositions
- Representative examples teach a reusable relationship or method
- Schema explanations lead with the delta and invariant, not a reprinted post-image
- Reference detail has not displaced the primary path to understanding
- No material ambiguity or unresolved promise remains
- Any final retained points are propositions rather than chapter summaries
- The last non-empty line is the credit

Return the output path and a brief summary. The document lives at the output path.
