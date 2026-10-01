# Version Revision / shell discipline

Authority for shell files and Revision Steps: Priority Developer Portal
[Installing your Customizations](https://prioritysoftware.github.io/sdk/Installing-Customizations)
(Eshbel / Priority SDK).

## Eshbel create flow (must follow)

1. Book a row on **Version Revisions** (`UPGRADES`) with a short description.
2. Open the **Revision Steps** sub-level (`UPGNOTES`). Flag or add every
   modification that belongs in this shell (`TAKE*` / `DEL*` / `DBI` codes).
3. Run **Prepare Upgrade** (pinned ENAME from `v2/config/pin.json`, CE proof:
   `ZEMG_TAKEUPGRADE`). Output is `system\upgrades\NN.sh`.
4. On the target: **Install Upgrade**, then Named Form Prep for touched forms.

A booked `UPGRADES` row with **zero** linked `UPGNOTES` is not a shippable
shell. Prepare may still produce or leave a tiny/hand file; Install will apply
nothing meaningful. Always confirm Revision Steps before Prepare.

## One shell per workstream

- Maintain a dedicated Version Revision shell file as work proceeds.
- Prepare after meaningful batches.
- Never mix unrelated features into a shared upgrade shell (CE example: Day
  Works must not enter upgrade 8338).

## Flag or add TAKE steps (hard gate)

Priority auto-tracks many UI dictionary edits into unlinked `UPGNOTES`
(`UPGRADE = 0`, often `HOWCREATED = A`). SQL patches to `FORMTRIGTEXT` /
dictionary tables **do not** auto-create Revision Steps.

Before Prepare:

1. Count steps: `SELECT COUNT(*) FROM UPGNOTES WHERE UPGRADE = <UPGRADE>`.
2. If zero, **select** matching unlinked rows (set `UPGRADE`) or **insert**
   manual steps for the changed entities.
3. For trigger text changes use `UPGTYPE = 2` (`TAKETRIG`) with
   `ENAME` = form, `TRIGNAME` = trigger, `TYPE = F`.

Working manual TAKETRIG shape (match known-good shells such as CE 8346):

| Column | Value |
|--------|--------|
| `UPGTYPE` | `2` (`TAKETRIG`) |
| `HOWCREATED` | `M` |
| `AFTERPREP` | `Y` |
| `OPTFLAG` | blank (space) |
| `TYPE` | `F` for forms |

Wrong shape can produce: shell booked / UI "Installed" but **zero**
`INSTALLEDUPGTRIG` / TAKETRIG rows applied (silent miss). Always verify
installed trigger rows and form trigger hashes after Install.

### Common UPGTYPE codes (from `UPGTYPES`)

| UPGTYPE | UPGCODE | Use |
|---------|---------|-----|
| 2 | TAKETRIG | Form trigger add/revise |
| 4 | TAKEFORMCOL | Form column |
| 10 | DBI | Table/column/key |
| 14 | TAKEENTHEADER | Entity attributes / design |
| 18 | TAKEPROCSTEP | Procedure step |
| 24 | TAKESINGLEENT | Entire entity |
| 26 | TAKEFORMLINK | Form to sub-level link |

Full code list: Eshbel Installing Customizations "Explanation of the
Modification Codes".

## Re-prepare is normal (site practice)

Re-preparing the same Version Revision after content changes is expected on
this estate when steps were added or trigger text changed. Ignore SDK "do not
re-prepare" as a hard site rule when content changed. Prefer a clean Prepare
after Revision Steps are correct.

Headless Prepare (`priority-shell-compile` / `ZEMG_TAKEUPGRADE`) can return
"Revision does not exist!" / "No upgrades are available for preparation" even
when `UPGRADES` + `UPGNOTES` exist. A human Prepare click from Version
Revisions remains valid. Do not treat a pre-existing tiny `.sh` as proof that
Prepare emitted the flagged TAKE steps — parse the file for the expected
codes / trigger dump.

## Prepare vs Install

- Compile/Prepare Upgrade and Install Upgrade ENAMEs come only from
  `v2/config/pin.json` (PinComplete). Never invent.
- After Install of trigger text: Named Form Prep until `EXECPREPLOCK.UPD = N`
  and `LASTPREPDATE` advanced.

## Cross-links

- Compile: `priority-shell-compile`
- Install: `priority-shell-install`
- Form Prep after trigger text change: named Form Prep /
  `priority-form-prep-after-sql-change`
