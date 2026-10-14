# How to Delete Companies in Priority (Web)

- **Source:** `How to Delete Companies in Priority (Web).pdf`

Medatech UK Ltd 
Anchor House, School Lane, 
Chandlers Ford 
Hampshire 
SO53 4DY 
Tel.: +44 2380 460 400 
Fax: +44 2380 261 078  
 
                                                                    
 URL: http://www.medatechuk.com   
                                                                             E-mail: info@medatechuk.com  
 
 
  
 
. 
 
 
 
 
HOW TO DELETE COMPANIES IN PRIORITY  
CHECKS  
 
First, check there are no tasks in the Tabula Task Scheduler defined against the company you are deleting:  
System Management > System Maintenance > Tabula Task Scheduler >  Define TTS Tasks 
 
 
If there is, change this to an active company to avoid the task becoming inactive when you delete the 
company. 
 
DELETING COMPANIES  
Note: No users should be working in the company that is to be deleted. 
Log into Priority on the Priority server. 
Go to System Management > System Maintenance > Companies > Companies and untick "active" for the 
company you wish to delete. 
Copy the Full Company Name. Make note of the Company Code.  
 
Then run System Management > System Maintenance > Companies > Delete Company

Medatech UK Ltd 
Anchor House, School Lane, 
Chandlers Ford 
Hampshire 
SO53 4DY 
Tel.: +44 2380 460 400 
Fax: +44 2380 261 078  
 
                                                                    
 URL: http://www.medatechuk.com   
                                                                             E-mail: info@medatechuk.com  
 
 
  
 
. 
 
 
 
 
Paste in the full company name. 
 
 
The company has been deleted. 
This does not remove any backups for this company. You will need to locate and delete them manually as 
necessary. 
 
DELETING BACKUPS  
Backups are scheduled in the Tabula Task Scheduler - check the list of Scheduled Tasks to see where they are 
pointed to save. 
The default is usually the back-up folder in the Priority drive.

Medatech UK Ltd 
Anchor House, School Lane, 
Chandlers Ford 
Hampshire 
SO53 4DY 
Tel.: +44 2380 460 400 
Fax: +44 2380 261 078  
 
                                                                    
 URL: http://www.medatechuk.com   
                                                                             E-mail: info@medatechuk.com  
 
 
  
 
. 
 
 
 
 
System Management > System Maintenance > Tabula Task Scheduler > Define TTS Tasks 
 
 
Enter the folder called Data and find the Company Code of the deleted company.  
 
Delete this folder to delete the backups. 
NOTE: DO NOT delete pritempdb or system backups.
