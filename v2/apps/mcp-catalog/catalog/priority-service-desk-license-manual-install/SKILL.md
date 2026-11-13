---
name: priority-service-desk-license-manual-install
description: >
  Renew License did not raise the purchased seat count. An official
  license for the installed version did. Automatic renewal stays open.
  Use when Renew License seat count, version-matched license, or
  /priority-service-desk-license-manual-install.
---

# Install the official license that matches the version

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/license-manual-install.md`.

Issue type: Renew License runs and the purchased user count does not increase. The supplier's automatic-renewal defect was still under investigation.

Known: the supplier supplied official license files for 25.0 and 26.0 and said to install the one that matches the system, then check the count. The system was 25.0. On 2026-10-15 10:01 BST support had installed that 25.0 license and the higher available count was visible. The 26.0 file was not the one that applied. The numeric count is omitted. No license file, identifier, or attachment is stored.

This recovers the entitlement. It does not fix Renew License. It is not proof that users could log in, and it is not permission to use another customer's license or to edit a license file.

## Steps

1. Read the installed version and the current licensed user count. Compare them with the purchased entitlement. Do not write the count into a skill.
2. Get the official file for that version through the vendor channel. Do not generate or patch a file.
3. A licensed administrator installs the matching major version only.
4. Read the seat count again. Keep the before and after with the owner, not in git.
5. Leave the automatic-renewal failure as its own open item.

## Verification

Proven: the matching 25.0 license was installed and support saw the higher count (SC263215).

Not proven: why Renew License failed, the install menu, and a user login test.

## Stop

Stop if the file is for a different major version, if it is not from the vendor for this customer, or if anyone asks to commit the file.
