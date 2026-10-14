# Mand. Cust. PO Install

- **Source:** `Mand. Cust. PO Install.docx`

How to Install Mandatory Customer Purchase Order Module

Run WINDBI and backup tables that are modified, scripts exist to help.

Open the ZEMG_MANDPRESHELL.q file using WINDBI and execute In All Companies

Install the ZEMG_MANDCUSTPO shell file.

Open the ZEMG_MANDPOSTSHELL.q file using WINDBI and execute In All Companies

Check the –COUNT.TXT files created in directory ../../system/upgrades, the ‘BEF’ and ‘AFT’ counts should match.
