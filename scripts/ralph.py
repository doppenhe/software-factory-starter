#!/usr/bin/env python3
"""Small portable runner helper for PROMPT.md and state/RALPH_STATE.md."""

from __future__ import annotations

import argparse
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
STATE = ROOT / "state/RALPH_STATE.md"
PROMPT = ROOT / "PROMPT.md"

ACTIVE = ("TODO", "DOING", "VERIFY", "AUDIT", "FIX", "PR", "BLOCKED")

REPORT_RE = re.compile(r"<ralph-report>(.*?)</ralph-report>\s*<promise>(.*?)</promise>", re.S)


def split_row(line: str) -> list[str]:
    return [cell.strip() for cell in line.strip().strip("|").split("|")]


def table() -> tuple[list[str], list[list[str]]]:
    """Read the campaign table. Columns are located by header, not by position."""
    if not STATE.exists():
        raise SystemExit("missing state/RALPH_STATE.md. run scripts/init-project.py first")

    headers: list[str] = []
    rows: list[list[str]] = []
    for line in STATE.read_text().splitlines():
        line = line.strip()
        if not line.startswith("|"):
            continue
        cells = split_row(line)
        if not cells:
            continue
        if all(set(cell) <= {"-", ":"} and cell for cell in cells):
            continue
        if not headers:
            headers = cells
            continue
        rows.append(cells)
    if not headers:
        raise SystemExit("no task table found in state/RALPH_STATE.md")
    return headers, rows


def status_index(headers: list[str]) -> int:
    for index, name in enumerate(headers):
        if name.lower() == "status":
            return index
    raise SystemExit("task table has no Status column")


def cmd_next(_: argparse.Namespace) -> int:
    if not PROMPT.exists():
        raise SystemExit("missing PROMPT.md. run scripts/init-project.py first")
    headers, rows = table()
    index = status_index(headers)
    for cells in rows:
        if len(cells) <= index or cells[index] not in ACTIVE:
            continue
        print("NEXT TASK")
        for header, value in zip(headers, cells):
            if value:
                print(f"{header.lower()}: {value}")
        print("")
        print("Read PROMPT.md, work this task in its own worktree, then end with the report contract.")
        return 0
    print("no active rows")
    return 0


def parse_report(path: Path) -> tuple[dict[str, str], str]:
    text = path.read_text()
    match = REPORT_RE.search(text)
    if not match:
        raise SystemExit("missing report block or promise tag")
    body, promise = match.groups()
    fields: dict[str, str] = {}
    current: str | None = None
    for line in body.splitlines():
        if not line.strip():
            continue
        if ":" in line and not line.startswith(" "):
            key, value = line.split(":", 1)
            current = key.strip()
            fields[current] = value.strip()
        elif current:
            fields[current] += "\n" + line.strip()
    return fields, promise.strip()


def cmd_check_report(args: argparse.Namespace) -> int:
    fields, promise = parse_report(Path(args.path))
    required = [
        "ITERATION",
        "PHASE",
        "COMPLETED",
        "DEFECTS_FOUND",
        "DEFECTS_FIXED",
        "DEFECTS_REMAINING",
        "FILES_CHANGED",
        "TESTS",
        "NEXT",
        "BLOCKERS",
        "PROGRESS",
    ]
    missing = [field for field in required if field not in fields]
    if missing:
        raise SystemExit("missing report fields: " + ", ".join(missing))
    if promise != "COMPLETE":
        raise SystemExit("promise must be COMPLETE")
    print("report valid")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description="Portable runner helper.")
    sub = parser.add_subparsers(dest="cmd", required=True)

    next_cmd = sub.add_parser("next", help="Print the next checklist item as a prompt.")
    next_cmd.set_defaults(func=cmd_next)

    report_cmd = sub.add_parser("check-report", help="Validate a report block.")
    report_cmd.add_argument("path", help="Path to a log or report file.")
    report_cmd.set_defaults(func=cmd_check_report)

    args = parser.parse_args()
    return args.func(args)


if __name__ == "__main__":
    raise SystemExit(main())

