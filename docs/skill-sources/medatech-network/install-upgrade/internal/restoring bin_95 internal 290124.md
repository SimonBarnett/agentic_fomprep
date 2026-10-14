# restoring bin_95 internal 290124

- **Source:** `restoring bin_95 internal 290124.pdf`

Restoring bin.95 
20/09/21 
1 
RESTORING BIN.95  
PURPOSE  
There are a few reasons why you may want to restore a bin.95 to its previous version:  
1. The update has to be cancelled i.e. process is running very slow and will not finish in 
the available time frame. 
2. The update has not changed the behaviour and you wish to return to the original 
value. 
3. The machine fails during the update. 
This document is a companion document to “Updating bin.95” 
Note: the file setup.log found in the priority\tmp directory shows all the actions performed by 
an upgrade. 
CHECK NO USERS IN SYSTEM  
Make sure there are no users on the system. You can check these forms:  
System Management > System Maintenance > Periodic Maintenance > Active Users  
System Management > System Maintenance > Periodic Maintenance > List of Recent 
Processes  
System Management > System Maintenance > Users > History of User Logins 
STOP SERVICES  
Stop the following windows services in the order shown: 
Priority App Service (priority.net in older versions) 
Priority Search Service 
Tabula Task Scheduler 
Priority Data Exchange 
Priority Redis Service 
World Wide Web Publishing Service 
IIS Admin Service 
Note: depending on the installation, not all the services may be running.

Restoring bin.95 
20/09/21 
2 
 
RESTORE ORIGINAL BIN.95 FOLDER  
1. Find the location of the bin.95 by right clicking on the Priority client shortcut on the 
server and select properties. 
 
2. Within the priority directory should be a copy of the bin.95 that was updated. This will 
normally have a name similar to bin.95 – ddmmyy. Note: if there is no copied bin.95 
folder you cannot proceed. 
3. Rename the bin.95 folder to another value i.e. bin.95.old 
4. Rename the copied bin.95 folder to bin.95 
CANCEL UPGRADE WARNING MESSAGE  
1. This will only be necessary if the bin.95 upgrade process fell over. Start the windows 
client. 
2. If the following message is seen, proceed to step 3, otherwise go to the next section.  
 
3. Run the process System Management > System Maintenance > Revisions > Unlock 
Upgrade Run.

Restoring bin.95 
20/09/21 
3 
 
4. On completion the following is displayed: 
 
5. Restart the windows client and confirm that the upgrade warning message is not 
displayed. 
REINSTAL L THE APPLICATION SERVER  
Reinstall the application server as per these instructions. 
RESTART SERVICES  
Start the following windows services in the order shown: 
IIS Admin Service 
World Wide Web Publishing Service 
Priority Redis Service 
Priority Data Exchange 
Tabula Task Scheduler 
Priority Search Service 
Priority App Service (priority.net in older versions)
