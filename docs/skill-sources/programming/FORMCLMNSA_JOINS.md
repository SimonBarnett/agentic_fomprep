# FORMCLMNSA join expressions (child forms)

Harvest 2026-09-28 from CE DEV Unique Index / Origin Table login warning on `ZCLA_ELEDITLOGREM`.

## Symptom

`A Unique Index is defined with a column that has no Unique Index defined on its Origin Table (<child>)`

After Named Form Prep, `FORMJOINS` may rewrite to wrong columns (e.g. `GUID → TEXT`). TEXT has no Unique on the origin → Tabula login warning.

## Root cause

Child forms that join a parent need **FORMCLMNSA** rows with parent expressions:

```
= :$$.PROJACT
= :$$.EDITID
= :$$.GUID
```

Without those expressions, Form Prep can corrupt `FORMJOINS` even when `FORMJOINS` rows looked correct before prep.

## Working pattern (compare stock `ZGEM_EXTRASPLIT`)

1. Child Unique index: prefer Automatic surrogate (`REMID` / `LOGID`), **not** the join columns alone when the parent Unique key is wider.
2. `FORMJOINS` WEIGHT **100** on join keys.
3. Join-key `FORMCLMNS`: `HIDE=H`, `EXPRESSION=Y`, READONLY blank.
4. **`FORMCLMNSA`**: `= :$$.<PARENTCOL>` for each join key.
5. After every Form Prep, assert joins still match (mismatched count = 0).

## Prefer WCF / Form Generator for form dictionary edits

When editing form column / join / trigger **code**, prefer Form Generator over WCF / Form Generator FCLMN path over raw SQL dictionary edits. SQL is fine for one-off DEV recovery of physical indexes (`IGNORE_DUP_KEY`) and for asserting state.

## Related

- Unique Index / Origin Table rule (dictionary INDEXES TYPE U vs A)
- `IGNORE_DUP_KEY.md` (separate Tabula error)
- Day Works assert: restore FORMJOINS after prep
