# updating bin.95 spectrum

- **Source:** `updating bin.95 spectrum.docx`

Updating bin.95

Step 1: Locating exe file

Step 2: Make a copy of the bin.95

Step 3: Running the update program

Step 4: web server

If you have a separate Web server, you will need to copy the updated bin.95 folder and paste it onto the web server’s local Priority directory. This is usually in C:\Priority.

In either case, you will now need to reinstall your application server.

Firstly, stop the IIS server.

Change the current WCF folder to WCF.OLD (can be found at c:\inetpub\wwwroot\wcf).

Go to System Management > System Maintenance > Internet Definitions > Application Server Maintenance > Install Application Server

Make sure a new WCF folder is created next to the old one.

Start the IIS server

Start the tabula task scheduler

Make sure this executable file is somewhere on your server | 

Find location of the bin.95 by right clicking on the priority client shortcut on the server and select properties | 

Go to the location and make a copy of the current bin.95 and paste this into the same folder | 

Open the executable file | 

Run the program  More info>Run anyway | 

Enter the tabula password when prompted  Press OK | 

Press OK | 

Once completed, you will be shown this success message  Press OK | 

Press OK | 

Take a copy of the files from the old bin (bin - copy).   Paste these in the new bin folder without replacing any of matching files.   Any additional files will be in the new bin and the rest of its contents will be unchanged. | 

Open priority client as administrator   Login as tabula | 

Check the highlighted fields are filled in  (If not, change companies until they are)  Input Windows password  Approve | 

Select Lite+Web  Approve | 

Make sure the Priority and Windows login details and passwords are filled in  Press OK | 

Approve | 

Input tabula password  Approve | 

Press OK and wait for dialogue boxes to disappear. |
