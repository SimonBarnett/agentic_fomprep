# Feature request: MRB + FR intake live in GitHub issues, not only /docs

**Date:** 2026-09-20
**Repo:** https://github.com/SimonBarnett/agentic_fomprep
**Raised by:** MRB worker (hostile MRB of `80d8ce4`)
**Parked by:** bob-spec-intake
**MRB home:** this issue

## Ask

`bob-hostile-mrb` and `bob-spec-intake` make **git issues** the source of truth: every parked
feature request has a `feature-request` issue that links its `/docs` markdown, and every MRB
verdict is an **issue** with labels `mrb` + `mrb-fail`/`mrb-pass`. This repo does not honour
that today, so review state only exists as loose markdown that nothing tracks or closes.

## Observed state at `80d8ce4`

| Hole | Evidence |
|---|---|
| Four parked FR markdown docs, no `feature-request` issue for any of them | `docs/feature-request-{priority-generic-catalog-rename,priority-skills-catalog,ce-priority-dba-skills,shell-compile-install-v2-spec-0.1}*` vs issues #1–#3 |
| MRB verdicts landed as commits, never as issues | `docs/mrb-2026-09-19-v1.md`, `docs/mrb-wcf-walker-23e7e64-eshbel-2026-09-19.md`, `docs/mrb-2026-09-19-wcf-walker-eshbel.md`; zero issues labelled `mrb` |
| Two divergent MRB docs for the same tip `23e7e64` merged together | `80d8ce4` merges both parents' review docs (113-line + 29-line) |
| MRB PDF in the tree | `docs/mrb-2026-09-19-v1.pdf` — the skill says do not generate MRB PDFs |
| No index of which doc is current | `/docs` has no README or front matter marking superseded reviews |

## Ask (scope)

1. Open a `feature-request` issue for each parked `docs/feature-request-*.md` that lacks one; put
   the md path in the body. That issue is the MRB home for that FR.
2. MRB verdicts are posted as issues (`mrb` + `mrb-fail`/`mrb-pass`) on this repo. A `/docs`
   copy is optional and must link back to the issue.
3. One review doc per reviewed SHA. Where two already exist for the same tip, keep the fuller
   one and reduce the other to a one-line pointer (or delete it).
4. Delete or stop adding `docs/mrb-*.pdf`.
5. `docs/README.md` index: FR docs, plans, reviews, and which SHA each review covers.

## Do not

- Rewrite or re-verdict historical reviews; only re-home and de-duplicate them.
- Change v1 `src\Prepare-NamedForm.ps1` or any `v2/` product code for this FR.
- Auto-close existing issues.

## Acceptance

1. Every `docs/feature-request-*.md` on main has exactly one open-or-closed `feature-request`
   issue linking it.
2. No two `docs/mrb-*` files review the same SHA.
3. No `docs/mrb-*.pdf` on main.
4. `docs/README.md` lists FRs, plans and reviews with their SHAs.
5. Bob's next MRB can be filed as an issue against the FR issue with no new md required.

## Out of scope

- The WP0 live-walk evidence gap and the `formlimited_audit` SQL defect — those are required
  fixes on the MRB issue for `80d8ce4`, not this FR.
- Any change to the verdict vocabulary (`FAIL` / `PASS-nits` / Bob's `PASS-UAT` stamp).
