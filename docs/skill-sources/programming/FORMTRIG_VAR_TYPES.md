# Form trigger `:VAR` types (Form Prep)

## Error

```
Variable with two different types : SORT
```

(or another `:VAR` name)

## Meaning

During `FORMPREPDRCT2` / Form Preparation, Priority assigned two different
scalar types to the same `:VAR` in one compile unit (trigger + includes +
related forms).

## Fix pattern

1. Find all `:VAR` assignments / `INTO :VAR` in the failing form and its
   `#INCLUDE` / sibling triggers.
2. Keep **one type per name**. Prefer renaming over overloading:
   - CHAR / STRIND → `:DWFIXSORT`, `:CURFIX`, …
   - INT / MAX(col) → `:SORT`, `:KLINE`, …
3. Re-prep the form (`Prepare-NamedForm.ps1 -Name … -ForceUnprepared`).
4. Confirm the SORT/type warning is **gone** from SDK `errors[]`.
5. SQL gate still required: `UPD=N` and `LASTPREPDATE` advanced.

## CE example (2026-09-28)

`ZCLA_ELEDITSPLIT` TRIG 22: `:SORT = ''` then `INTO :SORT` from
`STRIND(ITOA(FIX),…)`, while `ZCLA_FIXACT` uses numeric `:SORT`.
Renamed CHAR use to `:DWFIXSORT`.

## Related

- `PROCEDURE_STYLE.md` / catalog `priority-procedure-style`
- `priority-formprep` (WCF prep warnings)
- `priority-uat-wcf` (`startSubForm` when direct `formStart` says unprepared)
