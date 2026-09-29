#!/usr/bin/env python3
"""Validate deterministic Markdown constraints for markdown-explainer output."""

from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable


ATX_HEADING_PATTERN = re.compile(r"^\s*(#{1,6})\s+(.*\S)\s*$")
FENCE_PATTERN = re.compile(r"^\s*(`{3,}|~{3,})")
LIST_ITEM_PATTERN = re.compile(r"^\s*(?:[-+*]|\d+[.)])\s+(.+?)\s*$")
OUTPUT_FILENAME_PATTERN = re.compile(r"^\d{4}-\d{2}-\d{2}_.+\.md$")
SETEXT_H1_PATTERN = re.compile(r"^\s*=+\s*$")
THEMATIC_BREAK_PATTERN = re.compile(r"^\s*(-{3,}|\*{3,}|_{3,})\s*$")
HEADING_LINK_PATTERN = re.compile(r"\[[^\]]*\]\([^)]*\)")
DA_PERIOD_PATTERN = re.compile(r"だ。")
CREDIT_LINE = (
    "written by [markdown-explainer]"
    "(https://github.com/ras0q/dotfiles/tree/main/skills/markdown-explainer)"
)
HTML_TAG_PATTERN = re.compile(
    r"</?(?:a|article|aside|blockquote|br|code|details|div|em|footer|h[1-6]|"
    r"header|hr|img|li|main|ol|p|pre|section|span|strong|summary|table|tbody|"
    r"td|th|thead|tr|ul)\b[^>]*>",
    re.IGNORECASE,
)


@dataclass(frozen=True)
class Finding:
    """Describe one deterministic validation failure.

    Attributes:
        source: Human-readable input identifier, usually the Markdown path.
        line_number: One-based line number, or zero for a file-level failure.
        message: Concise statement of the violated output constraint.
    """

    source: str
    line_number: int
    message: str

    def format(self) -> str:
        """Return a compiler-style finding suitable for terminal output."""
        if self.line_number:
            return f"{self.source}:{self.line_number}: {self.message}"
        return f"{self.source}: {self.message}"


def content_lines(markdown: str) -> Iterable[tuple[int, str]]:
    """Yield lines that are outside fenced code blocks.

    Args:
        markdown: Complete Markdown source text.

    Yields:
        Pairs containing a one-based line number and the original line.

    Constraints:
        Backtick and tilde fences of at least three characters are recognized.
        A closing fence must use the same marker and at least the opening length.
        Indented code blocks are not interpreted because the skill emits fenced
        blocks for code examples.
    """
    fence_marker: str | None = None
    fence_length = 0

    for line_number, line in enumerate(markdown.splitlines(), start=1):
        match = FENCE_PATTERN.match(line)
        if match:
            marker = match.group(1)
            if fence_marker is None:
                fence_marker = marker[0]
                fence_length = len(marker)
            elif marker[0] == fence_marker and len(marker) >= fence_length:
                fence_marker = None
                fence_length = 0
            continue

        if fence_marker is None:
            yield line_number, line


def validate_markdown(
    markdown: str,
    source: str,
    *,
    check_filename: bool = False,
) -> list[Finding]:
    """Validate mechanical constraints without judging document meaning.

    Args:
        markdown: Complete Markdown source text to validate.
        source: Human-readable identifier included in each finding.
        check_filename: Whether `source` must use the dated Markdown filename
            convention required for file output.

    Returns:
        All deterministic findings in source order. An empty list means the
        supported mechanical constraints passed.

    Checks:
        No H1, first heading is H2, no ATX heading deeper than H3, no skipped
        heading level, no stacked headings, no heading full stop or link, no
        common raw HTML tags, no list item ending in a Japanese or English full
        stop, no sentence-final 「だ。」, a trailing markdown-explainer credit
        line, and optionally a `YYYY-MM-DD_*.md` filename.
    """
    findings: list[Finding] = []
    heading_levels: list[tuple[int, int]] = []
    previous_content: tuple[int, str] | None = None
    last_content: tuple[int, str] | None = None
    pending_heading: int | None = None

    if check_filename and not OUTPUT_FILENAME_PATTERN.fullmatch(Path(source).name):
        findings.append(
            Finding(
                source,
                0,
                "output filename must match YYYY-MM-DD_*.md",
            )
        )

    for line_number, line in content_lines(markdown):
        heading_match = ATX_HEADING_PATTERN.match(line)
        if heading_match:
            depth = len(heading_match.group(1))
            heading_text = heading_match.group(2).rstrip()
            if pending_heading is not None:
                findings.append(
                    Finding(
                        source,
                        line_number,
                        "heading must be followed by body text",
                    )
                )
            if depth == 1:
                findings.append(Finding(source, line_number, "H1 is not allowed"))
            if depth > 3:
                findings.append(
                    Finding(source, line_number, "heading depth must not exceed H3")
                )
            if heading_levels and depth > heading_levels[-1][1] + 1:
                findings.append(
                    Finding(source, line_number, "heading levels must not skip")
                )
            if heading_text.endswith(("。", ".")):
                findings.append(
                    Finding(
                        source,
                        line_number,
                        "headings must not end with a full stop",
                    )
                )
            if HEADING_LINK_PATTERN.search(heading_text):
                findings.append(
                    Finding(source, line_number, "headings must not contain links")
                )
            heading_levels.append((line_number, depth))
            pending_heading = line_number

        if (
            previous_content is not None
            and SETEXT_H1_PATTERN.fullmatch(line)
            and previous_content[1].strip()
        ):
            findings.append(Finding(source, previous_content[0], "H1 is not allowed"))

        if HTML_TAG_PATTERN.search(line):
            findings.append(Finding(source, line_number, "raw HTML is not allowed"))

        list_match = LIST_ITEM_PATTERN.match(line)
        if list_match and list_match.group(1).rstrip().endswith(("。", ".")):
            findings.append(
                Finding(
                    source,
                    line_number,
                    "Markdown list items must not end with a full stop",
                )
            )

        if DA_PERIOD_PATTERN.search(line):
            findings.append(
                Finding(source, line_number, "sentence-final だ。 is not allowed")
            )

        stripped = line.strip()
        if stripped and not heading_match and not THEMATIC_BREAK_PATTERN.fullmatch(line):
            pending_heading = None
        if stripped:
            previous_content = (line_number, line)
            last_content = (line_number, line)

    if pending_heading is not None:
        findings.append(
            Finding(
                source,
                pending_heading,
                "heading must be followed by body text",
            )
        )

    if last_content is None or last_content[1].strip() != CREDIT_LINE:
        findings.append(
            Finding(
                source,
                last_content[0] if last_content else 0,
                f"document must end with the credit line: {CREDIT_LINE}",
            )
        )

    if not heading_levels or heading_levels[0][1] != 2:
        location = heading_levels[0][0] if heading_levels else 0
        findings.append(
            Finding(source, location, "document must start with an H2")
        )

    return findings


def parse_args(argv: list[str]) -> argparse.Namespace:
    """Parse command-line arguments for file-based validation.

    Args:
        argv: Command-line arguments excluding the executable name.

    Returns:
        Parsed arguments containing one or more paths and the filename-check
        switch.
    """
    parser = argparse.ArgumentParser(
        description="Validate deterministic markdown-explainer constraints."
    )
    parser.add_argument("paths", nargs="+", type=Path, help="Markdown files to validate")
    parser.add_argument(
        "--check-filename",
        action="store_true",
        help="require each basename to match YYYY-MM-DD_*.md",
    )
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    """Validate requested files and return a process-friendly status code.

    Args:
        argv: Optional argument list for tests. When omitted, use `sys.argv`.

    Returns:
        Zero when all files pass, one for validation findings, and two when an
        input file cannot be read as UTF-8 text.
    """
    args = parse_args(sys.argv[1:] if argv is None else argv)
    findings: list[Finding] = []

    for path in args.paths:
        try:
            markdown = path.read_text(encoding="utf-8")
        except (OSError, UnicodeError) as error:
            print(f"{path}: unable to read UTF-8 Markdown: {error}", file=sys.stderr)
            return 2
        findings.extend(
            validate_markdown(
                markdown,
                str(path),
                check_filename=args.check_filename,
            )
        )

    for finding in findings:
        print(finding.format(), file=sys.stderr)

    return 1 if findings else 0


if __name__ == "__main__":
    raise SystemExit(main())
