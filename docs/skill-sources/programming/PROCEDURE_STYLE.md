# Priority procedure / trigger style

Priority-generic. CE examples are labeled.

## Banner (required on new or heavily touched triggers/procedures)

```
/* <NAME> â€” <one-line purpose> */
/* Inputs */
/*   :VAR1 â€” â€¦ */
/* Outputs */
/*   :VAR2 â€” â€¦ */
/* Heading */
/* Sub-heading */
```

When editing existing stack triggers, bring headers up to this standard.

## Debug pattern (CE example)

1. `#INCLUDE func/ZCLA_DEBUGUSR` (or site equivalent).
2. Before includes, set `:RUN_BY` to a string naming Form/proc / column / trigger-or-step.
3. Gate file logs on `:DEBUG = 1` writing to `:DEBUGFILE`.

## Shared vs dedicated triggers

Overwriting a shared POST-FORM (one TRIG id used by many forms) silently changes siblings. Prefer a **dedicated** TRIG for feature-specific mint/history logic (CE PART long-desc: shared TRIG 1306 replaced with dedicated 3797).

## #INCLUDE navigation (Form Generator)

- F6 on include line â†’ INCLUDE Line; F12 then F6 for body.
- Do not F6 an empty Form Name (opens wrong generator).

## Customization rules

- Customer objects use a 4-letter prefix.
- Copy vendor objects; do not edit vendor in place.

## FORMTRIGTEXT.TEXT line length (CAST IRON)

Each `FORMTRIGTEXT.TEXT` row is short (observed **max length 68** on current
estates). Long `SELECT … INTO :$1.…` lines truncate mid-statement and leave
SELECT/INTO column lists mismatched — Form Prep may still succeed while
runtime is wrong.

Split across multiple TEXTORD lines. Count characters before INSERT/UPDATE.
See also msg 154 resync hygiene in `MSG154_OPTIMISTIC_LOCK.md`.

## :VAR type consistency (CAST IRON)

Priority Form Prep fails with:

`Variable with two different types : VARNAME`

when the same `:VAR` is used as CHAR in one place and INT/REAL in another
**in the compile unit** (same trigger, #INCLUDE chain, or forms prepared
together).

### Known CE case (2026-09-28)

`ZCLA_ELEDITSPLIT` TRIG 22 had `:SORT = ''` (CHAR) then
`INTO :SORT, :FIXID` from `STRIND(...)` while other CE triggers
(e.g. `ZCLA_FIXACT`) use `:SORT` as numeric (`:SORT = 0`,
`MAX(SORT) INTO :SORT`).

**Fix:** rename the CHAR use to a dedicated name, e.g. `:DWFIXSORT`.
Do not reuse a well-known numeric name for a string.

Replay SQL (DEV applied): see Day Works
`scripts/fixes/Fix-ZCLA_ELEDITSPLIT-SORT.SQL`.