---
name: priority-service-desk-odata-record-limit-powerbi
description: >
  After an upgrade, a Power BI table fed by OData stopped loading records after a certain customer. A system constant limited API retrieval to 7000 records. Raising it to 30000 fixed the query. Use when Power BI OData missing records after upgrade API limit, or
  /priority-service-desk-odata-record-limit-powerbi.
---

# Power BI stopped loading records past a point because of the API record limit

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/odata-record-limit-powerbi.md`.

Issue type: a Power BI (or other OData) query returns only part of a table, for example customers stop after a certain number, often noticed after an upgrade.

Known: on 2026-09-29 15:28 BST the consultant told the customer he had changed a system constant related to how many records can be retrieved through the API, from a maximum of 7000 at once to 30000, and asked them to retry the Power BI query. At 15:39 BST the customer replied that it worked. The constant name is not recorded in the call. Customer and record identifiers are not stored.

This is not missing data and not the user-interface row cap (MAXFORMLINES, see priority-service-desk-maxformlines-user-group). Do not assume the constant name.

## Steps

1. Count the records the OData query returns. A round number (for example exactly 7000) suggests a retrieval cap, not a data problem.
2. Check that the missing records exist in Priority and are readable by that API user.
3. Find the system constant that limits API record retrieval in that environment. Confirm its name from the system, not from memory.
4. The system owner agrees a higher value, considering load. An authorised administrator changes it.
5. Rerun the Power BI query and confirm the missing records now load.

## Verification

Proven: after raising the API record limit from 7000 to 30000, the customer said the Power BI query worked (SC263022).

Not proven: the constant name, whether paging in the client would have avoided it, and the load impact.

## Stop

Stop if the count is not near a round limit, or if the records are missing in Priority too. Then treat it as a data or permission problem.
