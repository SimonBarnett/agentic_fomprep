# updating bin.95 customer use

- **Source:** `updating bin.95 customer use.docx`

Updating bin.95

Step 1: Locating exe file

Step 2: Make a copy of the bin.95

Now run System Management > Generators > Forms > Form Preparation > Form Preparation and System Management > Generators > Reports > Prepare Reports & Procedures

Take a copy of any errors received

Also, check that there has been a recent backup

Step 3: Running the update program

If you receive any errors at this point, compare them to those received after running form preparation.

If there are any discrepancies, send the errors to support or your project manager.

If you have any concerns, consider rolling the bin back by replacing with the copy made earlier.

Step 4: web server

If you have a separate Web server, you will need to copy the updated bin.95 folder and paste it onto the web server’s local Priority directory. This is usually in C:\Priority.

In either case, you will now need to reinstall your application server.

Firstly, stop the IIS server.

Change the current WCF folder to WCF.OLD (can be found at c:\inetpub\wwwroot\wcf).

Go to System Management > System Maintenance > Internet Definitions > Application Server Maintenance > Install Application Server

Make sure a new WCF folder is created next to the old one.

Start the IIS server

Check that your tabula task scheduler is running

Make sure this executable file is somewhere on your server | 

Find location of the bin.95 by right clicking on the priority client shortcut on the server and select properties | 

Go to the location and make a copy of the current bin.95 and paste this into the same folder | 

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
