# Installation

- **Source:** `Installation.pdf`

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
1/15 Ver.03 Cat.No. LB130122  
 
 
 
Welcome to the Priority Enterprise Management System Version 16 for Windows. 
This document contains instructions for installing the system on Microsoft SQL 
Server and Oracle. 
 
What’s included in the installation? 
The Priority package, including one user license in a demo environment. 
Contents 
1. Installing Priority on SQL Server  ................................................................. 2 
1.1 Installing the Server ................................................................................ 2 
1.2 Completing the Server Installation  ......................................................... 6 
1.3 Installing a Client  .................................................................................... 8 
2. Installing Priority on Oracle  ....................................................................... 10 
2.1 Installing the Server .............................................................................. 10 
2.2 Installing a Client  .................................................................................. 12 
3. Installing the Priority Lite Package & Priority on Outlook  .......................... 14 
4. Working From a Remote Site .................................................................... 15

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
2/15 Ver.03 Cat.No. LB130122  
 
1. Installing Priority on SQL Server 
1.1 Installing the Server 
Priority may run on an existing SQL Server installation or on a new installation of the SQL 
Server Express Edition, which is provided as part of the Priority installation. Hardware 
requirements and pre-installation steps are differe nt for each. 
Minimum Requirements 
For hardware requirements and supporting systems, download the Priority: Hardware and 
Support Systems document from the Priority Documentation section of the Customer Area 
on the Eshbel web site, at: http://www.priority-software.com/customer-zone/. 
Pre-install: Existing SQL Server Installation 
When installing the SQL Server, in the instance that will be connected to 
Priority, select a binary collation that is suitable for the language you work in. 
For instance, in an English -only system, you may use 
“SQL_Latin1_General_CP437_BIN”; if you work in Romanian, you may use 
“Romanian_BIN”; and so on. Choose a case-sensitive collation, or Priority 
will not work properly.  
1. Make sure you know the SQL Server password for the user “sa”. This password is 
crucial for the installation of Priority on the server. If this is a new installation of 
SQL Server, and you chose SQL Server Authentication during setup, this is the 
password to use during installation; if you chose Windows Authentication, you can 
assign the password for user “sa” via the SQL Server Management Studio.  
Note: The "sa" password is used when logging in to Priority as a superuser 
(tabula). Thus, it is important that you preserve this password and advise whoever 
will be using it. 
2. Choose the SQL Server instance on which you will be installing Priority (hereinafter 
called "the server"). Make sure it is defined with the correct coll ation (see #1 above). 
3. Choose the local drive on the server (hereinafter called “C”) on which to install 
Priority. This drive must contain at least 500 free megabytes.  
4. If you are transferring data from a previous installation of Priority on the Tabula 
database, and you installed SQL Server on a different computer, make sure you can 
access the Tabula system from the new server. If you cannot, install a client of the 
previous Tabula system on the new server. 
Pre-install: New SQL Server Express Installation 
1. Choose the local drive on the server (hereinafter called “ C”) on which to install 
Priority. This drive must contain at least 2000 free megabytes. 
2. If you are transferring data from a previous installation of Priority on the Tabula 
database, and you will be installing SQL Server Express Edition on a different 
computer, make sure you can access the Tabula system from the new server. If you 
cannot, install a client of the previous Tabula system on the new server.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
3/15 Ver.03 Cat.No. LB130122  
 
Installing Priority 
Perform the following steps on the new server (estimated installation time is 30 minutes, 
not including data transfer from the previous system):  
1. Enter the Customer Service Area on the Eshbel web site (http://www.priority-
software.com/customer-zone/), and select Installation Files. 
2. Type in your e-mail address and password.  
3. Select the type of system (i.e., American or Dual-Currency, as well as database) on 
which you work. 
4. Download the Priority 16 Installation File. In the dialogue box that opens, click Save. 
5. Choose the folder location on the server to which the file will be saved . 
6. In the Windows Explorer, navigate to the folder containing the installation file and 
double-click on the file to start the installation process . 
7. Click Setup and wait a few seconds while the installer "unpacks" the files needed to 
continue. 
8. Click Install. 
9. Designate the path of the directory that s hould be created for Priority – the program 
files will be installed there. A default directory called Priority appears on the drive 
containing the most free space, but it may be moved to any drive that has at least 500 
free megabytes (or 2000 free megabytes, if you still need to install  SQL Server). 
Note: If you are transferring data from the Tabula database, you must designate a 
different path than that of the original system.  
01. The installation program allows you t o install SQL Server Express 2008 on your server.  
 If SQL Server is already installed, choose No. A list of installed SQL Server 
instances will appear. Choose the one on which you want to install Priority and 
specify the password of user “sa” to connect to it. 
 If you have decided to install the provided SQL Server Express edition, choose Yes 
and record a password for the superuser (tabula). 
Note: Whatever password you record during this step will also be used in order to log 
in to Priority as a superuser (tabula).Thus, it is important that you preserve this 
password and advise whoever will be using it.  
00. If the installation program detects a previous installation of Priority on the Tabula 
database, it will ask you if you want to transfer the data from this system to the new 
system on SQL Server. Choose Yes to transfer the data, or No if you want to install a 
new system with only demo data. Transfer time depends on the volume of data and may 
require several hours. 
Running Priority on the Server 
3. Double-click the Priority icon on your Desktop. A screen will open, asking you to 
enter your user name and password in order to enter the system.  
4. Leave the user name tabula that appears on the screen, and once again enter the 
password of the superuser (this should be identical to the password for user “sa” on

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
4/15 Ver.03 Cat.No. LB130122  
 
an existing SQL installation) . Once you have entered the system, you can add users 
and change passwords. 
5. If you performed the data transfer from a system based on Tabula, the following 
adjustments must be made:  
 All forms, reports and procedures that were prepared for the Tabula-based system 
must be deleted and reprepared in the new SQL-based system: 
i. Delete the contents of the system\prep directory. 
ii. In Priority, from the upper Tools menu, select Run Entity (Advanced). 
iii. In the dialog box that opens, enter the command "FORMPREP -all" and click OK. 
iv. Use Windows Task Manager to track the progress of the formprep.exe process. 
Wait until this process finishes running before continuing.  
v. Return to Run Entity (Advanced) (in the upper Tools menu). 
vi. In the dialog box that opens, enter the command "REPPREP -all" and click OK. 
vii. Use Windows Task Manager to track the progress of the repprep.exe process. 
Wait until this process finishes running bef ore continuing. 
 All users need to update their passwords, which were erased in the transfer 
process.  
 Make sure that the company with the lowest Position value in the Companies form 
(i.e., the company that appears in the top line) is a company in which all  users have 
at least minimal privileges. Any user with no privileges in this company will not be 
permitted to log on to the system. 
 If you have not been working with the Tabula Task Scheduler, install it now. For 
instructions on installing the  Tabula Task Scheduler, download the Tabula Task 
Scheduler document from the Priority Documentation section of the Customer Area 
on the Eshbel web site, at: http://www.priority-software.com/customer-zone/. 
 If you have been working with the Task Scheduler, you need to  uninstall and re-
install it and update tasks in the Task List: 
i. To uninstall the Tabula Task Scheduler, run the Install Task Scheduler 
program in Priority and remove the flag from the Tabula Task Scheduler line. 
Click Update. 
ii. Re-install the Tabula Task Scheduler. 
iii. Open the Task List. The Company field displays the name of the company in 
which each program is run. Make sure that the correct company is defined for 
each active task. 
iv. For the Daily Backup and Weekly Backup programs, click Modify to update the 
file paths in the Command field. 
For example, assuming the new SQL installation is located in the D:\pr_sql 
directory and daily backup data should be transferre d to the D:\pr_sql\backup 
directory, the backup command for the Daily Backup program should appear as 
follows: 
BACKUP " " D:\pr_sql\system\prep D:\pr_sql\backup D

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
5/15 Ver.03 Cat.No. LB130122  
 
v. Set up an hourly backup. The Command field should contain the following 
command: 
BACKUP " " D:\pr_sql\system\prep D:\pr_sql\backup H 
Note: For detailed instructions on setting up and installing the Tabula Task Scheduler, 
download the Tabula Task Scheduler document from the Priority Documentation 
section of the Customer Area on the Eshbel web site.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
6/15 Ver.03 Cat.No. LB130122  
 
1.2 Completing the Server Installation 
Installing Your License 
Before you can install Priority on your company’s workstations, you need to install the file 
that contains your licensing information. To do so:  
1. Save the license file you have downloaded from  the Eshbel web site in any 
temporary folder on the Priority server. Make sure that the full path including the file 
name and extension does not exceed 50 characters. 
2. From within Priority, enter the Software License menu from the following path: 
System Management  System Maintenance  Software License. 
3. Click Install License.  
4. In the input screen that opens, click Browse and locate the license file.  
5. Click OK, and wait for the message confirming a successful installation. Your 
license is now installed in the  system. 
Administrating Permissions for Priority Files 
We recommend that you install Priority using the NTFS file system, so that you can define 
appropriate permissions to the program files and thus prevent changes to these files from 
unauthorized users, or their deletion from the system. 
Note: The following permissions are minimal. We recommend that you do not deviate from 
the list. If you nevertheless decide to change permissions, ensure that you haven't reduced 
them. Reducing permissions any further is likely to impair the proper functioning of the 
system! 
In order to install clients, it is also necessary to execute Sharing of the priority folder on the 
server. When defining the Sharing, assign Full Control permission to Everyone.  
Permissions that should be assigned to Priority files on the server: * 
User/ Group Directory Directory Contents Permission 
Administrator Priority  Full Control 
Administrator Priority\system\fusioncharts Used to display flash charts 
& graphs 
Full Control 
System Priority  Full Control 
Everyone Priority  Read 
Everyone Priority\bin.95 Priority programs Read 
Everyone Priority\client Files used to install new 
clients 
Read 
                                            
* If you decide to change permissions, ensure that the following two options are selected: 
Replace Permissions on Existing Files 
Replace Permissions on Subdirectories

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
7/15 Ver.03 Cat.No. LB130122  
 
User/ Group Directory Directory Contents Permission 
Everyone Priority\system\document 
(and all sub-directories) 
Non-HTML documents and 
screen-painted forms 
Full Control 
Everyone Priority\system\html HTML documents Full Control 
Everyone Priority\system\images Images for HTML 
documents and web sites 
Read 
Everyone Priority\system\javachart Java programs for graphs Read 
Everyone Priority\system\fusioncharts Used to display flash charts 
& graphs 
Read 
Everyone Priority\system\load Preferred path for files 
related to external 
interfaces  
Full Control 
Everyone Priority\system\macros User-defined macro files Full Control 
Everyone Priority\system\mail Files attached to e-mails Full Control 
Everyone Priority\system\prep Compiled forms and reports Full Control 
Everyone Priority\system\reports Saved reports Full Control 
Everyone Priority\system\sched Accessory files for 
programs 
Full Control 
Everyone Priority\system\upgrades Results of software 
upgrades 
Full Control 
Everyone Priority\system\util Utility queries Read 
Everyone Priority\tmp Priority’s temporary files Full Control 
Everyone Directory defined as Tabula 
Tmp in the tabula.ini file 
Priority’s temporary files 
for local use 
Full Control

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
8/15 Ver.03 Cat.No. LB130122  
 
1.3 Installing a Client 
Note: In the case of clients at a remote site (not connected to the local area network), skip 
this section and go instead to Section 4. 
Minimum Requirements 
Requirements in regard to hardware and supporting systems depend on the edition of SQL 
Server on which Priority is being installed. Download the Priority: Hardware and Support 
Systems document from the Priority Documentation section of the Customer Area on the 
Eshbel web site, at: http://www.priority-software.com/customer-zone/. 
Installing Priority on SQL Server 
1. Open Windows Explorer, enter the Tools menu and select Map Network Drive. A 
dialog box will appear, containing a drive identifier that will represent the Priority 
server on the local system (in the following instructions, we will use the id entifier F). 
2. Under Path:, enter the drive on which Priority is installed on the server, in the 
following manner: \\server\C (where server is the name of the server, and C is the 
drive identifier). 
3. Flag the Reconnect at Logon option.  
4. In the Windows Explorer, navigate to the F:\priority\client folder and double-click on 
the setup.exe file to start the installation process.  
5. Enter the path of the directory in your computer where you want to install the 
Priority client. There must be at least 150 MB free in your drive. 
Administrating Permissions for Priority Files 
As with installation of the server, we recommend that you install Priority on clients using 
the NTFS file system, so that you can define appropriate permissions to the program files 
and thus prevent changes to these files from unauthorized users, or their deletion from the 
system.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
9/15 Ver.03 Cat.No. LB130122  
 
Permissions that should be assigned to Priority files on client workstations:* 
User/User Group Directory Directory Contents Permission 
Everyone Priority\bin.95 Priority programs Full Control 
Everyone C:\Windows Needed to access 
tabula.ini and 
tabula.pri files 
Full Control 
Everyone Directory defined as 
Tabula Tmp in the 
tabula.ini file† 
Priority’s temporary 
files for local use 
Full Control 
 
                                            
* If you decide to change permissions, ensure that the following two options are selected: 
Replace Permissions on Existing Files 
Replace Permissions on Subdirectories 
† Usually C:\tmp. Check each user’s tabula.ini file (under the [Environment] section).

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
10/15 Ver.03 Cat.No. LB130122  
 
2. Installing Priority on Oracle 
2.1 Installing the Server 
Minimum Requirements 
For hardware requirements, see the Priority: Hardware and Support Systems document 
(download available from the Priority Documentation section of the Customer Area on the 
Eshbel web site, at http://www.priority-software.com/customer-zone/). 
Installing the Oracle Server 
1. Verify that your current Oracle version is 10.1.0 or higher.  
2. Use the Oracle DataBase Configuration Assistant to create a new database with 
the following parameter values: 
 
Name Value 
Template  Transaction Processing 
Global Database Name pri 
SID pri 
Memory Typical, 70% 
Character Set Change as needed 
Connection Mode Dedicated Server Mode 
 
3. Choose the option “All Initialization Parameters.” Change the following value:  
open_cursors = 1500 
4. If needed, set a system variable that defines the character set used in  
Step 2. This can be done as follows:  
i. Choose StartRun… 
ii. Type regedit and approve. In the Registry Editor open the key 
HKEY_LOCAL_MACHINE Software Oracle.  
iii. Set the value of key NLS_LANG to the character set wanted. 
5. Obtain the Oracle password for user "sys". This will be needed during the 
installation of Oracle on clients and during the inst allation of Priority on the server. 
Note: The "sys" password is used when logging in to Priority as a superuser. Thus, 
it is important that you preserve this password and advise whoever will be using it.  
6. Find the server’s name in the Network Neighborhood (hereafter “server”). 
7. Select the local drive on the server on which Priority will be installed. This drive 
should have at least 500 Mbytes free (hereafter “C:”).

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
11/15 Ver.03 Cat.No. LB130122  
 
8. On the disk in which the Priority tablespaces will be located (hereafter “ Q:”), you 
can create 3 new folders (hereafter “Q:\priorasys”, “Q:\priorademo” and 
“Q:\prioratmp”). These folders should have at least 2G bytes free and have full 
permission for the SYSTEM account (see Step 13 in the following section).  
Installing Priority on Oracle Server 
From an Oracle client (for UNIX servers) or the Oracle server (if it is a Windows server), 
perform the following steps (the installation should take about one hour):  
1. Enter the Customer Service Area on the Eshbel web site (http://www.priority-
software.com/customer-zone/), and select Installation Files. 
2. Type in your e-mail address and password.  
3. Select the type of system (i.e., American or Dual-Currency, as well as database) on 
which you work. 
4. Download the Priority 16 Installation File. In the dialogue box that opens, click Save. 
5. Choose the folder location on the server to which the file will be saved.  
6. In the Windows Explorer, navigate to the folder containing the installation file and 
double-click on the file to start the installation process. 
7. Click Setup and wait a few seconds while the installer "unpacks" the files needed to 
continue. 
8. Click Install. 
9. In the Priority Install window, designate the path of the directory that should be created 
for Priority – the program files will be installed there. A default directory called Priority 
appears on the drive containing the most free space, but it may b e moved to any drive 
that has at least 500 free megabytes. 
01. Log on to Oracle with username “sys,” its password (as obtained in "Installing the 
Oracle Server," Step 5) and host string “pri”.  
00. To install Priority on a database in which there is an existing installation of Priority, 
indicate an Installation ID for the new installation.  
01. Under Priority Tablespaces Location, specify Q:\priorasys, Q:\priorademo and 
Q:\prioratmp, if defined (see "Installing the Oracle Server," Step 8). Otherwise, leave 
the default folders suggested by the installation.  
Running the Priority System 
1. Double-click the Priority icon on your Desktop. A screen will open, asking you to enter 
your user name and password in order to enter the system.  
2. Leave the user name “tabula” that appears on the screen, and use “tabula” as the 
password as well. Once you have entered the system, you can add users and change 
passwords. 
Completing the Installation 
To continue, see section 
1.2

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
12/15 Ver.03 Cat.No. LB130122  
 
2.2 Installing a Client 
Note: In the case of clients at a remote site (not connected to the local area network), skip 
this section and go instead to Section 4. 
Minimum Requirements 
For hardware requirements, see the Priority: Hardware and Support Systems document 
(download available from the Priority Documentation section of the Customer Area on the 
Eshbel web site, at: http://www.priority-software.com/customer-zone/). 
Installing the Oracle Client 
1. Install the Oracle 10 client. Choose Database Administrator during its installation.  
Note: You must install a 32 bit client. 
2. Using Oracle Net Configuration Assistant, add a new service named prinet, which 
connects your client to the Oracle Server on Database SID pri. Test this connection by 
starting SQL*Plus with username “sys,” its password (obtained when installing the 
Oracle server) and host string “prinet.” 
3. Map the local drive to \\server\C (obtained during Steps 6-7 of “Installing the Oracle 
Server”), hereafter “F”. 
4. If needed, set the system variable that defines the character set. See “Installing the 
Oracle Server,” Step 2. 
Installing Priority on the Oracle Client 
9. Open Windows Explorer, enter the Tools menu and select Map Network Drive. A 
dialog box will appear, containing a drive identifier that will represent the Priority 
server on the local system (in the following instructions, w e will use the identifier F). 
10. Under Path:, enter the drive on which Priority is installed on the server, in the 
following manner: \\server\C (where server is the name of the server, and C is the 
drive identifier). 
11. Flag the Reconnect at Logon option.  
12. In the Windows Explorer, navigate to the F:\priority\client folder and double-click on 
the setup.exe file to start the installation process.  
13. Enter the path of the directory in your computer where you want to install the 
Priority client. There must be at least 150 MB free in your drive. 
14. Assign prinet as the Oracle Host String. 
Administrating Permissions for Priority Files 
As with installation of the server, we recommend that you install Priority on clients using 
the NTFS file system, so that you can define appropr iate permissions to the program files 
and thus prevent changes to these files from unauthorized users, or their deletion from the 
system.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
13/15 Ver.03 Cat.No. LB130122  
 
Permissions that should be assigned to Priority files on client workstations: * 
User/User Group Directory Directory Contents Permission 
Everyone Priority\bin.95 Priority programs Full Control 
Everyone C:\Windows Needed to access 
tabula.ini and 
tabula.pri files 
Full Control 
Everyone Directory defined as 
Tabula Tmp in the 
tabula.ini file† 
Priority’s temporary 
files for local use 
Full Control 
 
                                            
* If you decide to change permissions, ensure that the following two options are selected: 
a. Replace Permissions on Existing Files 
b. Replace Permissions on Subdirectories 
† Usually C:\tmp. Check each user’s tabula.ini file (under the [Environment] section).

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
14/15 Ver.03 Cat.No. LB130122  
 
3. Installing the Priority Lite Package & Priority on Outlook 
The Priority Lite server can be installed on either the Priority server or a Priority client. 
You can also install Priority Lite on an isolated server and/or restrict acc ess to the internal 
network, for added security. 
Installation of Priority on Outlook requires prior installation of the Priority Lite Server, as 
well as a valid license for the  BI module (if you do not have the proper license, contact 
Eshbel). 
For detailed installation instructions, see the Installing the Application Server (Lite/Rich) 
document (download available from the Priority Documentation section of the Customer 
Area on the Eshbel web site, at: http://www.priority-software.com/customer-zone/).

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel   📞 +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
15/15 Ver.03 Cat.No. LB130122  
 
4. Working From a Remote Site 
Do not install Priority clients on a remote site (i.e., one not connected to the local area 
network). Instead, use one of the following options: 
Option 1 
1. Install Windows 2008 Terminal Server. 
2. Install Priority on the terminal server.  
3. Move the Priority icon to the C:\Documents and Settings\All Users\Desktop folder.  
4. Install the Windows 200 8 Terminal Server Client on each remote workstation.  
Notes: 
 The tabula.ini file is copied automatically to each user's directory on the terminal 
server. 
 For further details, contact our Customer Support.  
Option 2 
 Have remote clients work in Priority's Rich interface. For details, see the Installing 
the Application Server (Lite/Rich) document (download available from the Priority 
Documentation section of the Customer Area on the Eshbel web site, at: 
http://www.priority-software.com/customer-zone/). 
For hardware requirements and supporting systems, download the Priority: Hardware and 
Support Systems document from the Priority Documentation section of the Customer Area 
on the Eshbel web site.
