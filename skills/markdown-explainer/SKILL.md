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

Use subject-specific headings and omit sections that do not advance the reader outcome.

Begin each major section with its retained proposition, then support it with reasons, conditions, evidence, or examples. Make causal and logical relationships explicit.

Prefer one reusable method or worked path over an inventory of shallow facts. Add a concrete example when an important abstraction, distinction, or causal claim would otherwise be hard to verify.

Remove a detail when omitting it would not prevent the reader from:

- Reaching the observable outcome
- Reconstructing the central model
- Applying the demonstrated method
- Avoiding a likely consequential mistake

End with three to five retained propositions only when they improve recall, judgment, or later action. Do not summarize the document's progression.

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

Output Markdown only unless the user requests separate commentary.

When writing a file, prefix its name with the current local date in `YYYY-MM-DD_` format.

Apply these constraints:

- Use exactly one H1 and no heading deeper than H3
- Use direct Japanese in plain form unless another language or style is requested
- Do not end Markdown list items with `。` or `.`
- Do not use raw HTML, custom CSS, JavaScript, decorative elements, or lists nested beyond two levels
- Use tables only for comparison across stable axes
- Use Mermaid only when it materially clarifies sequence, hierarchy, dependency, state, or data flow
- Keep surrounding prose understandable without rendered diagrams

Avoid ambiguous referents, omitted subjects that obscure meaning, long noun chains, and sentences that combine independent logical relationships. Introduce terminology when needed and include an English term at first use when its scope differs from the Japanese translation.

State effects, affected parties, and conditions instead of unsupported evaluations such as 「重要」「本質的」「非常に」.

Remove narration about document progression, such as 「本節では」 or 「次に見ていく」. State propositions about the subject instead.

## Review selectively

Before semantic review, run the bundled deterministic validator against file output:

```bash
python3 scripts/validate_markdown.py --check-filename <output.md>
```

Resolve the script path relative to this skill directory. Correct every reported violation before requesting semantic review. For temporary drafts whose filename is not part of the output, omit `--check-filename`.

Use one subagent only when the draft has complex dependencies or supports a high-consequence judgment and an independent comprehension review would materially reduce risk. Skip review for short explanations, simple lists or procedures, minor rewrites, and speed-prioritized drafts.

Give the reviewer the complete draft, evidence boundary, reader contract, central model, and likely misunderstanding. Ask for at most five concrete findings, not replacement prose.

Do not ask the reviewer to inspect H1 count, heading depth, raw HTML, list-item punctuation, or output filename. The bundled validator owns those mechanical checks.

Treat an issue as material only when it could cause the reader to:

- Misunderstand the central model or evidence boundary
- Miss a necessary dependency
- Fail to reach the observable outcome
- Apply the demonstrated method incorrectly
- Spend substantial effort resolving avoidable ambiguity

Do not treat stylistic preferences, optional enhancements, or missing reference detail as material.

Revise only supported material findings and preserve unaffected content. If no subagent is available, perform the same review as a separate second pass without claiming independence.

## Final check

Before returning the document, verify the mechanical constraints and confirm that:

- The bundled validator passes
- The opening establishes one clear reader outcome and central model
- The evidence boundary is accurate and no unsupported current-state claim remains
- No necessary logical dependency is missing
- Every section advances the reader outcome
- Representative examples teach a reusable relationship or method
- Reference detail has not displaced the primary path to understanding
- No material ambiguity or unresolved promise remains
- Any final retained points are propositions rather than chapter summaries

Return the final Markdown document.
