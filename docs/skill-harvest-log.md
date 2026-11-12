# Skill harvest log

- 2026-11-11: `priority-create-table` — WINDBI add column is `FOR TABLE <T> INSERT` (not `CHANGE TABLE … ADD`); table and column titles ≤ 20 characters. Authority in `CREATE_TABLE.md` §5–§6 and `DICTIONARY_SQL.md`.
- 2026-11-07: `priority-service-desk-shipping-site-vat`. SC263171 order VAT followed the shipping site. Customer confirmed the site correction. No tax code stored. Posted orders are not recalculated by this change.
- 2026-11-07: `priority-service-desk-procedure-loop-desktop-tile`. SC263369 step 10 set GO to 10. Prefixed copy and menu replacement were not enough until the customer replaced the old desktop tile on 2026-11-04. Do not edit the standard procedure in place.
- 2026-11-07: `priority-service-desk-mobile-migration-qr`. SC263384 apps failed after a server move. A new registration QR worked. QR contents and menu path were not recorded. Mail setup was not confirmed.

- 2026-11-07: `priority-service-desk-forecast-mrp-retrieve`. SC263390 Retrieve Sales Orders - MRP, Selected Orders only, set forecast lines to MRP? Y in local and customer Test. Live not run. Do not use All Open Orders from this skill.

- 2026-11-07: `priority-service-desk-first-costing-baseline`. SC263410 had never run costing, so 01/01/22 was costed before the 31/03/26 valuation. Those dates are not universal. Customer could then run the valuation. Distinct from the orphan work-order past-balance escalation. No autonomous delete.
- 2026-11-07: `priority-service-desk-quote-so-attachment-refresh`. SC263161 paperclip worked after refresh and reopen of the new sales order. Mitigation only. No product fix recorded.
- 2026-11-07: `priority-service-desk-scanner-numeration`. SC263177 Scanner Trans numeration was extended and the customer could open documents. Not an API quota. Diff and new width unknown. No sequence reset.
- 2026-11-07: `priority-service-desk-public-ip-allowlist`. SC263173 login worked after the new public IP was allowlisted. Later churn still happened. No addresses stored. Not an email or password fix.
- 2026-11-07: `priority-service-desk-license-manual-install`. SC263215 official 25.0 license matched the system and the higher seat count was visible. 26.0 was the wrong file. Renew License remains unfixed. No license material stored.
- 2026-11-07: `priority-service-desk-portal-view-price`. SC263208 View Price in Portal was ticked and the customer said it worked. Discounts and branding were not part of the fix. No prices recorded.
- 2026-11-07: `priority-service-desk-warranty-auto-raise`. SC263216 Live lacked Stat After Auto Raise. Two missed contracts were replayed in Draft after owner approval. Next automatic shipment not confirmed. Trigger diff unknown.
- 2026-11-07: `priority-service-desk-email-column-translation`. SC263220 Email Editor custom fields appeared after a missing column translation was added. Language direction in the notes disagrees. Check the installation. No direct dictionary edit.
- 2026-11-07: `priority-service-desk-invoice-po-column`. SC263237 PO reference was hidden in the selected invoice format. The field was MC Cust PO. Customer confirmed it printed. Wrong-column guess was rejected.
- 2026-11-07: `priority-service-desk-standard-cost-update`. SC263270 UpdStdCost=0 so nightly costing did not write catalogue standard costs. Calculate/Update Standard Cost corrected the parents. No amounts. No constant change.
- 2026-11-07: `priority-service-desk-hmrc-mtd-reauth`. SC263292 customer reauthenticated via Set Up for HMRC's MTD and the VAT submission went through. Not SC263549. No tokens. 18-month interval is not current policy.
- 2026-11-07: `priority-service-desk-serial-site-filter`. SC263316 serial customer matched but the site did not, so the device dropdown was empty. It listed the device when the site was removed. Customer accepted the explanation. Do not drop real site segregation.
- 2026-11-07: `priority-service-desk-mrp-production-days`. SC263299 practice company: quantity 5 and Production Days 21 with Time per Batch, MRP without Work Plan, duration 21 not 105. Customer tested maximum 100. Not live. Numbers are not universal. Earlier Work Plan advice is superseded for this case.
- 2026-11-07: `priority-service-desk-po-approval-restart`. SC263332 Cancel Auth restarted from the status that starts approval. Customer confirmed 2026-10-23 09:31 BST. Pending Auth is an example only. No status SQL.
- 2026-11-07: `priority-service-desk-runaway-report-cpu`. SC263359 two manual Repair History per Serial Number runs were terminated. Cleanup finished and SQL CPU recovered. HEAVYQUERY only logs. Mitigation only. No KILL script.
- 2026-11-07: `priority-service-desk-data-exchange-email-company`. SC263373 reinstall did not restore data exchange. Define Comps. for Data Exchange and Update Interface by Email in each company did. Customer found exchanges by searching the current date. Full PO and receipt lifecycle was not recorded.
- 2026-11-07: `priority-service-desk-shopify-product-code-import`. SC263397 order imported after the Shopify product code mapping was corrected. Exact field unknown. Failure email not fixed. Not the Dokka split-receipt skill.

- 2026-11-07: `priority-service-desk-last-purchase-price-report`. SC263402 report built in Part Catalogue Report Generator for last purchase price and date on R parts, then added to the menu. Field identifiers were not retrieved. No price update.

- 2026-11-07: `priority-service-desk-quote-order-duplicate-lines`. SC263415 copied standard BUF6 line-add inside custom triggers and duplicated quote-to-order lines. Redundant call removed. Copy-company Open Order had no duplicate lines. Exact diff and live customer test were not retrieved.

- 2026-11-07: `priority-service-desk-blank-partname-report`. SC263245 consumables report blank lines came from empty part link rows. PART.PARTNAME <> '' was deployed and the customer confirmed. Line 800 is not universal.

- 2026-11-07: `priority-service-desk-analytics-child-field`. SC263252 shipping-voucher Analytics hid parents without Additional Expenses while a child cost field was included. Removing the field restored parents. Full cost report not implemented.

- 2026-11-07: `priority-service-desk-ui-language-print`. SC263256 printouts were wrong in American English. Changing the UI language fixed them. Target language not named. Not the tile or OData language cases.

- 2026-11-07: Enriched `priority-odata-dev` with SC263233. Lead tasks were missing until the installed language code was added after the ini file. 2 and 3 are the supplier's British and American codes, not a hardcoded default.

- 2026-11-07: `priority-service-desk-mobile-app-update-registration`. SC263416 login succeeded after app update to the then-current 183.2.79 and user registration. That build is not a standing target. Update and registration were not isolated.

- 2026-11-07: Enriched `priority-formprep` with SC263320 and SC263343. After a move, preparing forms (and, for SC263343, procedures) cleared unprepared-form access. Exact commands were not recorded. Procedures stay on priority-procedure-prep.

- 2026-11-07: Enriched `priority-ops-install-upgrade` v1.1.0. SC263521 mobile security-certificate error cleared by installing the intermediate certificate (technician and customer confirmed); reboot and service recovery had already failed for that mobile error. Exact store and command unknown. SC263488 is a different case: services had not started after reboot, IT started them, Priority came back. Service names unknown. Do not treat either example as the other.
- 2026-11-07: Service-desk topic plus `priority-service-desk-record-modified-custom-close`. Work-order close record-modified when custom close logic sets the backend balance before the transition completes (SC263394, customer confirmed 2026-11-06). Exact code edit unknown. Diagnosis, authorized Test repro, escalate to the customization owner. Not the MSG154 original-buffer resync. Holds and unresolved calls from the same scan were not harvested.

- 2026-11-07: Enriched `priority-backup-standard` v1.1.0 with SC263422. Disk recovered after older backups were removed and the latest-night backup was kept. SQLBACKUPDAYS 2-to-1 was a guess, not a new retention standard. Monitoring OK is not a restore test.

- 2026-11-07: `priority-service-desk-report-browser-site-data`. SC263476 report ran in incognito; clearing that tab's cache and cookies let the user run it. Plugin was already installed and detected. Exact cached item unknown.

- 2026-11-07: `priority-service-desk-inventory-conversion-raw-lot`. SC263474: new lot must exist in Raw Material Lots before Inventory Conversion selection. Leave the conversion in Draft. Customer said the draft path was done. Finalized stock movement was not demonstrated. PLotByVendor=1 was observed there and is not a universal setting change.

- 2026-11-07: `priority-service-desk-user-paccount-signup`. SC263458: a former-employee flag inactivated the linked user; a later active user failed registration because P.Account Sign Up was unticked. Support corrected that box and the customer retry worked. Do not reactivate departed employees from this skill.

- 2026-11-07: `priority-service-desk-webhook-sync-mitigation`. SC263461: synchronous WebhookProcess used about 20s of a 21s request while outbound TLS failed. Temporarily disabling the listed business-rule webhooks restored performance (customer confirmed). Permanent endpoint repair and re-enable were not done. Mitigation only.

- 2026-11-07: `priority-service-desk-form-designer-multi-record`. SC263454: Form Designer change of the multi-record view generated multi-record entries; the design was copied to other users; customer said live was correct. Missing-entry cause and field list unknown. Not priority-form-engineering.

- 2026-11-07: `priority-service-desk-orphan-wo-past-balance`. SC263492: part created with no work-order number. Warehouse transfer was checked and was not the cause. Customer completed support-advised document corrections and Update Invent. by Past Balance, then said it was sorted. Formal approval, backup and full reconciliation evidence were not retrieved; future corrections require the stated owner controls. Escalation only. No autonomous delete or repost.

- 2026-11-07: `priority-service-desk-dokka-split-receipt-sync`. SC263506: split Priority receipt lines stayed aggregated in Dokka. Dokka reported a change on their side and that split goods synced. Customer retest was not documented. No local SQL or config patch. Adjacent tax calls SC263507, SC263508, and SC263509 stay unresolved and separate.

- 2026-11-07: `priority-service-desk-browser-plugin-enable`. SC263453 enabling the disabled plugin restored executive reports. SC263452 enabling it for Priority in Chrome restored statement PDFs. SC263456 attributes a shipping-document link to the plugin without recording the exact action, so it is corroboration only. No catalog plugin-enable skill existed to enrich.

- 2026-11-07: `priority-service-desk-maxformlines-user-group`. SC263442: some role members saw 2000 rows because of a user/group MAXFORMLINES override. Path: System Constants, MAXFORMLINES, Constant per User/User Group. Customer said sorted. Final value and precedence unknown. Do not lift all caps.

- 2026-11-07: `priority-service-desk-split-grv-before-invoice`. SC263436: split the GRV received line before the first invoice link, then invoice the split lines separately. Support finalized two 500-unit invoices against a 1000-unit receipt on local Priority 26.0 without changing received quantity. Customer production test was not recorded. Not the Dokka split-sync skill.

- 2026-11-07: `priority-service-desk-duplicate-report-cleanup`. SC263424: duplicate project reports cleaned by a developer script limited to an approved list, tested on a copy company, then run live after approval. Customer said it looked updated. Query text was not retrieved. Escalation only. Do not invent delete SQL. Do not blame a service restart.

- 2026-10-26: SaaS OIDC login residuals - PowerShell ordered-map `&` join; HttpClient no-auto-redirect; consent GET+UA; OData Bearer empty HTTP 500 = DNAME/API gap (stop guessing); WCF formStart REST may 404 on SaaS. `SAAS_OIDC_LOGIN.md` + catalog `priority-saas-oidc-login` v1.1.0.
- 2026-10-25: Priority SaaS / Cloud interactive login â€” tenant `POST /webui/<tenant>` exposes `_tabulaini=tabâ€¦.ini`; OIDC `priority-web` + PKCE; Accounts `login/checkPassword` then `mfa/checkotp` (single-use); consent redirect; `/auth/oauth2/token`; Bearer for tenant POST. New `docs/skill-sources/programming/SAAS_OIDC_LOGIN.md` + catalog `priority-saas-oidc-login` v1.0.0; pointers in `ODATA_REST_CLOUD.md` and `priority-mcp-setup`. Source: generic SaaS connectivity (customer names stripped).

- 2026-10-16: OData PATCH patterns â€” composite EntityType keys, `Prefer: return=representation`, approved Live writes only; field-touch re-fire of `POST-UPDATE` / BUF includes after reading trigger text. Extended `ODATA_REST_CLOUD.md`; catalog `priority-odata-dev` v1.2.0 hard rule 10. Source: Priority cloud approved config + document re-raise (generic lessons only).

- 2026-10-15: Cloud OData REST patterns â€” PAT Basic (`token`/`PAT`), DNAMEâ‰ LIVE, FORMLIMITED RESTFLAG null â†’ HTTP 400, form trigger text via EFORMâ†’FTRIGâ†’FTRIGTEXT (not FORMTRIG alone), typed *DOCSTATS entities, extended tables without EFORM. New `docs/skill-sources/programming/ODATA_REST_CLOUD.md`; catalog `priority-odata-dev` hard rules 7â€“9 + RESTFLAG/typed-status notes. Source: Priority cloud read-only investigation (generic lessons only).

- 2026-10-09: Hours recording CAST IRON â€” `{customer}/{project}/log.md` (or `{project}/log.md`) must be created/updated with actual work done whenever hours are logged (billing evidence). Corrected live Bob hours JSON field names (`start`/`customer`/`project`, not `started_at`/`customer_slug`); closed-in-one-POST with `start`+`end`. Updated `hours-log-work-session` skill-source + `.grok` leaflet, `AGENTS.md` CAST IRON #7, `hours-draft` pointer. Bobiverse API opacity filed as SimonBarnett/bobiverse#3673.

- 2026-10-08: Priority Agent home cleanup â€” repo-root `AGENTS.md`, `tools/Sync-PriorityGrokSkills.ps1` syncs portable `priority-*` catalog leaflets into `.grok/skills` (excludes Day Works product + DBA/backup by default). README/VISION point at generic Priority Agent; CE DEV1 stays example pin in `agent_readme.md`.

- 2026-10-08 (DEV1 / Day Works WP4): New skill `priority-create-table` + `CREATE_TABLE.md`. Form Generator *Table ZCLA_ELEDITDW is missing column GUID* was CHAR `COLUMNS.SIZE=0`; Tabula *Ignore Duplicate Values* was bare `PK_*` with `IGNORE_DUP_KEY=OFF`. Rules: unique index `[T#1#COLâ€¦] WITH (IGNORE_DUP_KEY=ON)`; CHAR/DATE SIZE=WIDTH; REAL/INT SIZE=8. Updated `DICTIONARY_SQL.md` + catalog `priority-dictionary-sql` v1.1.0.

- 2026-09-24: Added foundation honesty-box skill at `.grok/skills/harvest-agent-skills/SKILL.md` (home `https://github.com/SimonBarnett/agentic_fomprep`). Table row: Formprep / MSSQL fleet playbooks -> `SimonBarnett/agentic_fomprep`. Product playbooks remain under `v2/plugins/*/skills/` and `v2/apps/mcp-catalog/catalog/`.

- 2026-09-28 (DEV1 / Day Works WP3): New skill `priority-dictionary-sql` (.grok + catalog) and `docs/skill-sources/programming/DICTIONARY_SQL.md`. IDENTITY-safe CATALOG/COLUMNS/T$EXEC/INDEXES inserts; COLUMNS.CNAME; INDEXES.T$KEY; EXECPREPLOCK required before Named Form Prep (`name_missing`); EXECMODULE; shell DBI CREATE TABLE pattern; PowerShell Tee-Object return pollution. Clarified `priority-formprep` catalog `name_missing` / `still_unprepared` (FCLMN).

- 2026-09-28: Rebased honesty-box / Foundation harvest onto main after CONFLICTING PR #68 (issue #58). CAT-T50 asserts Foundation on all priority-* leaflets.

- 2026-09-28 (DEV1): Tabula *Ignore Duplicate Values* + Unique Index/Origin. Harvested `IGNORE_DUP_KEY.md` + `FORMCLMNSA_JOINS.md`; updated `DICTIONARY_SQL.md`, `FORMPREP_SHADOW_TABLES.md`, catalog `priority-dictionary-sql` / `priority-formprep-shadow-tables`. Physical unique indexes need `IGNORE_DUP_KEY=ON` (company often reported as `system`); child joins need FORMCLMNSA `= :$$.COL`.

- 2026-09-28 (DEV1): Form Prep `Variable with two different types : SORT` Ã¯Â¿Â½ `:VAR` type clash (`ZCLA_ELEDITSPLIT` `:SORT = ''` vs numeric `:SORT`). Harvested into `PROCEDURE_STYLE.md`, `FORMTRIG_VAR_TYPES.md`, catalog `priority-procedure-style`, `priority-formprep` (WCF warnings + formStart vs SQL gate), `priority-uat-wcf` (`startSubForm` when direct `formStart` says unprepared). Fix applied on DEV as `:DWFIXSORT`.

## 2026-09-29 - ce-priority split + leave-line generics

- Relocated CE DBA pack to private `SimonBarnett/ce-priority` `docs/dba/`; `docs/skill-sources/dba/` is pointer-only.
- Harvest domain table: CE instance/DBA/customisations -> ce-priority; Day Works product -> ce-dayworks.
- Added Priority-generic `INDEXES_TYPE_A_IDENTITY.md` and `MSG154_OPTIMISTIC_LOCK.md` under programming/.

## 2026-09-30 - empty named trigger stub

Added docs/skill-sources/programming/EMPTY_NAMED_TRIGGER_STUB.md.

## 2026-09-30 - WCF Projects hierarchy / retrieve window

Expanded `priority-uat-wcf` skill-source + catalog (v1.1.0): parent `startSubForm` when `formStart` stays O11 after Form Prep; `DOCUMENTS_p` retrieve windows and sticky empty `DOCNO`/`DOC` filters; clearSearchFilter + reload before `setActiveRow`; plot vs element `PROJACT` keys; `Owner missing`; multi-project scan fallback; unique appname/devicename. Product runner stays in ce-dayworks.

## 2026-09-30 - Version Revision TAKE steps (Eshbel shell files)

Expanded `VERSION_REVISION.md` + catalog `priority-version-revision-discipline` v1.1.0 from Eshbel Installing Customizations: Revision Steps (`UPGNOTES`) must be flagged/added before Prepare; SQL `FORMTRIGTEXT` patches do not auto-create TAKE rows; empty steps = non-shippable shell; TAKETRIG shape; headless Prepare may still need a human click. CE proof: shell 8366 Price Log Fix.

## 2026-09-30 - msg 154 nullable form columns + FORMTRIGTEXT 68

Expanded `MSG154_OPTIMISTIC_LOCK.md`: Cause B = nullable origin columns painted on the form with NULL in existing rows (`NULL = NULL` â†’ 0-row UPDATE); DEFAULT + backfill; resync hygiene (do not resync the column the user is editing); `FORMTRIGTEXT.TEXT` max ~68. Updated `PROCEDURE_STYLE.md`, catalog `priority-procedure-style` / `priority-form-engineering` (meta 1.1.0). Version Revision TAKE-steps harvest: merged PR #88.

## 2026-10-01 - Prepare procedure (REPPREPDIRECT2)

- New skill-source `docs/skill-sources/programming/PREPARE_PROCEDURE.md`.
- Catalog `priority-procedure-prep` (meta 1.0.0) + runners `src/Prepare-NamedProcedure.ps1`, `src/sdk/run-repprep-via-exec.mjs`.
- Path: `EXEC` â†’ `activateStart(REPPREPDIRECT2)`. Bare `procStart` cannot fill FILE `PAR`.
- Success: `EXECPREPLOCK.UPD=N` + `system/prep/d{T$EXEC}.prp` mtime advanced (`LASTPREPDATE` may stay 0).
- Cross-link from `priority-formprep` (TYPE=P is not EFORM).

## 2026-10-02 - UAT WCF startSubForm parent confirm + name filters

Expanded `priority-uat-wcf` (skill-source + catalog meta **1.2.0**) from CE Day Works WP1 WCF demo:

- Confirm warning/info/error on the **parent** during `startSubForm` when the child handle is still null.
- Prefer `PARTNAME` (string) filters; numeric `PART` filters often return Invalid filter.
- Sibling sub-forms under one parent: open hard path before revise-text; soft-skip text locks.
- WCF `getRows` may be empty after a successful open - SQL remains data authority.
- ASCII-only punctuation in PowerShell 5.1 runner strings without UTF-8 BOM.
## 2026-10-08 - Bobiverse intake dual-mode (moved from bobiverse#3349)

- Harvested lesson on CAST IRON `-Repo SimonBarnett/agentic_fomprep` + Report/Invoke wrappers + skillbook-referral + CAT needles; anti-omnibus small FRs. Refs #109-#118 / docs #119. Moved from SimonBarnett/bobiverse#3349.

## 2026-10-25 - Price quotation (PQ) create via OData

- New skill-source `docs/skill-sources/quotes/priority-price-quotation-create.md` (+ folder README).
- New catalog `priority-price-quotation-create` (meta 1.0.0), synced to `.grok/skills/`.
- Rules: draft-first approval for live writes; header copied from recent PQs (expiry +30d, REFERENCE max 12); one `CONS-HR-MED` line per step, qty = 2x internal, `ZEMG_INTQUANT` = internal, prep time spread; never send PRICE (triggers set it, read it back); lines inserted at LINE 1 and LINE not settable -> post in reverse; per-line remarks (Outcome / Forms/columns, `[new]` columns, no template headings, replace not append, plain apostrophes not `&#x27;`); quote Note + standard terms; duplicate checks; full read-back of lines and totals.
- Source session anonymised (customer, request and project replaced).


## 2026-10-31 - Report form zooms + API Licence + portable prep

- New skill-source `docs/skill-sources/programming/REPORT_FORM_ZOOMS.md` (ZOOMCOLUMNS2 FORMEXEC/COLNAME/ZOOMEXEC/JOINCOL; hide id; show PARTDES-style descriptions; prepare after change).
- New skill-source `docs/skill-sources/programming/API_LICENCE_WCF.md` (USERSB.REST = API License for formStart; prefer app-pool recycle over iisreset).
- Expanded `PREPARE_PROCEDURE.md`: portable `run-repprep-via-exec.mjs` path for airc/customer boxes; API Licence cross-link; Priority root discovery.
- Catalog `priority-report-form-zooms` (meta 1.0.0), `priority-api-licence-wcf` (meta 1.0.0); bumped `priority-procedure-prep` to **1.1.0**.
- Synced via `tools/Sync-PriorityGrokSkills.ps1`.
- Source: anonymised HR Smith Dev session (assembly-tree report links + prepare kit); no customer hosts/secrets in skill bodies.


## 2026-11-03 — SQLI entity column names

- PROCEDURE_STYLE: do not name custom SQLI table columns PART/SERIAL/SERN (entity clash).
- Catalog priority-procedure-style leaflet note.


## 2026-11-04 - SQLI strings, PROGPARAM, report FILE/REPCLMNSA

- PROCEDURE_STYLE: `''` vs `'\0'` (boolean 1-char); PROGPARAM on SQLI for `:$.NAME`; clear leftover INPUT PROGRAMSTEXT; GOTO forward / LOOP backward; report work tables without FILE/LINK; clear REPCLMNSA.EXPR with REPCLMNSTEXT; T-SQL CHAR(39) deploy tip for empty-string PROGRAMSTEXT.
- Catalog `priority-procedure-style` bumped to **1.2.0**.
- Synced via `tools/Sync-PriorityGrokSkills.ps1`.
- Source: anonymised customer Job Progress SQLI/report session; no hosts/secrets.

## 2026-11-08 — SaaS WCF Phase 1 field fix (Hillier Live)

- Tenant: Priority Cloud (generic lesson; customer name omitted from catalog).
- Bug: host-only login URL → SDK appends `/wcf/wcf/Service.svc` → `Can't connect to server.` Fix: use probed `wcf` (`…/wcf/service.svc`).
- Next error after fix: API License required on OIDC user for WCF; dictionary inventory path = REST PAT + OData (language `,3`) / Cloud MCP.
- Also: strip UTF-8 BOM on token/allowlist JSON; `token_expired` from `expires_in`+`obtained_at`; Failure table in `SAAS_WCF_CLIENT.md`.
- Evidence: `npm test` 20 pass; `Test-Fr-PrioritySaasWcf.ps1` PASS; Live `session` returns `api_licence` with `loginUrlSource=probe.wcf`.
- PR: https://github.com/SimonBarnett/agentic_fomprep/pull/338

## 2026-11-08 — API Licence Cloud form path + MCP root_records

- Cloud form path: set `USERSB.RESTLOGIN` then `PRIVUSERS.REST` (USERSB form often lacks REST column).
- MCP `form_update` requires `root_records` (not `root_form`).
- Updated `API_LICENCE_WCF.md` + catalog `priority-api-licence-wcf` / `priority-mcp-forms`.
- Source: SaaS WCF Live smoke after API License tick (generic). Folded into PR #338.
- 2026-11-09 (FR #339): Phase 2 `priority-saas-wcf` prepare form|procedure|report + FORMPREPERRS + proc start + SaaS OData gate (`odataBase`); never preparedClaim without gate.
- 2026-11-09 (FR #349): gitignore `.bobiverse-seat` / `**/.bobiverse-seat`; harvest-agent-skills: seat markers stay untracked.
- 2026-11-12: `priority-service-desk-browser-plugin-enable` 1.1.0. SC263047 added as corroboration: after a fresh install Chrome enabled the extension but disabled it for the Priority site (found in remote session). Customer retest not recorded. SC262928 known fix: pin the extension and enable it for the Priority tab, refresh; customer said email working. SC262664 added: Chrome silently disabled the extension; re-enable plus mail-by-Outlook setting fixed notifications.
- 2026-11-12: `priority-service-desk-closed-so-mrp-flag-demand`. SC262958: completed/cancelled SO still drove MRP demand; support removed MRP: Y from its order items; after MRP re-ran the customer said resolved.
- 2026-11-12: `priority-service-desk-company-timezone-scheduled-reports`. SC263125: after v26 upgrade scheduled report emails seemed missing; they arrived an hour late. Define Input for Task had no effect. Support set a time zone on each company; customer closed the call. Explicit timing retest not recorded. SC262659 second example: time stamps out because companies had no time zone; setting it fixed it (customer-confirmed).
- 2026-11-12: `priority-service-desk-debit-memo-part-account`. SC263134: debit memo journal unposted with account Lineitems because the part had no nominal account. Defining the account on the part resolved it (support note after call). Account values and form path not stored.
- 2026-11-12: `priority-service-desk-form-design-restore`. SC262983: Customer Sites showed data in wrong fields for one user across companies; restoring form design fixed it (user confirmed). SC263041: missing sublevel restored by hide/unhide in form design (support note).
- 2026-11-12: `priority-service-desk-inventory-count-prepare-zero`. SC263014: user could not zero a part stock by inventory count because the count was not prepared. Prepare Count for the part, leave count 0, approve. Customer confirmed they forgot the prep.
- 2026-11-12: `priority-service-desk-mrp-purchase-planning-input`. SC263116: overnight MRP in one company ran without Purchase Planning, so work orders but no purchase demands. Ran MRP with Purchase Planning, updated user input, Refresh Task Input by User. Customer said all resolved after a week.
- 2026-11-12: `priority-service-desk-numeration-fiscal-year-constant`. SC263045: Open Numeration Templates did not create new-year prefixes in one company; DocumentNumeration constant was 0 (calendar year). Set to 1 and reran; documents created with the new prefix (support-verified).
- 2026-11-12: `priority-service-desk-odata-record-limit-powerbi`. SC263022: Power BI OData stopped loading customers past a point after upgrade. A system constant capped API retrieval at 7000 records; raised to 30000 and customer said it worked. Constant name not recorded. SC262930 corroboration: 2000-record API cap after cloud move; support raised MAXAPILINES to 10,000; retest not recorded.
- 2026-11-12: `priority-service-desk-pasted-images-slow-text`. SC263088: internal dialogue slow after an email trail with images was pasted in. Customer removed the images and it was faster. Images should be imported with the image button, not pasted.
- 2026-11-12: `priority-service-desk-privilege-message-disable`. SC262991: below-minimum-price warning on many shipments; support showed how to set the message to no message for a group in Privilege Explorer and restart Priority. Customer thanked; explicit retest not recorded.
- 2026-11-12: `priority-service-desk-serial-number-renamed-history`. SC263002: asset missing from Catalogue of Parts with S Nos; serial had been renamed on the part (History of Changes). Customer changed it back. Reason for rename unknown.
- 2026-11-12: `priority-service-desk-ssl-acme-renewal-firewall`. SC263074: ACME SSL renewal failed. Renewal task had stale Windows credentials; after fixing, ACME port 80 validation timed out due to IP lockdown. Network provider renewed the cert and re-locked; support says task addresses were allowlisted. Customer confirmed OK.
- 2026-11-12: `priority-service-desk-upgrade-missing-custom-trigger-code`. SC262879: after upgrade, service contract errors and missing engineer fill; custom code in standard triggers was not recorded as a standard-trigger change and was lost. Restored; customer said resolved.
- 2026-11-12: `priority-service-desk-ui-language-print` 1.1.0. SC262893: user shortcuts missing after the user language changed to American English; changing back to British fixed it (customer confirmed). Support called it a known issue. SC262605 added: homepage tiles missing with American English; changing language fixed it (customer-confirmed).
- 2026-11-12: `priority-service-desk-wrong-url-error-404`. SC263091: Error 404 at login for some users. Supplier said it is the wrong-URL message; the user had a different URL and logged in with the correct one. URLs not stored.
