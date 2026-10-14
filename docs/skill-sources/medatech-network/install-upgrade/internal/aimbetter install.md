# aimbetter install

- **Source:** `aimbetter install.docx`

Gemma’s Guide for installing Aimbetter

Go on the customers DB server.

Go to this URL and download the zip: http://update.aimbetter.com/

Extract the zip file and run the exe:

Click “Activate your account”:

You will be prompted for our licence info, found in our library: LB21000011 (click here)

aimbetter license details.docx

Note: watch out because the Licence Key and Identifier in the document are the other way around!

License Key: 49112363-D4BE-4D45-BBE1-F8ABCA7166D4

Identifier: gv58h3gh

Select “Local System Account”:

Click “Finish”

Click “Add Server”:

Choose “Windows”:

In “Name”, put the customers name and in “IP/Name” put the server name:

e.g.:

Note: to find the server name, open the File Explorer, right click on “This PC” and choose properties e.g.:

Select “Add new DB”:

Set “Name” as customer name + DB.

Set “Endpoint” as the SQL instance (you can check this in SSMS, it will usually be servername\PRI)

For “Authentication”, select SQL Server Authentication.

Username is “sa” and the password is usually the tabula password. If it is not the tabula password, there should be a separate record for sa in the customer connection details. If sa doesn’t work, try tabula as the Username.

e.g.

Check SQL instance by opening SSMS:

Restart the agent:

Delete the install files from downloads.
This is everything done on the server side.

Next, login to Aimbetter: https://app.aimbetter.com/login

Select “Servers” from the settings menu:

Find the server you added and make sure it is enabled. There will be two records:

In Medatech Priority, against the AimBetter vendor (S000521 (click here)), record a task for todays date (date AimBetter installed), subject “Customer name”, Task Type “Service”, Status “InProgress”, Task Code “Aim”

e.g.

In the upgrades Trello, https://trello.com/b/6dIlfP4U/upgrades, move the customers card to “Currently installed”.

On the card, change the labels and set a due date for two weeks time. Comment the install date.

Email the customer.

Tell them AimBetter is on their system and that even though we get alerts, we find it’s best they notify us when they are having problems. Maybe reference the calls they have about it.

Note: I am working on a template:

AimBetter is now installed on your system. Although we do get notifications, we find it is best if you notify us when you are having problems so that we can look at the live data in AimBetter.

Please monitor and notify support if you have any problems with performance in the next few weeks: support@medatechuk.com

Paste the email into the Trello card. Paste the email into the service call.

Tell everyone on support that AimBetter is installed on the customer, so they are aware if we get service calls from them or if they notice anything themselves.

Record hours against the AIMBETTER service call.
