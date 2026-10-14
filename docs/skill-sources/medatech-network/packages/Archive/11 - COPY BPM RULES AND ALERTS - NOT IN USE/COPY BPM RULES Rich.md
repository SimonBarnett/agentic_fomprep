# COPY BPM RULES Rich

- **Source:** `COPY BPM RULES Rich.docx`

COPY BPM ROUTES/RULES

Shell file ZEMG_COPYBPMRULES_V13.sh or ZEMG_COPYBPMRULES_V14.sh

Creates new DB table, form load and 2 procedures.

To create file holding selected BPM routes and optionally rules on one system.  NB. A file created on a version 13 system will load Ok into a version 14 system and vice versa.

System Management > Generators > Procedures > Copy BPM Routes & Rules to File

To load BPM routes/rules on another system, Transfer file and load

System Management > Generators > Procedures > Copy BPM Routes/Rules from File

You may load with the same User login as used when created or choose a new User Login NB. Only one set of BPM Routes/Rules may exist at any one time irrespective of who created them. You may also choose to delete the existing BPM Routes/Rules NB. This option deletes the Routes and Rules: -

Procedure checks the BPM can be safely applied and no existing BPM elements for this form exist and all entities within the BPM exist in this system, if all OK prompts to ensure you want to load the BPM.

If yes loads the BPM.
