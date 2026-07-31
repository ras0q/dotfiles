---
name: markdown-explainer
description: Create a standalone Markdown document that helps Japanese readers understand complex source material, technical findings, investigations, comparisons, or plans. Use when the user requests a human-facing explanatory Markdown document rather than a short answer, simple summary, minor rewrite, or formal long-lived documentation. Produce a stable structure, explicit logical relationships, concrete examples, and an optional independent comprehension review for substantial documents.
---

# Markdown Explainer (Japanese)

Create a standalone Markdown document that enables the intended reader to understand the supplied subject.

Optimize for:

1. Correct understanding
2. Stable document structure
3. Low unnecessary reading effort
4. Concise prose and Markdown

Do not optimize for visual novelty, literary style, or long-term maintainability.

## Workflow

1. Inspect the request and supplied material.
2. Resolve material uncertainties with the user.
3. Determine the reader contract.
4. Design the path to understanding.
5. Write the Markdown draft.
6. Review the draft when independent review is useful.
7. Revise only material problems.
8. Return the final Markdown.

Do not expose internal planning or review notes unless requested.

## Clarification gate

Before writing, identify missing information that could materially change the document's accuracy, scope, or usefulness.

Check whether the request and supplied material establish:

- Intended reader and relevant prior knowledge
- Outcome the reader should achieve or decision the document should support
- Subject, central question, and necessary scope boundaries
- Source material that claims must be based on
- Authority among sources when they conflict or serve different purposes
- Constraints that affect correctness, such as required inclusions, exclusions, terminology, or a point-in-time cutoff

Ask the user for unresolved required information in one compact round. Prefer one to three questions by combining closely related items. State briefly why an answer is needed when the effect is not self-evident.

For each question:

- Present two to four numbered, mutually exclusive choices
- Make the choices concrete enough to show their effect on the document
- Include a safe agent-selected default as one choice when the user has no preference
- Mark one choice as recommended only when the request or supplied material provides a basis
- Tell the user to reply with the choice number alone

For multiple questions, restart numbering within each question and ask for a comma-separated sequence in question order, such as `1, 2`. This lets the user answer using numbers only.

Cover the plausible choices without inventing a false binary. If required information cannot be represented by finite choices, such as missing source text or an exact proprietary term, present numbered choices for how to resolve the gap and state the required follow-up action in the option itself.

Always ask before drafting when:

- Required source material is missing or inaccessible
- Multiple plausible readers, outcomes, interpretations, or scope boundaries would produce materially different documents
- The request requires factual accuracy but does not establish which supplied source or date boundary governs disputed or time-sensitive claims
- A missing constraint could cause the document to recommend, omit, or assert the wrong thing

Do not ask:

- For information already stated in the conversation or supplied material
- The user to confirm a reasonable inference when alternatives would not materially change the document
- About stylistic preferences the rules in this skill already determine
- Broad discovery questions when a narrower question can resolve the uncertainty
- Open-ended questions when numbered choices can resolve the uncertainty

Do not begin the draft while a required answer remains unresolved. If only non-material details are unknown, state any consequential assumption concisely and continue.

Example:

```text
作成前に2点確認したい。

質問1: 主な読者
1. 実装担当者 — 実装条件と技術的な因果関係を残す
2. 意思決定者 — 判断材料、影響、制約を中心にする
3. 指定なし（推奨）— 添付資料から最も妥当な読者を推定する

質問2: 「現行仕様」の基準
1. 添付資料 — 添付資料の記述を正とする
2. 最新の公開情報 — 公開情報を調査し、基準日を明記する
3. 指定なし（推奨）— 添付資料を正とし、時点の限界を明記する

`1, 2` のように、質問順の番号だけで回答してほしい。
```

## Reader contract

After resolving material uncertainties, determine:

- Intended reader
- Expected prior knowledge
- Outcome the reader should achieve
- Central claim
- Most likely misunderstanding

Infer values only when the request and supplied material support one materially safe interpretation. Otherwise, use the clarification gate.

Do not classify the document into a named profile.

Do not create a separate planning artifact unless requested.

## Design the path to understanding

Select only the points needed for the reader outcome.

Prefer 3 to 7 essential points.

Arrange them in a sequence such as:

1. Orientation or conclusion
2. Overall structure
3. Causes, mechanisms, or dependencies
4. Concrete application
5. Limitations, misunderstandings, or judgment criteria
6. Retained points

This is a semantic order, not a mandatory heading template.

Omit unnecessary sections. Use subject-specific headings.

## Write the document

Output Markdown only unless the user asks for commentary outside the document.

When writing the output to a Markdown file, ensure its filename begins with the current local date in `YYYY-MM-DD_` format, for example `2026-07-31_project-navigation.md`.

Use:

- One H1
- Headings no deeper than H3
- Paragraphs
- Lists
- Tables
- Blockquotes
- Code fences
- Mermaid diagrams
- Links
- Bold text
- Inline code

Do not use:

- Raw HTML
- Custom CSS
- JavaScript
- Headings deeper than H3
- Lists nested more than two levels
- Bold text as a substitute for headings
- Decorative visual elements

Use tables only for comparison across stable axes.

Use Mermaid only when sequence, hierarchy, dependency, state, or data flow is materially easier to understand as a diagram.

The surrounding prose must remain understandable without rendering the diagram.

## Explanation rules

Write natural and direct Japanese unless another language is requested.

Use plain form (常体), such as 「だ」「である」, rather than polite form (敬体), such as 「です」「ます」.

Do not end Markdown list items with Japanese or English full stops (`。` or `.`).

Begin each major section with, or quickly establish, the proposition the reader should retain. Follow it with reasons, conditions, evidence, or examples.

Make causal and logical relationships explicit.

Use explicit subjects when omission would create ambiguity.

Avoid ambiguous references such as 「これ」「それ」「このこと」when more than one antecedent is possible.

Prefer verbs that expose relationships over long noun chains.

Do not place several independent logical relationships in one sentence.

Introduce terminology when it becomes necessary. Do not begin with a large glossary unless terminology is itself the subject.

When an English term and its Japanese translation have different scopes, include the English term at first use.

Use emphasis sparingly. Scanning only the bold text must not distort the argument.

Avoid unsupported evaluative words such as 「重要」「本質的」「非常に」. State the effect, affected party, and conditions instead.

## Cognitive rhythm

Avoid a continuous sequence of similarly dense paragraphs.

When several dense paragraphs create sustained cognitive load, use one appropriate structural break:

- A short proposition
- A concrete example
- A compact list
- A comparison table
- A Mermaid diagram

Use structural variation only when it reduces reading effort.

When raising a question, objection, or promise, resolve it later.

Connect an enumeration to an example, consequence, or judgment criterion.

## Document narration

Remove sentences that describe only the progress of the document.

Avoid phrases such as:

- 「本節では」
- 「以下では」
- 「次に見ていく」
- 「ここまで見てきた」
- 「詳しく説明する」
- 「理解を深めるために」
- 「まず結論から述べると」

Replace them with propositions about the subject.

Bad:

> 次に、Markdownの再現性について説明する。

Better:

> Markdownは表示規則をViewerへ委譲するため、生成側が決定する変数を減らせる。

## Concrete examples

Add a concrete example when an important abstraction, distinction, or causal claim would otherwise remain difficult to verify.

A useful example should normally identify:

- Initial situation
- Operation or change
- Observable result
- Relationship between the result and the preceding explanation

Prefer one worked example over several shallow examples.

Do not add an example when the claim is already concrete and immediately observable.

## Ending

End with 3 to 5 propositions the reader should retain when doing so materially improves recall, judgment, or later action.

Do not summarize the progression of the document.

Bad:

- MarkdownとHTMLについて説明した
- 再現性について確認した

Better:

- Markdownは表示をViewerに委譲することで、生成側が決定する変数を減らせる
- 構造の一貫性は、表現の類似性よりも命題の順序と配置に依存する

For a short document, omit the final retained-points section when it would merely repeat the body.

## Decide whether to use a subagent

Use one subagent when at least one of the following applies:

- The draft is roughly 1,000 Japanese characters or longer; treat this as a heuristic, not a strict threshold
- It contains multiple causal or logical dependencies
- It explains an abstract technical concept
- It presents judgment or decision criteria
- Misunderstanding could cause a materially incorrect action or decision

Do not use a subagent for:

- A short explanation
- A simple list
- A three-step procedure
- A minor rewrite
- A lightweight draft where the user prioritizes speed

## Subagent review contract

Ask the subagent to perform an independent comprehension review, not a rewrite.

Provide:

- The complete draft
- Intended reader
- Expected prior knowledge
- Reader outcome
- Most likely misunderstanding
- Intended central claim

A material issue is a problem likely to cause the intended reader to:

- Misunderstand the central claim
- Miss a necessary logical dependency
- Make an incorrect judgment or action
- Spend substantial effort resolving avoidable ambiguity

The following are not material by themselves:

- Stylistic preference
- Optional wording improvement
- Lack of a diagram when prose is sufficient
- Lack of an example for an already concrete claim
- A heading that could merely be more elegant
- Minor repetition that does not affect understanding

## Subagent procedure

Instruct the subagent to perform these steps:

1. Infer the central claim from the opening before comparing it with the supplied intended central claim.
2. Compare the inferred and intended central claims.
3. Read the complete draft.
4. Inspect the document for material comprehension problems.
5. Return only concrete findings.

The subagent must not reinterpret an unclear opening merely to make it agree with the intended central claim.

The subagent must inspect:

- Whether the opening supports one clear reconstruction of the central claim
- Whether each section has a coherent purpose
- Whether multiple functions inside a section are explicitly connected
- Whether necessary causal steps or logical dependencies are missing
- Whether pronouns, omitted subjects, or referents are materially ambiguous
- Whether important abstractions have a concrete example or observable consequence when needed
- Whether questions, objections, or promises remain unresolved
- Whether headings, lists, tables, and diagrams serve clear functions
- Whether any sentence narrates document progression instead of explaining the subject
- Whether any section or passage exists only because of an assumed template
- Whether removable content creates substantial reading effort without improving understanding

Do not fact-check the subject matter unless:

- The draft contradicts itself, or
- The draft contradicts supplied source material

Do not use external knowledge as the sole basis for a finding.

Merge findings that share the same underlying cause.

Return no more than five findings, ordered by impact on reader understanding.

Use exactly this format:

```text
- Location:
  Problem:
  Required correction:
```

In `Required correction`, state the missing information, relationship, or outcome that the revision must achieve.

Do not:

- Supply replacement prose
- Rewrite a section
- Propose a new document structure unless the existing structure causes a material issue
- Report cosmetic or preference-based changes

If there are no material issues, return exactly:

```text
No material issues.
```

## Revision

Revise only the material issues identified by the subagent.

Preserve unaffected structure and wording.

Do not automatically accept a finding when it conflicts with supplied source material or the user request.

Do not add a section, table, example, or diagram solely because it could be useful. Add it only when needed to resolve a material issue.

## Fallback review

If no subagent capability is available, perform a separate second-pass review using the same materiality definition and checklist.

Treat the draft as fixed input during that pass.

Do not claim that an independent subagent performed the review.

## Final check

Before returning the document, verify:

- Exactly one H1
- No heading deeper than H3
- No raw HTML
- Japanese prose uses plain form rather than polite form
- No Markdown list item ends with `。` or `.`
- A Markdown output filename begins with the current local date in `YYYY-MM-DD_` format
- No unresolved question, objection, or promise
- No narration about document progression
- No materially ambiguous referent
- No unnecessary section created by an assumed template
- Final retained points, when present, are propositions rather than chapter summaries

Return the final Markdown document.
