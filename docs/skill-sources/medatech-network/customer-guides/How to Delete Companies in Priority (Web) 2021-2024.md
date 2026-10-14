# How to Delete Companies in Priority (Web) 2021-2024

- **Source:** `How to Delete Companies in Priority (Web) 2021-2024.pdf`

How to Delete Companies 
24 Apr. 21 
1 
HOW TO DELETE COMPANIES IN 
PRIORITY  
DELETING COMPANIES  
Note: No users should be working in the company that is to be deleted. 
Log into Priority on the Priority server. 
Go to System Management > System Maintenance > Companies > Companies and untick 
"active" for the company you wish to delete. 
Copy the Full Company Name. Make note of the Company Code.  
Then run System Management > System Maintenance > Companies > Delete Company 
Paste in the full company name.

How to Delete Companies 
24 Apr. 21 
2 
 
The company has been deleted. 
This does not remove any backups for this company. You will need to locate and delete 
them manually as necessary. 
DELETING BACKUPS  
Backups are scheduled in the Tabula Task Scheduler - check the list of Scheduled Tasks to 
see where they are pointed to save. 
The default is usually the back-up folder in the Priority drive. 
System Management > System Maintenance > Tabula Task Scheduler > Define TTS Tasks 
Enter the folder called Data and find the Company Code of the deleted  company. 
 
 
Delete this folder to delete the backups 
NOTE: DO NOT delete pritempdb or system backups.
