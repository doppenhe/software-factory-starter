#!/usr/bin/env python3
"""Content lints: forbidden dash characters and local absolute paths.

Runs against any root, which is what lets scripts/verify.sh prove the lints
fail on a known-bad fixture before trusting them to pass on the repository.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

FORBIDDEN_DASHES = (0x2013, 0x2014)

PATH_PATTERNS = [
    re.compile(r"/" + "Users/"),
    re.compile(r"/" + r"home/[A-Za-z0-9_.-]+"),
    re.compile(r"C:" + r"\\Users\\"),
]

SELF = "scripts/lint.py"


def iter_files(root: Path, targets: list[str]):
    for target in targets:
        path = root / target
        if not path.exists():
            continue
        files = [path] if path.is_file() else sorted(p for p in path.rglob("*") if p.is_file())
        for file in files:
            if file.relative_to(root).as_posix() == SELF:
                continue
            yield file


def check_dashes(root: Path, targets: list[str]) -> list[str]:
    findings = []
    for file in iter_files(root, targets):
        text = file.read_text(errors="ignore")
        for index, char in enumerate(text):
            if ord(char) in FORBIDDEN_DASHES:
                line = text[:index].count("\n") + 1
                findings.append(f"{file.relative_to(root)}:{line}: forbidden Unicode dash character")
    return findings


def check_paths(root: Path, targets: list[str]) -> list[str]:
    findings = []
    for file in iter_files(root, targets):
        text = file.read_text(errors="ignore")
        for number, line in enumerate(text.splitlines(), 1):
            if any(pattern.search(line) for pattern in PATH_PATTERNS):
                findings.append(f"{file.relative_to(root)}:{number}: local absolute path")
    return findings


def main() -> int:
    parser = argparse.ArgumentParser(description="Run content lints over a directory tree.")
    parser.add_argument("--root", default=".", help="Directory to lint.")
    parser.add_argument("--check", choices=("dashes", "paths", "all"), default="all")
    parser.add_argument("targets", nargs="*", default=None, help="Paths under root to lint.")
    args = parser.parse_args()

    root = Path(args.root).resolve()
    targets = args.targets or [
        ".github",
        "AGENTS.md",
        "CODEX.md",
        "CONTRIBUTING.md",
        "README.md",
        "docs",
        "examples",
        "prompts",
        "rules",
        "scripts",
        "skills",
        "state",
        "templates",
    ]

    findings: list[str] = []
    if args.check in ("dashes", "all"):
        findings += check_dashes(root, targets)
    if args.check in ("paths", "all"):
        findings += check_paths(root, targets)

    for finding in findings:
        print(finding)

    if findings:
        print(f"{len(findings)} finding(s)")
        return 1

    print("lints passed")
    return 0


if __name__ == "__main__":
    sys.exit(main())
