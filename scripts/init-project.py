#!/usr/bin/env python3
"""Initialize a portable software-factory project from this repository."""

from __future__ import annotations

import argparse
import shutil
from datetime import date
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


FILES = {
    "templates/scope.md": "state/SCOPE.md",
    "templates/plan.md": "state/PLAN.md",
    "templates/project-state.md": "state/PROJECT_STATE.md",
    "templates/spec.md": "SPEC.md",
    "templates/brief.md": "BRIEF.md",
    "templates/ralph-prompt.md": "PROMPT.md",
    "templates/ralph-state.md": "state/RALPH_STATE.md",
    "templates/run-log.md": "state/RUN_LOG.md",
    "templates/assessment.md": "state/ASSESSMENT.md",
    "templates/closeout.md": "CLOSEOUT.md",
}


DIRS = [
    "agents/foundation",
    "agents/domains",
    "agents/modules",
    "artifacts",
    "logs",
    "state",
    "work",
]


def write_if_missing(src: Path, dst: Path, force: bool) -> None:
    if dst.exists() and not force:
        return
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(src, dst)


def append_project_header(path: Path, name: str) -> None:
    text = path.read_text()
    if "## Project" in text:
        return
    path.write_text(f"# PROJECT STATE\n\n## Project\n\n{name}\n\n## Created\n\n{date.today().isoformat()}\n\n" + text)


def main() -> int:
    parser = argparse.ArgumentParser(description="Create starter software-factory files.")
    parser.add_argument("--name", default="New Project", help="Project name.")
    parser.add_argument("--force", action="store_true", help="Overwrite generated files.")
    args = parser.parse_args()

    for directory in DIRS:
        (ROOT / directory).mkdir(parents=True, exist_ok=True)
        keep = ROOT / directory / ".gitkeep"
        keep.touch(exist_ok=True)

    for source, target in FILES.items():
        write_if_missing(ROOT / source, ROOT / target, args.force)

    append_project_header(ROOT / "state/PROJECT_STATE.md", args.name)

    foundation = ROOT / "agents/foundation/COMPANY.md"
    domain = ROOT / "agents/domains/ENGINEERING.md"
    module = ROOT / "agents/modules/EXAMPLE.md"
    write_if_missing(ROOT / "templates/foundation-agent.md", foundation, args.force)
    write_if_missing(ROOT / "templates/domain-agent.md", domain, args.force)
    write_if_missing(ROOT / "templates/module-agent.md", module, args.force)

    print("initialized project files")
    print("next: read prompts/project-intake.md and fill state/SCOPE.md")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

