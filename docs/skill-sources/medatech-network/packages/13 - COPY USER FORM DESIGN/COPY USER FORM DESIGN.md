# COPY USER FORM DESIGN

- **Source:** `COPY USER FORM DESIGN.docx`

COPY USER FORM DESIGN

Shell file ZEMG_COPYUSERFORMDESIGN.sh

Creates new DB table, form load and 2 procedures.

To create file holding selected form design elements for logged on user on one system

System Management > Generators > Forms > Copy a Form Design to File

To load form design on another system, Transfer file and load

System Management > Generators > Forms > Copy a Form Design from a File

You may load with the same User login as used when created or choose a new User Login:-

Procedure checks the design can be safely applied and no existing design elements for this form/user combination exist and all entities within the design exist in this system, if all OK prompts to ensure you want to load the design.

If yes loads the user form design table.
