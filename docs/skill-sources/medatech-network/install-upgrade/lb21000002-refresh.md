# lb21000002-refresh

- **Source:** `lb21000002-refresh.docx`

Priority Refresh Manual

Types of Refresh

There are two methods of refreshing a test server:

Restore method : here a Priority backup is copied from the live server to the test server and then restored on to the test server.

Manual refresh : here the databases and relevant files from the live server are copied over to test and applied.

Method 1 should always be used if possible because it rebuilds the system complete and ensures all links work correctly. Otherwise you need to carry out checks to ensure the lift and shift will provide the complete system.

New Test server

In the case of a new test server, method 1 should be used as no Priority install will exist on the test server. The following software will also be needed:

.Net 4.8, .net 5.0 hosting, and .net 6.0 core hosting bundle (version v22.1 upwards)

Microsoft Redistributable Visual c++ libraries, x86 and x64

SQL Server – Medatech or customer may provide. If customer, they need to provide installation media. A free version should be installed i.e. Developer.

Add Internet Information Server features to server.

Install SQL Management server (SSMS).

Refer to installation manual for more details regarding these steps.

Restore Method

Run Daily Backup on the Test server. System Management > System Maintenance > Periodic Maintenance > Run Daily Backup. This is to be kept just in case there is some development that has not be saved.

Copy all folders from Live/Priority backup folder to Test/Priority. Note that if live and test servers cannot see each other, FTP may be needed to be used to copy the files via our FTP site.

In data folder, for each database delete all files except last .bak file.

Rename existing Priority folder so you can install into same place. Keep this if possible in case there are folders the backup ignores i.e. system/util. If disk space is an issue you can delete the system/mail and system/reports folders first as these are in the backup taken. Additionally check that the databases are not being stored in the the Priority/data folder rather than the SQL Server folder. If they are, follow steps 10-13 to move then.

Start Restore process as Administrator.

Accept user agreement.

Select Priority Restore

Select appropriate disk.

Select the SQL server instance on the test server and enter the sa password. The sa password is normally the same as the tabula password. If this fails check the customer connection details to see if a specific sa password is recorded. If necessary, log into SSMS and change the sa password manually.

Restore should recognise an existing Priority instance exists. Note that if restoring to a new server, this will not be shown.

Click Ok and then click Install on next window.

The process will restore the system and be completed when following is shown:

If error messages occur and the process fails, the message normally indicates what needs to be corrected.

Check where the process has restored the database files too. They can get restored to the data folder in Priority rather than the Microsoft SQL Server directory. If files are in Priority folder they should be moved to the SQL server folder.

Figure 1. Wrong file location

Detach all DBs in SQL Studio. Right click on DB name (e.g. pritempdb)->Task->Detach

Move all files to the SQL folder (for example E:\Program Files\Microsoft SQL Server\MSSQL14.PRI\MSSQL\DATA).

Attach DB in the SQL Server. Right click on Databases and open the folder E:\Program Files\Microsoft SQL Server\MSSQL14.PRI\MSSQL\DATA (should be opened by default)

Check that the restore process has not omitted any folders forms from bin.95 directory. Do a simple folder count / file count comparing restored bin.95 folder against bin.95 folder in restore directory. (One upgrade it was found that some files existed in the restore folder but had not been created in the new folder).

The util folder in the Priority\system is normally not restored and should be copied manually.

The restore process should ensure that all users have been created correctly in the database. No further action will be necessary. To confirm, log into SSMS on the live and test servers and check the logins in the Security section. If they do not look in sync, review section “Logins Recovery and Restore”.

Login to Priority (dedicated client), select base company and open a few forms. No errors should appear.

Open the Companies form (System Management > System Maintenance > Companies > Companies) and amend all company names so that they are prefixed with a T (to indicate that this is the test server)

Check the database backup commands in Tabula Task Scheduler are pointing at a valid directory. The live server will likely have multiple disk drives compared to the test server.

Check the tabula.ini file for references to disk drives that do not exist on the test server and correct if necessary.

Make sure tabula task scheduler is not running until other tasks in project have been completed.

Check file permissions (see section File Permissions).

Re-Install Priority App server. URL explanation needed here. Note that for servers without an SSL, you create one for the machine and then review the certificate to obtain the url to use. See “Manual SSL Steps” in install guide.

Re-Install Priority Search server.

Live system is overly large for test server

The biggest challenge when restoring is that in general the size of the test server is smaller that the live server, which means consideration needs to be taken into how this can be done.

Test servers tend to have lots of old Priority folders that are not needed i.e. backups from prior upgrades, multiple bin95 folders and so on. Initially pare back anything that is not needed, but leaving the current Priority install in place.

Check the backup folder and delete database backups, just leaving one backup per database.

Once this is done, total available disk space on test server will be known.

There may be enough space to copy the live backup over, but will there be enough space to restore it? If the Priority folder including backup is 100GB, then this is how much free space you will need at a minimum on the test server.

What if you can’t find enough space?

Pare down the live backup data you bring over so that you create a minimal system on the test server. This is the interesting bit.

Within the backup folder, the data folder contains the databases. You only need to take over one backup for each database. You cannot delete the other backups to reduce the files as it is live!

You could copy them over manually one by one, or if there is space on the live server, create a copy of the backup and then delete the files you don’t need to transfer.

Similarly you do not need to take over the system/reports folder as these are just reports.

The system/mail folder can also be exceeding large. Here, just the latest folders can be copied over. Note that if you do that, sometimes you find that company images used in documents stop displaying. Simply look for the location and copy over from live to test.

A script can be used to create a smaller backup folder if space on live permits. You can then copy this instead. See “Backup Scripts” Section.

File Permissions

See section “File Permissions” in install document.

Manual Refresh

This can be done if the test server already has a Priority install on it which is working and the same version and Bin as the live server. The principle is to move the databases over from live to test. Additionally the system\mail and system\reports folders should be copied over if needed.

Make sure nobody is logged in on test. In order to make sure nobody is logged in go to System Management > System Maintenance > Periodic Maintenance > Active Users. The upgrade can only be completed if everyone is logged out of the system.

Stop services on test server (App, Redis, Search, TTS). Set to manual so they cannot start again.

Run Daily Backup on the Test server (System Management > System Maintenance > Periodic Maintenance > Run Daily Backup) to keep copy on existing system so that it can be restored. Rename this.

Detach DB’s on test server in SSMS.

Right click on database and select “Detach”:

Select the check boxes and click ok.

Delete DB’s on test server in file manager.

Copy databases from live. There are two ways to do this.

Copy the *.bak files from the Priority backup folder in live.

Copy the *mdf and *ldf files from the SQL server instance. This method requires the live system to be down and is the method used in migrations. See migrations document for details.

On live server, copy “\priority\backup\data” folder to test server. Alternatively, only copy the last .bak file for each database to save time. You do not need the *trn files. Include the system and pritempdb databases. You can view the companies within Priority to see their actual database names and the number.

On test server, in SSMS right click on Databases on the left panel.

Select Restore Database->Device->Add and find BAK file you need to restore a DB.

On the left side where is Select a page, choose Files and tick the box Relocate all files to folder. By default, it should be a MS SQL folder. Click OK.

On the Option tab do not change anything and click OK.

Wait for the end of process.

Depending on when the last proper restore was done on the test server, the users defined in test may not match those defined in test. Refer to section “Logins recovery and restore”.

The links in the copied database will refer to system\mail and system\reports files. These can be copied over from live to test having first deleted the folders on test. Alternatively, the processes System Management > System Maintenance > Periodic Maintenance > Clear "mail" Directory, and System Management > System Maintenance > Periodic Maintenance > Delete Saved Reports, can be run to clean the database links. Then all files in system\mail and system\reports should be removed.

Logins recovery and restore

There can be times when the logins in the test system do not match the logins in the live. This then causes problems for users to login to the system.

If it is just one or two users then you can create them manually using SSMS. Go to the “Security>Logins” section, right click and add new user. Review an existing user to make sure all the properties are correct.

If many logins are missing, use the code in section 2. The code in section 1 and 3 are alternatives to only be considered if section 2 does not work.

Note that I have rarely had to use this and has normally coincided with customers who are running old versions of SQL Server and it has not been possible to do a Priority restore for some reason.

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

This also contains detailed instructions which are worth reading to understand this method.

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

Note that the NT SERVICE/xxx accounts may be named differently between the A and B server which may result in the script failing to execute completely, see below.  If this happens, remove the NT Services accounts from the script and re-run.  You will need to restart SQL Management Studio to see the results.

Backup Scripts

Two backup scrips have been created which are in the zip file “refreshbackupscripts” stored in LB21000002.

The first, testdir.bat is used to test the from and to directories to be used.

The second, copyprioritybackup.bat will copy files from the current backup to a new location. The file locations determined by the first script are put into this script. This script is also edited to copy over the data required.

Upon completion, the new subset backup folder can be copied to the test server.

This script also allows to do the transfer in chunks by doing the copy in sections.

Live database has many Companies but only few needed on Test server

The situation can arise where a customer has many live companies which are not needed on the test server. The restore process will fail if these are missing from the backup. The solution is to not copy these databases over to the test server initially and then clone a database that has been copied. For example:

The database timp2 is not needed. The folder backup/data/timp2 is not copied to the test server. On the test server, create the backup/data/timp2 folder and copy the demo.bak file to it from the backup/data/demo folder (if this does not exist use the smallest database that does). Rename the demo.bak to timp2.bak. This will allow the restore to not fail and create the timp2 database. This can then be deleted from within Priority after the restore.

Search Server – Troubleshooting

Refer to section “Search Server – Troubleshooting” in install guide.

Application Server - Troubleshooting

When restoring onto a server where an existing Priority install exists, when you install the application server, if problems are encountered it may be worth uninstalling the application server first, as well as the Redis server.

Open “Services” and stop the “Priority Application Service” and the “Priority Redis Service”.

Close “Services”. Important as otherwise the services may go to disabled when you uninstall them and you will have to reboot the server.

Open CMD prompt as administrator.

Enter command: SC delete “Priority Application Service” and press enter.

Enter command: SC delete “Priority Redis Service” and press enter.

Open “Services” and check they are not longer showing.

Priority Backup – Things to know

The system/mail and system/reports can contain a lot of data. Whenever the backup runs any new files are copied to the backup.

However, files are never removed from the backup directory. Hence if the processes are run to delete reports and documents, these are NOT removed from the backup directory.

This means that all customers should really on a regular basis delete(!) their backup directory and create a new one, and this will remove the dross.

This is important as needs to be taken into account when doing migrations.
