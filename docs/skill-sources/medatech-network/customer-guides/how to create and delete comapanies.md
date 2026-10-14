# how to create and delete comapanies

- **Source:** `how to create and delete comapanies.docx`

How to Create and Delete a Copy Company in Priority

To Create:

This must be completed while users are out of the company you are making a copy of.

System Management > System Maintenance > Companies > Copy Company

Full Company Name: Write the name of the company you want to copy, EXACTLY as it appears – you can F6 into the form (if the form is blank, press F11 and * to return all companies) Use F8 on the Full Company Name field to select the relevant company, and pull it back to your Parameter Input.

New Company: Choose the code for the new company. This should always be lower case. If left blank, Priority will assign a code.

New Co. – Full Name: Write the name of your new company.

To Delete:

NO users should be working in the company that is to be deleted.

System Management > System Maintenance > Companies > Delete Company

Note: this should be done from the server

This doesn't remove copies of backups of that company that may have been created, you would need to locate and delete them manually if necessary.

To Locate the Back-Up files:

Back Ups are scheduled in the Tabula Task Scheduler – check the list of Scheduled Tasks to see where they are pointed to save.

The default is usually the back-up folder in the Priority drive.

In the Back Up> Data - there will be one folder per company (you can find these Company Codes in System Management > System Maintenance > Companies > Companies)

Look at list of company codes vs company names and delete the files you wish to.

NOTE: DO NOT delete pritempdb or system back ups.
