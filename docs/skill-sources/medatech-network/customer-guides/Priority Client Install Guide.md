# Priority Client Install Guide

- **Source:** `Priority Client Install Guide.pdf`

Priority Client Install Guide 
05 Aug. 21 
1 
INSTALLING PRIORITY CLIENT  
STEP 1: MAPPING PRIORITY SERVER TO A LETTER DRIVE  
Open File Explorer and select “This PC” from the left pane. Under the Computer tab, select 
Map network drive. 
 
 
 
 
 
 
 
A dialog box will appear, containing a drive identifier that will represent the Priority server on 
the local system (in the following instruction, we will use the identifier F). 
 
 
 
 
 
 
 
 
 
 
 
Under Folder, enter the drive on which Priority is installed on the server, in the following 
manner: \\server\C (where server is the name of the server, and C is the drive identifier).

Priority Client Install Guide 
05 Aug. 21 
2 
Note: Ensure that the installation path is not too long. An installation path of no more than 
two directories (e.g. P:\dir_name\priority) is recommended. 
Flag the Reconnect at Logon option. 
STEP 2: RUN NING  THE INSTALL  
 
In the File 
Explorer, 
navigate to the 
F:\priority\client 
folder and 
double-click on 
the setup.exe 
file to start the 
installation 
process. This 
process should 
be run whilst 
logged on as a 
user with full 
administrator 
privileges. 
 
Read and 
accept the user 
license 
agreement 
 
Press Next

Priority Client Install Guide 
05 Aug. 21 
3 
Press Continue 
 
Enter the 
location of the 
Priority folder on 
the server 
 
Press Continue

Priority Client Install Guide 
05 Aug. 21 
4 
Enter the path 
of the directory 
in your 
computer 
where you want 
to install the 
Priority client. 
There must be at 
least 150 MB 
free in your drive 
 
Press Continue 
 
Press Install

Priority Client Install Guide 
05 Aug. 21 
5 
If this message 
appears, ignore 
it and press OK 
 
 
STEP 3: ADMINISTRATING PERMISSIONS FOR PRIORITY FILES  
As with installation of the server, we recommend that you install Priority on clients using the 
NTFS file system, so that you can define appropriate permissions to the program files and thus 
prevent changes to these files from unauthorized users, or their deletion from the system.  
Permissions that should be assigned to Priority files on client workstations:* 
 
 
 
 
 
* If you decide to change permissions, ensure that the following two options are  selected: 
Replace Permissions on Existing Files 
Replace Permissions on Subdirectories 
** Usually C:\tmp. Check each user’s tabula.ini file. 
 
 
 
User/User Group Directory Directory Contents Permission 
Everyone Priority\bin.95 Priority programs Full Control 
Everyone Directory defined as 
Tabula Tmp in the 
tabula.ini file** 
Priority’s temporary 
files for local use 
Full Control
