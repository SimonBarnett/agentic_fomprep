#!/usr/bin/env python3
"""Resolve which lessons/skills to load for a query."""
import json
import pathlib
import re
import sys

repo = pathlib.Path(sys.argv[1]).resolve()
query = sys.argv[2].lower()
max_lessons = int(sys.argv[3]) if len(sys.argv) > 3 else 8
max_skills = int(sys.argv[4]) if len(sys.argv) > 4 else 5

dag_path = repo / "docs/skill-sources/medatech-network/_dag/dag.json"
if not dag_path.exists():
    raise SystemExit(f"DAG missing: {dag_path} — run build_dag.py first")

dag = json.loads(dag_path.read_text(encoding="utf-8"))
tokens = [t for t in re.split(r"[^a-z0-9]+", query) if len(t) >= 3]


def score(node):
    s = 0
    blob = " ".join(
        [node.get("title", "")]
        + node.get("triggers", [])
        + [node.get("path", ""), node.get("topic", "")]
    ).lower()
    title = node.get("title", "").lower()
    for t in tokens:
        if t in blob:
            s += 3 if t in title else 1
            if any(t == tr.lower() for tr in node.get("triggers", [])):
                s += 2
    return s


lessons, skills, topics = [], [], []
for n in dag["nodes"]:
    sc = score(n)
    if sc <= 0:
        continue
    if n["type"] == "lesson":
        lessons.append((sc, n))
    elif n["type"] == "catalog-skill":
        skills.append((sc, n))
    elif n["type"] == "topic":
        topics.append((sc, n))

lessons.sort(key=lambda x: (-x[0], x[1]["id"]))
skills.sort(key=lambda x: (-x[0], x[1]["id"]))
topics.sort(key=lambda x: (-x[0], x[1]["id"]))

out = {
    "query": query,
    "tokens": tokens,
    "topics": [{"score": s, "id": n["id"], "title": n["title"]} for s, n in topics[:5]],
    "skills": [
        {"score": s, "id": n["id"], "path": n["path"], "topic": n.get("topic")}
        for s, n in skills[:max_skills]
    ],
    "lessons": [
        {
            "score": s,
            "id": n["id"],
            "path": "docs/skill-sources/medatech-network/" + n["path"],
            "topic": n.get("topic"),
        }
        for s, n in lessons[:max_lessons]
    ],
    "loadOrder": [],
}
for s in out["skills"]:
    out["loadOrder"].append({"kind": "skill", "path": s["path"]})
for lesson in out["lessons"]:
    out["loadOrder"].append({"kind": "lesson", "path": lesson["path"]})
print(json.dumps(out, indent=2))
