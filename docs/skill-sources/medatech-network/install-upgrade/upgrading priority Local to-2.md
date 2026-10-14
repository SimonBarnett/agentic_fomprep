# upgrading priority Local to-2

- **Source:** `upgrading priority Local to-2.pdf`

Upgrading Priority to the Latest Version Internal Guide 
09 Sep. 21 
1 
UPGRADING  PRIORITY DEMO  
STEP 1: DOWNLOAD  THE UPGRADE  FILE   
Open priority 
client as 
administrator  
 
Login as tabula 
 
 
Select Help > 
Upgrade System 
 
Press OK

Upgrading Priority to the Latest Version Internal Guide 
09 Sep. 21 
2 
Read the 
Checklist 
carefully 
 
Press ‘Checklist 
Completed’ 
 
See Step 4 for 
more details 
 
 
Select ‘Save 
File’ 
 
Click Approve 
 
 
Choose a 
location to save 
the file 
 
Select OK

Upgrading Priority to the Latest Version Internal Guide 
09 Sep. 21 
3 
 
STEP 2: RUNNING THE UPGRADE  
Firstly, log out of your Priority system. 
Press OK 
 
Run the 
upgrade file

Upgrading Priority to the Latest Version Internal Guide 
09 Sep. 21 
4 
When 
prompted, 
enter the 
tabula 
password 
 
Scroll to the 
bottom, 
accept the 
terms, and 
click 
‘Continue’ 
 
  
Press ‘OK’

Upgrading Priority to the Latest Version Internal Guide 
09 Sep. 21 
5 
 
  
 
 
 
Press ‘OK’ 
 
Press ‘OK’

Upgrading Priority to the Latest Version Internal Guide 
09 Sep. 21 
6 
STEP 3: REINSTALL THE APPLICATION SERVER  
 
Open priority client as administrator  
 
Login as tabula 
 
 
Go to System Management > System Maintenance > Internet Definitions > Application Server 
Maintenance > Install Application Server 
 
Check the 
highlighted 
fields are filled 
in 
 
(If not, change 
companies until 
they are) 
 
Input Windows 
password 
 
Approve 
 
 
Select 
Lite+Web 
 
Approve

Upgrading Priority to the Latest Version Internal Guide 
09 Sep. 21 
7 
Make sure the 
Priority and 
Windows login 
details and 
passwords are 
filled in 
 
Press OK 
 
Approve 
 
Input tabula 
password 
 
Approve 
 
Press OK and 
wait for 
dialogue boxes 
to disappear.

Upgrading Priority to the Latest Version Internal Guide 
09 Sep. 21 
8 
STEP 4: FAQS  
HOW TO CHECK BACK -UPS HAVE RAN  
In Priority, go to System Management > System Maintenance > Tabula Task Scheduler >  
Define TTS Tasks 
You should see three backup tasks: 
Daily, Hourly and Weekly 
Note the back-up location e.g., C:\priority\backup 
In file explorer, go to this location and enter the “data” folder:

Upgrading Priority to the Latest Version Internal Guide 
09 Sep. 21 
9 
You should see a folder for each of your companies: 
Enter one of the folders, and note the time stamp on the latest BAK File: 
 
If you need to run a backup, follow the instructions below 
Any questions, please ask support!

Upgrading Priority to the Latest Version Internal Guide 
09 Sep. 21 
10 
HOW TO RUN A BACKUP  
In Priority, go to System Management > System Maintenance > Tabula Task Scheduler >  
Define TTS Tasks 
You should see three backup tasks: 
Daily, Hourly and Weekly 
Take a copy of the command e.g. BACKUP '' '' C:\priority\system\prep C:\priority\backup D 
From the top Priority menu, run Tools > Run Entity (Advanced)… 
 
This should pop up with a window where you can paste your command:  
 
Press OK 
This window will appear: 
 
The backup is done once it has disappeared. Follow the instructions above to check this has 
run correctly.

Upgrading Priority to the Latest Version Internal Guide 
09 Sep. 21 
11 
ERROR MESSAGE: THE KEY USED TO RUN UPGRADES DOES NOT EXIST OR HAS 
EXPIRED  
You may run into this error message: 
 
To resolve, go to System Management > System Maintenance > Users > User Permissions 
Change the tabula email to support@medatechuk.com:

Upgrading Priority to the Latest Version Internal Guide 
09 Sep. 21 
12 
ERROR MESSAGE: YOUR E -MAIL ADDRESS DOES NOT APPEAR IN THE LIST OF 
ESHBEL'S CONTACTS  
Like above, make sure you are logged in as tabula, and that the email address for tabula in 
the User Permissions form is support@medatechuk.com 
If you still get this error, check the Help > About Priority: 
 
If the Company Registration Name differs from “Priority Demo – Medatech UK – SQL”, 
contact support about getting the correct licence installed.
