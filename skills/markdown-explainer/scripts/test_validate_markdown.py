#!/usr/bin/env python3
"""Unit tests for deterministic Markdown validation."""

from __future__ import annotations

import unittest

from validate_markdown import CREDIT_LINE, validate_markdown

CREDIT_BLOCK = f"\n{CREDIT_LINE}\n"


class ValidateMarkdownTest(unittest.TestCase):
    """Verify supported constraints without depending on filesystem state."""

    def test_accepts_valid_markdown_and_ignores_fenced_examples(self) -> None:
        """Accept valid output even when a code fence contains forbidden syntax."""
        markdown = f"""## Title

Opening sentence.

## Structure

- Item

```markdown
# Example
#### Example
<div>example</div>
- Sentence.
これは例だ。
```
{CREDIT_BLOCK}"""

        self.assertEqual(
            [],
            validate_markdown(
                markdown,
                "2026-07-31_valid.md",
                check_filename=True,
            ),
        )

    def test_reports_each_supported_content_violation(self) -> None:
        """Report heading, HTML, punctuation, and H1 failures together."""
        markdown = f"""# First
# Second

#### Too deep

<div>raw</div>

- Ends here。
{CREDIT_BLOCK}"""

        messages = [
            finding.message
            for finding in validate_markdown(markdown, "invalid.md")
        ]

        self.assertIn("H1 is not allowed", messages)
        self.assertIn("heading depth must not exceed H3", messages)
        self.assertIn("raw HTML is not allowed", messages)
        self.assertIn(
            "Markdown list items must not end with a full stop",
            messages,
        )
        self.assertIn("document must start with an H2", messages)

    def test_checks_output_filename_only_when_requested(self) -> None:
        """Keep filename validation optional for temporary semantic-review drafts."""
        markdown = f"## Title\n\n本文\n{CREDIT_BLOCK}"

        unchecked = validate_markdown(markdown, "draft.md")
        checked = validate_markdown(
            markdown,
            "draft.md",
            check_filename=True,
        )

        self.assertEqual([], unchecked)
        self.assertEqual(
            ["output filename must match YYYY-MM-DD_*.md"],
            [finding.message for finding in checked],
        )

    def test_rejects_sentence_final_da_outside_fences(self) -> None:
        """Reject だ。 in prose while ignoring the same sequence inside a fence."""
        markdown = f"""## Title

これは例だ。

```text
フェンス内は例外だ。
```
{CREDIT_BLOCK}"""

        self.assertEqual(
            ["sentence-final だ。 is not allowed"],
            [finding.message for finding in validate_markdown(markdown, "draft.md")],
        )

    def test_requires_trailing_credit_line(self) -> None:
        """Require the verbatim markdown-explainer credit as the last line."""
        markdown = "## Title\n\n本文\n"

        self.assertEqual(
            [f"document must end with the credit line: {CREDIT_LINE}"],
            [finding.message for finding in validate_markdown(markdown, "draft.md")],
        )

    def test_rejects_heading_full_stop_link_skip_and_stack(self) -> None:
        """Reject heading punctuation, links, skipped levels, and stacked headings."""
        markdown = f"""## Title。

## Next

#### [skip](https://example.com)

text
{CREDIT_BLOCK}"""

        messages = [
            finding.message
            for finding in validate_markdown(markdown, "draft.md")
        ]

        self.assertIn("headings must not end with a full stop", messages)
        self.assertIn("heading must be followed by body text", messages)
        self.assertIn("heading levels must not skip", messages)
        self.assertIn("headings must not contain links", messages)


if __name__ == "__main__":
    unittest.main()
