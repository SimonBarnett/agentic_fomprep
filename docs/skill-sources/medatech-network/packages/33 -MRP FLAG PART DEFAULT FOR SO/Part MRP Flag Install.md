# Part MRP Flag Install

- **Source:** `Part MRP Flag Install.docx`

How to Install Part Flag for MRP Module

Run WINDBI and backup tables that are modified, scripts exist to help.

Open the ZEMG_PARTMRPPRESHELL.q file (or open the file in Notepad and copy the text and paste it in WINDBI) using WINDBI and execute In All Companies

Install the ZEMG_PRTFLAGMRP shell file.

Open the ZEMG_PARTMRPPOSTSHELL.q file (or open the file in Notepad and copy the text and paste it in WINDBI) using WINDBI and execute In All Companies

Check the –COUNT.TXT files created in directory ../../system/upgrades, the ‘BEF’ and ‘AFT’ counts should match.
