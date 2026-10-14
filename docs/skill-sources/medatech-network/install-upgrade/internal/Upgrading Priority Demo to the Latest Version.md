# Upgrading Priority Demo to the Latest Version

- **Source:** `Upgrading Priority Demo to the Latest Version.docx`

Upgrading Priority demo

Step 1: Download the upgrade file

Step 2: Running the upgrade

Firstly, log out of your Priority system.

Step 3: reinstall the application server

Go to System Management > System Maintenance > Internet Definitions > Application Server Maintenance > Install Application Server

Step 4: FAQs

How to check back-ups have ran

In Priority, go to System Management > System Maintenance > Tabula Task Scheduler > Define TTS Tasks

You should see three backup tasks:

Daily, Hourly and Weekly

Note the back-up location e.g., C:\priority\backup

In file explorer, go to this location and enter the “data” folder:

You should see a folder for each of your companies:

Enter one of the folders, and note the time stamp on the latest BAK File:

If you need to run a backup, follow the instructions below

Any questions, please ask support!

How to run a backup

In Priority, go to System Management > System Maintenance > Tabula Task Scheduler > Define TTS Tasks

You should see three backup tasks:

Daily, Hourly and Weekly

Take a copy of the command e.g. BACKUP '' '' C:\priority\system\prep C:\priority\backup D

From the top Priority menu, run Tools > Run Entity (Advanced)…

This should pop up with a window where you can paste your command:

Press OK

This window will appear:

The backup is done once it has disappeared. Follow the instructions above to check this has run correctly.

Error message: The Key used to run upgrades does not exist or has expired

You may run into this error message:

To resolve, go to System Management > System Maintenance > Users > User Permissions

Change the tabula email to support@medatechuk.com:

Error Message: Your e-mail address does not appear in the list of Eshbel's contacts

Like above, make sure you are logged in as tabula, and that the email address for tabula in the User Permissions form is support@medatechuk.com

If you still get this error, check the Help > About Priority:

If the Company Registration Name differs from “Priority Demo – Medatech UK – SQL”, contact support about getting the correct licence installed.

Open priority client as administrator   Login as tabula | 

Select Help > Upgrade System | 

Press OK | 

Read the Checklist carefully  Press ‘Checklist Completed’  See Step 4 for more details | 

Select ‘Save File’  Click Approve | 

Choose a location to save the file  Select OK | 

Press OK | 

Run the upgrade file | 

When prompted, enter the tabula password | 

Scroll to the bottom, accept the terms, and click ‘Continue’ | 

Press ‘OK’ | 

Press ‘OK’ | 

Press ‘OK’ | 

Open priority client as administrator   Login as tabula | 

Check the highlighted fields are filled in  (If not, change companies until they are)  Input Windows password  Approve | 

Select Lite+Web  Approve | 

Make sure the Priority and Windows login details and passwords are filled in  Press OK | 

Approve | 

Input tabula password  Approve | 

Press OK and wait for dialogue boxes to disappear. |
