# Priority SDK feature map (archaeology cheat-sheet)

Use when deciding *where* a site customization likely lives. Not a replacement for form/procedure dumps.

| Area | Look at |
|------|---------|
| Forms / triggers / subforms | Form tree, FORMTRIG / FORMTRIGTEXT, sub-level forms |
| Procedures + SQLI + ACTIVATF | EPROG / PROGTEXT; ACTIVATF recalc stacks |
| Reports / HTML docs | Report generators, HTML document procs |
| Tables / DBI | CATALOG (+ SQL register when OData blocked) |
| Form loads / INTERFACE | INTERFACE loads (`-enforcebpm` where used) |
| Menus | Menu Generator (F6 on menu ≠ Form Generator) |
| Business Rules + BPM | BPM definitions, rule attachments |
| REST OData | tabula.ini/{company}/… ; Basic auth |
| Web SDK | EFORM family, WCF walkers for prepare/install |
| MCP | Cloud Priority MCP ≥ 26.0 where licensed |
| TTS | `:FROMTTS` patterns |
| Privileges / multi-company | USERENV.DNAME vs UI title |
| Customization-Rules | 4-letter prefix; copy don't edit vendor |
| Version Revisions | Shells, TAKETRIG, Prepare/Install upgrades |

For a concrete site: dump form trees + triggers, ACTIVATF recalc stacks, INTERFACE BOM loads, TTS, BPM — then code.
