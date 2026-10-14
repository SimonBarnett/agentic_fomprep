#!/usr/bin/env python3
"""Verify catalog skills against medatech-network lessons."""
import datetime
import pathlib
import re
import sys

repo = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else ".").resolve()
day = datetime.date.today().isoformat()
lessons_root = repo / "docs/skill-sources/medatech-network"
catalog = repo / "v2/apps/mcp-catalog/catalog"
out = repo / f"docs/medatech-skill-verify-{day}.md"

lesson_index = {}
for f in lessons_root.rglob("*.md"):
    if "_dag" in f.parts or f.name in ("README.md", "_convert-log.txt"):
        continue
    rel = f.relative_to(lessons_root).as_posix()
    key = re.sub(r"[^a-zA-Z0-9]+", " ", f.stem).lower()
    for tok in key.split():
        if len(tok) > 4:
            lesson_index.setdefault(tok, [])
            if len(lesson_index[tok]) < 8:
                lesson_index[tok].append(rel)

lines = [
    f"# Medatech docs vs catalog skill verification ({day})",
    "",
    "Compares catalog SKILL.md keywords to converted Medatech-network lessons.",
    "",
    "| Catalog skill | Topic guess | Lesson hits (sample) | Gap notes |",
    "|---------------|-------------|----------------------|-----------|",
]

for d in sorted(catalog.iterdir(), key=lambda p: p.name):
    skill_path = d / "SKILL.md"
    if not skill_path.exists():
        continue
    text = skill_path.read_text(encoding="utf-8", errors="ignore")
    name = d.name
    if "hours" in name:
        topic = "hours"
    elif "uat" in name or "smoke" in name:
        topic = "uat"
    elif "ops-install" in name or "post-move" in name:
        topic = "install-upgrade"
    elif any(x in name for x in ("ops-system", "backup", "health", "disk", "sunday")):
        topic = "system-admin"
    elif "ops-financ" in name:
        topic = "financials"
    elif any(x in name for x in ("ops-integr", "mcp", "odata")):
        topic = "integrations"
    elif "ops-support" in name:
        topic = "support-desk"
    elif "ops-customer" in name:
        topic = "customer-guides"
    elif "ops-sop" in name or "help-wizard" in name:
        topic = "sop/forms-code"
    elif "ops-package" in name or "shell" in name:
        topic = "packages"
    elif "ops-procedure" in name:
        topic = "procedures"
    elif "ops-report" in name:
        topic = "reports"
    elif "ops-train" in name:
        topic = "training"
    elif "skill-dag" in name:
        topic = "loader"
    else:
        topic = "programming"

    hits = []
    tokens = sorted(set(re.findall(r"[a-z]{5,}", text.lower())))
    for tok in tokens:
        if tok in lesson_index:
            for h in lesson_index[tok]:
                if h not in hits:
                    hits.append(h)
                if len(hits) >= 5:
                    break
        if len(hits) >= 5:
            break

    hit_str = "; ".join(hits[:5]) if hits else "_none_"
    if not hits and topic not in ("programming", "hours", "uat", "loader"):
        gap = "No medatech lesson keyword overlap — check conversion or add lessons"
    elif not hits:
        gap = f"OK — owned by skill-sources/{topic}"
    else:
        gap = "OK — lessons available"

    lines.append(f"| `{name}` | {topic} | {hit_str} | {gap} |")

lesson_count = sum(
    1
    for f in lessons_root.rglob("*.md")
    if "_dag" not in f.parts and f.name not in ("README.md", "_convert-log.txt")
)
lines += [
    "",
    "## CAST IRON",
    "Harvest gaps into catalog + `docs/skill-sources/` via `harvest-priority-skills`.",
    "",
    f"Lesson files indexed: {lesson_count}",
]
out.write_text("\n".join(lines) + "\n", encoding="utf-8")
print(f"Wrote {out}")
