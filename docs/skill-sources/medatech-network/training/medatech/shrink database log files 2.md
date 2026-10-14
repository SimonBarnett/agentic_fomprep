# shrink database log files 2

- **Source:** `shrink database log files 2.docx`

Shrink Database Log files

1. Manually shrink a log file

2. Steps to shrink log files

2a. Database file require shrinking

3. Log file does not shrink

4. Backup implications when Simple mode used

Note: open this document in Word rather than Edge. If Edge is used, when you copy the code into SSMS, it loses all the line breaks.

On occasion the log file of a database can growth beyond its expected size for whatever reason. The way log files work, they never reduce their size even though they may actually be practically empty.

1. Manually shrink a log file

On the database server, login to SQL Server Management Studio (SSMS).

Click Connect to login using Windows Authentification.

For the database you wish to shrink the log for, select the following:

The following is displayed:

Select the file type of log:

This shows that in this example, if we shrink the log file we will get back 94.66 MB which is 91% of the file.

Click ok to shrink the file.

Re-open the window to confirm the file has been shrunk.

You can see that the file is now only 8MB.

If the file size is unchanged, refer to section 3.

2. Steps to shrink all log files

A script to shrink a log file i.e. remove all the empty space, is as follows, curtesy of Nikita:

This can be done with the users accessing the system.

Login to SSMS as shown in section 1.

Click “New Query” and past the text in the resulting window.

Before clicking execute, check existing log fil sizes:

Click Execute to run.

The following messages will be displayed. The number will depend on the number of databases.

Re-check the file sizes.

You can see that the log files are all now about 100MB.

Refer to section 4 for implications of this method.

2a. Database File Requires Shrinking

You can run the following in SSMS to shrink .MDF files which has free space which won’t release when you run the shrink files from the SSMS interface.

USE [tempdb]

GO
DBCC SHRINKFILE (N'tempdev', 100);
GO

Where ‘tempdb’ can be replaced with the database name.
100 is the number of mb to shrink to

And ‘tempdev’ is the name of the file when you look in the shrink files screen (below)

3. Log file does not shrink

It is possible that using either 1 or 2 will result in a log file not being shrunk. This is normally due to there being open transactions which can have resulted from deadlocks.

To determine if there are any open transactions, in a query window run “DBCC OPENTRAN”.

In this example there are none. However below is what was seen troubleshooting a 55GB log file for House of Flags:

Transaction information for database 'datamig'.

Oldest active transaction:

SPID (server process ID): 54

UID (user ID) : -1

Name          : DELETE

LSN           : (118877:20040:1)

Start time    : Oct 29 2021  8:43:14:067AM

SID           : 0x7802fd53fa8c7e4791bd958c531baef4

DBCC execution completed. If DBCC printed error messages, contact your system administrator.

This was showing an open transaction from 2 months ago which explained why the log file had grown so large.

To investigate this, start the activity monitor in SSMS.

Open the Processes section.

Here the first column shows the session ID which correlates to the PID in the error message. Note that there can be many lines for the same PID.

In the case of the HOF example, there were two processes for PID 54, a DELETE and INSERT. Both were showing that they were SUSPENDED and waiting. IN the above we just see one RUNNING task, nothing is waiting.

To see more details, right click on the line and take “Details”.

Doing this on PID 58 shows the following:

Based on this you can see what is happening.

To resolve a deadlock you need to kill the process which can be done using the button above.

When you kill a deadlocked process, some data is going to be lost as the system will rollback some data.

4. Backup implications when Simple mode used

Be aware that when a database is put into simple mode to facilitate the shrinking of a log file, this means that if you need to restore during that day, you will only be able to restore up to the point of the shrink. So if a few hours later you need to restore, those hours will be lost. This is because you have to go back to the last full backup and then apply the hourly log backups. These though will only be valid up to when the shrink was run.
