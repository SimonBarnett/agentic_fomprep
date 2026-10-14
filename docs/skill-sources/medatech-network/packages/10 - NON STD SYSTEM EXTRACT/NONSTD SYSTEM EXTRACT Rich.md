# NONSTD SYSTEM EXTRACT Rich

- **Source:** `NONSTD SYSTEM EXTRACT Rich.docx`

NON STANDARD SYSTEM EXTRACT

Shell file ZEMG_NONSTD_SYSTEM.sh

Amends revision step maximum from 3 to 6 so enough steps can be added to a revision and 2 procedures.

NB. Not valid for Version 15 so been removed therefore limit is 999 steps in the revision list.

System Management > Revisions > Create Customer Revision Version

This procedure creates a Revision version containing all the steps to copy any non-standard modifications to another system.

It extracts entities based on the masks (See list below) and up to two additional masks of 4 or 5 characters in length.

You can limit extraction to just the specified addition masks: -

You may be told you need to run Create Print Format Rev. Version: -

System Management > Revisions > Create Print Format Rev. Version

This procedure creates a Revision version containing SQLI to create any procedure print formats that contain entities based on the masks (See list below) and up to two additional masks of 4 or 5 characters in length. This revision should be loaded AFTER the script created from the revisions created by {Create Customer Revision Version} as then the procedures and report required will have been loaded.

Masks list:-

'Z????_%' or 'Z????-%' or 'Z???_%' or 'Z???-%' or 'EMG_%' or 'TEV_%' or ‘MED_%’

NB. Triggers are selected with additional masks of 'A???_%' or 'A???-%' or 'A????_%' or 'A????-%'

(where ? means any character and % means all further characters)
