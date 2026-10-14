# Priority on SQL Server Express Edition Backup and Maintenance

- **Source:** `Priority on SQL Server Express Edition Backup and Maintenance.pdf`

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
1/7 Ver.10 Cat.No. A6000331  
 
 
Priority on SQL Server Express Edition:  
Backup and Maintenance 
This document contains instructions for creating a backup of the data in your system, as 
well as performing a recovery if such an action is necessary. 
I. Priority Backup 
Backups require the knowledge of a systems administrator. They are used as a contingency 
source for the recovery of data when the database has been damaged (e.g., by a virus or 
hardware malfunction). In order to minimize such damage, backups should be performed on 
a regular basis, according to the instructions contained in this document.  
Requirements  
 4 to 5 daily backup tapes (one for each day of the week, except the last), each marked 
for one day of the week (e.g., Monday, Tuesday). 
 4 weekly backup tapes for the month’s work. 
Running a Backup 
Daily Tapes:  Each day of the week (except for the last – see Weekly Backup), a backup 
should be made of the system data on the tape designated for that day. The daily tapes are 
meant to be used on a rotational basis: they are taped over on the same day of every 
consecutive week (e.g., every Tuesday, the backup is made on the tape labeled “Tuesday,” 
which will always contain the backup data from the previous Tuesday). 
Weekly Tapes: The backup tape for the last day of the week will serve as the weekly 
backup containing the source data for the entire week. Weekly backup tapes are held for a 
month, rather than overwritten every week. They should be clearly marked with the date 
they were recorded, otherwise you will not know to which week they belong.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
2/7 Ver.10 Cat.No. A6000331  
 
Verification 
The log files should be checked on a daily basis to verify that the backup was completed 
successfully. When changing the backup tape, it is important to note that a message 
appears on the screen indicating that the backup was successfully completed.   
Another important verification procedure is a random check of the contents of one of the 
backup tapes, including a full reading of the tape, to be performed once a month. 
Storage 
It is very important that the backup tapes be stored at a location other than the company 
building. This will ensure against loss of critical data in the event of irreversible damage to 
the company site (e.g., as a result of a fire). The person responsible for performing the 
backup procedures should store the weekly backup tapes of the system data from the 
previous three weeks in his or her home. 
Backup Procedure 
Backups are performed via the Run Daily Backup program (System Management > 
System Maintenance > Periodic Maintenance), which only the system manager is 
permitted to run. This program backs up both the SQL Server database and the system 
directories, saving the data in the backup sub-folder of the priority directory. Daily backups 
are stored in this folder for three days, which allows you to transfer a backup from Friday to 
a different tape on Monday. Older files are deleted automatically by the program. If you 
want to store backups for a longer period, increase the value assigned to the 
SQLBACKUPDAYS constant in the System Constants form.  
It is recommended to run the backup program automatically by means of the Tabula Task 
Scheduler, in order to ensure that the process is carried out routinely and accurately. 
Backups via the Tabula Task Scheduler 
To install the Tabula Task Scheduler: 
a. Run the Tabula Services Setup program on the Priority server (System 
Management > System Maintenance). 
b. Flag the Tabula Task Scheduler option, and press Update to authorize the 
installation.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
3/7 Ver.10 Cat.No. A6000331  
 
c. Run the Task Scheduler program and press the Start Tabula Task Scheduler 
button. 
To activate the automatic backup procedure: 
a. Run the Task Scheduler program on the Priority server and press the Task List 
button. 
b. Move to the “Daily Backup” procedure and press Modify. 
c. Flag the Active option. 
d. In the Week Days section, flag the days of the week on which you want to perform 
backups (usually, every day of the week), and specify the desired time underneath. 
 
e. In the Command field, the backup command appears. The next-to-last parameter 
defines the folder to which the data will be transferred. The default value is 
C:\priority\backup, but it may be revised. Do not change any of the other 
parameters. 
f. Press OK and close the windows you opened. 
g. Repeat Steps A through F and define an automatic backup to be performed hourly. In the 
Task List, select the “Hourly Backup” program. Flag the Every option and specify the 
interval between backups (in minutes) underneath. These backups save the logs (i.e., the 
last transactions performed in the entire company), and not all of the system data.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
4/7 Ver.10 Cat.No. A6000331  
 
h. In the same manner, define the “Weekly Backup”. In the Week Days section, flag the 
day of the week on which the backup will be performed (for example, Saturday) and 
specify the desired time underneath. 
Storing the Backup on a Tape 
Copy the backup directory (created when running the backup program – for example, 
C:\priority\backup) onto the backup tape. 
II. Maintenance 
Clearing Temporary Tables 
Priority programs save intermediate results and other data in temporary tables. This data is 
usually deleted when a program finishes running. However, when the program is prevented 
from terminating properly (e.g., due to a power outage, computer crash, procedure freeze) 
this data remains stored in the tables, needlessly increasing the size of the database. 
You can delete all such unnecessary data by running the Clean Temporary Tables task in 
the Tabula Task Scheduler. It is recommended to run this program now and then, but only 
on a weekend or at night, when nobody is working on the system. 
Note: The program only requires several minutes to run; however, it could cause serious 
problems if it runs simultaneously with other programs. Make sure that it does not overlap 
with any other tasks in the Scheduler.  
Recovery  
The following are instructions for performing a recovery when data needs to be retrieved 
from a backup. These actions should be performed on the server only. 
Important: This section is intended for authorized DBA professionals. If needed, you 
can purchase DBA services from Eshbel. 
Requirements 
 Up-to-date server – If you are performing the recovery on your backup server, rather 
than the original Priority server, make sure that it contains the current release of 
Priority, with the same service pack that was last run before the system crashed, as well 
as SQL Server 2005 Express Edition.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
5/7 Ver.10 Cat.No. A6000331  
 
 Sufficient disk space – Make sure that there are at least 2GB of open memory on the 
server drive, as well as twice as much memory as that used by the data file directory on 
the original SQL server. 
 No users are currently using the system – Users cannot be working in Priority during 
a recovery. 
 Active remote software – In case you need assistance from the Eshbel technical 
support staff. 
 The latest available backup tape. 
 SQL Management Studio – Make sure that this SQL Express administrative tool is 
installed on your computer. You can download this tool without charge from the Microsoft 
web site: http://msdn.microsoft.com/vstudio/express/sql/download.  
Recovery Procedure 
a. Recover the databases from the backup tape to the SQL server. If you used the 
Priority’s built-in backup program, these data are located in the priority/backup/data 
directory. If the data from the old server are available,  you should also recover the log 
files recorded after the last full backup, which include the latest transactions performed in 
the entire company. If the logs were copied to another computer in the network as part of 
the backup routine, recover them from that computer. 
b. If you are using the backup server (i.e., the alternate server) to recover data, change the 
name of the server to that of the original server. In addition, change the name of the SQL 
server as well. To do so, execute the following commands in the SQL Management 
Studio: 
sp_dropserver old_computer_name 
sp_addserver new_computer_name, local 
c. Recover user data from the backup. To do so, use the code in Appendix A. 
d. Change the names of the system and bin.95 sub-folders in the priority directory, to 
system_old and bin95_old, then recover those directories from the tape. 
Note: Do not overwrite the old directory – make sure that you have already changed its 
name.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
6/7 Ver.10 Cat.No. A6000331  
 
e. Define Sharing for the recovered directory, according to the definitions of the original 
directory. 
f. If there were companies in the system that did not undergo backup (e.g., practice 
companies), delete them by running the Delete Company program in Priority (System 
Management > System Maintenance > Companies). Afterwards you can create new 
practice companies. 
g. Copy the tabula.ini file from the c:\priority\backup directory to the C:\WinNT or C:\Windows 
directory. 
Note: If the file was not backed up, you can receive a new Priority license from Eshbel and 
install it. 
h. Make sure that the backup process has been properly defined in the computer in which the 
recovery is performed (see Section I). If necessary, redefine the maintenance programs and 
backup scheduling. 
i. Check the state of the Priority system by running several reports. These checks are 
intended to determine if there are any breaks or problems in the continuity of document 
numbers after the completion of the recovery: 
 Check J. Entry No. Continuity (Financials > General Ledger > Financial 
Statements > Auxiliary Reports) 
 Check Finance Doc No. Continuity (same menu path; run the report for the most 
commonly used document in your system) 
 Document No. Continuity Check (Inventory > Inventory Maintenance – again, run 
this report for the most commonly used document in your system). 
j. Users can now enter and work in the system. When you have verified that the Priority 
system is working as it should with the new data, delete the system_old and bin.95_old 
folders and all their contents. If you recovered the databases from a backup tape to a 
temporary directory on the disk, you can delete this directory as well.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
7/7 Ver.10 Cat.No. A6000331  
 
Appendix A: SQL Code to Recover User Data 
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
