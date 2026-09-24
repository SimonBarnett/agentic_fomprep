---
name: priority-sql-udate-user
description: >
  Mint History or audit rows with correct Priority UDATE (minutes since 1988-01-01)
  and USERLOGIN from USERS. Use when UDATE shows 01/01/88, SQL triggers mint History,
  or /priority-sql-udate-user.
---

# Priority SQL UDATE and user fields

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-sql-udate-user`).

Authority: `docs/skill-sources/programming/SQL_UDATE_USER.md`.

## Hard rules

1. `UDATE` = minutes since 1988-01-01. Use `SQL.DATE` in form/SQLI; never `MAX(UDATE)+1` in SQL Server triggers.
2. `SQL.USERLOGIN` is invalid — use `USERLOGIN` from `USERS` where `USER = SQL.USER`.
3. Gate mint on meaningful text only; avoid empty leave-field spam and cross-part Curr bleed.

## Related

- Form engineering: **priority-form-engineering**
- Day Works Gate A History asserts: **priority-day-works-uat**
