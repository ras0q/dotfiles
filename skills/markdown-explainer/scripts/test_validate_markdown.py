#!/usr/bin/env python3
"""Unit tests for deterministic Markdown validation."""

from __future__ import annotations

import unittest

from validate_markdown import validate_markdown


class ValidateMarkdownTest(unittest.TestCase):
    """Verify supported constraints without depending on filesystem state."""

    def test_accepts_valid_markdown_and_ignores_fenced_examples(self) -> None:
        """Accept valid output even when a code fence contains forbidden syntax."""
        markdown = """# Title

## Structure

- Item

```markdown
#### Example
<div>example</div>
- Sentence.
```
"""

        self.assertEqual(
            [],
            validate_markdown(
                markdown,
                "2026-07-31_valid.md",
                check_filename=True,
            ),
        )

    def test_reports_each_supported_content_violation(self) -> None:
        """Report heading, HTML, punctuation, and H1-count failures together."""
        markdown = """# First
# Second

#### Too deep

<div>raw</div>

- Ends here。
"""

        messages = [
            finding.message
            for finding in validate_markdown(markdown, "invalid.md")
        ]

        self.assertIn("heading depth must not exceed H3", messages)
        self.assertIn("raw HTML is not allowed", messages)
        self.assertIn(
            "Markdown list items must not end with a full stop",
            messages,
        )
        self.assertTrue(
            any(message.startswith("document must contain exactly one H1") for message in messages)
        )

    def test_checks_output_filename_only_when_requested(self) -> None:
        """Keep filename validation optional for temporary semantic-review drafts."""
        markdown = "# Title\n"

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


if __name__ == "__main__":
    unittest.main()
