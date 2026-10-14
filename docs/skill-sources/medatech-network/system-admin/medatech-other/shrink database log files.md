# shrink database log files

- **Source:** `shrink database log files.pdf`

Manually shrink a log file 
On the database server, login to SQL Server Management Studio (SSMS). 
 
Click Connect to login using Windows Authentification. 
For the database you wish to shrink the log for, select the following: 
 
The following is displayed:

Select the file type of log: 
 
This shows that in this example, if we shrink the log file we will get back 94.66 MB which is 
91% of the file. 
Click ok to shrink the file.

Re-open the window to confirm the file has been shrunk. 
 
You can see that the file is now only 8MB. 
If the file size is unchanged, refer to section 3.
