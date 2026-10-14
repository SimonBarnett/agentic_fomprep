# updating bin_95 internal 

- **Source:** `updating bin_95 internal .docx`

Updating bin.95

Step 1: Download exe file

Step 2: Make a copy of the bin.95 and other prep

Run System Management > System Maintenance > Software Licenses > View License Details and take a copy of the report.

Make sure there are no users on the system. You can check these forms: 
System Management > System Maintenance > Periodic Maintenance > Active Users
System Management > System Maintenance > Periodic Maintenance > List of Recent Processes
System Management > System Maintenance > Users > History of User Logins

Check Info type 20, Technical Notes, in “Medatech Add’l Customer Info.” sub form for customer and check if any additional actions are needed.

Step 3: Running the update program

Step 4: web server

Run Update Priority Executables on any workstations using Priority Client. Any issues with this, manually copy the updated bin folder from the Priority server over to the workstations.

If Priority is on two separate servers, copy the updated bin.95 folder from the DB server to the WEB server. You can find where the bin.95 lives on the WEB server in the same way we did on the DB server in step 2.

You will now need to reinstall the application server. This is done on the WEB server.

Note: skip to step 5 if the customer does not use the Priority web or mobile applications i.e., they only use client.

Take a copy of the folder C:\inetpub\wwwroot and rename this to e.g. “wwwroot.date”

This is a backup in case of problems

Go to System Management > System Maintenance > Internet Definitions > Application Server Maintenance > Install Application Server

Step 5: Checks

If you reinstalled the application server, make sure the WCF folder is updated: C:\inetpub\wwwroot

If customer uses windows-client (e.g. Trutex, Senstronics, etc) make sure they run ‘Update Executables’ from the windows menu or copy the updated files if this throws errors!

Start the IIS

Start any services that were stopped before the update.

Check the tabula task scheduler is running.

Check you can log into Priority Web.

Try opening reports and sending data to excel.

Run System Management > System Maintenance > Software Licenses > View License Details and compare this to the copy you saved earlier. If you have any concerns, please contact support.

Add /odata to their Priority URL and check you get a login box. E.g. https://priority.medatecherp.co.uk/odata

Check FQ240004 if you get errors.

Check the new bin version and add to CRM > Customers > Customers -> Medatech Add'l Customer Info.

If you need to revert the bin.95, please refer to this guide.

Sign into Priority Xpert and click downloads | 

Select Addons; Update Bin 95 Folder; SQL Server; and the Priority Version.  Then select view files and click to download the file. | 

Select the customer and project.  Click download. | 

File will download.   Make sure this file is located somewhere on the Priority database server. | 

On the Priority server (DB server if Priority is on two separate servers), find location of the bin.95 by right clicking on the priority client shortcut on the server and select properties. | 

Go to the location and make a copy of the current bin.95 and paste this into the same folder. Give the copied file todays date. | 

Stop the following services:  Priority App Service* (priority.net* in old versions) Priority Redis Service* Priority Search Service* Tabula Task Scheduler Priority Data Exchange  Note: some of these services might not be installed. It depends on your installation.  Note: If Priority is on two servers (a DB server and a WEB server), you will need to go to the WEB server to stop the services marked *. | 

Stop the IIS.  Note: If Priority is on two servers (a DB server and a WEB server), you will need to be on the WEB server to stop the IIS. | 

Open the executable file | 

Run the program  More info>Run anyway | 

Enter the tabula password when prompted  Press OK | 

Press OK | 

Once completed, you will be shown this success message  Press OK | 

Press OK | 

Open priority client as administrator   Login as tabula | 

Check the highlighted fields are filled in  (If not, change companies until they are)  Input Windows password  Approve | 

Select Lite+Web  Approve | 

Make sure the Priority and Windows login details and passwords are filled in  Press OK | 

Approve | 

Input tabula password  Approve | 

Press OK and wait for dialogue boxes to disappear. |
