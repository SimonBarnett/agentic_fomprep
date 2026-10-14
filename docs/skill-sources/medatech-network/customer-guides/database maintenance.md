# database maintenance

- **Source:** `database maintenance.pdf`

Clearing Space on Priority Server 
21 Jul. 20 
1 
DATABASE MAINTENANCE  
OBJECTIVE  
There are regular procedures that you can run to clear up space on your Priority server. 
Whenever you run a report in priority, a copy of it is saved on the server. It is therefore a good 
idea to regularly delete these and other temporary or unnecessary files to prevent loss of 
space. 
SOF TWARE  
TREESIZE  
TreeSize Free is a free disk space manager for Windows. The software shows you the sizes of 
folders including all subfolders. 
If you are running out of disk space, you can use TreeSize Free to determine specific areas 
where you are running low on space. 
PROCESSES AND PROCEDURES TO RUN  
DELETE SAVED REPORTS  
Use Delete Saved Reports from the Priority menu to remove saved reports that you no longer 
need.

Clearing Space on Priority Server 
21 Jul. 20 
2 
System Management > System Maintenance > Periodic Maintenance > Delete Saved 
Reports 
More information can be found in Delete Saved Reports  
EMPTY MAILBOXES  
Run Empty Mailboxes from the Priority menu to delete all user’s mail up to a certain date.  
This clears emails and their attachments from ../../system/mail. Do not delete any files from 
this folder manually.  
Note: The program will not delete mail flagged to Block Delete. 
 
 
System Management > System Maintenance > Periodic Maintenance > Empty M ailboxes  
Alternatively, users can delete their own mailboxes by running Empty Own Mailbox from the 
Priority menu.

Clearing Space on Priority Server 
21 Jul. 20 
3 
Note: The program will not delete mail flagged to Block Delete. 
 
Office Management > Mail > Empty Own Mailbox 
CLEAR MAIL DIRECTORY  
Run Clear “mail” Directory from the Priority menu to clear unnecessary files from 
../../system/mail. 
../../system/mail contains documents attached to forms, emails sent and received from 
Priority and their attachments. 
 
System Management > System Maintenance > Periodic Maintenance > Clear "mail" Directory

Clearing Space on Priority Server 
21 Jul. 20 
4 
DELETE COMPANIES  
Delete any companies that you do not use by running Delete Company in the Priority menu. 
Note: this should be done from the server. 
Once you have deleted a company, you should manually delete any unnecessary backups. 
 
 
System Management > System Maintenance > Companies > Delete Company  
DELETE UNREQUIRED BACK -UPS  
Define TTS Tasks shows you where any scheduled backups are saved.

Clearing Space on Priority Server 
21 Jul. 20 
5 
Enter this location and delete any old back-ups that you don’t need. This might include 
backups of companies that no longer exist. 
System Management > System Maintenance > Tabula Task Scheduler > Define TTS Tasks 
EMPTY TEMPORARY FOLDERS  
Temporary files are created in Priority temp folders. These files should delete themselves but 
there are some cases where they do not. Any “stuck” files should be deleted manually. 
Temp folders: 
../../priority/system/tmp 
../../priority/tmp 
SCHEDULING PROCE DURES  
As most of these procedures should be routinely carried out, it is a good idea to schedule 
regular tasks using the Tabula Task Scheduler. 
 
System Management > System Maintenance > Tabula Task Scheduler > Define TTS Tasks
