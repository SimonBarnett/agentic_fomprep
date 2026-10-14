# reinstall app server-1

- **Source:** `reinstall app server-1.docx`

Reinstall App Server

Step 1: prep

Check Info type 20, Technical Notes, in “Medatech Add’l Customer Info.” sub form for customer and check if any additional actions are needed.

Make sure there are no users on the web version of Priority.

You can check System Management > System Maintenance > Periodic Maintenance > Active Users

Step 2: reinstalling the app server

Go to System Management > System Maintenance > Internet Definitions > Application Server Maintenance > Install Application Server

Step 3: Checks

Make sure the WCF folder is updated: C:\inetpub\wwwroot

Start the IIS server if stopped.

Start any services that were stopped before the update.

Check the tabula task scheduler is running.

Check you can log into Priority Web.

Try opening reports and sending data to excel.

Stop the following services:  Priority app (priority.net in old versions) Priority Search Server Tabula Task Scheduler Priority Data Exchange Priority Redis  Note: Not all of these service might be active, depending on your installation. | 

You may also need to stop the IIS  (if, for example, you get messages that files are in use when reinstalling the app server). | 

Open priority client as administrator   Login as tabula | 

Check the highlighted fields are filled in  (If not, change companies until they are)  Input Windows password  Approve | 

Select Lite+Web  Approve | 

Make sure the Priority and Windows login details and passwords are filled in  Press OK | 

Approve | 

Input tabula password  Approve | 

Press OK and wait for dialogue boxes to disappear. |
