# Error 9002

- **Source:** `Error 9002.pdf`

Error 9002 
06. Sept. 2021 
1 
SQL SERVER TRANSACTION LOG 
FULL (ERROR 9002)  
ERROR S 
 
SQL Server Error (80040e14) 
The transaction log for database ‘live’ is full due to ‘LOG_BACKUP’. (Error 9002) 
 
SQL Server Error (80040e14) 
BACKUP DATABASE is terminating abnormally. (Error 3013) 
The transaction log for database ‘live’ is full due to ‘LOG_BACKUP’. (Error 9002) 
EXPLANATION  
When the backup runs the logs are truncated.  
Then as transactions are carried out this is saved to the log file, so that you could restore to 
any point in time.  
BUT... if there is no backup, or there are a lot of transactions created on the database (by 
users or automatic procedures etc). then the log files can get large.

Error 9002 
06. Sept. 2021 
2 
If not monitored, they can keep getting bigger and bigger.  
There is a setting in SQL to ensure that they do not exceed a given size, and when that is hit, 
the message is received... 
EXAMPLE  
Here the log for ‘live’ is large 
 
SOLUTION  
The solution is to BACKUP the log, and then this will shrink it and then make sure there is a 
backup running.  
OR set the DB backup mode to Simple so that the logs are not kept (in SQL right click on the 
live database > properties >options). 
e.g., clear the log, change the database type to simple, shrink the log file and change the 
DB back to Full.

Error 9002 
06. Sept. 2021 
3
