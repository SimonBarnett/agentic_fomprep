# FR-002: save the identified USERLOGIN for the next run

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

A successful whoami writes the login under the user profile, keyed by instance.

## Deliverables

- Path %USERPROFILE%\.priority-agent\last-user.json, UTF-8 without BOM.
- Object keyed by instance id. Value: userLogin, company, identifiedAt, source.
- Refuse a userLogin that fails BobHours.IsPriorityUserLogin. Leave the file unchanged.
- Never write access_token, refresh_token, or password keys.

## Testable

- Temp-profile test: whoami success creates the key for instance saas1.
- File text does not contain access_token.
- A value with a space is refused and the previous key stays.

## Out of scope

- Do not change the launcher prompt (FR-03).
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #384
