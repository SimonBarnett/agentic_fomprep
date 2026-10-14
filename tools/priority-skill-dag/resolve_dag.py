#!/usr/bin/env python3
"""Resolve which lessons/skills to load for a query (context-budgeted)."""
from __future__ import annotations

import json
import pathlib
import re
import sys

repo = pathlib.Path(sys.argv[1]).resolve()
query = sys.argv[2].lower()
max_lessons = int(sys.argv[3]) if len(sys.argv) > 3 else 8
max_skills = int(sys.argv[4]) if len(sys.argv) > 4 else 5
max_bytes = int(sys.argv[5]) if len(sys.argv) > 5 else 24000
allow_large = (sys.argv[6].lower() in ("1", "true", "yes")) if len(sys.argv) > 6 else False
single_file_ceiling = int(sys.argv[7]) if len(sys.argv) > 7 else 20000

dag_path = repo / "docs/skill-sources/medatech-network/_dag/dag.json"
if not dag_path.exists():
    raise SystemExit(f"DAG missing: {dag_path} — run build_dag.py first")

dag = json.loads(dag_path.read_text(encoding="utf-8"))
defaults = dag.get("defaults") or {}
if len(sys.argv) <= 5 and "maxBytes" in defaults:
    max_bytes = int(defaults["maxBytes"])
if len(sys.argv) <= 7 and "singleFileCeiling" in defaults:
    single_file_ceiling = int(defaults["singleFileCeiling"])

QUERY_STOP = {
    "the",
    "and",
    "for",
    "with",
    "from",
    "this",
    "that",
    "when",
    "how",
    "user",
    "priority",  # too common across catalog names
    "medatech",
}
tokens = [
    t
    for t in re.split(r"[^a-z0-9]+", query)
    if len(t) >= 3 and t not in QUERY_STOP
]
# help/WIZ intent unlocks low-weight sacred lessons
help_intent = bool(
    re.search(r"\b(wiz3?|help\s*wizard|sacred|robohelp|form\s*help)\b", query, re.I)
) or ("forms-code" in query)

# Build adjacency for topic depends_on / contains / loads_topic
deps: dict[str, set[str]] = {}
contains: dict[str, set[str]] = {}
skill_topics: dict[str, str] = {}
for e in dag.get("edges") or []:
    rel = e.get("rel")
    frm, to = e.get("from"), e.get("to")
    if not frm or not to:
        continue
    if rel == "depends_on":
        deps.setdefault(frm, set()).add(to)
    elif rel == "contains":
        contains.setdefault(frm, set()).add(to)
    elif rel == "loads_topic":
        skill_topics[frm] = to

nodes_by_id = {n["id"]: n for n in dag["nodes"]}


def word_hit(token: str, text: str) -> bool:
    """Whole-token match for short tokens; substring OK for longer ones."""
    text = text.lower()
    token = token.lower()
    if len(token) < 5:
        return re.search(rf"(?<![a-z0-9]){re.escape(token)}(?![a-z0-9])", text) is not None
    return token in text


def score_node(node: dict) -> int:
    s = 0
    title = (node.get("title") or "").lower()
    path = (node.get("path") or "").lower()
    topic = (node.get("topic") or "").lower()
    triggers = [tr.lower() for tr in node.get("triggers") or []]
    summary = (node.get("summary") or "").lower()
    title_compact = re.sub(r"[^a-z0-9]+", "", title)
    blob_parts = [title, path, topic, summary] + triggers
    blob = " ".join(blob_parts)
    for t in tokens:
        if word_hit(t, title):
            s += 5
        elif t in title_compact and len(t) >= 4:
            # "form"+"prep" vs title "priority-formprep"
            s += 3
        elif any(word_hit(t, tr) or t == tr for tr in triggers):
            s += 4
        elif word_hit(t, summary):
            s += 2
        elif word_hit(t, path) or word_hit(t, topic):
            s += 1
        elif len(t) >= 5 and t in blob:
            s += 1
    # Multi-token phrase boost: consecutive pairs and full join vs compact title
    if len(tokens) >= 2:
        for i in range(len(tokens) - 1):
            pair = tokens[i] + tokens[i + 1]
            if len(pair) >= 6 and pair in title_compact:
                s += 10
            pair_space = tokens[i] + " " + tokens[i + 1]
            if any(pair_space in tr for tr in triggers):
                s += 6
        joined = "".join(tokens)
        if len(joined) >= 6 and joined in title_compact:
            s += 4
        phrase = " ".join(tokens)
        if any(phrase in tr for tr in triggers):
            s += 6
    weight = node.get("weight") or "normal"
    if weight.startswith("low") and not help_intent:
        s = max(0, s - 4)
        # path-only form hits in sacred without help intent: kill
        if "forms-code/sacred" in path and s < 6:
            return 0
    return s


def expand_topics(seed_ids: list[str], depth: int = 1) -> set[str]:
    out = set(seed_ids)
    frontier = list(seed_ids)
    for _ in range(depth):
        nxt = []
        for tid in frontier:
            for dep in deps.get(tid, ()):
                if dep not in out:
                    out.add(dep)
                    nxt.append(dep)
        frontier = nxt
    return out


# Score all nodes
scored_topics: list[tuple[int, dict]] = []
scored_skills: list[tuple[int, dict]] = []
scored_lessons: list[tuple[int, dict]] = []
for n in dag["nodes"]:
    sc = score_node(n)
    if sc <= 0:
        continue
    t = n.get("type")
    if t == "topic":
        scored_topics.append((sc, n))
    elif t == "catalog-skill":
        scored_skills.append((sc, n))
    elif t == "lesson":
        scored_lessons.append((sc, n))
    elif t == "loader":
        scored_skills.append((sc, n))

scored_topics.sort(key=lambda x: (-x[0], x[1]["id"]))
scored_skills.sort(key=lambda x: (-x[0], x[1]["id"]))
scored_lessons.sort(key=lambda x: (-x[0], x[1]["id"]))

# Topic-first gate: if we have topic hits, prefer lessons in those topics (+ deps)
active_topics: set[str] = set()
if scored_topics:
    seeds = [n["id"] for _, n in scored_topics[:3]]
    active_topics = expand_topics(seeds, depth=1)
# Include topics from high-scoring skills only (avoid weak name-overlap noise)
for sc, n in scored_skills[:max_skills]:
    if sc < 6:
        continue
    tid = skill_topics.get(n["id"])
    if not tid and n.get("topic") and n["topic"] not in (
        "loader",
        "programming",
        "hours",
        "uat",
    ):
        tid = f"topic:{n['topic']}"
    if tid:
        active_topics |= expand_topics([tid], depth=1)

gated_lessons: list[tuple[int, dict]] = []
if active_topics:
    allowed = set()
    for tid in active_topics:
        allowed |= contains.get(tid, set())
    for sc, n in scored_lessons:
        if n["id"] in allowed or (n.get("topic") and f"topic:{n['topic']}" in active_topics):
            gated_lessons.append((sc, n))
    # If gate emptied results (odd query), fall back
    if not gated_lessons:
        gated_lessons = scored_lessons
else:
    gated_lessons = scored_lessons


def pack(items: list[tuple[int, dict]], kind: str, limit: int, budget: list[int]):
    """Fill until count or remaining byte budget. budget is [remaining]."""
    out = []
    skipped_large = []
    for sc, n in items:
        if len(out) >= limit:
            break
        nbytes = int(n.get("bytes") or 0)
        weight = n.get("weight") or "normal"
        is_large = nbytes > single_file_ceiling or "large" in weight
        if is_large and not allow_large:
            skipped_large.append(
                {
                    "id": n["id"],
                    "path": n.get("path"),
                    "bytes": nbytes,
                    "reason": f"exceeds singleFileCeiling={single_file_ceiling}; pass -AllowLarge",
                }
            )
            continue
        if nbytes and nbytes > budget[0] and out:
            # would blow remaining budget; stop adding more of this kind
            skipped_large.append(
                {
                    "id": n["id"],
                    "path": n.get("path"),
                    "bytes": nbytes,
                    "reason": f"would exceed maxBytes remaining={budget[0]}",
                }
            )
            continue
        if nbytes > budget[0] and not out and kind == "lesson":
            # first lesson alone too big — skip unless allow_large
            if not allow_large:
                skipped_large.append(
                    {
                        "id": n["id"],
                        "path": n.get("path"),
                        "bytes": nbytes,
                        "reason": "single lesson exceeds maxBytes; pass -AllowLarge",
                    }
                )
                continue
        entry = {
            "score": sc,
            "id": n["id"],
            "path": n.get("path"),
            "topic": n.get("topic"),
            "bytes": nbytes,
            "weight": weight,
            "summary": n.get("summary") or "",
            "title": n.get("title"),
        }
        if kind == "lesson":
            entry["path"] = "docs/skill-sources/medatech-network/" + n["path"]
        out.append(entry)
        budget[0] = max(0, budget[0] - nbytes)
    return out, skipped_large


budget = [max_bytes]
skills_out, skip_s = pack(scored_skills, "skill", max_skills, budget)
lessons_out, skip_l = pack(gated_lessons, "lesson", max_lessons, budget)

load_order = []
for s in skills_out:
    load_order.append(
        {
            "kind": "skill",
            "path": s["path"],
            "bytes": s["bytes"],
            "summary": s["summary"][:160],
        }
    )
for lesson in lessons_out:
    load_order.append(
        {
            "kind": "lesson",
            "path": lesson["path"],
            "bytes": lesson["bytes"],
            "summary": lesson["summary"][:160],
        }
    )

used = max_bytes - budget[0]
out = {
    "query": query,
    "tokens": tokens,
    "helpIntent": help_intent,
    "activeTopics": sorted(active_topics),
    "budget": {
        "maxBytes": max_bytes,
        "usedBytes": used,
        "remainingBytes": budget[0],
        "singleFileCeiling": single_file_ceiling,
        "allowLarge": allow_large,
        "maxLessons": max_lessons,
        "maxSkills": max_skills,
    },
    "topics": [
        {"score": s, "id": n["id"], "title": n["title"]} for s, n in scored_topics[:5]
    ],
    "skills": skills_out,
    "lessons": lessons_out,
    "skipped": (skip_s + skip_l)[:20],
    "loadOrder": load_order,
    "agentRules": [
        "Do NOT read docs/skill-sources/medatech-network/_dag/dag.json (too large).",
        "Prefer loadOrder skills first; open lesson bodies only when summary is insufficient.",
        "Skip any path whose bytes exceed your remaining context; re-resolve with a tighter query.",
    ],
}
print(json.dumps(out, indent=2))
