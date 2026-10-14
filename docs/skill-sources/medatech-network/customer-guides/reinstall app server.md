# reinstall app server

- **Source:** `reinstall app server.pdf`

REINSTALL APP SERVER 
29 Jan. 24 
1 
REINSTALL APP SERVER  
STEP 1: PREP  
Check Info type 20, Technical Notes, in “Medatech Add’l Customer Info.” sub form for 
customer and check if any additional actions are needed. 
Make sure there are no users on the web version of Priority.  
You can check System Management > System Maintenance > Periodic Maintenance >  
Active Users 
Stop the following 
services: 
 
Priority app 
(priority.net in old 
versions) 
Priority Search Server 
Tabula Task Scheduler 
Priority Data 
Exchange 
Priority Redis 
 
Note: Not all of these 
service might be 
active, depending on 
your installation.

REINSTALL APP SERVER 
29 Jan. 24 
2 
You may also need to 
stop the IIS  
(if, for example, you 
get messages that 
files are in use when 
reinstalling the app 
server). 
 
 
STEP 2: REINSTALLING THE APP SERVER  
 
 
 
 
 
 
 
 
 
 
 
Open priority client as administrator  
 
Login as tabula 
 
 
 
 
 
Go to System Management > System Maintenance > Internet Definitions > Application Server 
Maintenance > Install Application Server

REINSTALL APP SERVER 
29 Jan. 24 
3 
 
 
Check the 
highlighted 
fields are filled 
in 
 
(If not, change 
companies until 
they are) 
 
Input Windows 
password 
 
Approve 
 
 
 
Select 
Lite+Web 
 
Approve 
 
 
 
 
 
Make sure the 
Priority and 
Windows login 
details and 
passwords are 
filled in 
 
Press OK 
 
 
 
 
 
Approve

REINSTALL APP SERVER 
29 Jan. 24 
4 
 
Input tabula 
password 
 
Approve 
 
 
Press OK and 
wait for 
dialogue boxes 
to disappear. 
 
 
STEP 3: CHECKS  
Make sure the WCF folder is updated: C:\inetpub\wwwroot 
Start the IIS server if stopped.  
Start any services that were stopped before the update. 
Check the tabula task scheduler is running. 
Check you can log into Priority Web.  
Try opening reports and sending data to excel.
