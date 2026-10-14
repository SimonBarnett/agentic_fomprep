# delete saved reports

- **Source:** `delete saved reports.docx`

DElete saved reports

objective

When ran, this procedure frees up space in the database by deleting old reports. It is recommended that you schedule this on a regular basis. If the amount of saved reports in the system exceeds a certain value, the tabula user will be prompted with an error message.

running the procedure

Note: If you are working in a multi-company environment, run this procedure in each company.

Login to Priority as the system administrator.

From the menu, select System Management > System Maintenance > Periodic Maintenance > Delete Saved Reports

This screen will appear:

You can run Delete Saved Reports by date or by specific reports.

To run “by date”

Note: No reports which have been blocked for deletion will be deleted*

Select “By Date” and press OK.

In the next input box which appears, enter the date up-to which you want to delete reports. Press OK.

Once completed, you will receive a message, which shows how many reports have been deleted:

Press OK

To run by specific reports

Note: No reports which have been blocked for deletion will be deleted*

Select “By Specified Reports” and press OK.

You will be taken to the View Saved Reports form

Query for reports you wish to delete. F7 on any line to clear it from the query.

Either press ESC to select all retrieved reports, or press F8 on the line to only choose this report.

When prompted, press OK to exit the form.

Press OK to continue the execution.

A message will appear, which informs you how many reports have been deleted.

Viewing results

You can check which reports are still saved by going to System Management > System Maintenance > Periodic Maintenance > View Saved Reports

*To block reports from deletion when using Delete Saved Reports, enter System Management > System Maintenance > Periodic Maintenance > Saved Reports and flag “Deletion Blocked” on desired reports.
