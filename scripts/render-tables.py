#!/usr/bin/env python3
"""Render the version tables in README.md from versions/*/gradle.properties."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
VERSIONS = ROOT / "versions"
README = ROOT / "README.md"

LOADERS = ("fabric", "forge", "neoforge")
LOADER_NAMES = {"fabric": "Fabric", "forge": "Forge", "neoforge": "NeoForge"}
SUPPORTED_START = "<!-- supported:start -->"
SUPPORTED_END = "<!-- supported:end -->"
ARTIFACTS_START = "<!-- artifacts:start -->"
ARTIFACTS_END = "<!-- artifacts:end -->"


def read_props(path: Path) -> dict[str, str]:
    props: dict[str, str] = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        if not line or line.lstrip().startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        props[key.strip()] = value.strip()
    return props


def version_key(value: str) -> tuple[int, ...]:
    return tuple(int(part) for part in value.split("."))


def collect() -> list[dict[str, object]]:
    entries: list[dict[str, object]] = []
    for directory in sorted(VERSIONS.iterdir()):
        props_file = directory / "gradle.properties"
        if not directory.is_dir() or not props_file.is_file():
            continue
        props = read_props(props_file)
        entries.append(
            {
                "minecraft": props.get("minecraft_version", directory.name),
                "mod_name": props.get("mod_name", "SmoothThai"),
                "version": props.get("version", "0.0.0"),
                "loaders": [loader for loader in LOADERS if (directory / loader).is_dir()],
            }
        )
    return sorted(entries, key=lambda entry: version_key(str(entry["minecraft"])))


def supported_table(entries: list[dict[str, object]]) -> str:
    lines = [
        "| Minecraft | Fabric | Forge | NeoForge |",
        "|-----------|--------|-------|----------|",
    ]
    for entry in entries:
        loaders = set(entry["loaders"])  # type: ignore[arg-type]
        cells = ["✅" if loader in loaders else "—" for loader in LOADERS]
        lines.append(f"| {entry['minecraft']} | {' | '.join(cells)} |")
    return "\n".join(lines)


def artifacts_table(entries: list[dict[str, object]]) -> str:
    lines = [
        "| Minecraft | Loader | Output |",
        "|-----------|--------|--------|",
    ]
    for entry in entries:
        for loader in entry["loaders"]:  # type: ignore[union-attr]
            jar = f"{entry['mod_name']}-{entry['minecraft']}-{loader}-{entry['version']}.jar"
            lines.append(f"| {entry['minecraft']} | {LOADER_NAMES[loader]} | `{jar}` |")
    return "\n".join(lines)


def replace_block(text: str, start: str, end: str, body: str) -> str:
    pattern = re.compile(re.escape(start) + r".*?" + re.escape(end), re.DOTALL)
    replacement = f"{start}\n{body}\n{end}"
    if not pattern.search(text):
        raise SystemExit(f"Missing markers in README.md: {start} / {end}")
    return pattern.sub(replacement, text)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true", help="fail if README is out of date")
    args = parser.parse_args()

    entries = collect()
    original = README.read_text(encoding="utf-8")
    rendered = replace_block(original, SUPPORTED_START, SUPPORTED_END, supported_table(entries))
    rendered = replace_block(rendered, ARTIFACTS_START, ARTIFACTS_END, artifacts_table(entries))

    if args.check:
        if rendered != original:
            print("README.md version tables are out of date. Run scripts/render-tables.py.", file=sys.stderr)
            return 1
        print("README.md version tables are up to date.")
        return 0

    README.write_text(rendered, encoding="utf-8")
    print("Updated README.md version tables.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
