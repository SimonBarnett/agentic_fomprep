# Setting Up the Tabula Task Scheduler

- **Source:** `Setting Up the Tabula Task Scheduler.pdf`

Cat.No. LB130449  1  Ver.1, Oct. 22,’13  
 
Setting Up the Tabula Task Scheduler 
The Tabula Task Scheduler runs a series of Priority programs automatically at a 
predefined time and with a predefined frequency. The following explains how to 
set up the Scheduler to run those programs.  
Notes: 
 In a hosted (SaaS) installation, you can begin defining tasks immediately in 
the Define Task Scheduler Tasks form (path: System Management > 
System Maintenance). Once you have finished defining the desired tasks in 
this form, select Define Scheduler Tasks from the list of Direct Activations. 
 The following instructions for installing the Scheduler are relevant only on a 
client-server installation with Windows GUI. 
To install the Scheduler:  
How the Scheduler is installed depends on the database in question: 
Priority on Tabula  
1. Log in as Administrator, either on the server or remotely via CONSOLE. 
2. From the Start button, go to the Setup Tabula Service window: Start > 
Programs > Priority > Setup Tabula Service.  
3. Flag the check box for the Tabula Task Scheduler, and ensure that the 
Tabula Server box is already flagged. Click Update to install the Scheduler.  
Priority on Oracle or SQL Server  
1. Log in as Administrator, either on the server or remotely via CONSOLE. 
2. Choose a Priority workstation (client or server), operating on Windows XP or 
higher, from which to run the scheduled programs, and log in as Administrator 
from that workstation.  
3. Enter Priority as the tabula user and run the Install Task Scheduler 
program: System Management > System Maintenance > Install Task 
Scheduler. Flag the check box for the Tabula Task Scheduler and click 
Update. The Scheduler will be added as a service.  
Note: If you change the password of the Priority superuser (Manager in the 
Tabula environment, tabula in SQL and Oracle), you will need to change it in the 
Scheduler as well.

Cat.No. LB130449  2  Ver.1, Oct. 22,’13  
To activate the Scheduler:  
In the computer on which the Scheduler is installed:  
 From within Priority, run the Tabula Task Scheduler program (path: 
System Management > System Maintenance), select Start Task 
Scheduler and click OK. 
or  
 From the Start menu, open Services (Control Panel > Administrative 
Tools), right-click Tabula Task Scheduler and select Start. 
 
Note: If you are running Priority on SQL Server or Oracle, you will be prompted 
for a username and password. 
To select the programs run by the Scheduler:  
1. Open the Task List (on the File menu, if you opened the program from the 
Desktop). 
Note: In Priority on Tabula, when you open the program from the Desktop, 
you will be prompted for the Manager username and password. 
2. Move to the program you wish to run via the Scheduler and click Modify. 
 
Task Scheduler when run on Tabula Task Scheduler when run on SQL Server or Oracle 
3. In the dialog box that opens, flag the Active option.

Cat.No. LB130449  3  Ver.1, Oct. 22,’13  
4. The frequency and time at which the program is to run are predefined. Revise 
these definitions as desired. 
5. The Start in field (titled Company on Oracle and SQL Server) displays the 
name of the company in which the program is run. Ensure that this is the 
correct company.  
Notes:  
 In Priority on Tabula the company is defined by its full path  
(e.g., C:\priority\data\eshbel). In Priority on Oracle or SQL  
Server, only the company name appears (e.g., eshbel).  
 With the exception of a few programs (Delete 3-month-old mail  
messages; Daily Backup; Weekly Backup; FormPrep), which  
are automatically run on all companies, the program will run  
only in the designated company. To have it run in an additional  
company, return to the Task List, click Add, and fill in the  
blanks manually (copy the definitions from the pre-defined  
program, changing only the company name).  
 
6. If the program appearing in the Command field is run using the WINACTIV 
command and requires user input, choose a user whose saved input 
parameters will be used to run the program (in the Use Input Parameters of 
User field). The last input parameters that this particular user used to run this 
particular program in Priority will now be saved for and used by the 
Scheduler.  
Notes:  
 If that user later reruns the program, the change will have no effect on the 
Scheduler. 
 You can only define input parameters for a "simple" procedure, i.e., one for 
which the Rep/Wizard/Dashboard column in the Procedure Generator is 
blank. 
7. Repeat Steps 2-6 for any additional programs you want to schedule.  
8. When done, close the Task List. All programs flagged as Active will run 
immediately and continuously, in keeping with their scheduling definitions.  
9. In order to apply changes made in the Scheduler via the Priority interface, 
you need to stop it (Stop Task Scheduler) and run it again (Start Task 
Scheduler).  
To set up the Scheduler to send time-activated BPM messages:  
If you are using the Scheduler to send time-activated e-mail notifications on the 
basis of BPM rules (i.e., you have included the Send reminders about 
document status program to the list of active tasks), it is recommended that you 
define an outgoing mail application other than MS-Outlook.

Cat.No. LB130449  4  Ver.1, Oct. 22,’13  
To reroute mail so it is not sent through MS-Outlook: 
1. Enter Priority on the workstation from which you want to send mail (but not 
via a terminal server).  
2. From the Top Bar, select Mail > Mail Options > Other Servers. 
3. Fill in the user name and password as defined for the outgoing mail server. 
4. Fill in the remaining parameters, and flag the Send Test Message option. 
5. Make sure the test e-mail is received properly. 
From now on, all of the user's external mail will be sent using the alternate 
program. To return to MS-Outlook, from the Top Bar, select Mail > Mail Options 
> Outlook > Mail Options. 
To send all external mail through MS-Outlook: 
1. Change the user running the Task Scheduler from the default System user to 
one for which a mail account can be defined (e.g., Administrator): 
a. Enter the Services window (usually under Administrative Tools in the 
Control Panel) and move to the Tabula Task Scheduler.  
b. Right-click the icon and select Properties.  
c. Click the Log On tab and flag the This account option.  
d. Type the name and password of a user with permissions to use Outlook 
mail (e.g., Administrator). 
2. Log on to the server and define an MS-Outlook mail profile for the 
Administrator user. Make sure that this user is able to send a test e-mail 
properly. 
3. Enter Priority as any user. 
a. From the Top Bar, select Mail > Mail Options > Outlook > Mail Options, 
and flag the Without Outlook security messages column. 
b. Open the tabula.ini file (under C:\Windows) and make sure that the line 
OutlookMessages=0 appears under the [Menu] title. 
4. Enter Outlook, open the Tools menu and select Options. Click the Mail 
Format tab, and make sure that Word is not flagged as the default e-mail 
editor in the Message Format section. 
Notes:  
 From now on, you must access the Tabula Task Scheduler from within  
Priority. 
 For more details, see the User Interface Guide document,  
available from the Customer Area on the Eshbel web site, at:  
http://www.eshbel.com/customerarea.htm.
