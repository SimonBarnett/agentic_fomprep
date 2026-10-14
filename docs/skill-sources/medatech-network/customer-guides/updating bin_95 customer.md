# updating bin_95 customer

- **Source:** `updating bin_95 customer.pdf`

Updating Bin.95 
28 Jul. 20 
1 
UPDATING THE PRIORITY BIN.95 
STEP 1: LOCATE  EXE FILE   
STEP 2: MAKE A COPY OF THE BIN.95  AND OTHER PREP  
Run System Management > System Maintenance > Software Licenses > View License Details 
and take a copy of the report. 
Make sure there are no users on the system.  
You can check System Management > System Maintenance > Periodic Maintenance >  
Active Users 
Make sure this file is 
located somewhere 
on the server. 
 
e.g. nbin200es.exe 
 
 
 
 
 
 
 
 
 
Find location of the bin.95 by right clicking 
on the priority client shortcut on the server 
and select properties 
 
 
 
Go to the location and make a copy of the 
current bin.95 and paste this into the same 
folder.

Updating Bin.95 
28 Jul. 20 
2 
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
 
You may also need to 
stop the IIS  
(if, for example, you 
get messages that 
files are in use when 
reinstalling the app 
server). 
 
STEP 3: RUNNING THE UPDATE PROGRAM  
Open the executable file

Updating Bin.95 
28 Jul. 20 
3 
 
 
 
 
 
 
 
 
Run the program 
 
More info>Run anyway 
 
 
 
 
 
 
 
Enter the tabula password 
when prompted 
 
Press OK

Updating Bin.95 
28 Jul. 20 
4 
STEP 4: WEB SERVER  
Run Update Priority Executables on any work stations using Priority Client. 
If you have a separate Web server, run Update Priority Executables here as well. 
Any issues with this, manually copy the updated bin folder from the Priority server over to the 
workstations. 
If you work with Priority Web, check the value of the system constant REMOTEH5 . 
You will need to reinstall your application server if this has been changed to 0 or 2. 
Note: We strongly recommend you reinstall the application server regardless of this constant.  
 
 
 
 
 
 
 
 
Press OK 
 
 
 
 
Once completed, you will 
be shown this success 
message 
 
Press OK 
 
 
 
 
 
Press OK

Updating Bin.95 
28 Jul. 20 
5 
Otherwise, skip to step 5. 
 
 
 
 
 
 
 
 
 
 
Open priority client as administrator  
 
Login as tabula 
 
 
 
 
 
Go to System Management > System Maintenance > Internet Definitions > Application Server 
Maintenance > Install Application Server 
 
 
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

Updating Bin.95 
28 Jul. 20 
6 
 
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
 
 
Input tabula 
password 
 
Approve 
 
 
Press OK and 
wait for 
dialogue boxes 
to disappear.

Updating Bin.95 
28 Jul. 20 
7 
STEP 5: CHECKS  
If you reinstalled the application server, make sure the WCF folder is updated: 
C:\inetpub\wwwroot 
Start the IIS server if stopped.  
Start any services that were stopped before the update. 
Check the tabula task scheduler is running. 
Check you can log into Priority Web.  
Try opening reports and sending data to excel. 
Run System Management > System Maintenance > Software Licenses > View License Details 
and compare this to the copy you saved earlier. If you have any concerns, please contact 
support. 
Check the new bin version and send a screenshot of the new About Priority to support:
