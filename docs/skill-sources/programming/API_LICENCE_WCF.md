# API Licence for WCF / priority-web-sdk

Web SDK calls that open forms (`formStart`, including `EXEC` for
`REPPREPDIRECT2`) require the login user to have an **API Licence**.

## Error text

```text
formStart(...) failed: To open the form via the API, you must flag the user as having an API Licence.
```

Login can succeed while `formStart` still fails with this Blocker.

## Flag

On `system.dbo.USERSB`, column **`REST`** is titled **API License** in the
dictionary (`COLUMNS`).

```sql
-- Dev/test only unless the operator approved the exact write
UPDATE B
SET REST = N'Y'
FROM USERSB B
JOIN USERS U ON U.[T$USER] = B.[T$USER]
WHERE U.USERLOGIN = N'<web-user>';
```

Related columns (do not confuse):

| Column | Title (typical) | Role |
|--------|-----------------|------|
| `REST` | API License | Required for SDK `formStart` |
| `RESTLOGIN` | API User Name | Often set on dedicated API users |
| `RESTFIELD` | API Field License | Field-level API |

`LICENSETYPE` alone is **not** the API Licence checkbox.

## Verify

```sql
SELECT U.USERLOGIN, B.REST, B.RESTLOGIN
FROM USERS U
JOIN USERSB B ON B.[T$USER] = U.[T$USER]
WHERE U.USERLOGIN = N'<web-user>';
```

After flipping `REST`, retry the SDK walk. If the web tier still denies, recycle
the **app pool** (prefer that over a full `iisreset`, which can leave `W3SVC`
stopped).

## Dedicated API user

Some estates already have a user with `REST='Y'` (often named like `apiuser`).
Prefer that account when CredMan / allowlist already points at it. Do not invent
passwords; use the customer connections file on the agent box only.

## Related

- Procedure prepare WCF walk: `PREPARE_PROCEDURE.md` / **priority-procedure-prep**
- OData / REST: `ODATA_REST_CLOUD.md` (also mentions API licence for Bearer paths)
