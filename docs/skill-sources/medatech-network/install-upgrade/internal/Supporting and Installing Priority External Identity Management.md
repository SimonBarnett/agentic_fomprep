# Supporting and Installing Priority External Identity Management

- **Source:** `Supporting and Installing Priority External Identity Management.docx`

Supporting and Installing Priority External Identity Management

Refresh test server (SC242523)

If any server with MFA installed on is refreshed, then we will need to reinstall MFA once refreshed.

To uninstall MFA:

1. Open SQL management studio and connect to the correct instance of priority with "SA" user (Windows user worked in SC242523)

2. Execute query from database system

DELETE FROM [system].[dbo].[SYSCONST] WHERE NAME = 'ACTIVEDIR';

3. Reset password for tabula user (from management studio under security>login)

4. Delete file defs.ad   located in priority folders client>misc

To install MFA:

See Stage II: https://priority.medatecherp.co.uk/primail/24/8/w/o/wc83jo/sop_identity_local_e.pdf

Integrations (SC241780)

Logging into Apps (SC241770)

To log into apps after installing MFA you will need to regenerate the QR codes from Priority.

API/Emails (SC240604)
