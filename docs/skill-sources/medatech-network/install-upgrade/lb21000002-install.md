# lb21000002-install

- **Source:** `lb21000002-install.docx`

Priority Installation

Priority Installation

Priority vanilla installation is a clean (new) Priority installation on a machine. The installation project in Priority should be followed with reference to this document for the detail. The project does not concern itself whether the install is one server (containing Priority DB and IIS) or two servers (Priority DB and IIS separate).

Installation Preliminary Checks

Create and populate LB21000001 excel for this customer installation. It should be saved for this customer and saved against the project. Use that Excel file to check the specification of the system according to Priority’s support document.

Software Needed Prior to Priority Server Installation

The server should have the following:

.net 4.8 (note that if you install Priority and try and run it, if this is missing it will tell you).

MS SQL Server: Follow the section “MS SQL Server Installation” to install a SQL Server instance on the server.

SQL Management Server (SSMS) : Download SSMS from the internet and install.

Microsoft Visual C++ runtime 2015-2022 x86

Microsoft Visual C++ runtime 2015-2022 x64

Install Priority

Download the Priority version you need from https://support.priority-software.com/#/downloads. You will need to connect the download for a company and a project.

For internal use (ie local installs for staff) Use Medatech UK Ltd as a company name, with project  Priority Demo – Medatech UK -SQL (This is a full manufacturing system) or Priority Demo – Medatech UK -SQL -comer (This is a commercial / distribution only system)

For customers make sure to select the company name for which you are doing the installation. If the company is not available in the downloads, use the Medatech demo.

Create folder named INSTALL + current version of Priority (e.g. INSTALL 201) on a drive where Priority will be installed and save all installation files there (MS SQL, Priority, BIN etc.)

IMPORTANT NOTE: Until recently there were no installer files for 22.1 and 23.0. However in using both of these recently, I have encountered errors running them. They complete and Priority could not advise whether there was going to be any problem. Hence for now for installs, I install v22.0 and then upgrade it. Do not follow the upgrade documentation with regards to backups etc, simply start Priority and take the upgrade option. Do this until you get to the desired version.

Run the downloaded file (from step 1.3) as an administrator.

C:\Priority – is a default folder for the installation. Change the drive if needed. Preferably to the D or E drive.

A message box will be displayed asking if you wish to install SQL Server Express. Click NO If SQL server is already installed. Unless the customer is going to SQL Express, SQL will have been installed earlier.

Select the SQL Instance you installed previously. In this example CLAMP is a computer name, and PRI is an MS SQL instance name.

Click install on next screen to begin installation. Save Installation errors (if any) to the Installation folder.

Run the dedicated client.

Note that the Tabula Task Scheduler will have been installed.

IMPORTANT: The tabula use password will take the password of the sa user in SQL Server. See Changing tabula password section.

Install Latest Bin95

Download the latest BIN version from Priority website https://support.priority-software.com/#/downloads.

Install License for Priority

For customer installs and Medatech staff, a license will be provided by Keith.

Run Priority and go System Management->System Maintenance->Users. Search for Tabula user and change email to support@medatechuk.com

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

Post Installation Steps – For Customer Installs

Update Medatech Additional Info with new version (Priority -> CRM > Customers > Customers-> Medatech Add’l Custmer Info)

Set tabula.ini (Windows folder) file to Auto Translation False

[Environment] add a new line:

Auto Translation = FALSE

Defining Companies

The software installs a demo system as standard.

Add a new company to perform initial set ups on, and once this company is set-up, create a copy so that there is always a base company with basic data. You will then be left with 2 companies. Blank Initialised system, and Test XXX Company Ltd. Depending on the project the project manager can then decide which company should be copied for use as the live system etc..

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

Subscription Customers Renew License in TTS

If the customer is a subscription customer, create a task in the tabula task scheduler to renew the license every day:

Install IIS and App Server

Depending on the requirements, the IIS and App server will be installed on their own server or be installed on the database server.

In both cases, enable IIS on the relevant server. Follow Priority’s instructions here: https://support.priority-software.com/en/kb/LB22000402/English

Install the .net 5.0 core hosting bundle.

If the .net 6.0 core hosting bundle is required, when you install the app server it will tell you. Currently v23.0 and v22.1 (I think) want it. Do not uninstall .net 5.0 as the API calls still use it. Also do not install a higher version i.e. 7 as this seems to break Priority.

It is worth rebooting the server at this point as it has been known that some things do not work correctly until this is done.

For a separate IIS server, ensure the visual c++ runtime libraries are installed.

Procure and install SSL certificate, follow instructions in document “SSL Renewal Process” in LB19000006. If this installation is not going to have a procured SSL, follow steps in section “Manual SSL”.

Single server (DB and IIS)

Within Priority run System Management > System Maintenance> Internet Definitions> Application Server Maintenance> Install Application Server

The windows login/password should be the administrator credentials you have been given.

Website URL: This will be the URL defined on the SSL certificate.

Separate Database and IIS server

On the IIS server, follow the steps to install the dedicated client on the IIS server (document “Priority client install guide” in librarary LB19000001). This will create a dedicated Priority client on the IIS server. If you review the tabula.ini file created you will see references to the db server e.g.

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

Start the dedicated client. If the following is seen it indicates a firewall issues. Note that it takes a long time for this message to appear.

On the database machine (this applies to Ridgeon servers) carry out the following. If customer servers then will need to engage with customer to edit the firewall settings.

Start Windows defender firewall:

Click “Turn Windows Defender Firewall on or off”.

For the Domain network setting, select “Turn off….”. Now try to start dedicated client on web server. It should connect successfully. This proves that it is the firewall that is the problem.

Create the following three rules. According to the internet you should only need to open the standard ports up. However, if you are using named instances of SQL then it may not use the standard ports, in which case a program rule is needed. I have found that creating all three rules is the way to go.

Click “Advanced settings”.

Click “Inbound Rules”.

Click “New Rule” and create TCP rule:

Click “New Rule” and create UDP rule:

Click “New Rule” and create SQL Server rule:

Run Priority and the Install Application Server process. The only difference is that the temp files should be mapped back to the database server rather than exist on the IIS.

Application install notes

The install will complete but when you review the services, they are not running. When trying to start then they stop straight away. This can be because the windows account does not have the rights to logon as a service. Go to the Priority Redis service and select properties, then in the login tab, enter the same details again, user and password. Upon saving a message will occur stating that the logon has been granted the rights. The Redis service and the App service should now start.

If installing on a Medatech pc, you need to be in the office or connected to the VPN, as otherwise the app server install always fails with the message:

If the install fails and you need to repeat, it may be necessary to delete the wwwroot directory in inetpub folder. You will get an error that it cannot create the WCF.  You may need to stop the World Wide Web service to allow the deletion of wwwroot.

DNS changes when not using a local SSL – if these have not been done you can modify the hosts file and the system will work while on the server. The hosts file is located in C:\Windows\System32\drivers\etc. Add a line as highlit below.

The ip address is the ip address of the local server. In CMD window run ipconfig to see it. The name is the url. This allows the IIS to identify that the the URL resolves to the local server.

Once the DNS changes have been made, then this should be removed.

I have in the past directed the temp files to the local IIS server and it all works fine. You have to create the directory first. Is this more efficient than writing the temporary files to the database server, I don’t know. This is how it has always been done so I have continued this trend.

If the customer is using AWS servers then you need to use IP addresses to map the folder back to the database server. Clarkson-Evans is an example of this. Additionally a change was required in the tabula.ini file to enable the dedicated client to work. This was using the ip address in the host entry.

The services may be running but you cannot login. Try running the process to update the password in the services. See section “Changing Tabula Password”.

Search Service installation

You must install the Search Service on the same machine where the Application server is located.

Detailed Priority instructions are located here :

https://support.priority-software.com/#/kb/LBI2000264/English

Install Java

Java must be installed before you can complete the process. You can download java and install on the server from https://www.java.com/en/download/manual.jsp

When installing Java, change the destination folder to a generic name i.e. C:\Program Files (x86)\java\jre. By default java includes the version in the directory. This means that if java updates itself, the file path can change which may affect the search service. The file path is held in the tabula.ini file:

[PriSearch]

Java Location=C:\Program Files\Java\jre1.8.0_311\bin\java.exe

Install Search Server

Run Priority as Administrator

System Management > System Maintenance > Search > Install Search Server

Input requested information

When complete is done run System Management > System Maintenance > Search > Activate Search Service.

Run System Management > System Maintenance > Search > Search Definitions > Initialise Search Definitions. Do not click the Default Document check box.

Run System Management > System Maintenance > Search > Build Search Index.

Notes

Windows domain and user name can cause problems. You can enter in one of two formats e.g.

Medatech.priority@ridgeonnetwork.com or ridgeonnetwork.com\medatech.priority.

Try both if one does not work.

You may also find that the length of username field will be not long enough to accept the field.

You need to do two things:

Change the length of this field from 32 to 50

Write domain and username in this order domain\username

Additionally, if the user name contains special characters, the search installer will not be able to login. The work around here is to create a new login, if you have admin rights

Alternatively go back to customer to ask for alternative login.

Search Server – Troubleshooting

You can check if the index is being built correctly by checking in the prisearch folder. Look in :

C:\Program Files\prisearch\priority_collection\data\index

You should see files dated today which indicates the index is being built.

If the index build appears to not update the index, check the tabula.ini file. There is a search section e.g.

[PriSearch]

Dir=c:\program files\prisearch

Java Location=C:\Program Files\Java\jre1.8.0_341\bin\java.exe

Host=Cher-Pr-web

A problem when a system is restored from live to test is that the tabula.ini file still contains a reference to the original live host. Re-installing the search server does not update this.

In this case, checking the log file, “C:\Program Files\prisearch\logs\solr.log” you will see a message like this:

WARN  - 2022-08-05 10:56:43.720; org.eclipse.jetty.util.component.AbstractLifeCycle; FAILED SocketConnector@cher-pr-web:8983: java.net.BindException: Cannot assign requested address: JVM_Bind

This shows it was trying to talk to the wrong machine.

Delete the [PriSearch] section from the tabula.file and install again.

File Permissions

The following is Priority’s statement on file permissions. Check folders match below and change if necessary. Normally the “Everyone” permissions has to be added.

We recommend that you install Priority using the NTFS file system, so that you can define appropriate permissions to the program files and thus prevent changes to these files from unauthorized users, or their deletion from the system.

Note: The following permissions are minimal. We recommend that you do not deviate from the list. If you nevertheless decide to change permissions, ensure that you haven't reduced them. Reducing permissions any further is likely to impair the proper functioning of the system!

In order to install clients, it is also necessary to execute Sharing of the priority folder on the server. When defining the Sharing, assign Full Control permission to everyone.

If you decide to change permissions, ensure that the following two options are selected:

• Replace Permissions on Existing Files

• Replace Permissions on Subdirectories

MS SQL server installation

If customer is supplying SQL Server they will load the install software on to the server. If we are providing it then copy the SQL2019 installation media from SYSADMIN/Applications folder.

If Ridgeon are going to be hosting the customers server, they may be providing the installation media depending on the contract.

If you install on a live server, you need to have a license key. You can get it from a customer or from Keith Doddington.

Run the installer and click Installation and select New SQL Server stand-alone installation.

For the local installation or TEST/DEV server use FREE edition (Developer, NOT Evaluation as the screenshot) . For the LIVE servers use Product Key option

Tick the boxes as following

For some clients you may need to change the path to D: or another drive. Usually, Priority and SQL are on the same drive.

Switch SQL Server Browser to Automatic

SQL_Latin1_General_CP437_BIN – must be a default collation.

You can check the collation of an existing working server (in case of debugging). Right click on a database on the left panel and Properties.

Select Mixed Mode, Enter a password; Add current user.

Click Next all the way through to the install screen.

The resulting finish screen should show all green ticks. If not the install has failed and needs to be debugged.

SQL Hints

No SQL server in Priority or ODBC dropdown menu

When installing Priority it does not locate the SQL instance that you wish to use. Check that the browser is running.

Use Configuration manager

C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft SQL Server 2017\Configuration Tools and run it, or type in search “sql server configuration manager”.

Check SQL server browser. Turn it on and restart the sql server.

Check Filewall as described in section “Separate Database and IIS server”

Manually type server

Enter hostname/sql instance manually. E.g. Server11/PRI

Run Command Prompt (run… -> cmd) and type hostname

Find the instance name (PRI in this case)

Use ODBC to check connection to MS SQL

Search for ODBC in Start menu. Choose according to your OS x32 or x64

Click Add… and select ODBC driver

Enter any name for this and choose server you want to connect from Drop down menu.

Choose authentication method – Windows account or MS SQL user

Click Next until you see this

Click on Test Data Source… button.

You should see this if everything is fine.

Manual SSL steps

Start IIS and click on the server in left panel. Then double click on “Server Certificates”.

Click on “Create Self-Signed Certificate” in right hand pane.

Specify a name and save. This creates a local SSL certificate.

Click on “Sites” in the left hand pane, select the web site, and select “Bindings” in right hand pane.

Create an HTTPS record and associate your certificate with it.

Changing Tabula Password

In the dedicated client, go to “File> Change Password” while logged in as tabula.

Change the password for the services in System Management > System Maintenance > Users > Update Password in Services.

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
