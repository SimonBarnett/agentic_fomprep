# lb21000002-installupgrade

- **Source:** `lb21000002-installupgrade.docx`

Priority Installation, Upgrade & Refresh Manual

Version 20.0 and 20.1 and 21.0

Document Directory

Types of Installation & Upgrade

Priority Installation – Full installation of Priority

Test upgrade – Upgrade test server (usually includes a full refresh)

Live upgrade – Upgrade live server

Types of Refresh

Full refresh – Update DBs AND copy all priority folders

Partial refresh – Update DBs on another server, which already has priority installed for

Priority Installation

Definition

Priority vanilla installation is a clean (new) Priority installation on machine.

Steps to be completed

Preliminary Checks

Install Priority

Install Addons and fixes

Install module upgrade files

Install IIS and App Server

Install Search service

Post Installation process

Installation Preliminary Checks

Create and populate LB21000001 excel for this customer installation. It should be saved for this customer and saved against the project

Use that Excel file to check the specification of the system according to current supported software

Install all software needed for Priority

.Net 4.8

MS SQL. Version and license according to LB21000001 for this installation

IIS

Install SQL Management server

Download the Priority version you need https://support.priority-software.com/#/downloads. You will need to connect the download for a company and a project.

For internal use (ie local installs for staff) Use Medatech UK Ltd as a company name, with project  Priority Demo – Medatech UK -SQL (This is a full manufacturing system) or Priority Demo – Medatech UK -SQL -comer (This is a commercial / distribution only system)

For customers make sure to select the company name for which you are doing the installation.

Create folder named INSTALL + current version of Priority (e.g. INSTALL 201) on a drive where Priority will be installed and save all installation files there (MS SQL, Priority, BIN etc.)

Install Priority

You can use a manual from here https://support.priority-software.com/#/kb/LBI2000453/English

Run the downloaded file (from step 1.3) as an administrator

C:\Priority – is a default folder for the installation. Change the drive if needed. Preferably to the D or E drive.

Click NO If SQL server is already installed

Select the machine where you want to install Priority. In this example CLAMP is a computer name, and PRI is an MS SQL instance name

Save Installation errors (if any) to the Installation folder created in step 1.4

Install Add-ons and fixes

Manual is here

Install module upgrade files

This is according to what the customer has ordered and will change on a one by one basis.. If modules ordered then it will be discussed at installation handover.

Install IIS and App Server

Manual is here

Install Search service

Manual is here

Post Upgrade process

Manual is here.

Test Upgrade

Definition

Upgrade of Test server to newer (not necessarily the newest) Priority version/BIN version. Sometimes, before test upgrade DBs from the live server may be copied to Test server. If customer didn’t have a Test server before:

Vanilla installation has to be completed first and DBs transferred from Live to Test server

Copy Backup folder from Live server and run Restore on Test server. Then copy all folders that do not exists on Test server (Priority folder) from Live server (Priority folder).

Steps to be completed

Preliminary Checks

Refresh System, if required

Run Daily Backup

Form preparation

Report preparation

View License

Download and Upgrade

Renew License

Install Add-ons

Re-install Application Server

Re-install Search Server

Post Installation process

Upgrade Preliminary Checks

Is LB170000041 signed by customer? This document must be attached to our Priority.

1.1.1 Do you have a domain name for IIS and SSL certificate if it is needed?

Read the technical specification file for the Priority version you want to install and make sure the server meets the minimum requirements. Technical requirements can be found here https://support.priority-software.com/#/kb, use keywords “hardware and support systems”.

Create and populate LB21000001 excel for this customer upgrade. It should be saved for this customer and saved against the project

Any info to consider in Med Add'l Info Type 20 for the customer.

Install all software needed for Priority

.Net 4.8 and .net5.0 hosting

MS SQL. What version and where is a license key

IIS

Install SQL Management server

Download Priority version you need https://support.priority-software.com/#/downloads. Use Medatechuk as a company name if you install Priority for yourself or a company name for which you do installation. NOT NEEDED IF YOU ARE UPGRADING ONLY IF INSTALLING

Create folder Upgrade + current version of Priority (e.g. Upgrade 18.1) on a drive where Priority will be installed and save all installation files there (MS SQL, Priority, BIN etc.)

Review size of system\mail and system\reports folders on live environment. These hold all the mail and reports generated and will increase the time to copy the data over from live to test system. Customers should be running the supplied processes to manage the size of these folders. System Management > System Maintenance > Periodic Maintenance > Clear "mail" Directory, and System Management > System Maintenance > Periodic Maintenance > Delete Saved Reports. Encourage customers to cleanup these folders prior to upgrading.

Refresh System, if required.

Instructions on this process can be found here

Run Daily Backup on the Test server

System Management > System Maintenance > Periodic Maintenance > Run Daily Backup.

Run Form preparation

System Management > Generators > Forms > Form Preparation > Form Preparation , and select Reprepare all forms and save result to Upgrade folder with default name + ‘pre upgrade’.

Run Report & Procedure preparation

System Management > Generators > Reports > Prepare Reports & Procedures. and select Reprepare all and save result (If there are errors a report will display) to the Upgrade folder with default name + ‘pre upgrade’.

Run View License

System Management > System Maintenance > Software Licenses > View License Details and save result to Upgrade folder with default name + ‘pre upgrade’. Note: save the file as a PDF of MHT file (not an html) so that you can view the contents later..

Download and Upgrade Priority

Create folder Upgrade + current version on the same drive where is Priority (e.g Upgrade180).

Open priority and run Help/Upgrade System.

Save file to Upgrade folder.

Close Priority and run downloaded file as Administrator.

Save Installation Errors (if any) to Upgrade folder.
Then repeat 7.2, 7.3 and 7.4 until reaching the latest version.

Repeat steps 3,4,5 but add + ‘post upgrade’. – to define the files as the error reports post upgrade.

You will need to repeat this step (Step 7 Download and Upgrade Priority) until you get to the final version you are upgrading to.

All files downloaded should be referenced in the Priority Project so that they can be located for the live upgrade.

Renew Priority License

Tabula user must have email  support@medatechuk.com

Run Renew Licence and check that the line at the top of the report which advises the date it is valid until. This needs to be in the future.

Install Add-ons if needed

Manual is here.

Check table changes recorded in Std Trigger Chgs

For customer review all records in Standard Trigger Changes which are of type “T”. This indicates a table change. Review the comment and check that the table definition in Priority still matches. For example, a column may have been increased in length from 6 to 15. The check would be to ensure the column is still 15.

This will reveal if any table copies will be needed for the live upgrade.

To create table backups, run the following command in windbi, replacing table name as appropriate.

SELECT 'BEFORE', SQL.ENV, COUNT(*) FROM [TABLE_NAME] FORMAT ADDTO STRCAT('../../system/upgrades/[TABLE_NAME]- ',SQL.ENV, ' -COUNT.TXT');
 SELECT * FROM [TABLE_NAME]  DATA STRCAT('../../system/upgrades/[TABLE_NAME] -', SQL.ENV,'.BAK');

This has to be done for each company. Note that the company name is part of the filenames.

Re-install Application Server

Manual is here.

Re-install Search Engine Server

Manual is here.

Post Upgrade process

Manual is here.

Handover to PM to check errors in upgrade and to carry out “Standard Trigger Changes”

Send email to PM to advise upgrade is completed and the current status. They should fix any errors encountered, update any std trigger changes and create a revision file (saved in the upgrades folder and referenced in the project ready for live upgrade)  and advise you and the customer when then is completed so that they may commence testing.

Ensure project is up to date with all details

Update the Priority project with all relevant details which may be needed for the live upgrade. Where files are located. And save those files to the live server ready for the live upgrade.

Live Upgrade

Definition

Upgrade of Live server to newer (not necessarily the newest) Priority version/BIN version.

Steps to be done

Preliminary Checks

Run Daily Backup

Form preparation

Report preparation

View License

Download files from Test/Upgrade folder

Renew License

Install Add-ons

Post Upgrade process

Preliminary Checks

Is LB170000042 signed by customer? This document must be attached to our Priority.

Review  LB21000001 excel for this customer upgrade.

Read the technical specification file for the Priority version you want to install and make sure the server meets the minimum requirements. Technical requirements can be found here https://support.priority-software.com/#/kb, use keywords “hardware and support systems”.

Check (and copy if necessary) folder Upgrade from Test server onto a drive where Priority is located.

Run Daily Backup on the Live server

System Management > System Maintenance > Periodic Maintenance > Run Daily Backup.

Have you PM or nominated other check the backup file.

Run Form preparation

System Management > Generators > Forms > Form Preparation > Form Preparation and save result to Upgrade folder with default name + ‘pre upgrade’.

Run Report preparation

System Management > Generators > Reports > Report Generator and save result to Upgrade folder with default name + ‘pre upgrade’.

Run View License

System Management > System Maintenance > Software Licenses > View License Details and save result to Upgrade folder with default name + ‘pre upgrade’.

Upgrade Priority

Make sure nobody is logged in. In order to make sure nobody is logged in go to System Management > System Maintenance > Periodic Maintenance > Active Users. The upgrade can only be completed if everyone is logged out of the system.

Run installation file from Upgrade folder as Administrator

Save Installation Errors (if any) to Upgrade folder.

Repeat steps 3,4,5 but add + ‘post upgrade’.

Install files from PM (*.sh, *.rv). Parameter Input form is for sh file. Shell file to install “emerge” menu (if it doesn’t exist). R:\INSTALLED AS STANDARD\02 - TAKE & INSTALL UPGRADE

Renew Priority License

Tabula user must have email  support@medatechuk.com

Run Renew License System Management > Revisions > Renew License

Install Add-ons if needed

Manual is here.

Re-install Application Server

Manual is here.

Re-install Search Engine Server

Manual is here.

Post Upgrade process

Manual is here.

Handover to PM.

PM to check system and handover to customer.

Partial Refresh

Definition

Partial Refresh – Update DBs on the test server

Steps to be done

Run Daily Backup

Update DBs

Run Daily Backup on the Test server

System Management > System Maintenance > Periodic Maintenance > Run Daily Backup.

Update DBs

Stop IIS server

Make sure nobody is logged in. In order to make sure nobody is logged in go to System Management > System Maintenance > Periodic Maintenance > Active Users. The upgrade can only be completed if everyone is logged out of the system.

Update DBs.

Manual for Restore.

Manual if DBs copied manually.

Check that you successfully import all users and DBs.

Login to Priority, select base company and open a few forms. No errors should appear.

Open the Companies form (P System Management > System Maintenance > Companies > Companies) and amend all company names so that they are prefixed with a T (to indicate that this is the test server)

If DBs copied manually, all links from database to system\mail and system\reports on the test server will be broken. The processes System Management > System Maintenance > Periodic Maintenance > Clear "mail" Directory, and System Management > System Maintenance > Periodic Maintenance > Delete Saved Reports, should be run to clean the database links. Then all files in system\mail and system\reports should be removed.

Full Refresh

Definition

Full refresh – Update DBs AND copy all priority folders.

Steps to be done

Run Daily Backup on Test server

Copy all folders in the backup directory from Live/Priority backup folder to Test/Priority.

Update DBs

Run Daily Backup on the Test server

System Management > System Maintenance > Periodic Maintenance > Run Daily Backup.

Copy all folders from Live/Priority backup folder to Test/Priority

Update DBs

Stop IIS server.

Make sure nobody is logged in. In order to make sure nobody is logged in go to System Management > System Maintenance > Periodic Maintenance > Active Users. The upgrade can only be completed if everyone is logged out of the system.

Update DBs.

Manual for Restore.

Manual if DBs copied manually.

Check that you successfully import all users and DBs.

Login to Priority, select base company and open a few forms. No errors should appear.

Open the Companies form (P System Management > System Maintenance > Companies > Companies) and amend all company names so that they are prefixed with a T (to indicate that this is the test server)

Check the database backup commands in Tabula Task Scheduler are pointing at a valid directory. The live server will likely have multiple disk drives compared to the test server.

Check the tabula.ini file for references to disk drives that do not exist on the test server and correct if necessary.

Manuals

MS SQL server installation

If you install on a live server, you need to have a license key. You can get it from a customer or from Keith Doddington.

Can be an Error with Firewall. It is OK.

For the local installation or TEST/DEV server use FREE edition (Developer, NOT Evaluation as the screenshot) . For the LIVE servers use Product Key option

Tick the boxes as following

For some clients you may need to change the path to D: or another drive. Usually, Priority and SQL are on the same drive.

Switch SQL Server Browser to Automatic

SQL_Latin1_General_CP437_BIN – must be a default collation.

You can check the collation of an existing working server (in case of debugging). Right click on a database on the left panel and Properties.

Select Mixed Mode, Enter a password; Add current user.

IIS and Application service installation

It is not necessary to remove the existing folder c:/inetpub/wwwroot before the Application Server installation. Feel free to take a copy if you feel necessary.

Follow instructions in the link below. When you click on the link wait for 5 seconds to get manual. Manuals describe an installation process on Windows Server and Windows 10 OS:

https://support.priority-software.com/#/kb/LB22000064/English (v22 file)

https://support.priority-software.com/#/kb/LBI2100511/English (v21 file)

https://support.priority-software.com/#/kb/ /English (v20 file)

https://support.priority-software.com/#/kb/LB19000069/English (v19 file)

Note: If you need to repeat this because something went wrong, you may find that when you try and delete the wwwroot directory it will be in use. Stop the World Wide Web Publishing service to allow delete.

Search Service installation

You must install the Search Service on the same machine where the Application server is located.

Detailed Priority instructions are located here

https://support.priority-software.com/#/kb/LBI2000264/English

You must have java installed before you can complete the process. You can download java and install on the server from https://www.java.com/en/download/manual.jsp

Once it is installed.

Run Priority as Administrator

System Management > System Maintenance > Search > Install Search Server

Input requested information

When complete is done run System Management > System Maintenance > Search > Activate Search Service.

Run System Management > System Maintenance > Search > Search Definitions > Initialise Search Definitions. Do not click the Default Document check box.

Run System Management > System Maintenance > Search > Build Search Index.

Install License for Priority.

Run Priority and go System Management->System Maintenance->Users. Search for Tabula user and change email to support@medatechuk.com

Before you can install Priority on your company’s workstations, you need to install the file that contains your licensing information. If using Medatech Demo License find it in V:\LICENSES. You may need to adjust server date to install license.

To do so you will need to use one of the below options dependants on file type supplied:

Option A can be used if file type is .lic

Save the license file you have (Keith Doddington is responsible for License keys) into a folder on the Priority server. Make sure that the full path including the file name and extension does not exceed 50 characters.

From within Priority, enter the Software License menu from the following path:

System Management > System Maintenance > Software License.

Click Install License.

In the input screen that opens, click Browse and locate the license file.

Click OK, and wait for the message confirming a successful installation. Your license is now installed in the system.

Option B must be used if file type is .lic.exe

Save the license file you have in a folder on the Priority server. Make sure that the full path including the file name and extension does not exceed 50 characters.

From within Priority, enter the Revisions Menu:

System Management > Revisions.

Click Install Upgrade.

In the input screen that opens, click Browse and locate the lic.exe file.

Click OK, you will be prompted for the tabula password.

Wait for the message confirming a successful installation click Ok.

Your license is now installed in the system and will display in a web browser screen.

If you have changed the computer date to install the license then you must change it back before continuing.

Add-ons installation

Download the latest BIN version from Priority website https://support.priority-software.com/#/downloads.

Run Priority upgrade Sys. Maintenance->Revisions->Install Upgrade.

ONLY Version 20.0 Addons.

Install HMRC Add-on. BIN must be version 20.0.38 or higher.

Install Hebrew Add-on – SC20002336 – only needed in v20.0

Post Installation

When Priority is installed these steps must be completed.

Update Medatech Additional Info with new version (Priority -> CRM > Customers > Customers-> Medatech Add’l Custmer Info)

Set tabula.ini (Windows folder) file to Auto Translation False

[Environment] add a new line:

Auto Translation = FALSE

Company Setups

Defining Companies.

The software installs a demo system as standard.

You should add a new company to perform initial set ups on, and once this company is set-up, create a copy so that you can always have a base company with basic data. You will then be left with 2 companies. Blank Initialised system, and Test XXX Company Ltd. Depending on your project you can then decide which company should be copied for use as the live system etc..

Company Short code should be lowercase no capitals

Add blank company:

System Management > System Maintenance > Companies > Add Company

GBP is not in the currency drop down, but you can input it as base currency.

(GBP does exist in Financials > Maintenance of Financials > Exchange Rates > Currencies)

Use C2 as the second currency. (You will need to change this to British Pounds or customers required currency)

Uncheck “Initialise accounts” flag.

Copy blank company:

System Management > System Maintenance > Companies > Copy Company

Now switch to your test company.

Additional Items on Installing Priority Specific to UK

These MUST BE DONE! But only once the new company has been created.

Install the following shell file INSTALLSTANDARDV27.sh, found in R:\INSTALLED AS STANDARD. This will install the list of changes below which do have their own shell files if required (“System Management > Revisions >Install Upgrade”) – Current Version is 27

NB. Exit priority and restart.

Fix Alert (Z:\INSTALLED AS STANDARD\ fix form alerts version 20-1) should be installed ONLY in case of Upgrade.

Shell files can only be run on a licensed system so you may need to carry out the 2 steps below before you can run them.

You will need to change the email address of the user ‘tabula’ to ‘support@medatechuk.com’ using Human Resources > Personnel File Or you can change it in System Management > System Maintenance > Users > Users under user Tabula.

And will need to renew the license using System Management > Revisions > Renew License

Check the default currency is set to GBP.

Financials > Maintenance of Financials > Exchange Rates > Update Local Currency

or

Financials > Maintenance of Financials > Auxiliary Programs > Update Local & Second Currencies

Check  that you can get into some forms and reports.

Set REMOTE H5 to 0. System Management > System Maintenance > Constant Forms > System Constants

Install Priority Special Additions. – only if specified.

Ensure that the Journal Entry Patterns are set correctly for VND, GRV

They need to look like this. The standard second line will show LineItems with Debit 1, it should show Debit 2, and then a line for Tax with Debit 3.

Ensure customer is advised to check that the file permissions are accurate. – We should add this to the installation handover (item 9) .

Check Tabula Scheduler is installed and running: System Management > System Maintenance > Tabula Task Scheduler

Switch the daily backup on so that it runs every night. .

Set up service startup and recovery options

Priority App Service - startup type: automatic (delayed), Recovery option to restart on failure

Priority Redis Service - Recovery options to restart on failure

Send the installation handover document.

Permissions

Administrating Permissions for Priority Files

We recommend that you install Priority using the NTFS file system, so that you can define appropriate permissions to the program files and thus prevent changes to these files from unauthorized users, or their deletion from the system.

Note: The following permissions are minimal. We recommend that you do not deviate from the list. If you nevertheless decide to change permissions, ensure that you haven't reduced them. Reducing permissions any further is likely to impair the proper functioning of the system!

In order to install clients, it is also necessary to execute Sharing of the priority folder on the server. When defining the Sharing, assign Full Control permission to everyone.

Permissions that should be assigned to Priority files on the server: *

*If you decide to change permissions, ensure that the following two options are selected:

• Replace Permissions on Existing Files

• Replace Permissions on Subdirectories

Tabula Task Scheduler

Check the tabula task scheduler has installed and started.

Change Backup settings – Set Daily backup to run every day.

Priority Restore Process

Copy Backup folder from Live server

Prepare MS SQL using this manual

Start Restore process as Administrator. It imports all DBs to the SQL DB and install Priority

Check where all DBs are. If files are in Priority folder – it must be moved to SQL.

Figure 1. Wrong file location

Detach all DBs in SQL Studio. Right click on DB name (e.g. pritempdb)->Task->Detach

Move all files to the SQL folder (E:\Program Files\Microsoft SQL Server\MSSQL14.PRI\MSSQL\DATA).

Attach DB in the SQL Server. Right click on Databases and open the folder E:\Program Files\Microsoft SQL Server\MSSQL14.PRI\MSSQL\DATA (should be opened by default)

5.  Check that the restore process has not omitted any folders forms from bin.95 directory. Do a simple folder count / file count comparing restored bin.95 folder against bin.95 folder in restore directory. (One upgrade it was found that some files existed in the restore folder but had not been created in the new folder).

Manual Refresh (DBs update)

Run Daily backup on Test/Dev server.

Check the names of companies in Priority on Live server. Sometimes there can be more DBs, but only DBs that are in Priority must be copied on Test server.

Refresh using BAK files

Copy C:\priority\backup\data folder from Live server. It is a default location, but check settings in Priority to find current location of the backup (System Management > System Maintenance > Tabula Task Scheduler > Define TTS Tasks). In this folder are all companies from Priority (in screenshot it is demo, live, a101920, a102820) + system and pritempdb must be copied.

Go to ‘a101920’ folder and sort files by Date modified.

Find more recent BAK file and trn file where date and time of modification is approximately the same (+/- 3 minutes).

Copy these files to Test server. This method can save a lot of time, because no need to copy unneeded files.

Do it with all companies you need to copy.

Prepare MS SQL using this manual.

Two ways to import DBs: when BAK or MDF files are using

Open MS Studio and Right click on Databases on the left panel.

Select Restore Database->Device->Add and find BAK file you need to restore a DB.

On the left side where is Select a page, choose Files and tick the box Relocate all files to folder. By default, it should be a MS SQL folder. Click OK.

On the Option tab do not change anything and click OK.

Wait for the end of process.

Refresh using mdf files

Copy mdf and ldf files to C:\Program Files\Microsoft SQL Server\MSSQL14.PRI\MSSQL\DATA

In SQL Studio right click on Databases and Attach…->Add

Select the DB you want to import

Priority and IIS on different servers

If Priority is already installed on IIS server.

On IIS server run "update priority executables" from the Start menu or manually copy the BIN folder from the Priority/Client server to the local disk on IIS server.

New Priority Client installation on IIS server.

Add shared network folder to server where Priority is installed.

Go to Client folder and run Setup.exe with administrator privileges.

Fill in this form according to your client.

Example of tabula.ini

C:\Windows\Tabula.ini from IIS server

[Environment]

Tabula Tmp=E:\tmp

Tabula Path=E:\priority-Emerge\bin.95

Priority Directory=\\copperhead\priority-Emerge\system\prep

Priority RemoteRoot=E:\priority-emerge

Tabula Host=COPPERHEAD\PRI

GlobalParams->language=2

Portal=true

Language=2

Priority UNC=\\Copperhead\priority-emerge\system\prep

HighTime=30855721

LowTime=107262796

[Report]

HTML=1

[Wizard]

OpenHelp=1

[Log]

Server Level=5

Server Path=\\copperhead\priority-Emerge\log

Server Buffered=1

Upgrade Level=3

Upgrade Path=\\copperhead\priority-Emerge\log

Upgrade Buffered=1

[Internet]

Images Source=..\..\system\images

Mail Source=..\..\system\mail

Images Directory=/priimages

Mail Directory=/primail

SQL DBs preparation before Restore/Refresh

Make sure you have all backups needed before starting this process and you got permission from the client and Christine/Fode to delete DBs!!!

Open SQL Server Management Studio

Delete all DBs. In this case it is ‘demo’, ‘pritempdb’,’system’. DO NOT DELEETE anything from System Databases!

Delete all users except ‘sa’, ‘tabula’, ‘## *’ users and any users related with domains (Deathstar\ and NT *\ in this case).

Hints

No SQL server in Priority or ODBC dropdown menu

Use configuration manager

C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft SQL Server 2017\Configuration Tools and run it, or type in search “sql server configuration manager”.

Check SQL server browser. Turn it on and restart the sql server.

Manually type server

Enter hostname/sql instance manually. E.g. Server11/PRI

Run Command Prompt (run… -> cmd) and type hostname

Find the instance name (PRI in this case)

ODBC to check connection to MS SQL

Search for ODBC in Start menu. Choose according to your OS x32 or x64

Click Add… and select ODBC driver

Enter any name for this and choose server you want to connect from Drop down menu.

Choose authentication method – Windows account or MS SQL user

Click Next until you see this

Click on Test Data Source… button.

You should see this if everything is fine.

If ODBC connection doesn’t work or SSMS doesn’t accept password

Disable firewall

Check Antivirus. They can have their own Firewall

The "sa" account disabled by default. So, you'll need to toggle the account from disabled to enabled under the status section of the account.

The server must have windows and sql server authentication enabled. By default, only windows authentication is enabled.

How to delete user with schema in MS SQL

use master;

GO

sp_changedbowner 'sa'

GO

Default Tabula user email

Tabula user must have this email address support@medatechuk.com for successful upgrade.

Priority upgrade from old versions on SQL 2019

1. First install SQL on the OS supported

2. Restore the data in SQL from 2012 to 2019

3. Upgrade to priority 20.1 on the new server

Part of Tabula.ini from Priority server

[Environment]

Tabula Host=COPPERHEAD\PRI

Tabula Tmp=D:\priority-emerge\tmp

Tabula Path=D:\priority-emerge\bin.95

Priority Directory=D:\priority-emerge\system\prep

Language=2

Portal=true

;Tabula External Editor=C:\Program Files\EditPlus 2\editplus.exe -t tabula

Priority UNC=D:\priority-emerge\system\prep

Client Checked=15502875

Bin Path=D:\priority-emerge\bin.95

Priority RemoteRoot=D:\priority-emerge

Part of tabula.ini when IIS not on the same server with Priority

[Environment]

Tabula Tmp=E:\tmp

Tabula Path=E:\priority-Emerge\bin.95

Priority Directory=\\copperhead\priority-Emerge\system\prep

Priority RemoteRoot=E:\priority-emerge

Tabula Host=COPPERHEAD\PRI

GlobalParams->language=2

Portal=true

Language=2

Priority UNC=\\Copperhead\priority-emerge\system\prep

[Log]

Server Level=5

Server Path=\\copperhead\priority-Emerge\log

Server Buffered=1

Upgrade Level=3

Upgrade Path=\\copperhead\priority-Emerge\log

Upgrade Buffered=1

TTS Tabula Time Schedule

You just need to run the below program to do this, on the relevant machine.

System > System Maintenance > Tabula Task Scheduler > Tabula Task Scheduler, and then select Install Task Scheduler

That would install the relevant service on the machine.

Log file for Support

In case of errors during upgrade run this.

System Management > System Maintenance > Periodic Maintenance > Run Diagnositcs for Service Call

Set Chrome as default browser for Priority

Ensure Chrome is set as the default browser (Control Panel>Default Programs)

If it is, open Regedit.exe expand the following: HKEY_CLASSES_ROOT\HTTP\shell\open\command

You are likely to see a path to Internet Explorer stored in this key. You can right click it to modify this to point to Google Chrome.

e.g.

Change:

"C:\Program Files (x86)\Internet Explorer\iexplore.exe"

To:

"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -- "%1"

Ensure the path to chrome.exe exists on the computer.

Logins recovery and restore

First Code (Do not Use)

Doesn’t work properly. Some logins or passwords can be missed

Export

use system

go

if exists (select name from sysobjects

where name = 'tabula_sql_logins' and type = 'U')

drop table tabula_sql_logins

go

create table system.dbo.tabula_sql_logins

(

name sysname null,

password sysname null,

sid varbinary(85)

)

go

insert into system.dbo.tabula_sql_logins

select master.dbo.syslogins.name, master.dbo.syslogins.password, master.dbo.syslogins.sid

from master.dbo.syslogins, system.dbo.USERS, system.dbo.SYSCONST

where system.dbo.SYSCONST.NAME = 'LANGUAGE'

AND master.dbo.syslogins.name = (case when system.dbo.SYSCONST.VALUE = 1 then reverse(system.dbo.USERS.USERLOGIN) else system.dbo.USERS.USERLOGIN end)

Go

Import

use master

go

declare logincur cursor fast_forward for

select name, password, sid

from system.dbo.tabula_sql_logins

where name <> 'tabula'

declare @loginame varchar(50),

@passwd nvarchar(128),

@sid varbinary(85),

@qry nvarchar(128)

open logincur

fetch next from logincur

into @loginame, @passwd, @sid

while (@@fetch_status = 0)

begin

exec master..sp_addlogin @loginame, @passwd, 'system', 'us_english', @sid, 'skip_encryption'

set @qry = N'grant view server state to [' + @loginame + ']'

exec sp_executesql @qry

exec master..sp_addsrvrolemember @loginame, 'sysadmin'

fetch next from logincur into @loginame, @passwd, @sid

end

close logincur

deallocate logincur

go

Second code for restore (default method!)

Tabula user is not copied!

Create database ‘Login’ on server where are needed logins.

Run the Export code

Backup Login database

Restore Login database to the new server where you want import logins

Run Import code

Export

use Login

go

if exists (select name from sysobjects where name = 'tabula_sql_logins' and type = 'U')

drop table tabula_sql_logins

go

create table Login.dbo.tabula_sql_logins

( name sysname null, password sysname null, sid varbinary(85) )

go

insert into Login.dbo.tabula_sql_logins

select master.dbo.syslogins.name, master.dbo.syslogins.password, master.dbo.syslogins.sid

from master.dbo.syslogins, system.dbo.USERS, system.dbo.SYSCONST

where system.dbo.SYSCONST.NAME = 'LANGUAGE' AND master.dbo.syslogins.name = (case when system.dbo.SYSCONST.VALUE = 1

then reverse(system.dbo.USERS.USERLOGIN) else system.dbo.USERS.USERLOGIN end)

AND master.dbo.syslogins.name <> 'tabula'

go

Import

use master

go

declare logincur cursor fast_forward

for select name, password, sid

from Login.dbo.tabula_sql_logins

where name <> 'tabula'

declare @loginame varchar(50), @passwd nvarchar(128), @sid varbinary(85), @qry nvarchar(128)

open logincur fetch next from logincur into @loginame, @passwd, @sid while (@@fetch_status = 0)

begin exec master..sp_addlogin @loginame, @passwd, 'system', 'us_english', @sid, 'skip_encryption' set @qry = N'grant

view server state to [' + @loginame + ']' exec sp_executesql @qry exec master..sp_addsrvrolemember @loginame, 'sysadmin'

fetch next from logincur into @loginame, @passwd, @sid end close logincur deallocate logincur

go

NOTE: eliminate the above highlit codes if you NEED to restore the tabula login. This will be necessary if you resort to copying files rather than using “Priority Restore”.

Third code (was send by email from medatech)

(ONLY USE IF SECOND DOES NOT WORK)

How to transfer logins and passwords between instances of SQL Server

The below is taken from:  http://support.microsoft.com/kb/918992

1.    On server A, start SQL Server Management Studio, and then connect to the instance of SQL Server from which you moved the database.

2.    Open a new Query Editor window, and then run the following script.

USE master

GO

IF OBJECT_ID ('sp_hexadecimal') IS NOT NULL

DROP PROCEDURE sp_hexadecimal

GO

CREATE PROCEDURE sp_hexadecimal

@binvalue varbinary(256),

@hexvalue varchar (514) OUTPUT

AS

DECLARE @charvalue varchar (514)

DECLARE @i int

DECLARE @length int

DECLARE @hexstring char(16)

SELECT @charvalue = '0x'

SELECT @i = 1

SELECT @length = DATALENGTH (@binvalue)

SELECT @hexstring = '0123456789ABCDEF'

WHILE (@i <= @length)

BEGIN

DECLARE @tempint int

DECLARE @firstint int

DECLARE @secondint int

SELECT @tempint = CONVERT(int, SUBSTRING(@binvalue,@i,1))

SELECT @firstint = FLOOR(@tempint/16)

SELECT @secondint = @tempint - (@firstint*16)

SELECT @charvalue = @charvalue +

SUBSTRING(@hexstring, @firstint+1, 1) +

SUBSTRING(@hexstring, @secondint+1, 1)

SELECT @i = @i + 1

END

SELECT @hexvalue = @charvalue

GO

IF OBJECT_ID ('sp_help_revlogin') IS NOT NULL

DROP PROCEDURE sp_help_revlogin

GO

CREATE PROCEDURE sp_help_revlogin @login_name sysname = NULL AS

DECLARE @name sysname

DECLARE @type varchar (1)

DECLARE @hasaccess int

DECLARE @denylogin int

DECLARE @is_disabled int

DECLARE @PWD_varbinary  varbinary (256)

DECLARE @PWD_string  varchar (514)

DECLARE @SID_varbinary varbinary (85)

DECLARE @SID_string varchar (514)

DECLARE @tmpstr  varchar (1024)

DECLARE @is_policy_checked varchar (3)

DECLARE @is_expiration_checked varchar (3)

DECLARE @defaultdb sysname

IF (@login_name IS NULL)

DECLARE login_curs CURSOR FOR

SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin FROM

sys.server_principals p LEFT JOIN sys.syslogins l

ON ( l.name = p.name ) WHERE p.type IN ( 'S', 'G', 'U' ) AND p.name <> 'sa'

ELSE

DECLARE login_curs CURSOR FOR

SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin FROM

sys.server_principals p LEFT JOIN sys.syslogins l

ON ( l.name = p.name ) WHERE p.type IN ( 'S', 'G', 'U' ) AND p.name = @login_name

OPEN login_curs

FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin

IF (@@fetch_status = -1)

BEGIN

PRINT 'No login(s) found.'

CLOSE login_curs

DEALLOCATE login_curs

RETURN -1

END

SET @tmpstr = '/* sp_help_revlogin script '

PRINT @tmpstr

SET @tmpstr = '** Generated ' + CONVERT (varchar, GETDATE()) + ' on ' + @@SERVERNAME + ' */'

PRINT @tmpstr

PRINT ''

WHILE (@@fetch_status <> -1)

BEGIN

IF (@@fetch_status <> -2)

BEGIN

PRINT ''

SET @tmpstr = '-- Login: ' + @name

PRINT @tmpstr

IF (@type IN ( 'G', 'U'))

BEGIN -- NT authenticated account/group

SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' FROM WINDOWS WITH DEFAULT_DATABASE = [' + @defaultdb + ']'

END

ELSE BEGIN -- SQL Server authentication

-- obtain password and sid

SET @PWD_varbinary = CAST( LOGINPROPERTY( @name, 'PasswordHash' ) AS varbinary (256) )

EXEC sp_hexadecimal @PWD_varbinary, @PWD_string OUT

EXEC sp_hexadecimal @SID_varbinary,@SID_string OUT

-- obtain password policy state

SELECT @is_policy_checked = CASE is_policy_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name

SELECT @is_expiration_checked = CASE is_expiration_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name

SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' WITH PASSWORD = ' + @PWD_string + ' HASHED, SID = ' + @SID_string + ', DEFAULT_DATABASE = [' + @defaultdb + ']'

IF ( @is_policy_checked IS NOT NULL )

BEGIN

SET @tmpstr = @tmpstr + ', CHECK_POLICY = ' + @is_policy_checked

END

IF ( @is_expiration_checked IS NOT NULL )

BEGIN

SET @tmpstr = @tmpstr + ', CHECK_EXPIRATION = ' + @is_expiration_checked

END

END

IF (@denylogin = 1)

BEGIN -- login is denied access

SET @tmpstr = @tmpstr + '; DENY CONNECT SQL TO ' + QUOTENAME( @name )

END

ELSE IF (@hasaccess = 0)

BEGIN -- login exists but does not have access

SET @tmpstr = @tmpstr + '; REVOKE CONNECT SQL TO ' + QUOTENAME( @name )

END

IF (@is_disabled = 1)

BEGIN -- login is disabled

SET @tmpstr = @tmpstr + '; ALTER LOGIN ' + QUOTENAME( @name ) + ' DISABLE'

END

PRINT @tmpstr

END

FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin

END

CLOSE login_curs

DEALLOCATE login_curs

RETURN 0

GO

Note This script creates two stored procedures in the master database. The procedures are named sp_hexadecimal and  sp_help_revlogin.

3.    Run the following statement:

EXEC sp_help_revlogin

The output script that the sp_help_revlogin stored procedure generates is the login script. This login script creates the logins that have the original Security Identifier (SID) and the original password.

4.    On server B, start SQL Server Management Studio, and then connect to the instance of SQL Server to which you moved the database.

Open a new Query Editor window, and then run the output script that is generated in step 3.

Recovery pending

You can see this problem in SQL Studio – database has status ‘Recovery pending’ and you can’t do anything with it.

Run this code in SQL Studio to remove this status:

ALTER DATABASE [DBName] SET EMERGENCY;

GO

ALTER DATABASE [DBName] set single_user

GO

DBCC CHECKDB ([DBName], REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORMSGS;

GO

ALTER DATABASE [DBName] set multi_user

GO

Error – no databases, but Priority has record about this company

Needed to create a company in MS SQL Studio (one for each env which priority thinks exists), and then OK through all the errors about tables not existing when it is deleted in Priority.

Advanced Debugging

In addition to the above debugging options available from within Priority, you

may occasionally wish to inspect the queries being sent to the database itself

(SQL Server or Oracle).

If no profiler is installed, you can open Priority in trace mode, so that all queries sent to the database are written to one or more trace files.

To open Priority in this mode, you must first set the directory in which trace files will be saved (e.g., C:\tmp). To do so, open a command line and execute one of the following commands:

When working with an SQL Server installation:

SET SSDEBUG=C:\tmp

When working with an Oracle installation:

SET ORADEBUG=C:\tmp

Note: You must specify an existing folder.

Next, open Priority from the command line. The easiest way to do this is to

record the target path of your desktop shortcut for Priority (e.g.,

D:\priority\bin.95\WINMENU.exe).

All queries that are sent to the database while working in this environment will

be written to trace files, which are saved in the specified folder.

Change currency

Financials > Maintenance of Financials > Auxiliary Programs > Update Local & Second Currencies

Run SQL interpreter in Priority

Priority -> Tools -> Run Entity windbi

Remove Redis service

Instructions: Make sure the customer’s system administrator implements them and only as

necessary.

To delete the Service named Priority REDIS, do the following:

1. First, stop the service via the operating system – Run > Services.msc

After stopping the service, take the exact name (by right clicking into Properties – the

relevant field is already highlighted, just copy it)

Open a CMD window with manager permissions and run the following command (be

careful that the name is written exactly – do this only with a system administrator):

SC Delete "Priority Redis Service"

2. Restart the server before installing the application server.

3. Now install the application server again to create the service in a valid way.

Note: It is recommended to make a backup of the configuration file redis.conf (found in

the Priority\tmp folder) in an external location in order to have a place from which to restore it

.if necessary

Djamal method

So this was a long complex process, i will only highlight the changes made towards the end of the process

Firstly i pulled any missing data from a separate tabula.ini file (this one didn't work but it had some extra data

next we removed the target from right clicking priority and going to properties, and removing the minus t section!

This then added the tabula path to help about!

next i restarted the server

I then made the wwwroot old

turned off iis

stopped pri.net

reinstalled app server

restarted server to ensure services came back on in right order

Issue resolved

SQL Port. Cannot connect to server '10013'

Some users can log into Priority, other users receive the error 'Cannot connect to server (10013)' on the same client machine.

This error can be received when an anti-virus program or firewall is blocking access to Priority.

You should define static port in the SQL server (dynamic would obviously change with every restart) - preferably the default 1433 , then open it both for UDP and TCP.

Then open port 1435 TCP and 1434 UDP (both ways)

To check whether it works - just try to reach the server from the client with ODBC (Using SQL Native Client Driver), that should suffice.

Incorrect Character display for £

In the tabula.ini file

under [Environment] add a new line:

Auto Translation = FALSE

Reports hours on project

To see the hours you spend on projects run this:

Project > Reports on Projects > Project Hrs & Efficiency Reports > Reported Hrs-Totals Inc Days FKS

Medatech employee reports > Hours Reported Per Day

Medatech employee reports > Less than 8 Rep Hours

Project > Reports on Projects > Project Hrs & Efficiency Reports > Reported Hrs-Totals Inc Days

In workstations with Windows 10, the minimize button does not work

For users with color coding for companies via the Companies form (path: System Management > System Maintenance > Companies), in the Color field, delete the colors specified for companied, and restart the system.

Another solution is to change the following value in the tabula.ini file:

ThinButtons=35

to tabula.ini under [Environment] section

If this doesn’t help, you can try between 20-45, depending on the version of Windows 10 you have.

Install/uninstall IIS via PowerShell - FQ21000022

Uninstall

Warning! It will be impossible to install IIS via UI (26/04/21).

Run Powershell as Administrator

Uninstall-WindowsFeature -Remove Web-Server

Install

Use it when UI doesn’t work.

1) PS C:\> Get-WindowsFeature - list of all Features. Here you can find the names of features to install.

2) List all features you neeed to install

PS C:\> Install-WindowsFeature -Name @(“Web-Server”, “Web-WebServer”, “Web-Common-Http”, “Web-Default-Doc”
, “Web-Dir-Browsing”, “Web-Http-Errors”, “Web-Static-Content”, “Web-Health”, “Web-Http-Logging”, “Web-Http-Tracing”, “We
b-Performance”, “Web-Stat-Compression”, “Web-Dyn-Compression”, “Web-Security”, “Web-Filtering”, “Web-App-Dev”, “Web-Net-
Ext”, “Web-Net-Ext45”, “Web-AppInit”, “Web-Asp-Net”, “Web-Asp-Net45”, “Web-ISAPI-Ext”, “Web-ISAPI-Filter”, “Web-Mgmt-Too
ls”, “Web-Mgmt-Console”)

How To Know Which Process is Using a File or Folder in Windows

1) Run Resource Monitor

2) Select CPU and search for the folder you want to Delete/Rename...

Is Form Alerts Fix Needed to be Applied to Upgrade?

The decision is not so much based on what version the customer is going TO, but actually what version they are coming FROM.

The way to check is in the form prep errors. Errors referring to ZEMG_COPYFORMALERTS or ZEMG_LOADFORMALERTS indicate that the fix is needed.

The following is an example from Fairey upgrade.

Stop Test Server from Sending Emails

In the desktop client, go to mail options:

In the resulting screen, enter rubbish in the user name, password and e-mail address fields.

Tick the send test email box and click approve, A message will be displayed saying the send failed.

SSL Certification – Information

When asking Wiki to organize a SSL for a customer, the customer needs to provide an approver email. This has to be one of the following:

Administrator@yourdomain.co.uk

admin@yourdomain.co.uk

hostmaster@yourdomain.co.uk

postmaster@yourdomain.co.uk

webmaster@yourdomain.co.uk

This is because as part of the process a verification email is sent to whichever one is provided.

Unassigned Privileges

Refer to process on Xpert site via this link:

https://support.priority-software.com/#/kb/FQ110124_E/English

How to identify and handle unassigned privileges

Search Server – Troubleshooting

You can check if the index is being built correctly by checking in the prisearch folder. Look in :

C:\Program Files\prisearch\priority_collection\data\index

You should see files dated today which indicates the index is being built.

If the index built appears to not update the index, check the tabula.ini file. There is a search section e.g.

[PriSearch]

Dir=c:\program files\prisearch

Java Location=C:\Program Files\Java\jre1.8.0_341\bin\java.exe

Host=Cher-Pr-web

A problem when a system is restored from live to test is that the tabula.ini file still contains a reference to the original live host. Re-installing the search server does not update this.

In this case, checking the log file, “C:\Program Files\prisearch\logs\solr.log” you will see a message like this:

WARN  - 2022-08-05 10:56:43.720; org.eclipse.jetty.util.component.AbstractLifeCycle; FAILED SocketConnector@cher-pr-web:8983: java.net.BindException: Cannot assign requested address: JVM_Bind

This shows it was trying to talk to the wrong machine.

Delete the [PriSearch] section from the tabula.file and install again.

Version Number | Date | Author | Detail of Change

1.0 | 23/04/21 | N Zujevs | 

1.1 | 25/04/21 | C Lidgey | Updates following checking

1.2 | 15/07/21 | C Lidgey | Added some v21 ref’s

1.3 | 02/12/21 | C Lidgey | Updated Test refresh steps

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
