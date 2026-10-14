# What can I check when the system seems to be working very slowly

- **Source:** `What can I check when the system seems to be working very slowly.docx`

What can I check when the system seems to be working very slowly?

English |

All Databases |

All Versions |

There are several possible issues that can cause the system to perform slowly:

I. Performance is slow for some time, and then recovers

Open the List of Recent Processes (menu path: System Management > System Maintenance > Periodic Maintenance), and check whether any resource-heavy processes (e.g., preparation for BI or costing) were running at the time the problem was noticed. Performance will improve once any "heavy" processes finish running.

Check whether your Antivirus software is currently running in the background and over-using system resources, as this can temporarily slow down your system's overall performance.

If you work with the web interface: Check your Internet speed, as follows:

From the upper Run menu, select Check Operating Speed.

A message appears, notifying you of the time (in seconds) required to receive data from the server. If this value is greater than 8, contact your Internet Service Provider to find out why the Internet connection is exceptionally slow.

II. Performance is slow when working on a client workstation, but not on the server

If you are able to work normally on the physical server (i.e., not via a remote connection), the problem is probably due to a network or hardware issue. Contact your system administrator.

Notes:

You may experience slowdown in the Windows interface when there is no internet access (due to Internet Explorer searching for revocation for publisher certificates). For more information, click here.

If performance is slow when opening forms:

If the performance is slow when opening forms in work stations, try to change the bin.95 file in the work station.

If the issue persists. ask your system administrator to open the priority/system/prep directory in Windows Explorer. If the list of files in that directory is slow to load in Windows Explorer, forms in Priority will also load slowly. In such a case, ask the system administrator to resolve that issue.

III. Performance is slow even when working on the server

If you are unable to work normally even when logged in on the physical server (i.e., not via a remote connection), try the following:

Check the server for errors. If an error is displayed upon login or is logged in the Event Viewer, open a service call and attach a screen shot of the error message.

Check whether your anti-virus software is set up to scan the system. If so, cancel the scan temporarily, as it may be slowing down performance. Rerun at a later time, when users are not working in the system.

Check whether your server meets the minimum hardware requirements for the system. You may need to add server memory.
Note: To view hardware requirements, download the Hardware and Support Systems document from the Customer Zone of the Priority    web site.

If your system uses the Tabula database:

On the server, right-click the Tabula Server icon (looks like 3 computers arranged as a pyramid) and select Open.

Check whether any messages are displayed other than the "Flushed to Disk" or "Flushing to Disk" message (e.g., "Unreliable Connection"). If so, contact your system administrator.

To analyze usage of database resources, run the Check Record Count per Table report (menu path: System Management > System Maintenance > Periodic Maintenance) on a monthly basis in the company with the most activity. Open a service call and attach the report.

If your system uses the SQL Server or SQL Server Express database:

Have your DBA check database integrity.

Make sure the following default settings are defined for the database:

Recovery Model = Full

Automatic Close = False

Routine Maintenance

In order to maintain optimal performance capabilities and available disk space, it is recommended that you perform the following maintenance activities on a regular basis:

Empty the priority\tmp directory.

Empty the priority\system\tmp directory.

Run the following programs from the Periodic Maintenance menu (menu path: System Management > System Maintenance):

Clean "mail" Directory: Empties the system\mail directory of any files that are not attachments in Priority (i.e., files that are neither mail messages nor external documents attached to Priority forms).

Empty Mailboxes: Deletes all e-mail messages sent/received by all users up to a specified date.
Note: Review the Help topic for this program before running.

Delete Saved Reports

Delete any companies that are no longer in use.

IV. Performance is slow only when entering one or more specific forms
This can occur if the default query for the form itself, or for its default sub-level form, incurs a massive database search. For example, it may take a long time to enter the Chart of Accounts form if hundreds of ledger transactions have been recorded for each of several different accounts, as these transactions are retrieved automatically in the default sub-level form. In such a case, it is recommmended that you set up the default query for the form in which the massive query is performed (in the above example, the default sub-level of the Chart of Accounts form), as follows:

Move to the form in question (e.g., the Ledger Transactions - YTD sub-level of the Chart of Accounts form) and press Shift+F11 to open the Query Generator.
Tip: For detailed instructions on using the Query Generator, see the User Interface Guide (accessed from the upper Help menu).

Define a query that does not retrieve any records (e.g., Entry Date > end of next year).

Save this query as usual and set it as the form's default query. Subsequently, no records will be retrieved upon entering the form in question.
Tip: Once you enter the form, you can retrieve records as needed (perform a new query or run a saved query).
