#!/usr/bin/env python3
"""Small portable runner helper for PROMPT.md and state/RALPH_STATE.md."""

from __future__ import annotations

import argparse
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
STATE = ROOT / "state/RALPH_STATE.md"
PROMPT = ROOT / "PROMPT.md"

REPORT_RE = re.compile(r"<ralph-report>(.*?)</ralph-report>\s*<promise>(.*?)</promise>", re.S)


def rows() -> list[list[str]]:
    if not STATE.exists():
        raise SystemExit("missing state/RALPH_STATE.md. run scripts/init-project.py first")
    found: list[list[str]] = []
    for line in STATE.read_text().splitlines():
        line = line.strip()
        if not line.startswith("|"):
            continue
        cells = [cell.strip() for cell in line.strip("|").split("|")]
        if not cells or cells[0] in ("#", "---"):
            continue
        if cells[0].startswith("-"):
            continue
        found.append(cells)
    return found


def cmd_next(_: argparse.Namespace) -> int:
    if not PROMPT.exists():
        raise SystemExit("missing PROMPT.md. run scripts/init-project.py first")
    for cells in rows():
        if len(cells) >= 6 and cells[5] in ("TODO", "BLOCKED", "DOING"):
            print("NEXT CHECK")
            print(f"id: {cells[0]}")
            print(f"module: {cells[1]}")
            print(f"check: {cells[2]}")
            print(f"impact: {cells[3]}")
            print("")
            print("Read PROMPT.md, perform this check, then end with the report contract.")
            return 0
    print("no TODO rows")
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

