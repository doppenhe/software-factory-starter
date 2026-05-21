#!/usr/bin/env python3
"""Generate a BRIEF.md draft from SPEC.md without copying L3 details."""

from __future__ import annotations

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SPEC = ROOT / "SPEC.md"
BRIEF = ROOT / "BRIEF.md"


KEEP_HEADERS = {
    "System Goal",
    "Principles",
    "Constraints",
    "Edge-Case Decisions",
}


def main() -> int:
    if not SPEC.exists():
        raise SystemExit("missing SPEC.md")

    lines = SPEC.read_text().splitlines()
    output = [
        "# BRIEF",
        "",
        "## Purpose",
        "",
        "L1 context generated from SPEC.md for QA, audit, review, and orientation agents.",
        "",
    ]
    capture = False
    current: str | None = None
    bucket: list[str] = []

    def flush() -> None:
        nonlocal bucket, current
        if current:
            output.append(f"## {current}")
            output.append("")
            output.extend(bucket if bucket else [""])
            output.append("")
        bucket = []

    for line in lines:
        if line.startswith("### "):
            name = line[4:].strip()
            if current:
                flush()
            current = name if name in KEEP_HEADERS else None
            capture = current is not None
            continue
        if line.startswith("## L2:"):
            break
        if capture:
            bucket.append(line)

    flush()
    output.extend(["## Source Spec", "", "SPEC.md", ""])
    BRIEF.write_text("\n".join(output))
    print("generated BRIEF.md from SPEC.md")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

