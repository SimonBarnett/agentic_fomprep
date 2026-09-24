# Priority hours — enter a line (UI)

**Form:** Reports of Project Hrs/Expenses.

## Hard rules

1. **Never leave the current row incomplete.** Leaving early creates a record with missing columns.
2. **WBS is required** before leaving the line. Tab to WBS, **F6**, pick a code — never Tab/Ctrl+Enter with WBS blank.
3. **Ctrl+Enter** adds a **new blank** line. Never overwrite an existing booked row.
4. Fill every column on the line before Ctrl+Enter: Date, Project, WBS, Part (if used), Hours / Total to Charge, Billable flag, Part Description.

## Loop

1. Navigate to a blank line (or Ctrl+Enter from a completed row).
2. Enter Date.
3. Enter Project (picker preferred).
4. Tab to WBS → F6 → select code (see orchestrator WBS map).
5. Enter hours; set Billable per customer rules (non-billable customers force N).
6. Enter description (orchestrator PDES rules).
7. Only when complete: Ctrl+Enter for the next blank line, or leave the form after the last line.

## After a batch

- Re-search the day and sum hours (must be ≤8.0).
- Optionally run `priority-hours-less-than-8-report` for the month.
