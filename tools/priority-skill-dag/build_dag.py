#!/usr/bin/env python3
"""Build docs/skill-sources/medatech-network/_dag/dag.json"""
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

nodes = []
edges = []

topics = [p.name for p in lessons.iterdir() if p.is_dir() and not p.name.startswith("_")]
for t in topics:
    nodes.append(
        {
            "id": f"topic:{t}",
            "type": "topic",
            "title": t,
            "path": t,
            "triggers": [t.replace("-", " ")],
        }
    )
    for dep in topic_depends.get(t, []):
        edges.append({"from": f"topic:{t}", "to": f"topic:{dep}", "rel": "depends_on"})

for f in lessons.rglob("*.md"):
    if "_dag" in f.parts or f.name in ("README.md", "_convert-log.txt"):
        continue
    rel = f.relative_to(lessons).as_posix()
    topic = rel.split("/", 1)[0]
    lid = "lesson:" + rel[:-3]
    stem = f.stem
    toks = re.split(r"[_\s\-]+", stem)
    triggers = [stem] + [tok.lower() for tok in toks if len(tok) > 3][:8]
    nodes.append(
        {
            "id": lid,
            "type": "lesson",
            "title": stem,
            "path": rel,
            "topic": topic,
            "triggers": sorted(set(triggers)),
        }
    )
    edges.append({"from": f"topic:{topic}", "to": lid, "rel": "contains"})

for d in catalog.iterdir():
    if not d.is_dir() or not (d / "SKILL.md").exists():
        continue
    name = d.name
    topic = skill_topic.get(name)
    if not topic:
        if name.startswith("priority-ops-"):
            topic = name.replace("priority-ops-", "")
        elif name == "priority-help-wizards":
            topic = "forms-code"
        elif name == "priority-skill-dag":
            topic = "loader"
        elif "hours" in name:
            topic = "hours"
        elif "uat" in name or "smoke" in name:
            topic = "uat"
        elif any(x in name for x in ("backup", "health", "disk", "sunday", "post-move")):
            topic = "system-admin"
        elif any(x in name for x in ("mcp", "odata")):
            topic = "integrations"
        elif any(
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
            topic = "programming"
        else:
            topic = "programming"
    nodes.append(
        {
            "id": f"skill:{name}",
            "type": "catalog-skill",
            "title": name,
            "path": f"v2/apps/mcp-catalog/catalog/{name}/SKILL.md",
            "topic": topic,
            "triggers": [name.replace("-", " ")],
        }
    )
    edges.append({"from": f"skill:{name}", "to": f"topic:{topic}", "rel": "loads_topic"})

nodes.append(
    {
        "id": "skill:priority-skill-dag",
        "type": "loader",
        "title": "priority-skill-dag",
        "path": "v2/apps/mcp-catalog/catalog/priority-skill-dag/SKILL.md",
        "triggers": ["skill dag", "lazy load", "medatech docs", "priority lesson"],
    }
)

dag = {
    "version": 1,
    "built": datetime.date.today().isoformat(),
    "repo": "SimonBarnett/agentic_fomprep",
    "lessonsRoot": "docs/skill-sources/medatech-network",
    "nodeCount": len(nodes),
    "edgeCount": len(edges),
    "nodes": nodes,
    "edges": edges,
}
out = dag_dir / "dag.json"
out.write_text(json.dumps(dag, ensure_ascii=False), encoding="utf-8")
print(f"Wrote {out} nodes={len(nodes)} edges={len(edges)}")
