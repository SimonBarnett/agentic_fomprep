# FR-003: launcher suggests the saved USERLOGIN

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The interactive prompt offers the saved login and Enter accepts it.

## Deliverables

- Prompt text: Priority USERLOGIN [<saved>]: when a last-user row exists for an instance in this session.
- Empty answer binds that login via BindSessionOwner.
- --hours-user still wins over the saved value.
- The Windows user name is never inserted.

## Testable

- launcher.Tests: saved MEDATECH and an empty answer sets priorityUserLogin MEDATECH.
- launcher.Tests: --hours-user OTHER binds OTHER.
- Stdout of the prompt contains [MEDATECH] and does not contain the OS user.

## Out of scope

- Non-interactive behaviour is FR-04. Mismatch exit is FR-05.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #385
