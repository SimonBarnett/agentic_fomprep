# Development Modifications Rich

- **Source:** `Development Modifications Rich.docx`

DEVELOPMENT MODIFICATIONS

System Management > Revisions > Version Revisions

Allows Shell File Name to be entered

Any files created by the “Emerge – Prepare the Revision” direct activation are renamed to this name.  The .sh extension is optional file is always created with this.

Also a .mht document based on the “Revision Step Detailed Report” is produced in addition to the .sh and .rv files. You may enter a file name the same as the revision number if you just want the additional .mht document.

You may wish to swap Shell File Name and Remark (Lang 2) fields for convenience.

Revision Steps show the first line of a Revision Steps – Remarks

System Management > Revisions > Delete Zero Revision Steps

This procedure deletes any Revision Steps which are not part of a Version Revision.

System Management > Generators > Forms > Form Generator.

Row & Form Triggers.

Entering a trigger name that does not exist an option appears to create the trigger name without F6 to trigger name form. E.G. Enter new trigger name F12 to sub-level, option appears, answer yes to immediately continue to sub-level

Form Column Triggers, same functionality.

Forms, Menus, Procedures and Reports changed module to Internal Development.

Direct Activation on all these to set the module to “Internal Development”

Forms add Changes Log Code.

Direct Activation to add columns and triggers to add standard CHANGES_LOG form functionality to an existing form.

PRE-FORM Trigger.

The convention is form changes log triggers to be suffixed with -CH

NB. On a non-bespoke form remember to use Z???_ prefix

POST-UPDATE Trigger.

POST-INSERT Trigger.

Unique Column.

If more than one unique column on the base table, then these forms columns need adding manually.

Only Z???_ form cols.

NB. Tick is non-bespoke form that has changes log already but has had bespoke columns added and you also want those field changes logged.

.

Adjust Code for POST-INSERT-CH trigger

Just remove all the \ characters.

Adjust the POST-UPDATE-CH trigger

Remove all the \ characters.

Change the :$.CHARKEY? list according to number of CHARKEY form columns needed for the unique. E.G for base table with an auto unique>

:CHARKEY1 = :$.CHARKEY1;

:CHARKEY2 = :CHARKEY3 = :CHARKEY4 = :CHARKEY5 = '';

If more than one column in the base table unique you’ll need to change the form column CHARKEY2 expression and add extra CHARKEY columns, then the above code to match.

If 2 unique columns the sub-level form added can remain as CHANGES_LOG but for 3,4 or 5 change it to ZEMG_CHANGES_LOG3, 4 or 5.
