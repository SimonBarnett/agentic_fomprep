# Priority SQL UDATE and user fields

## UDATE

Priority stores `UDATE` as **minutes since 1988-01-01**, not as a SQL `datetime`.

| Context | Correct | Wrong |
|---------|---------|-------|
| Form / SQLI | `SQL.DATE` | inventing datetimes |
| SQL Server trigger | `DATEDIFF(minute, '19880101', GETDATE())` (or site-approved equivalent) | `MAX(UDATE)+1` |

`MAX(UDATE)+1` on an empty/maxed set collapses to Priority zero display **01/01/88 00:01** and fails History UAT (UDATE too small / epoch).

## User login

`SQL.USERLOGIN` is **invalid**. Resolve:

```sql
SELECT USERLOGIN FROM USERS WHERE USER = SQL.USER
```

(or the form/SQLI equivalent already used on the form path).

## Mint gating

Only mint History/revision rows when text meaningfully changed. Empty leave-field must not insert spam rows. Prefer one Curr header per parent key (filter parent PART / revision correctly to avoid cross-part bleed).
