# FR-D --- harvest-agent-skills + skill host/store hygiene

## Goal

No skill teaches git hours branch as the hours store; HTTP `/bob/v1/*` hosts in this repo are bob.ntsa.uk.

## Deliverables

- Fix `.grok/skills/harvest-agent-skills/SKILL.md` bullet "hours on hours branch" -> webhook store on bob.ntsa.uk.
- Sweep `.grok/skills` + `docs/skill-sources` for store-on-branch wording and `irc.ntsa.uk` + `/bob/v1` HTTP cues.
- Leave IRC Ergo `irc.ntsa.uk` wording alone when it is about IRC connectivity.

## Testable

- Grep/fixture: zero "hours on hours branch" (or equivalent store-on-git) in skills.
- Zero `irc.ntsa.uk/bob/v1` in skills/docs skill-sources.
- hours-* still cite `bob.ntsa.uk/bob/v1/hours`.
