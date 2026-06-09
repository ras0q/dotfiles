# Handoff Templates

Replace placeholders and drop sections that do not help.

## First Handoff

```text
Objective: <single concrete outcome>

Context:
- Repo: <path>
- Files: <paths>
- Constraints: <decisions already made>

Instructions:
1. Inspect relevant code before editing.
2. Implement only the objective.
3. Keep the diff minimal.
4. If ambiguous, stop and report the blocking question.

Verification: Run <command>, or explain why you cannot.

Return: summary, files changed, verification results, risks or questions
```

## Investigation

```text
Question: <bug or behavior to explain>
Scope: inspect only <paths>
Do not edit files.

Return: root cause, evidence with file refs, smallest fix, risks
```

## Revision

```text
Required changes:
1. <correction>
2. <correction>

Do not expand scope.

Verification: Run <command>

Return: delta from last patch, verification, unresolved items
```

## Review Only

```text
Review without editing unless a fix is explicitly requested.

Check: correctness, regressions, missing tests, scope creep

Return: findings by severity, file refs, open questions, acceptable as-is?
```

## Checkpoint

```text
Learned: <fact>
Changed: <implemented change>
Next: <smallest next task>
```
