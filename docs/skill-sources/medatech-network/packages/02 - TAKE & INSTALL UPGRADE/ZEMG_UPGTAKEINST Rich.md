# ZEMG_UPGTAKEINST Rich

- **Source:** `ZEMG_UPGTAKEINST Rich.docx`

Medatech Revision Prepare & Install

NB. Ensure 05 - SYNTAX CHECKS & SQLI REVISIONS is installed first.

Preparing a revision

Use the original Prepare the Revision first to ensure no errors exist then the new direct activation and extra files with the extension of dot rv and mht get created holding the details of the revision, its steps and step remarks. (NB Currently does not extract any other details)

Transfer all files to the target system.

Install Revision

Use New Install Upgrade procedure

FIRST select a dot rv if you have one

Optionally untick the Make Revisions, Backup Table Changes or tick the Do not rename Shell options.

If you supply a .rv file and leave Make Revisions ticked any TAKETRIG or TAKEPROCSTEP (INPUT, INPUTF, SQLI) for triggers or procedure steps that already exist will have a trigger or procedure revision created with the existing code prior to installing the shell file.

If you supply a .rv file and leave Backup Table Changes ticked any DBI steps for changing tables will back up the table(s) prior to installing the shell file., you’ll be warned this has been done

Then the directory created to hold the files will open for you to check the table record counts and data files created.

Select the dot sh file

When completed you will get message.

If Revision already exists on Target system

You are offered r the choice: -

Checking the Tables after exiting and Restarting Priority

Any revisions not yet checked will re-read the table record counts and display the file(s)

Installing just the Revision Details

Use New Create/Update Revision procedure

You will be prompted for a dot rv file

This will then create (NB Removing any existing revision details first) the revision, revision steps and step remarks.

As when installing a shell file if Revision already exists on Target system

You are offered the choice: -

Overwrite deletes existing revision details, renumber increments the existing revision number under it is unique: -

Combining existing Revision onto another Revision

Use New Combine Revisions procedure

Enter the “From” and “To” revision you wish to combine and the existing revision to contain the steps from all these revisions.

Upon completion you will be told how many steps were created (If none previously existed) or how many were updated (if previous steps removed first).

The revision now contains all the steps from the combined revisions, the step number jump up to next value rounded by 10 upon change of combining revision but there is no indication from which revision each step was taken.
