# LB21000002-InstallUpgradeAndRefresh

- **Source:** `LB21000002-InstallUpgradeAndRefresh.pdf`

LB21000002 1.1 Friday, 25 April 2021 1 
PRIORITY INSTALLATION , 
UPGRADE & REFRESH 
MANUAL  
 
Version 20.0 and 20.1 and 21.0 
 
 
Version Number Date Author Detail of Change 
1.0 23/04/21 N Zujevs  
1.1 25/04/21 C Lidgey Updates following checking  
1.2 15/07/21 C Lidgey Added some v21 ref’s

LB21000002 1.1 Friday, 25 April 2021 2 
Table of Contents 
Document Directory ....................................................................................................................................... 6 
Types of Installation & Upgrade ................................................................................................................. 6 
Types of Refresh ......................................................................................................................................... 6 
Priority Installation ......................................................................................................................................... 7 
Definition .................................................................................................................................................... 7 
Steps to be completed ................................................................................................................................ 7 
1. Installation Preliminary Checks ...................................................................................................... 8 
2. Install Priority ................................................................................................................................. 8 
3. Install Add-ons and fixes ................................................................................................................ 9 
4. Install module upgrade files ........................................................................................................... 9 
5. Install IIS and App Server................................................................................................................ 9 
6. Install Search service ...................................................................................................................... 9 
7. Post Upgrade process..................................................................................................................... 9 
Test Upgrade .................................................................................................................................................10 
Definition ..................................................................................................................................................10 
Steps to be completed ..............................................................................................................................10 
1. Upgrade Preliminary Checks ........................................................................................................11 
2. Refesh System, if required. ..........................................................................................................11 
3. Run Daily Backup on the Test server ............................................................................................11 
4. Run Form preparation ..................................................................................................................11 
5. Run Report & Procedure preparation ..........................................................................................12 
6. Run View License ..........................................................................................................................12 
7. Download and Upgrade Priority...................................................................................................12 
8. Renew Priority License .................................................................................................................12 
9. Install Add-ons if needed .............................................................................................................12 
10. Re-install Application Server ....................................................................................................12 
11. Re-install Search Engine Server ................................................................................................13 
12. Post Upgrade process ..............................................................................................................13 
13. Handover to PM to check errors in upgrade and to carry out “Standard Trigger Changes” ...13 
14. Ensure project is up to date with all details .............................................................................13 
Live Upgrade .............................................................................................................................................14 
Definition ..............................................................................................................................................14

LB21000002 1.1 Friday, 25 April 2021 3 
Steps to be done ...................................................................................................................................14 
1. Preliminary Checks .......................................................................................................................15 
2. Run Daily Backup on the Live server ............................................................................................15 
3. Run Form preparation ..................................................................................................................15 
4. Run Report preparation ...............................................................................................................15 
5. Run View License ..........................................................................................................................15 
6. Upgrade Priority ...........................................................................................................................15 
7. Renew Priority License .................................................................................................................16 
8. Install Add-ons if needed .............................................................................................................16 
9. Re-install Application Server ........................................................................................................16 
10. Re-install Search Engine Server ................................................................................................16 
11. Post Upgrade process ..............................................................................................................16 
12. Handover to PM. ......................................................................................................................16 
Partial Refresh ...............................................................................................................................................17 
Definition ..................................................................................................................................................17 
Steps to be done .......................................................................................................................................17 
1. Run Daily Backup on the Test server ............................................................................................17 
2. Update DBs ...................................................................................................................................17 
Full Refresh ...................................................................................................................................................18 
Definition ..................................................................................................................................................18 
Steps to be done .......................................................................................................................................18 
1. Run Daily Backup on the Test server ............................................................................................18 
3. Update DBs ...................................................................................................................................18 
Manuals ........................................................................................................................................................20 
MS SQL server installation ........................................................................................................................20 
IIS and Application service installation .....................................................................................................24 
Search Service installation ........................................................................................................................24 
Install License for Priority. ........................................................................................................................25 
Add-ons installation ..................................................................................................................................26 
Post Installation ........................................................................................................................................28 
Defining Companies. .............................................................................................................................28 
Additional Items on Installing Priority Specific to UK ...........................................................................28 
Permissions ...............................................................................................................................................29

LB21000002 1.1 Friday, 25 April 2021 4 
Administrating Permissions for Priority Files .......................................................................................29 
Tabula Task Scheduler ..........................................................................................................................30 
Priority Restore Process ............................................................................................................................31 
Manual Refresh (DBs update) ...................................................................................................................33 
Refresh using BAK files .........................................................................................................................33 
Refresh using mdf files .........................................................................................................................35 
Priority and IIS on different servers ..........................................................................................................37 
Example of tabula.ini ............................................................................................................................37 
SQL DBs preparation before Restore/Refresh ..........................................................................................39 
Hints ..............................................................................................................................................................40 
No SQL server in Priority or ODBC dropdown menu ................................................................................40 
Use configuration manager ..................................................................................................................40 
Manually type server ............................................................................................................................40 
ODBC to check connection to MS SQL ......................................................................................................40 
If ODBC connection doesn’t work or SSMS doesn’t accept password .....................................................42 
How to delete user with schema in MS SQL .............................................................................................43 
Default Tabula user email .........................................................................................................................43 
Priority upgrade from old versions on SQL 2019 ......................................................................................43 
Part of Tabula.ini from Priority server ......................................................................................................43 
Part of tabula.ini when IIS not on the same server with Priority .............................................................43 
TTS Tabula Time Schedule ........................................................................................................................44 
Log file for Support ...................................................................................................................................44 
Set Chrome as default browser for Priority ..............................................................................................44 
Logins recovery and restore .....................................................................................................................44 
First Code ..............................................................................................................................................44 
Second code for restore (default method!) .........................................................................................45 
Third code (was send by email from medatech) ..................................................................................46 
Recovery pending .....................................................................................................................................49 
Error – no databases, but Priority has record about this company ..........................................................49 
Advanced Debugging ................................................................................................................................50 
Change currency .......................................................................................................................................50 
Run SQL interpreter in Priority .................................................................................................................50 
Remove Redis service ...............................................................................................................................50

LB21000002 1.1 Friday, 25 April 2021 5 
Djamal method .....................................................................................................................................51 
SQL Port. Cannot connect to server '10013' .............................................................................................51 
Incorrect Character display for £ ..............................................................................................................51 
Reports hours on project ..........................................................................................................................51 
In workstations with Windows 10, the minimize button does not work .................................................52 
Install/uninstall IIS via PowerShell - FQ21000022 ....................................................................................52 
Uninstall ................................................................................................................................................52 
Install ....................................................................................................................................................52 
How To Know Which Process is Using a File or Folder in Windows .........................................................53

LB21000002 1.1 Friday, 25 April 2021 6 
Document Directory 
 
Types of Installation & Upgrade 
Priority Installation – Full installation of Priority 
Test upgrade – Upgrade test server (usually includes a full refresh) 
Live upgrade – Upgrade live server 
 
Types of Refresh 
Full refresh – Update DBs AND copy all priority folders 
Partial refresh – Update DBs on another server, which already has priority installed for

LB21000002 1.1 Friday, 25 April 2021 7 
Priority Installation 
Definition 
Priority vanilla installation is a clean (new) Priority installation on machine. 
Steps to be completed 
 
1. Preliminary Checks 
2. Install Priority 
3. Install Addons and fixes 
4. Install module upgrade files 
5. Install IIS and App Server 
6. Install Search service  
7. Post Installation process

LB21000002 1.1 Friday, 25 April 2021 8 
1. Installation Preliminary Checks 
1.1 Create and populate LB21000001 excel for this customer installation. It should be saved for 
this customer and saved against the project 
1.1.1 Use that Excel file to check the specification of the system according to current 
supported software  
1.2 Install all software needed for Priority 
1.2.1 .Net 4.8 
1.2.2 MS SQL. Version and license according to LB21000001 for this installation 
1.2.3 IIS  
1.2.4 Install SQL Management server 
1.3 Download the Priority version you need https://support.priority-software.com/#/downloads. 
Use Medatech UK as a company name if you install Priority for yourself or the company 
name for which you do installation. 
 
 
1.4 Create folder named INSTALL + current version of Priority (e.g. INSTALL 201) on a drive 
where Priority will be installed and save all installation files there (MS SQL, Priority, BIN etc.) 
 
2. Install Priority 
You can use a manual from here https://support.priority-software.com/#/kb/LBI2000453/English  
2.1 Run the downloaded file (from step 1.3) as an administrator 
 
2.2 C:\Priority – is a default folder for the installation. Change the drive if needed. Preferably to 
the D or E drive.

LB21000002 1.1 Friday, 25 April 2021 9 
 
2.3 Click NO If SQL server is already installed  
2.4 Select the machine where you want to install Priority. In this example CLAMP is a computer 
name, and PRI is an MS SQL instance name 
  
Save Installation errors (if any) to the Installation folder created in step 1.4 
3. Install Add-ons and fixes 
Manual is here 
4. Install module upgrade files 
This is according to what the customer has ordered and will change on a one by one basis.. If modules 
ordered then it will be discussed at installation handover.  
5. Install IIS and App Server 
Manual is here 
6. Install Search service  
Manual is here 
7. Post Upgrade process 
Manual is here.

LB21000002 1.1 Friday, 25 April 2021 10 
Test Upgrade 
 
Definition 
Upgrade of Test server to newer (not necessarily the newest) Priority version/BIN version. Sometimes, 
before test upgrade DBs from the live server may be copied to Test server. If customer didn’t have a Test 
server before: 
1) Vanilla installation has to be completed first and DBs transferred from Live to Test server 
2) Copy Backup folder from Live server and run Restore on Test server. Then copy all folders that do 
not exists on Test server (Priority folder) from Live server (Priority folder). 
Steps to be completed 
1. Preliminary Checks 
2. Refesh System, if required  
3. Run Daily Backup 
4. Form preparation  
5. Report preparation 
6. View License 
7. Download and Upgrade 
8. Renew License 
9. Install Add-ons 
10. Re-install Application Server 
11. Re-install Search Server 
12. Post Installation process

LB21000002 1.1 Friday, 25 April 2021 11 
1. Upgrade Preliminary Checks 
1.1 Is LB170000041 signed by customer? This document must be attached to our Priority. 
1.1.1 Do you have a domain name for IIS and SSL certificate if it is needed? 
1.2 Read the technical specification file for the Priority version you want to install and make sure 
the server meets the minimum requirements. Technical requirements can be found here 
https://support.priority-software.com/#/kb, use keywords “hardware and support systems”. 
1.2.1 Create and populate LB21000001 excel for this customer upgrade. It should be saved 
for this customer and saved against the project 
1.3 Install all software needed for Priority 
1.3.1 .Net 4.8 and .net5.0 hosting 
1.3.2 MS SQL. What version and where is a license key 
1.3.3 IIS  
1.3.4 Install SQL Management server 
1.4 Download Priority version you need https://support.priority-software.com/#/downloads. 
Use Medatechuk as a company name if you install Priority for yourself or a company name 
for which you do installation. 
 
 
1.5 Create folder Upgrade + current version of Priority (e.g. Upgrade 18.1) on a drive where 
Priority will be installed and save all installation files there (MS SQL, Priority, BIN etc.) 
1.6 Review size of system\mail and system\reports folders on live environment. These hold all 
the mail and reports generated and will increase the time to copy the data over from live to 
test system. Customers should be running the supplied processes to manage the size of 
these folders. System Management > System Maintenance > Periodic Maintenance > Clear 
"mail" Directory, and System Management > System Maintenance > Periodic Maintenance > 
Delete Saved Reports. Encourage customers to cleanup these folders prior to upgrading. 
2. Refesh System, if required. 
Instructions on this process can be found here 
3. Run Daily Backup on the Test server 
System Management > System Maintenance > Periodic Maintenance > Run Daily Backup. 
4. Run Form preparation 
System Management > Generators > Forms > Form Preparation > Form Preparation , and select 
Reprepare all forms and save result to Upgrade folder with default name + ‘pre upgrade’. 
 Commented [TP1]: I took the option "Reprepare All 
forms". 
Commented [CL2R1]: correct. I updated the document

LB21000002 1.1 Friday, 25 April 2021 12 
5. Run Report & Procedure preparation 
System Management > Generators > Reports > Prepare Reports & Procedures. and select Reprepare all 
and save result (If there are errors a report will display) to the Upgrade folder with default name + ‘pre 
upgrade’. 
6. Run View License 
System Management > System Maintenance > Software Licenses > View License Details and save 
result to Upgrade folder with default name + ‘pre upgrade’. 
7. Download and Upgrade Priority  
7.1. Create folder Upgrade + current version on the same drive where is Priority (e.g Upgrade180). 
7.2. Open priority and run Help/Upgrade System. 
7.3. Save file to Upgrade folder. 
7.4. Close Priority and run downloaded file as Administrator. 
7.5. Save Installation Errors (if any) to Upgrade folder. 
7.6. Repeat steps 3,4,5 but add + ‘post upgrade’. – to define the files as the error reports post 
upgrade.  
7.7. You will need to repeat this step (Step 7 Download and Upgrade Priority) until you get to the 
final version you are upgrading to.  
7.8. All files downloaded should be referenced in the Priority Project so that they can be located for 
the live upgrade.  
8. Renew Priority License 
8.1. Tabula user must have email  support@medatechuk.com  
8.2. Run Renew Licence and check that the line at the top of the report which advises the date it is 
valid until. This needs to be in the future.  
 
9. Install Add-ons if needed 
Manual is here. 
10. Re-install Application Server  
Manual is here. 
Commented [TP3]: Same here, selected "Reprepare All". 
Commented [CL4R3]: correct. doc updated 
Commented [TP5]: How do you know if this has worked? I 
ran it and it opened the license report at the end. Is that 
considered ok? 
Commented [CL6R5]: Yes, specifically check the line at 
the top of the report which advises the date it is valid until. 
This needs to be in the future 
Commented [TP7]: How do I know if I have any add-ons to 
install? 
Commented [CL8R7]: when you are running the ACTUAL 
upgrade, the project check list details if there are any.. It is 
specific to each upgrade and version.

LB21000002 1.1 Friday, 25 April 2021 13 
11. Re-install Search Engine Server 
Manual is here. 
12. Post Upgrade process 
Manual is here. 
13. Handover to PM to check errors in upgrade and to carry out 
“Standard Trigger Changes” 
Send email to PM to advise upgrade is completed and the current status. They should fix any errors 
encountered, update any std trigger changes and create a revision file (saved in the upgrades folder and 
referenced in the project ready for live upgrade)  and advise you and the customer when then is 
completed so that they may commence testing.  
14. Ensure project is up to date with all details 
Update the Priority project with all relevant details which may be needed for the live upgrade. Where 
files are located. And save those files to the live server ready for the live upgrade.  
 
 
 
 
 
 
 
  
Commented [TP9]: This link takes you to the top of the 
document. Is that right? 
Commented [NZ10R9]: Yes, but it is wrong. It should go 
to the Post upgrade in Manuals 
Commented [CL11R9]: @Nikita Zujevs can you fix it?  
Commented [NZ12R9]: No, I can't. It is a software glitch. 
Other links work fine.

LB21000002 1.1 Friday, 25 April 2021 14 
Live Upgrade 
 
Definition 
Upgrade of Live server to newer (not necessarily the newest) Priority version/BIN version.  
Steps to be done 
1. Preliminary Checks 
2. Run Daily Backup 
3. Form preparation  
4. Report preparation 
5. View License 
6. Download files from Test/Upgrade folder 
7. Renew License 
8. Install Add-ons 
9. Post Upgrade process

LB21000002 1.1 Friday, 25 April 2021 15 
1. Preliminary Checks 
1.1 Is LB170000042 signed by customer? This document must be attached to our Priority. 
1.2 Review  LB21000001 excel for this customer upgrade. 
1.2.1 Read the technical specification file for the Priority version you want to install and 
make sure the server meets the minimum requirements. Technical requirements 
can be found here https://support.priority-software.com/#/kb, use keywords 
“hardware and support systems”. 
1.3 Check (and copy if necessary) folder Upgrade from Test server onto a drive where Priority is 
located. 
2. Run Daily Backup on the Live server 
2.1 System Management > System Maintenance > Periodic Maintenance > Run Daily Backup. 
2.2 Have you PM or nominated other check the backup file.  
3. Run Form preparation 
3.1 System Management > Generators > Forms > Form Preparation > Form Preparation and save 
result to Upgrade folder with default name + ‘pre upgrade’. 
4. Run Report preparation 
4.1 System Management > Generators > Reports > Report Generator and save result to Upgrade 
folder with default name + ‘pre upgrade’. 
5. Run View License 
5.1 System Management > System Maintenance > Software Licenses > View License Details and 
save result to Upgrade folder with default name + ‘pre upgrade’. 
6. Upgrade Priority 
6.1 Make sure nobody is logged in. In order to make sure nobody is logged in go to System 
Management > System Maintenance > Periodic Maintenance > Active Users. The upgrade 
can only be completed if everyone is logged out of the system. 
6.2 Run installation file from Upgrade folder as Administrator 
6.3 Save Installation Errors (if any) to Upgrade folder. 
6.4 Repeat steps 3,4,5 but add + ‘post upgrade’. 
6.5 Install files from PM (*.sh, *.rv). Parameter Input form is for sh file. Shell file to install 
“emerge” menu (if it doesn’t exist). R:\INSTALLED AS STANDARD\02 - TAKE & INSTALL 
UPGRADE

LB21000002 1.1 Friday, 25 April 2021 16 
 
7. Renew Priority License 
7.1 Tabula user must have email  support@medatechuk.com  
7.2 Run Renew License System Management > Revisions > Renew License 
8. Install Add-ons if needed 
Manual is here. 
9. Re-install Application Server  
Manual is here. 
10. Re-install Search Engine Server 
Manual is here. 
11. Post Upgrade process 
Manual is here. 
12. Handover to PM.  
PM to check system and handover to customer.

LB21000002 1.1 Friday, 25 April 2021 17 
Partial Refresh 
 
Definition 
Partial Refresh – Update DBs on the test server 
 
Steps to be done 
1. Run Daily Backup 
2. Update DBs 
 
1. Run Daily Backup on the Test server 
1.1. System Management > System Maintenance > Periodic Maintenance > Run Daily Backup. 
2. Update DBs 
2.1. Stop IIS server  
 
2.2. Make sure nobody is logged in. In order to make sure nobody is logged in go to System 
Management > System Maintenance > Periodic Maintenance > Active Users. The upgrade can 
only be completed if everyone is logged out of the system. 
2.3. Update DBs.  
2.3.1.  Manual for Restore.  
2.3.2.  Manual if DBs copied manually. 
2.4. Check that you successfully import all users and DBs.  
2.4.1.  Login to Priority, select base company and open a few forms. No errors should appear. 
2.5. If DBs copied manually, all links from database to system\mail and system\reports on the test 
server will be broken. The processes System Management > System Maintenance > Periodic 
Maintenance > Clear "mail" Directory, and System Management > System Maintenance > 
Periodic Maintenance > Delete Saved Reports, should be run to clean the database links. Then 
all files in system\mail and system\reports should be removed.

LB21000002 1.1 Friday, 25 April 2021 18 
 
 
 
Full Refresh 
 
Definition 
Full refresh – Update DBs AND copy all priority folders. 
Steps to be done 
1. Run Daily Backup on Test server 
2. Copy all folders from Live/Priority folder to Test/Priority. 
3. Update DBs 
 
 
1. Run Daily Backup on the Test server 
1.1. System Management > System Maintenance > Periodic Maintenance > Run Daily Backup. 
2. Copy all folders from Live/Priority folder to Test/Priority.  
3. Update DBs 
3.1. Stop IIS server.  
 
3.2. Make sure nobody is logged in. In order to make sure nobody is logged in go to System 
Management > System Maintenance > Periodic Maintenance > Active Users. The upgrade can 
only be completed if everyone is logged out of the system. 
3.3. Update DBs.  
3.3.1.  Manual for Restore.  
3.3.2.  Manual if DBs copied manually. 
3.4. Check that you successfully import all users and DBs.  
3.4.1. Login to Priority, select base company and open a few forms. No errors should appear.

LB21000002 1.1 Friday, 25 April 2021 19 
3.5. Check the database backup commands in Tabula Task Scheduler are pointing at a valid 
directory. The live server will likely have multiple disk drives compared to the test server.  
3.6. Check the tabula.ini file for references to disk drives that do not exist on the test server and 
correct if necessary.

LB21000002 1.1 Friday, 25 April 2021 20 
Manuals 
MS SQL server installation 
 
If you install on a live server, you need to have a license key. You can get it from a customer or from Keith 
Doddington. 
 
Can be an Error with Firewall. It is OK. 
For the local installation or TEST/DEV server use FREE edition. For the LIVE servers use Product Key option 
 
Tick the boxes as following

LB21000002 1.1 Friday, 25 April 2021 21 
 
For some clients you may need to change the path to D: or another drive. Usually, Priority and SQL are on 
the same drive.

LB21000002 1.1 Friday, 25 April 2021 22 
 
Switch SQL Server Browser to Automatic 
 
SQL_Latin1_General_CP437_BIN – must be a default collation.

LB21000002 1.1 Friday, 25 April 2021 23 
 
 
 
You can check the collation of an existing working server (in case of debugging). Right click on a database 
on the left panel and Properties.

LB21000002 1.1 Friday, 25 April 2021 24 
Select Mixed Mode, Enter a password; Add current user. 
 
 
 
IIS and Application service installation 
 
1. Rename the folder c:/inetpub/wwwroot (if it exists already) to wwwroot.old before the 
Application Server installation 
2. Follow instructions in the link below. When you click on the link wait for 5 seconds to get 
manual. Manuals describe an installation process on Windows Server and Windows 10 OS: 
https://support.priority-software.com/#/kb/LBI2100511/English (v21 file) 
https://support.priority-software.com/#/kb/ /English (v20 file)  
https://support.priority-software.com/#/kb/LB19000069/English (v19 file)  
Note: If you need to repeat this because something went wrong, you may find that when you try and 
delete the wwwroot directory it will be in use. Stop the World Wide Web Publishing service to allow 
delete. 
Search Service installation 
You must install the Search Service on the same machine where the Application server is located. 
Commented [TP13]: When the parameter screen is 
displayed, need to change the URL to test server name 
(when doing test server). By default it shows the live url.  
 
I also found I had to delete the existing services "Redis" and 
"App" manually using cmd prompt as administrator with 
command "sc delete "Priority Redis Service" and "sc delete 
"Priority App Service". This also required a reboot as one of 
them went to disable state. I saw this as well when doing the 
refresh on Grubb. 
Commented [NZ14R13]: It doesn't show default URL if it 
a new installation of Priority. This manual describes clean 
installation. 
Sometimes Redis and App work fine without deletion. 
Commented [TP15]: Should read c:\inetpub\wwwroot ? 
Commented [CL16R15]: yes, it should.  
Commented [TP17]: If you have to redo this because 
something went wrong, (didn't work so I deleted the services 
to try again), when you try and delete the wwwroot 
directory it will be in use. Stop the World Wide Web 
Publishing Service to allow delete. 
Commented [CL18R17]: @Tim Poland please can you 
update the document to reflect this comment

LB21000002 1.1 Friday, 25 April 2021 25 
Detailed Priority instructions are located here  
https://support.priority-software.com/#/kb/LBI2000264/English   
You must have java installed before you can complete the process. You can download java and install on 
the server from https://www.java.com/en/download/manual.jsp  
Once it is installed. 
1. Run Priority as Administrator 
2. System Management > System Maintenance > Search > Install Search Server 
3. Input requested information 
 
4. When complete is done run System Management > System Maintenance > Search > Activate 
Search Service. 
5. Run System Management > System Maintenance > Search > Search Definitions > Initialise Search 
Definitions. Do not click the Default Document check box. 
6. Run System Management > System Maintenance > Search > Build Search Index. 
 
Install License for Priority. 
 
Run Priority and go System Management->System Maintenance->Users. Search for Tabula user and 
change email to support@medatechuk.com 
Before you can install Priority on your company’s workstations, you need to install the file that contains 
your licensing information. If using Medatech Demo License find it in V:\LICENSES. You may need to 
adjust server date to install license. 
 To do so you will need to use one of the below options dependants on file type supplied: 
Commented [TP19]: Am I right in thinking that all the 
search indexes are brought across because we are copying 
the databases, hence we do not need to rebuild the search 
index. 
Commented [TP20R19]: I mean here that we do not need 
to re set up the defnitions. Just activate and then build the 
index. Also, if a Tabula Task Schedule task had already been 
created to rebuild the indexes, will this still exist after the 
upgrade? 
Commented [CL21R19]: i do not know the answer to this, 
so lets check with Gemma  
Commented [NZ22R19]: Search Engine use its own DB, 
not MS SQL. It is using Solr Apache search and it is default 
location is C:\Program Files\prisearch

LB21000002 1.1 Friday, 25 April 2021 26 
Option A can be used if file type is .lic 
1. Save the license file you have (Keith Doddington is responsible for License keys) into a folder on the 
Priority server. Make sure that the full path including the file name and extension does not exceed 50 
characters. 
2. From within Priority, enter the Software License menu from the following path: 
2.1. System Management > System Maintenance > Software License. 
3. Click Install License. 
4. In the input screen that opens, click Browse and locate the license file. 
5. Click OK, and wait for the message confirming a successful installation. Your license is now installed 
in the system. 
 
Option B must be used if file type is .lic.exe 
1. Save the license file you have in a folder on the Priority server. Make sure that the full path 
including the file name and extension does not exceed 50 characters. 
2. From within Priority, enter the Revisions Menu: 
a. System Management > Revisions. 
3. Click Install Upgrade. 
4. In the input screen that opens, click Browse and locate the lic.exe file. 
5. Click OK, you will be prompted for the tabula password.  
6. Wait for the message confirming a successful installation click Ok.  
7. Your license is now installed in the system and will display in a web browser screen. 
 
 
If you have changed the computer date to install the license then you must change it back before 
continuing. 
 
 
 
 
 
 
Add-ons installation 
1. Download the latest BIN version from Priority website https://support.priority-
software.com/#/downloads.

LB21000002 1.1 Friday, 25 April 2021 27 
 
2. Run Priority upgrade Sys. Maintenance->Revisions->Install Upgrade. 
3. ONLY Version 20.0 Addons.  
3.1. Install HMRC Add-on. BIN must be version 20.0.38 or higher. 
 
3.1 Install Hebrew Add-on – SC20002336 – only needed in v20.0

LB21000002 1.1 Friday, 25 April 2021 28 
Post Installation 
When Priority is installed these steps must be completed. 
 
1. Update Medatech Additional Info with new version (Priority -> CRM > Customers > Customers-> 
Medatech Add’l Custmer Info) 
2. Set tabula.ini (Windows folder) file to Auto Translation False 
[Environment] add a new line: 
Auto Translation = FALSE 
3. Company Setups 
Defining Companies.  
The software installs a demo system as standard.  
You should add a new company to perform initial set ups on, and once this company is set-up (as detailed 
later in this document) create a copy so that you can always have a base company with basic data. You 
will then be left with 2 companies. Blank Initialised system, and Test XXX Company Ltd. Depending on 
your project you can then decide which company should be copied for use as the live system etc..  
Company Short code should be lowercase no capitals 
System Management > System Maintenance > Companies > Add Company 
GBP is not in the currency drop down, but you can input it as base currency. 
Financials > Maintenance of Financials > Exchange Rates > Currencies 
Use C2 as the second currency. (You will need to change this to British Pounds or customers required 
currency) 
Now switch to your test company. 
Additional Items on Installing Priority Specific to UK  
These MUST BE DONE! But only once the new company has been created. 
• Install the following shell file ZEMG_INSTALLSTANDARD.sh, found in R:\INSTALLED AS 
STANDARD. This will install the list of changes below which do have their own shell files if 
required (“System Management > Revisions >Install Upgrade”) – Current Version is 26 
o NB. Exit priority and restart. 
• Fix Alert (Z:\INSTALLED AS STANDARD\ fix form alerts version 20 -1) should be installed ONLY in 
case of Upgrade. 
• Shell files can only be run on a licensed system so you may need to carry out the 2 steps below 
before you can run them.  
o You will need to change the email address of the user ‘tabula’ to 
‘support@medatechuk.com’ using Human Resources > Personnel File Or you can change it 
in System Management > System Maintenance > Users > Users under user Tabula. 
o And will need to renew the license using System Management > Revisions > Renew License 
 
• Check the default currency is set to GBP.  
o Financials > Maintenance of Financials > Exchange Rates > Update Local Currency 
or 
o Financials > Maintenance of Financials > Auxiliary Programs > Update L ocal & 
Second Currencies

LB21000002 1.1 Friday, 25 April 2021 29 
 
o Check  that you can get into some forms and reports. 
 
4. Set REMOTE H5 to 0. System Management > System Maintenance > Constant Forms > System 
Constants 
5. Install Priority Special Additions. – only if specified.  
6. Ensure customer is advised to check that the file permissions are accurate. – We should add this to 
the installation handover (item 9) .  
7. Check Tabula Scheduler is installed and running: System Management > System Maintenance > 
Tabula Task Scheduler 
8. Set up service startup and recovery options  
8.1. Priority App Service - startup type: automatic (delayed), Recovery option to restart on failure 
8.2. Priority Redis Service - Recovery options to restart on failure 
9. Send the installation handover document. 
 
 
Permissions  
 
Administrating Permissions for Priority Files 
We recommend that you install Priority using the NTFS file system, so that you can define appropriate 
permissions to the program files and thus prevent changes to these files from unauthorized users, or 
their deletion from the system. 
Note: The following permissions are minimal. We recommend that you do not deviate from the list. If you 
nevertheless decide to change permissions, ensure that you haven't reduced them. Reducing permissions 
any further is likely to impair the proper functioning of the system! 
In order to install clients, it is also necessary to execute Sharing of the priority folder on the server. When 
defining the Sharing, assign Full Control permission to everyone. 
User/ Group Directory Directory Contents Permission 
Administrator Priority 
 
Full 
Control 
Administrator Priority/fusioncharts Used to display flash charts & graphs Full 
Control 
System Priority 
 
Full 
Control 
Everyone Priority 
 
Read 
Everyone Priority/bin.95 Priority programs Read 
Everyone Priority/client Files used to install new Clients Read 
Everyone Priority/system/document (and all sub-directories) Non-HTML documents and screen-painted forms Full 
Control 
Everyone Priority/system/html HTML documents Full 
Control 
Everyone Priority/system/images Images for HTML docs/webs Read 
Everyone Priority/system/java Java programs Read 
Everyone Priority/system/javachart Java programs for graphs Read 
Everyone Priority/system/javahelp Java client help files Read 
Everyone Priority/fusioncharts Used to display flash charts & graphs Read

LB21000002 1.1 Friday, 25 April 2021 30 
Permissions that should be assigned to Priority files on the server: * 
 
 
*If you decide to change permissions, ensure that the following two options are selected: 
• Replace Permissions on Existing Files 
• Replace Permissions on Subdirectories 
Tabula Task Scheduler  
Check the tabula task scheduler has installed and started.  
o Change Backup settings – Set Daily backup to run every day. 
 
 
 
 
 
  
Everyone Priority/system/load Preferred path for files related to external 
interfaces 
Full 
Control 
Everyone Priority/system/macros Users’ macro definition files Full 
Control 
Everyone Priority/system/mail Files attached to e-mails Full 
Control 
Everyone Priority/system/prep Compiled forms and reports Full 
Control 
Everyone Priority/system/reports Saved reports Full 
Control 
Everyone Priority/system/sched Accessory files for programs Full 
Control 
Everyone Priority/system/upgrades Results of software upgrades Full 
Control 
Everyone Priority/system/util Utility queries Read 
Everyone Priority/tmp Priority’s temporary files Full 
Control 
Everyone Directory defined as Tabula Tmp in the tabula.ini 
file 
Priority’s temporary files for local use Full 
Control

LB21000002 1.1 Friday, 25 April 2021 31 
Priority Restore Process 
1. Copy Backup folder from Live server 
2. Prepare MS SQL using this manual  
3. Start Restore process as Administrator. It imports all DBs to the SQL DB and install Priority 
 
4. Check where all DBs are. If files are in Priority folder – it must be moved to SQL. 
 
Figure 1. Wrong file location 
4.1. Detach all DBs in SQL Studio. Right click on DB name (e.g. pritempdb)->Task->Detach 
 
4.2. Move all files to the SQL folder (E:\Program Files\Microsoft SQL 
Server\MSSQL14.PRI\MSSQL\DATA).  
Commented [TP23]: The restore process created large .ldf 
files in the data directory. Is this normal? 
Commented [CL24R23]: yes 
Commented [TP25]: The 'sa' password is the test tabula 
user. 
Commented [TP26R25]: After restore, 'sa' test tabula 
password is now the same as the live tabula password. 
Should it be reset to the original test tabula password. 
Commented [CL27R25]: yes, but sometimes it is nice to 
have it different (so we are sure we are logging into correct 
company).  
Commented [TP28]: Do you just copy the .mdf files and 
leave the .ldf files? I think so. 
Commented [CL29R28]: just mdf should be fine.

LB21000002 1.1 Friday, 25 April 2021 32 
 
4.3. Attach DB in the SQL Server. Right click on Databases and open the folder E:\Program 
Files\Microsoft SQL Server\MSSQL14.PRI\MSSQL\DATA (should be opened by default) 
 
 
 
 
 
  
Commented [TP30]: Need to check the backup 
commands in tabula task scheduler to ensure they are 
pointing at valid directory 
Commented [TP31]: For the tabula task scheduler service, 
ensure the service is set to restart after failure for 1st, 2nd 
and subsequent times. 
Commented [TP32R31]: The same applies to the Redis 
and App services as well. 
Commented [TP33R31]: And the Search service as well. 
Commented [CL34]: @Tim Poland please add this to the 
relevant section in the document 
Commented [CL35]: this is already listed in the steps 
against the project and within this document as well 
Commented [CL36]:  I will make this resolved as we do 
not know what it was about 
Commented [TP37]: Should also check the tabula.ini file 
for references to disk drives that do not exist. 
Commented [CL38R37]: OK, please update document 
@Tim Poland

LB21000002 1.1 Friday, 25 April 2021 33 
Manual Refresh (DBs update) 
 
1. Run Daily backup on Test/Dev server. 
2. Check the names of companies in Priority on Live server. Sometimes there can be more DBs, but only 
DBs that are in Priority must be copied on Test server. 
 
Refresh using BAK files 
3. Copy C:\priority\backup\data folder from Live server. It is a default location, but check settings in 
Priority to find current location of the backup (System Management > System Maintenance > Tabula 
Task Scheduler > Define TTS Tasks). In this folder are all companies from Priority (in screenshot it is 
demo, live, a101920, a102820) + system and pritempdb must be copied.  
3.1. Go to ‘a101920’ folder and sort files by Date modified. 
3.2. Find more recent BAK file and trn file where date and time of modification is approximately the 
same (+/- 3 minutes). 
 
3.2 Copy these files to Test server. This method can save a lot of time, because no need to copy 
unneeded files.  
3.3 Do it with all companies you need to copy. 
4. Prepare MS SQL using this manual. 
5. Two ways to import DBs: when BAK or MDF files are using 
5.1. Open MS Studio and Right click on Databases on the left panel. 
Commented [TP39]: If you do the restore this way, I 
believe you break the links to the files stored in system\mail 
and system\reports. If this is acceptable then you can speed 
up the restore process using Priorities process by not 
copying these directories over. Also the restore process also 
needs to copy these files again. In the case of MV Milk these 
added up to 58GB. Alternatively can the customer be 
persuaded to run the processes to tidy these up by deleting 
up to a specific data by the standard processes. Also the 
PRITEMPDB should be cleaned before the transfer if 
possible.  
Commented [CL40R39]: @Tim Poland Sometimes we do 
ONLY want to transfer the databases... and that is part of the 
decision process about the upgrade. BUT... i do agree the 
cleanup should be done before transfer, so please add this is 
as preliminary steps to the document to speed the process

LB21000002 1.1 Friday, 25 April 2021 34 
 
 
5.2. Select Restore Database->Device->Add and find BAK file you need to restore a DB. 
 
 
5.3. On the left side where is Select a page, choose Files and tick the box Relocate all files to folder. 
By default, it should be a MS SQL folder. Click OK. 
 
 
5.4. On the Option tab do not change anything and click OK.

LB21000002 1.1 Friday, 25 April 2021 35 
 
 
5.5. Wait for the end of process. 
 
 
Refresh using mdf files 
1. Copy mdf and ldf files to C:\Program Files\Microsoft SQL Server\MSSQL14.PRI\MSSQL\DATA 
2. In SQL Studio right click on Databases and Attach…->Add 
3. Select the DB you want to import

LB21000002 1.1 Friday, 25 April 2021 36

LB21000002 1.1 Friday, 25 April 2021 37 
Priority and IIS on different servers 
 
1. If Priority is already installed on IIS server. 
1.1. On IIS server run "update priority executables" from the Start menu or manually copy the BIN 
folder from the Priority/Client server to the local disk on IIS server. 
2. New Priority Client installation on IIS server. 
2.1. Add shared network folder to server where Priority is installed. 
2.2. Go to Client folder and run Setup.exe with administrator privileges. 
2.3. Fill in this form according to your client. 
 
 
 
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

LB21000002 1.1 Friday, 25 April 2021 38 
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

LB21000002 1.1 Friday, 25 April 2021 39 
SQL DBs preparation before Restore/Refresh 
 
Make sure you have all backups needed before start this process and you got permission from the client 
and Christine/Fode to delete DBs!!! 
1. Open SQL Server Management Studio 
2. Delete all DBs. In this case it is ‘demo’, ‘pritempdb’,’system’. DO NOT DELEETE anything from 
System Databases! 
3. Delete all users except ‘sa’, ‘tabula’, ‘## *’ users and any users related with domains (Deathstar\ 
and NT *\ in this case).

LB21000002 1.1 Friday, 25 April 2021 40 
Hints 
 
No SQL server in Priority or ODBC dropdown menu 
Use configuration manager 
1) C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft SQL Server 
2017\Configuration Tools and run it, or type in search “sql server configuration manager”. 
2) Check SQL server browser. Turn it on and restart the sql server. 
 
Manually type server 
1) Enter hostname/sql instance manually. E.g. Server11/PRI 
a. Run Command Prompt (run… -> cmd) and type hostname 
b. Find the instance name (PRI in this case) 
 
ODBC to check connection to MS SQL 
1) Search for ODBC in Start menu. Choose according to your OS x32 or x64 
2) Click Add… and select ODBC driver

LB21000002 1.1 Friday, 25 April 2021 41 
 
3) Enter any name for this and choose server you want to connect from Drop down menu. 
 
4) Choose authentication method – Windows account or MS SQL user 
 
5) Click Next until you see this

LB21000002 1.1 Friday, 25 April 2021 42 
 
6) Click on Test Data Source… button. 
 
You should see this if everything is fine. 
 
If ODBC connection doesn’t work or SSMS doesn’t accept password 
1) Disable firewall 
2) Check Antivirus. They can have their own Firewall 
3) The "sa" account disabled by default. So, you'll need to toggle the account from disabled to 
enabled under the status section of the account. 
4) The server must have windows and sql server authentication enabled. By default, only windows 
authentication is enabled.

LB21000002 1.1 Friday, 25 April 2021 43 
 
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

LB21000002 1.1 Friday, 25 April 2021 44 
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
System > System Maintenance > Tabula Task Scheduler > Tabula Task Scheduler, and then select Install 
Task Scheduler 
That would install the relevant service on the machine.  
 
Log file for Support  
In case of errors during upgrade run this. 
System Management > System Maintenance > Periodic Maintenance > Run Diagnositcs for Service Call 
 
Set Chrome as default browser for Priority 
Ensure Chrome is set as the default browser (Control Panel>Default Programs) 
If it is, open Regedit.exe expand the following: HKEY_CLASSES_ROOT\HTTP\shell\open\command 
You are likely to see a path to Internet Explorer stored in this key. You can right click it to modify this to 
point to Google Chrome. 
e.g. 
Change: 
"C:\Program Files (x86)\Internet Explorer\iexplore.exe" 
To: 
"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -- "%1" 
Ensure the path to chrome.exe exists on the computer. 
 
Logins recovery and restore 
First Code 
Doesn’t work properly. Some logins or passwords can be missed

LB21000002 1.1 Friday, 25 April 2021 45 
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
AND master.dbo.syslogins.name = (case when system.dbo.SYSCONST.VALUE = 1 then 
reverse(system.dbo.USERS.USERLOGIN) else system.dbo.USERS.USERLOGIN end) 
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

LB21000002 1.1 Friday, 25 April 2021 46 
1. Create table ‘Login’ on server where are needed logins.  
2. Run the Export code 
3. Export the table 
4. Attach table to the server where you want import logins 
5. Run Import code 
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
where system.dbo.SYSCONST.NAME = 'LANGUAGE' AND master.dbo.syslogins.name = (case when 
system.dbo.SYSCONST.VALUE = 1  
then reverse(system.dbo.USERS.USERLOGIN) else system.dbo.USERS.USERLOGIN end)  
AND master.dbo.syslogins.name <> 'tabula'  
go 
 
Import 
use master  
go  
declare logincur cursor fast_forward for select name, password, sid from Login.dbo.tabula_sql_logins  
where name <> 'tabula' declare @loginame varchar(50), @passwd nvarchar(128), @sid varbinary(85), 
@qry nvarchar(128)  
open logincur fetch next from logincur into @loginame, @passwd, @sid while (@@fetch_status = 0)  
begin exec master..sp_addlogin @loginame, @passwd, 'system', 'us_english', @sid, 'skip_encryption' set 
@qry = N'grant  
view server state to [' + @loginame + ']' exec sp_executesql @qry exec master..sp_addsrvrolemember 
@loginame, 'sysadmin'  
fetch next from logincur into @loginame, @passwd, @sid end close logincur deallocate logincur  
go 
 
Third code (was send by email from medatech) 
How to transfer logins and passwords between instances of SQL Server 
  
The below is taken from:  http://support.microsoft.com/kb/918992 
 
1.    On server A, start SQL Server Management Studio, and then connect to the instance of SQL Server 
from which you moved the database. 
2.    Open a new Query Editor window, and then run the following script. 
 
USE master 
GO

LB21000002 1.1 Friday, 25 April 2021 47 
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

LB21000002 1.1 Friday, 25 April 2021 48 
      SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin FROM  
sys.server_principals p LEFT JOIN sys.syslogins l 
      ON ( l.name = p.name ) WHERE p.type IN ( 'S', 'G', 'U' ) AND p.name = @login_name 
OPEN login_curs 
FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, 
@hasaccess, @denylogin 
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
      SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' FROM WINDOWS WITH 
DEFAULT_DATABASE = [' + @defaultdb + ']' 
    END 
    ELSE BEGIN -- SQL Server authentication 
        -- obtain password and sid 
            SET @PWD_varbinary = CAST( LOGINPROPERTY( @name, 'PasswordHash' ) AS varbinary (256) ) 
        EXEC sp_hexadecimal @PWD_varbinary, @PWD_string OUT 
        EXEC sp_hexadecimal @SID_varbinary,@SID_string OUT 
        -- obtain password policy state 
        SELECT @is_policy_checked = CASE is_policy_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE 
NULL END FROM sys.sql_logins WHERE name = @name 
        SELECT @is_expiration_checked = CASE is_expiration_checked WHEN 1 THEN 'ON' WHEN 0 THEN 
'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name 
            SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' WITH PASSWORD = ' + @PWD_string 
+ ' HASHED, SID = ' + @SID_string + ', DEFAULT_DATABASE = [' + @defaultdb + ']' 
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

LB21000002 1.1 Friday, 25 April 2021 49 
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
  FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, 
@hasaccess, @denylogin 
   END 
CLOSE login_curs 
DEALLOCATE login_curs 
RETURN 0 
GO 
 
Note This script creates two stored procedures in the master database. The procedures are named 
sp_hexadecimal and  sp_help_revlogin. 
 
3.    Run the following statement:  
EXEC sp_help_revlogin 
The output script that the sp_help_revlogin stored procedure generates is the login script. This login 
script creates the logins that have the original Security Identifier (SID) and the original password. 
 
4.    On server B, start SQL Server Management Studio, and then connect to the instance of SQL Server to 
which you moved the database. 
 
4. Open a new Query Editor window, and then run the output script that is generated in step 3. 
 
Recovery pending 
You can see this problem in SQL Studio – database has status ‘Recovery pending’ and you can’t do 
anything with it.  
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
Needed to create a company in MS SQL Studio (one for each env which priority thinks exists), and then 
OK through all the errors about tables not existing when it is deleted in Priority.

LB21000002 1.1 Friday, 25 April 2021 50 
Advanced Debugging 
   
In addition to the above debugging options available from within Priority, you 
may occasionally wish to inspect the queries being sent to the database itself 
(SQL Server or Oracle). 
If no profiler is installed, you can open Priority in trace mode, so that all queries sent to the 
database are written to one or more trace files. 
To open Priority in this mode, you must first set the directory in which trace files will be 
saved (e.g., C:\tmp). To do so, open a command line and execute one of the following 
commands: 
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
Financials > Maintenance of Financials > Auxiliary Programs > Update Local & Second 
Currencies 
 
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

LB21000002 1.1 Friday, 25 April 2021 51 
Djamal method 
 
So this was a long complex process, i will only highlight the changes made towards the end of the process 
Firstly i pulled any missing data from a separate tabula.ini file (this one didn't work but it had some extra 
data 
next we removed the target from right clicking priority and going to properties, and removing the minus t 
section! 
This then added the tabula path to help about! 
next i restarted the server 
I then made the wwwroot old 
turned off iis 
stopped pri.net 
reinstalled app server 
restarted server to ensure services came back on in right order 
Issue resolved 
 
SQL Port. Cannot connect to server '10013' 
  
Some users can log into Priority, other users receive the error 'Cannot connect to server (10013)' on the 
same client machine.  
  
This error can be received when an anti-virus program or firewall is blocking access to Priority. 
You should define static port in the SQL server (dynamic would obviously change with every restart) - 
preferably the default 1433 , then open it both for UDP and TCP.  
 
Then open port 1435 TCP and 1434 UDP (both ways) 
 
To check whether it works - just try to reach the server from the client with ODBC (Using SQL Native 
Client Driver), that should suffice. 
 
Incorrect Character display for £ 
In the tabula.ini file 
under [Environment] add a new line: 
Auto Translation = FALSE 
 
 
Reports hours on project 
To see the hours you spend on projects run this: 
 
1) Project > Reports on Projects > Project Hrs & Efficiency Reports > Reported Hrs-Totals Inc Days 
FKS 
2) Medatech employee reports > Hours Reported Per Day 
3) Medatech employee reports > Less than 8 Rep Hours 
4) Project > Reports on Projects > Project Hrs & Efficiency Reports > Reported Hrs-Totals Inc Days

LB21000002 1.1 Friday, 25 April 2021 52 
 
 
In workstations with Windows 10, the minimize button does not work 
For users with color coding for companies via the Companies form (path: System Management > 
System Maintenance > Companies), in the Color field, delete the colors specified for companied, and 
restart the system. 
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
PS C:\> Install-WindowsFeature -Name @(“Web-Server”, “Web-WebServer”, “Web-Common-Http”, 
“Web-Default-Doc” 
, “Web-Dir-Browsing”, “Web-Http-Errors”, “Web-Static-Content”, “Web-Health”, “Web-Http-Logging”, 
“Web-Http-Tracing”, “We 
b-Performance”, “Web-Stat-Compression”, “Web-Dyn-Compression”, “Web-Security”, “Web-Filtering”, 
“Web-App-Dev”, “Web-Net- 
Ext”, “Web-Net-Ext45”, “Web-AppInit”, “Web-Asp-Net”, “Web-Asp-Net45”, “Web-ISAPI-Ext”, “Web-
ISAPI-Filter”, “Web-Mgmt-Too 
ls”, “Web-Mgmt-Console”)

LB21000002 1.1 Friday, 25 April 2021 53 
 
How To Know Which Process is Using a File or Folder in Windows 
1) Run Resource Monitor 
2) Select CPU and search for the folder you want to Delete/Rename...
