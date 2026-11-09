---
name: priority-service-desk-procedure-loop-desktop-tile
description: >
  An aged-debtors style custom procedure repeats because a step jumps to
  itself, and the desktop tile can still launch the old procedure after
  the menu is fixed. Use when procedure step GO repeats, stale desktop
  tile, prefixed procedure copy, or
  /priority-service-desk-procedure-loop-desktop-tile.
---

# Procedure self-loop and a stale desktop tile

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/procedure-loop-desktop-tile.md`.

Issue type: a customized procedure repeats forever because a step sets the next step to itself, and users can still launch the old procedure from a desktop tile after the menu points at the replacement.

Both stages were required. Fixing only the procedure left the old tile in place.

Known: internal note 2026-11-02 17:24 GMT: step 10 was setting GO to 10, so it constantly repeated. A custom report had also been inserted into the standard procedure. At 17:27 GMT the developer updated the step numbers, added a customer-prefixed procedure to the menu, and removed the other menu entry. They did not keep editing the standard procedure. On 3 Nov the customer still failed when using the tile. On 2026-11-04 09:37 GMT the customer deleted that desktop tile, added a new tile, and said the new tile was working.

Unknown: the exact procedure diff and any financial totals. Do not claim the tile change alone repairs the loop. Authoring rules for new trigger text stay in `priority-procedure-style`. This skill is the launch-path incident.

## Prerequisites

A developer reviews the flow in Test. Menu replacement uses a customer-prefixed copy. The user confirms which tile they click before anyone removes it. This harvest does not authorize editing the standard procedure or deleting a tile.

## Steps

1. Record how the report is started: menu, desktop tile, or both. Record the procedure name that actually runs.
2. In Test, read the step flow for a step whose GO target is itself, and for custom content dropped into a standard procedure.
3. The developer builds a customer-prefixed copy, corrects the self-jump, and replaces the menu entry. Do not keep patching the standard procedure in place.
4. Run the report from the new menu entry, not only from a developer session.
5. If the user's tile still fails, that tile is still bound to the old procedure. Confirm the target with the user, remove that tile, and add a tile that launches the prefixed procedure. Preserve any other desktop shortcuts.
6. The affected user reruns the original route and confirms the report finishes.

## Verification

Proven for SC263369: after the prefixed procedure and menu change, the report still failed from the old tile, and it worked after the customer replaced that tile (2026-11-04 09:37 GMT).

Not proven: the diff text and the report figures.

## Stop or escalate

Stop if the self-jump is not identified, if the proposal is to overwrite the standard procedure, or if the tile to remove has not been confirmed. No arbitrary step renumbering.
