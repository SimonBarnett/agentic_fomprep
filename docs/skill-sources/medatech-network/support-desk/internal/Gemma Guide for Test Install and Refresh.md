# Gemma Guide for Test Install and Refresh

- **Source:** `Gemma Guide for Test Install and Refresh.docx`

Gemma’s Guide for Refreshing on a Blank Test System

Install SQL Server

If we are providing, copy the ISO file from N:\Applications\MS SQL Server 2022 (check which version live is on and make sure you use the same one on test) onto server.

On the server, double click on the ISO file and run the setup.exe (this is the installer).

Select New SQL Server stand-alone installation.

Specify a free edition: Developer:

Tick the boxes as follows:

Name the instance PRI:

Switch SQL Server Browser to Automatic:

Click on the Collation tab and switch collation to SQL_Latin1_General_CP437_BIN

Select Mixed Mode and enter sa password (give same as live):

Click Next all the way through to the install screen.

Insall .net files

Copy all these files onto the server and run to install:

Install core hosting bundle 9 (for 25.0/25.1 servers)

Install Microsoft Redistributable Visual c++

Copy all these files onto the server and run to install:

Install IIS

Follow this guide on Xpert to install IIS onto the server: https://cdn.priority-software.com/docs/Install_LiteRich_Applic_Server_22_1_E.pdf

Section: Installation of IIS

Install SSMS

From the web: https://learn.microsoft.com/en-us/ssms/install/install

Backup Live server

Make sure there is a recent backup on the live server that can be copied to the test server.

You may need to run a backup, and you may need to clear space on the servers to copy the file across.

Copy the whole live backup folder to the test server (rename - backup old.version)

Clean up the files in data folder so you only have the latest .bak files

Restore

From the backup folder, run restore as administrator.

Accept licence agreement

Select Priority Restore

Choose location to restore Priority e.g. c:\priority (this doesn’t exist beforehand)

Select the SQL Server (test) and enter sa password

Select Install

This may then take a couple of hours.

Move Database Files

Check if the database files are in the Priority\Data folder:

If so, open SSMS.

Right click on each DB, select Task, Detach:

Tick both tick boxes to detach:

Move all DB files to C:\Program Files\Microsoft SQL Server\MSSQL16.PRI\MSSQL\DATA

In SSMS right click on Databases and select Attach:

Select Add:

The C:\Program Files\Microsoft SQL Server\MSSQL16.PRI\MSSQL\DATA should open and add each DB.

Check Files

Check all the bin.95 files are there (compare test and live)

Copy live \priority\system\util folder to test  \priority\system folder

Check Users

In SSMS open Security > Logins and visually compare this to live:

Open Priority and run SQL Server Checks: System Management > System Maintenance > Periodic Maintenance > Run Integrity Checks-SQL Server

Check Client

Open forms and check no errors.

Open System Management > System Maintenance > Companies > Companies, add a T to the start of each company name.

In the TTS, change the backups to point to the correct path.

Check the tabula.ini references the correct paths

Check File Permissions

You will need to add “Everyone”:

Web

Install Self Signed Certificate

Install App Server – take URL from certificate e.g. ERPTEST01.EmcelFilters.local

Start the IIS and services

Check functionality of web

Install Search

We are now ready to upgrade!!!

Perform a backup

Rename backup to version number

Reprepare forms and procedures

Save licence, renew licence, save licence again

Download upgrade file

Run as admin. We may need to repeat above steps if upgrading more than one version.

Check known errors from the Upgrades Trello

Checks

Check errors with developer

Check all logs

Check for RCHARS

Check bin version – update if not latest

Stop server sending emails

Handle unassigned privileges

Check files/space and run backup

Reinstall App Server

Set recovery on services and change App to delayed start.

Install TTS

User/ Group | Directory | Directory Contents | Permission

Administrator | Priority |  | Full Control

Administrator | Priority/system/fusioncharts | Used to display flash charts & graphs | Full Control

System | Priority |  | Full Control

Everyone | Priority |  | Read

Everyone | Priority/bin.95 | Priority programs | Read

Everyone | Priority/client | Files used to install new Clients | Read

Everyone | Priority/system/document (and all sub-directories) | Non-HTML documents and screen-painted forms | Full Control

Everyone | Priority/system/html | HTML documents | Full Control

Everyone | Priority/system/images | Images for HTML docs/webs | Read

Everyone | Priority/system/java | Java programs | Read

Everyone | Priority/system/javachart | Java programs for graphs | Read

Everyone | Priority/system/javahelp | Java client help files | Read

Everyone | Priority/fusioncharts | Used to display flash charts & graphs | Read

Everyone | Priority/system/load | Preferred path for files related to external interfaces | Full Control

Everyone | Priority/system/macros | Users’ macro definition files | Full Control

Everyone | Priority/system/mail | Files attached to e-mails | Full Control

Everyone | Priority/system/prep | Compiled forms and reports | Full Control

Everyone | Priority/system/reports | Saved reports | Full Control

Everyone | Priority/system/sched | Accessory files for programs | Full Control

Everyone | Priority/system/upgrades | Results of software upgrades | Full Control

Everyone | Priority/system/util | Utility queries | Read

Everyone | Priority/tmp | Priority’s temporary files | Full Control

Everyone | Directory defined as Tabula Tmp in the tabula.ini file | Priority’s temporary files for local use | Full Control
