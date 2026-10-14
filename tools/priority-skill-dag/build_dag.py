#!/usr/bin/env python3
"""Build docs/skill-sources/medatech-network/_dag/dag.json (context-efficient index)."""
from __future__ import annotations

import datetime
import json
import pathlib
import re
import sys

repo = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else ".").resolve()
lessons = repo / "docs/skill-sources/medatech-network"
catalog = repo / "v2/apps/mcp-catalog/catalog"
dag_dir = lessons / "_dag"
dag_dir.mkdir(parents=True, exist_ok=True)

topic_depends = {
    "install-upgrade": ["system-admin"],
    "system-admin": [],
    "financials": ["sop"],
    "integrations": ["install-upgrade", "system-admin"],
    "support-desk": ["system-admin", "customer-guides"],
    "customer-guides": ["sop"],
    "sop": [],
    "packages": ["install-upgrade", "procedures"],
    "procedures": ["packages"],
    "reports": ["procedures"],
    "training": ["sop", "customer-guides"],
    "forms-code": [],
    "sales-crm": ["customer-guides"],
    "inventory-mrp": ["sop", "packages"],
    "production": ["sop", "packages"],
    "purchasing": ["sop", "packages"],
    "release-notes": [],
    "restored-from-xx-invalid": ["install-upgrade", "support-desk"],
}

skill_topic = {
    "priority-formprep": "programming",
    "priority-shell-install": "packages",
    "priority-shell-compile": "packages",
    "priority-odata-dev": "integrations",
    "priority-uat-orchestrator": "uat",
    "priority-hours-orchestrator": "hours",
}

STOP = {
    "the",
    "and",
    "for",
    "with",
    "from",
    "this",
    "that",
    "when",
    "user",
    "says",
    "or",
    "via",
    "into",
    "over",
    "under",
    "only",
    "must",
    "does",
    "not",
    "use",
    "load",
    "lazy",
    "markdown",
    "lessons",
    "skill",
    "skills",
    "catalog",
    "foundation",
    "harvest",
    "priority",
    "report",
    "back",
    "github",
    "simonbarnett",
    "agentic",
    "fomprep",
}


def tokenize(text: str) -> list[str]:
    return [t for t in re.split(r"[^a-z0-9]+", text.lower()) if len(t) >= 3 and t not in STOP]


def frontmatter_triggers(skill_md: pathlib.Path) -> list[str]:
    """Parse YAML description / Use when lines into trigger phrases + tokens."""
    text = skill_md.read_text(encoding="utf-8", errors="replace")
    triggers: list[str] = []
    # name
    m = re.search(r"(?m)^name:\s*(.+)$", text)
    if m:
        name = m.group(1).strip().strip("\"'")
        triggers.append(name.replace("-", " "))
        triggers.extend(tokenize(name.replace("-", " ")))
    # description block (folded or literal)
    desc = ""
    m = re.search(r"(?ms)^description:\s*>-?\s*\n((?:[ \t].*\n)+)", text)
    if m:
        desc = m.group(1)
    else:
        m = re.search(r"(?m)^description:\s*(.+)$", text)
        if m:
            desc = m.group(1)
    if desc:
        # pull "Use when: ..." clause if present
        um = re.search(r"Use when:\s*(.+)", desc, re.I | re.S)
        blob = um.group(1) if um else desc
        # split on commas / "or" / newlines
        parts = re.split(r"[,\n]|/(?=[a-z])|\bor\b", blob, flags=re.I)
        for p in parts:
            p = re.sub(r"[`*\"']", "", p).strip().lower()
            p = re.sub(r"\s+", " ", p)
            if 3 <= len(p) <= 80 and p not in STOP:
                triggers.append(p)
                triggers.extend(tokenize(p))
    # body "Use when" lines
    for line in text.splitlines():
        if line.lower().startswith("use when:"):
            triggers.extend(tokenize(line))
    # unique preserve order
    seen = set()
    out = []
    for t in triggers:
        t = t.strip().lower()
        if not t or t in seen:
            continue
        seen.add(t)
        out.append(t)
    return out[:40]


def lesson_summary(path: pathlib.Path, max_chars: int = 240) -> str:
    try:
        text = path.read_text(encoding="utf-8", errors="replace")
    except OSError:
        return ""
    # skip front YAML if any
    if text.startswith("---"):
        end = text.find("\n---", 3)
        if end != -1:
            text = text[end + 4 :]
    lines = []
    for line in text.splitlines():
        s = line.strip()
        if not s:
            if lines:
                break
            continue
        if s.startswith("#"):
            s = s.lstrip("#").strip()
        if s.startswith("<!--") or s.startswith("[["):
            continue
        lines.append(s)
        joined = " ".join(lines)
        if len(joined) >= max_chars:
            return joined[:max_chars].rstrip() + "…"
    return " ".join(lines)[:max_chars]


def canonical_stem(stem: str) -> str:
    s = stem.lower()
    s = re.sub(r"\s*-\s*rich\b", "", s)
    s = re.sub(r"\s+rich\b", "", s)
    s = re.sub(r"\s+", " ", s).strip()
    return s


def infer_skill_topic(name: str) -> str:
    topic = skill_topic.get(name)
    if topic:
        return topic
    if name.startswith("priority-ops-"):
        return name.replace("priority-ops-", "")
    if name == "priority-help-wizards":
        return "forms-code"
    if name == "priority-skill-dag":
        return "loader"
    if "hours" in name:
        return "hours"
    if "uat" in name or "smoke" in name:
        return "uat"
    if any(x in name for x in ("backup", "health", "disk", "sunday", "post-move")):
        return "system-admin"
    if any(x in name for x in ("mcp", "odata")):
        return "integrations"
    if any(
        x in name
        for x in (
            "form",
            "procedure",
            "shell",
            "sql",
            "dictionary",
            "table",
            "recalc",
            "version",
            "shadow",
            "prepare",
        )
    ):
        return "programming"
    return "programming"


def lesson_weight(rel: str, topic: str) -> str:
    """Tier for default resolve: low = demote unless query asks for help/WIZ."""
    low = rel.startswith("forms-code/sacred/") or "/WIZ3" in rel or topic == "forms-code" and "sacred" in rel
    if low:
        return "low"
    # huge reference docs
    return "normal"


nodes: list[dict] = []
edges: list[dict] = []
seen_ids: set[str] = set()


def add_node(node: dict) -> None:
    nid = node["id"]
    if nid in seen_ids:
        return
    seen_ids.add(nid)
    nodes.append(node)


topics = [p.name for p in lessons.iterdir() if p.is_dir() and not p.name.startswith("_")]
for t in topics:
    add_node(
        {
            "id": f"topic:{t}",
            "type": "topic",
            "title": t,
            "path": t,
            "triggers": [t.replace("-", " ")] + tokenize(t.replace("-", " ")),
            "weight": "normal",
        }
    )
    for dep in topic_depends.get(t, []):
        edges.append({"from": f"topic:{t}", "to": f"topic:{dep}", "rel": "depends_on"})

# Prefer non-Rich when both exist; skip Rich twin if canonical already queued
preferred: dict[tuple[str, str], pathlib.Path] = {}
all_md = [
    f
    for f in lessons.rglob("*.md")
    if "_dag" not in f.parts and f.name not in ("README.md", "_convert-log.txt")
]
for f in all_md:
    rel = f.relative_to(lessons).as_posix()
    topic = rel.split("/", 1)[0]
    key = (topic, canonical_stem(f.stem))
    prev = preferred.get(key)
    if prev is None:
        preferred[key] = f
        continue
    # prefer non-rich / shorter path / larger file as tie-break
    prev_rich = bool(re.search(r"\brich\b", prev.stem, re.I))
    cur_rich = bool(re.search(r"\brich\b", f.stem, re.I))
    if prev_rich and not cur_rich:
        preferred[key] = f
    elif prev_rich == cur_rich and len(rel) < len(prev.relative_to(lessons).as_posix()):
        preferred[key] = f

skipped_rich = 0
for f in all_md:
    rel = f.relative_to(lessons).as_posix()
    topic = rel.split("/", 1)[0]
    key = (topic, canonical_stem(f.stem))
    if preferred.get(key) != f:
        skipped_rich += 1
        continue
    stem = f.stem
    toks = tokenize(stem)[:8]
    triggers = [stem.lower()] + toks
    try:
        nbytes = f.stat().st_size
    except OSError:
        nbytes = 0
    weight = lesson_weight(rel, topic)
    if nbytes > 20000:
        # large docs need explicit allow-large at resolve
        weight = "large" if weight != "low" else "low-large"
    lid = "lesson:" + rel[:-3]
    add_node(
        {
            "id": lid,
            "type": "lesson",
            "title": stem,
            "path": rel,
            "topic": topic,
            "triggers": sorted(set(triggers)),
            "bytes": nbytes,
            "summary": lesson_summary(f),
            "weight": weight,
            "canonicalStem": key[1],
        }
    )
    edges.append({"from": f"topic:{topic}", "to": lid, "rel": "contains"})

for d in sorted(catalog.iterdir()):
    if not d.is_dir() or not (d / "SKILL.md").exists():
        continue
    name = d.name
    topic = infer_skill_topic(name)
    skill_path = f"v2/apps/mcp-catalog/catalog/{name}/SKILL.md"
    abs_skill = d / "SKILL.md"
    try:
        nbytes = abs_skill.stat().st_size
    except OSError:
        nbytes = 0
    triggers = frontmatter_triggers(abs_skill)
    ntype = "loader" if name == "priority-skill-dag" else "catalog-skill"
    add_node(
        {
            "id": f"skill:{name}",
            "type": ntype if name == "priority-skill-dag" else "catalog-skill",
            "title": name,
            "path": skill_path,
            "topic": topic,
            "triggers": triggers,
            "bytes": nbytes,
            "summary": lesson_summary(abs_skill, 180),
            "weight": "normal",
        }
    )
    if topic and topic != "loader":
        edges.append({"from": f"skill:{name}", "to": f"topic:{topic}", "rel": "loads_topic"})

dag = {
    "version": 2,
    "built": datetime.date.today().isoformat(),
    "repo": "SimonBarnett/agentic_fomprep",
    "lessonsRoot": "docs/skill-sources/medatech-network",
    "nodeCount": len(nodes),
    "edgeCount": len(edges),
    "skippedRichDupes": skipped_rich,
    "defaults": {
        "maxLessons": 8,
        "maxSkills": 5,
        "maxBytes": 24000,
        "singleFileCeiling": 20000,
    },
    "nodes": nodes,
    "edges": edges,
}
out = dag_dir / "dag.json"
out.write_text(json.dumps(dag, ensure_ascii=False), encoding="utf-8")

# Slim index for grepping without loading full bodies into agent context
slim_nodes = []
for n in nodes:
    slim_nodes.append(
        {
            "id": n["id"],
            "type": n["type"],
            "title": n.get("title"),
            "path": n.get("path"),
            "topic": n.get("topic"),
            "triggers": n.get("triggers", [])[:8],
            "bytes": n.get("bytes"),
            "weight": n.get("weight", "normal"),
        }
    )
slim = {
    "version": 2,
    "built": dag["built"],
    "note": "Slim index. Agents must NOT read dag.json; use Resolve-SkillDag.ps1.",
    "nodeCount": len(slim_nodes),
    "defaults": dag["defaults"],
    "nodes": slim_nodes,
}
slim_out = dag_dir / "dag-index.json"
slim_out.write_text(json.dumps(slim, ensure_ascii=False), encoding="utf-8")

print(
    f"Wrote {out} nodes={len(nodes)} edges={len(edges)} "
    f"skippedRich={skipped_rich} slim={slim_out}"
)
