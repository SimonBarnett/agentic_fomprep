# FR-C — launcher README + hours-template legacy

## Goal

README Hours section matches the webhook gate; `hours-template.md` is clearly legacy (not the hours store).

## Deliverables

- Update `launcher/README.md` Hours mandatory section (webhook GET/POST, not origin/hours).
- Mark `launcher/hours-template.md` legacy / do-not-use-as-store, or remove from mandatory path if unused after cutover.

## Testable

- README documents `bob.ntsa.uk/bob/v1/hours` exit gate.
- No README claim that git `hours` branch is the mandatory store.
