# Programming skill-sources MANIFEST

Harvest date: 2026-09-24  
Owner: Eshbel → Bob build / Eshbel hostile MRB  
FR: `docs/feature-request-eshbel-priority-programming-harvest-2026-09-24.md`

| File | Catalog skill |
|------|----------------|
| PROCEDURE_STYLE.md | priority-procedure-style |
| SQL_UDATE_USER.md | priority-sql-udate-user |
| FORMPREP_SHADOW_TABLES.md | priority-formprep-shadow-tables |
| RECALC_CONCURRENCY.md | priority-recalc-concurrency |
| VERSION_REVISION.md | priority-version-revision-discipline |
| SDK_FEATURE_MAP.md | (docs only; optional catalog later) |

| DICTIONARY_SQL.md | priority-dictionary-sql | IDENTITY-safe dictionary inserts; EXECPREPLOCK / name_missing |
| IGNORE_DUP_KEY.md | priority-dictionary-sql | Tabula unique indexes must use IGNORE_DUP_KEY=ON |
| FORMCLMNSA_JOINS.md | priority-dictionary-sql / priority-formprep | Child FORMCLMNSA `= :$$.COL`; joins survive Form Prep |
| INDEXES_TYPE_A_IDENTITY.md | priority-dictionary-sql | IDENTITY columns keep INDEXES TYPE=A (8102 if U) |
| MSG154_OPTIMISTIC_LOCK.md | priority-form-engineering / procedure-style | msg 154: mid-edit :$1 race; nullable form cols; PRE-UPDATE resync hygiene; FORMTRIGTEXT 68-char lines |

| EMPTY_NAMED_TRIGGER_STUB.md | Empty FORMTRIG named stub (0 FORMTRIGTEXT); restore from good instance |
