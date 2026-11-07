---
name: priority-ops-install-upgrade
description: >
  Priority install / upgrade / refresh. Lazy-load markdown lessons from
  docs/skill-sources/medatech-network/install-upgrade/ via priority-skill-dag.
  Use when the user says install Priority, upgrade Priority, SSL, intermediate certificate, mobile security certificate, services did not start after reboot, bin_95, refresh, AimBetter, search service, web install, client install, /priority-ops-install-upgrade.
---

# Priority install / upgrade / refresh

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

## Hard rules

1. Resolve lessons with `priority-skill-dag` / `tools/priority-skill-dag/Resolve-SkillDag.ps1` — do not dump the whole `install-upgrade` tree into context.
2. Lessons are distilled from Medatech network docs. Prefer catalog executable skills (formprep, shell-install, hours, UAT) when the task is automation.
3. Priority-generic: hosts and company codes in lessons are examples only.
4. New hard rules learned from lessons must be harvested (CAST IRON).

## Load

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\priority-skill-dag\Resolve-SkillDag.ps1 -Query "install-upgrade <detail>" -MaxLessons 8 -MaxBytes 24000
```

Lesson root: `docs/skill-sources/medatech-network/install-upgrade/`

## Related catalog skills

Use `Resolve-SkillDag.ps1` to pick overlapping executable skills (shell-install, formprep, mcp-*, backup-*, etc.).


## Example: mobile security certificate (SC263521)

Issue type: mobile app still shows a security certificate error after a certificate change. Recorded client OS in this call: Android 13. Do not treat that as the only affected platform.

This example enriches the existing install/SSL owner. Do not open a second skill for the same intermediate-certificate repair.

Known: the intermediate certificate required by that mobile path was not in place until the successful install. An earlier installation attempt, reboot, and restoration of services did not clear the mobile error. On 2026-11-06 11:48 GMT the technician recorded: "I have successfully installed the intermediate certificate. I checked on my end and the apps are loading without error now." On 2026-11-06 14:38 GMT the recorded customer response was "Working now, thank-you!" The morning of 2026-11-06 09:03 GMT (customer mail 08:21 GMT) still said the mobile app showed the same security certificate error.

Unknown: trust store, certificate provider, thumbprint, binding, and the exact install command. A note at 2026-11-06 15:43 GMT says the SSL library guide would be updated with what was done. That updated guide was not in the retrieved call. Do not invent the clicks or commands. Do not copy portal addresses, certificate requests, or private keys out of `docs/skill-sources/medatech-network/install-upgrade/to-be-updated/SSL Guide.md`. That lesson is a separate estate note. It is not the recorded repair for SC263521.

Discriminate:

1. Write down the client OS, the full certificate error text, and whether this followed a renewal.
2. Separate "server or services are down" from "TLS chain is rejected". A successful web or server login is not a mobile-app test.
3. Ask an authorized certificate administrator to inspect whether the endpoint presents a complete trusted chain, including the required intermediate. That inspection is diagnostic. This call does not record the command.
4. If services were restarted and the mobile error remains, the outage is not the defect. Continue the chain check.
5. Install or correct the intermediate only under an authorized administrator and an approved maintenance window. This harvest authorizes neither.
6. Retest the original mobile apps. Service availability does not prove the certificate path is fixed.

Stop: do not bypass certificate checks, install an unverified certificate, or ask for a private key. Do not delete trusted roots from this example. After any approved reboot, check required services, including delayed-start services, and still retest the mobile app.

Opened 2026-11-05 10:38 GMT. SC263520 was a cancelled duplicate with no repair text. Do not count it as a second fix.

## Example: services not started after reboot (SC263488)

Issue type: Priority is unavailable after a server reboot because required services did not start. This is not the mobile certificate failure above.

Known: on 2026-11-04 09:14 GMT support recorded that the server had been rebooted and the services did not turn on. The IT team then turned the services on and Priority was back up.

Unknown: service names, startup type, dependency order, and the commands used. Do not invent them. Use the estate's own service inventory.

Discriminate from SC263521: there, bringing services back did not clear the mobile certificate error. Here, the recorded defect was that services were stopped, and starting them restored Priority. A running service does not prove a certificate chain is valid. A valid chain does not prove Priority services are running.

Steps: correlate the outage with the reboot. Have authorized IT check required Priority services, including delayed-start services. Apply only the approved start or startup correction. Retest the original Priority sign-in or form that failed. Do not restart the database or application servers blindly, and do not change service identities.

Opened 2026-11-04 09:04 GMT. Not proven: a permanent startup-type change or a reboot regression test.
