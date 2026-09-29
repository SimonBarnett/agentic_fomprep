# Dictionary INDEXES TYPE=A for SQL IDENTITY columns

Harvest 2026-09-29 (from CE Element Edits leave-line; rule is Priority-generic).

## Error

```
Cannot update identity column '<COL>'. (Error 8102)
```

## Cause

When a physical column is SQL Server **IDENTITY**, Priority dictionary
`INDEXES` for that key must be **TYPE=A** (Automatic / Autounique).

**TYPE=U** (Unique) makes Tabula emit `UPDATE … SET <identitycol>=…` on
leave-line save. SQL Server rejects that with error 8102.

## Stock pattern

Identity surrogates use TYPE=A: `PART.PART`, `ORDERS.ORD`, and CE examples
`ZCLA_ELEDIT.EDITID`, `ZCLA_ELEDITLOG.LOGID`, `ZCLA_ELEDITSPLIT.EDITSPLIT`.

## Fix

```sql
UPDATE system.dbo.INDEXES SET TYPE = 'A' WHERE T$KEY = <key>;
```

Confirm the physical column is IDENTITY before changing TYPE. Fully log out
of Priority and log back in after dictionary changes, then Form Prep if
triggers/forms were touched.

## Do not

Do not flip an identity key to TYPE=U to clear Unique Index / Origin Table
warnings. Prefer Automatic (A) child surrogates + FORMJOINS filters
(see `FORMCLMNSA_JOINS.md`).

## Related

- Optimistic lock msg 154: `MSG154_OPTIMISTIC_LOCK.md`
- Dictionary inserts: `DICTIONARY_SQL.md`
- Unique / Origin Table: `FORMCLMNSA_JOINS.md`
