# Transferring Priority on SQL Server to a New Server

- **Source:** `Transferring Priority on SQL Server to a New Server.pdf`

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
1/5 Ver.04 Cat.No. LB10000720  
 
 
Transferring Priority on SQL Server to a New Server 
Introduction 
The following instructions apply to the Standard, Enterprise and Workgroup editions of SQL 
Server, and can be used for a number of related purposes: 
 to transfer the server to a different computer 
 to transfer data to a test server 
 to recover backup files to a new server if the old one cannot be used. 
Note: They can also be used to install Priority on a new drive in the existing server. 
However, in that scenario, some of the steps are slightly different. For details, see the 
last section of this document. 
Before you begin  
 Make sure the target computer is running properly and connected to the network. 
 Make sure all users exit Priority. 
 Ensure that the following are on the target computer: (1) SQL Server installation 
including latest Service Pack; (2) backup capabilities; (3) remote support 
capabilities (for details, see the Priority: Hardware and Support Systems 
document; download available from the Customer Area on 
http://www.eshbel.com/customerarea.htm). 
 Download the appropriate installation file from the Customer Area. 
Transferring the system 
1. Have the Database Administrator (DBA) install SQL Server on the target computer. 
2. Install Priority on the new server; its home directory will hereafter be referred to as 
x:\priority.  
3. Have the DBA transfer the Priority on SQL Server database from the source 
computer to the target computer. Note that the installation performed in Step 2 adds 
two databases to the new SQL Server: system and demo. Delete them and replace 
them with the same databases from the source computer. If the Priority demo 
company has already been deleted from the source computer, the demo will no 
longer be there. Nonetheless, you should delete the demo database created during 
the installation. 
Note: See Appendix for tips on performing the transfer. 
4. Make a backup copy of the file: x:\priority\system\srvpath in a different directory (not 
under x:\priority). This file stores data on the location of the server and the mapping 
of Priority files. 
5. Delete the entire contents of the x:\priority directory and copy the contents of the priority 
directory in the old server to x:\priority. (The deletion is highly important; you must not

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
2/5 Ver.04 Cat.No. LB10000720  
 
copy new data onto old data.) You must copy the entire priority directory – do not 
attempt to transfer only part of the data. 
Note: In the case of recovery in a new server, or if you are setting up a test server, copy 
the contents of your backup tape to x:\priority. 
6. Copy the tabula.ini file from the Windows directory of the source computer to that of 
the target (generally in c:\Windows or c:\WinNT). 
7. Copy the backup file for srvpath (see Step 4) back under x:\priority\system. 
8. Open the tabula.ini file in Notepad and do the following: 
 Make sure the Priority Directory is x:\priority\system\prep. 
 Check that the name of the server (Tabula Host) corresponds to the 
name of the SQL Server Instance. 
 Revise and save the file, as necessary. 
9. While in Notepad, open the srvpath file in the x:\priority\system directory and do the 
following: 
 Make sure the first line contains the correct path to the Priority directory 
(e.g., c:\priority). 
 Make sure the third line contains the name of the new server (see Step 8 
regarding Tabula Host). 
 Revise and save the file, as necessary, and exit Notepad. 
10. If the target computer has been used as a Windows terminal server and had a 
previous installation of Priority on it, it is possible that the tabula.ini file has been 
copied into the terminal users’ home directories (e.g., c:\Documents and 
Settings\John_Smith). If this is the case, you should find and delete all these files, so 
the tabula.ini file you have just corrected will be copied again (the file is copied 
automatically by Windows when the user enters Priority for the first time). 
11. Define appropriate Windows permissions and sharing definitions for Priority’s 
program files on the new server. For details on Windows permissions (and other 
installation information), see the relevant installation instructions document 
(download available from the Customer Area on 
http://www.eshbel.com/customerarea.htm). 
12. Perform a system check of Priority by generating a few reports. These checks are 
designed to detect missing information or any other problems with document 
numeration: 
 Check J. Entry No. Continuity (menu path = Financials  General 
Ledger  Financial Statements  Auxiliary Reports) 
 Check Finance Doc No. Continuity (same menu path; run the report for 
the most commonly used document in your system) 
 Document No. Continuity Check (menu path = Inventory  Inventory 
Maintenance; again, run this report for the most commonly used 
document in your system). 
13. If there are Priority companies that were not transferred as SQL databases (e.g., 
practice sites), delete these companies by running the Delete Company program in

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
3/5 Ver.04 Cat.No. LB10000720  
 
Priority (menu path: System Management   System Maintenance   Companies). 
Please ask your DBA to determine which companies have been transferred. 
14. To prevent unintentional use of the old server, if it is still connected to the network, 
change the name of its priority directory and disconnect the old server from network 
sharing. 
Note: This should only be done when the old server will no longer be in use. For 
instance, ignore this step if you are installing a test server.  
Connecting clients to the new server 
If the old server has been replaced, it is now necessary to connect all existing clients to the 
new server. The fastest way to do so is to map the server from within each client and 
reinstall the client from there. 
Note for advanced users: The client reinstallation is for the purpose of revising each 
client’s tabula.ini file. If the server is mapped identically for all clients, rather than reinstalling 
all clients, you can simply reinstall a single client and then copy the lines in that client’s 
tabula.ini file for “Priority Directory,” “Priority RemoteRoot” and “Tabula Host” into the 
tabula.ini files of all remaining clients. 
Installing the Tabula Task Scheduler 
The tabula.tsk file holds definitions of all tasks in the Scheduler. Rather than manually 
redefining scheduled tasks in the new server, simply copy this file from the Windows 
directory of the old server to the same directory in the new server. 
Note: This is only necessary if you are using the new server as your main server. 
Transferring Priority from one drive to another 
Follow the above instructions (replacing “server” with “drive”), with the following additions: 
 Before Step 2: Before installing Priority on the new drive, make a backup copy of 
the tabula.ini file, as this file will be revised as a result of the reinstallation.  
 Instead of Step 5: After the installation, use Notepad to revise the tabula.ini file. 
Specifically, restore the lines from the backup file for: Organization, License and 
Concurrent Users. Remember to also check the Priority directory and the host 
server (see Step 8).

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
4/5 Ver.04 Cat.No. LB10000720  
 
Appendix: Tips on Transferring the System to a New Server 
Login Data 
Use the SQL code below to store login data from the old server and restore it to the new 
server.  
 
SQL Code to Store Login Data 
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
AND master.dbo.syslogins.name = (case when  
system.dbo.SYSCONST.VALUE = 1 then  
reverse(system.dbo.USERS.USERLOGIN) else  
system.dbo.USERS.USERLOGIN end) 
go

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
5/5 Ver.04 Cat.No. LB10000720  
 
SQL Code to Restore Login Data 
 
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
 
exec master..sp_addlogin @loginame, @passwd, 'system', 'us_english', @sid, 
'skip_encryption' 
set @qry = N'grant view server state to [' + @loginame + ']' 
exec sp_executesql @qry 
exec master..sp_addsrvrolemember @loginame, 'sysadmin' 
 
fetch next from logincur into @loginame, @passwd, @sid  
 
end  
 
close logincur  
deallocate logincur 
go  
 
Server Names 
Don’t forget to change the name of the new server to that of the old one. Also change the 
name of your SQL Server Instance, using the following commands in the Query Analyzer: 
 sp_dropserver old_computer_name 
 sp_addserver new_computer_name, local
