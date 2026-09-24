# Recalc concurrency and checkpoint deletes

## ELEMENT sign (hang without 1205)

Some checkpoint delete includes expect a **positive** `:ELEMENT` and internally delete `-:ELEMENT`.

If PRE-DELETE selected backup rows with `PROJACT < 0` (negative checkpoints) and passes that value straight through, the include can **loop/hang** with no SQL 1205.

Fix pattern:

```
:ELEMENT = - :ELEMENT
#INCLUDE …/ZCLA_CHKPNT-DEL   /* site path */
```

(CE: `ZCLA_ELACT/ZCLA_CHKPNT-DEL` from HOUSETYPE PRE-DELETE.)

## Harden under live Stack

Before deleting an entity that participates in recalc:

1. Clear `ZCLA_RECALC` rows for **that entity only**.
2. Pre-purge dependent plot buffers for those checkpoints (CE: `ZCLA_SMALLWORKSPLOT` for `PROJACT<0`).
3. Ensure supporting NCI matches live (CE: `(PROJACT, FIX)` inclusive shape).

Do not drain the whole Stack for a smoke test unless the case says so.

## Blocking children

Open edit documents can block delete by design (CE: open `ZCLA_HTEDIT` → "Value exists in House Type Edits form"). Use 0-edit fixtures for delete smoke.

## Stale-price consumers

Some calculators only check `RECALC=Y` / `ISBUILD=Y` and then read **already-priced** element costs. They can still open on stale prices after HT swap or with stuck P/INPROG flags. Treat as a product/ISS risk, not only a stuck-flag cleanup.
