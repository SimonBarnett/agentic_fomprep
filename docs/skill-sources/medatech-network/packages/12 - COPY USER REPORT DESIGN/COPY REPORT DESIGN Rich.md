# COPY REPORT DESIGN Rich

- **Source:** `COPY REPORT DESIGN Rich.docx`

COPY REPORT DESIGN

Shell file ZEMG_COPYREPORTDESIGN.sh

Creates new DB table, form load and 2 procedures.

To create file holding selected report design on one system

System Management > Generators > Reports > Copy a Report Design to File

To load report design on another system, Transfer file and load

System Management > Generators > Reports > Copy a Report Design from a File

Procedure checks the design can be safely applied and no existing design for this report exist and all entities within the design exist in this system, if all OK prompts to ensure you want to load the design.

If yes loads the report design table, also if any html colours or fonts do not exist on target system they are created OR if they do exists but have different settings then they are created and report design amended with a “_1” (or whatever number is required to make unique name) appended to the colour or font name, so existing settings are not affected but new design loads with setting from source system.
