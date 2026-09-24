# Priority procedure / trigger style

Priority-generic. CE examples are labeled.

## Banner (required on new or heavily touched triggers/procedures)

```
/* <NAME> — <one-line purpose> */
/* Inputs */
/*   :VAR1 — … */
/* Outputs */
/*   :VAR2 — … */
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

- F6 on include line → INCLUDE Line; F12 then F6 for body.
- Do not F6 an empty Form Name (opens wrong generator).

## Customization rules

- Customer objects use a 4-letter prefix.
- Copy vendor objects; do not edit vendor in place.
