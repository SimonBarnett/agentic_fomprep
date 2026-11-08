# API Licence for WCF / priority-web-sdk

Web SDK calls that open forms (`formStart`, including `EXEC` for
`REPPREPDIRECT2`) and SaaS `priority.login` with an OIDC Bearer require the
login user to have an **API Licence**.

## Error text

```text
formStart(...) failed: To open the form via the API, you must flag the user as having an API Licence.
```

SaaS / Cloud login variant:

```text
To enter the system via the API, you must flag the user as having an API License.
```

Login can succeed (or reach the server) while `formStart` / SaaS login still
fails with this Blocker.

## Flag (dictionary vs forms)

On `system.dbo.USERSB`, column **`REST`** is titled **API License** in the
dictionary (`COLUMNS`). Related:

| Column | Title (typical) | Role |
|--------|-----------------|------|
| `REST` | API License | Required for SDK / SaaS API entry |
| `RESTLOGIN` | API User Name | **Required before** ticking REST via forms |
| `RESTFIELD` | API Field License | Field-level API |

`LICENSETYPE` alone is **not** the API Licence checkbox.

### SQL (on-prem / when SQL is available)

```sql
-- Dev/test only unless the operator approved the exact write
UPDATE B
SET REST = N'Y', RESTLOGIN = COALESCE(NULLIF(B.RESTLOGIN, N''), U.USERLOGIN)
FROM USERSB B
JOIN USERS U ON U.[T$USER] = B.[T$USER]
WHERE U.USERLOGIN = N'<web-user>';
```

### Cloud MCP / form path (no SQL)

On Cloud, the **Personnel File** form `USERSB` exposes **`RESTLOGIN`** but often
**not** `REST`. The API License checkbox is on form **`PRIVUSERS`** (and the
unprepared `USERPRIV` twin may exist — prefer `PRIVUSERS` if `USERPRIV` is
unprepared).

Sequence (operator-approved env only):

1. **USERSB** — set `RESTLOGIN` to the user's login (e.g. same as `USERLOGIN`).
2. **PRIVUSERS** — set `REST` to `Y` / true.

If you tick `PRIVUSERS.REST` first, Priority returns:

```text
Before flagging API License for a user, record an API User Name for him in the {USERSB.F} form.
```

MCP `form_update` on current Cloud MCP uses **`root_records`** (array), not the
older `root_form` shape in some skill leaflets. Include **all** key fields from
a prior `form_fetch` (e.g. `USERLOGIN`, `USERB`, `USERID`, `IDNUMBER`).

## Verify

```sql
SELECT U.USERLOGIN, B.REST, B.RESTLOGIN
FROM USERS U
JOIN USERSB B ON B.[T$USER] = U.[T$USER]
WHERE U.USERLOGIN = N'<web-user>';
```

Or MCP: `form_fetch` `PRIVUSERS` / `USERSB` for that `USERLOGIN` and confirm
`REST: true` and `RESTLOGIN` populated.

After flipping `REST`, retry the SDK walk. On-prem: if the web tier still
denies, recycle the **app pool** (prefer that over a full `iisreset`, which can
leave `W3SVC` stopped).

## Dedicated API user

Some estates already have a user with `REST='Y'` (often named like `apiuser`)
and a REST PAT. Prefer that account for unattended OData/MCP. OIDC Tabula users
used for WCF still need their own API License when the Bearer maps to that
USERLOGIN.

## Related

- Procedure prepare WCF walk: `PREPARE_PROCEDURE.md` / **priority-procedure-prep**
- SaaS WCF client: `SAAS_WCF_CLIENT.md` / **priority-saas-wcf**
- OData / REST: `ODATA_REST_CLOUD.md` (also mentions API licence for Bearer paths)
- MCP forms: **priority-mcp-forms** (`root_records`)
