# Upgrading to Priority 16

- **Source:** `Upgrading to Priority 16.pdf`

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
1/6 Ver.07 Cat.No. LB130092  
 
 
 
Upgrading to Priority 16 
 
Eshbel is pleased to announce the release of Priority Version 16.  
This upgrade will install all of the latest developments and fixes to Priority, based on the 
version and modules you are currently running. You must upgrade to Version 16 in order to 
receive customer support in the future. 
During the upgrade process, the system will be off-line for several hours.  
Notes:  
 The upgrade can only be run if there are no outstanding debts to Eshbel. In order to 
avoid last minute surprises, we recommend that you enter Priority from the 
Windows interface and run the Renew License program (menu path: System 
Management > System Maintenance > Software License). When the program 
finishes running, a report will appear. Make sure that the date displayed in the line 
"Your license to run upgrades expires on" is in the future.  
 Before downloading the upgrade file, make sure that the following sites have been 
added to the Trusted Sites zone in your web browser: 
 ftp://ftp.eshbel.com 
 ftp://ftp.eshbelsaas.com 
 http://backoffice.eshbel.com 
 If you have purchased the Field Service Mngmt module and/or any of the WMS 
modules (module numbers 10, 15-17, 27, 28, 122), please contact the Eshbel 
support staff for further instructions, as you will need to install another update after 
upgrading the system. 
 If your Priority installation runs on an Oracle database, we recommend that your 
DBA be on hand while performing the upgrade: to backup the system, assist with 
the upgrade and then perform whatever modifications might be necessary in the 
database once the upgrade has completed. 
Upgrading without Internet access: If Priority is installed on a server that does not have 
Internet access, see the Appendix for pertinent upgrade instructions. 
Important! Before running the upgrade, make sure that your system meets the minimal 
hardware, operating system and database requirements for Priority 16. 
1. Backing Up the System 
Before running the upgrade, you must first perform a full backup of your system! 
2. Upgrading on the Test Server 
Important! It is essential to first perform the upgrade on your test server. 
1. To copy data from the real server to a separate test server, follow the instructions 
appearing in the Switching Servers document appropriate to your system. You can

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
2/6 Ver.07 Cat.No. LB130092  
 
download this file from the Priority Documentation page in the Customer Service 
Area, under the subject Installations (Doc.). 
2. Check a variety of private customizations to make sure they function properly. For 
example, print some customized documents and reports to make sure they haven’t 
changed. In addition, check some forms that contain customized columns (in both 
multi-record and full-record views). 
3. Once the upgrade is complete, have all users enter Priority and perform their routine 
work. This simulation will test the main system processes, as well as user privileges. 
Note! When running the upgrade on the real server, it is recommended that you use the 
executable file that was downloaded previously and installed on the test server, rather than 
downloading the file a second time. This file has been saved to the priority\tmp directory, 
using a file name that begins with the characters 16v153. 
3. Running the Upgrade 
3.1 Preliminary instructions  
1. Make sure that all users have logged out of the system. 
2. On the server, close all Priority entities and MS-Office applications. 
3.2 Download/install the upgrade  
1. From the physical server, enter Priority from the Windows interface, logging in as a 
user whose email address (defined in the Personnel File) is used to enter the 
Eshbel web site. 
Notes:  
 This user must be assigned to the privilege group of the superuser (i.e., 
tabula or Manager, depending on your database). 
 When installing the upgrade on a server running Windows Server 2008 or 
higher, enter Priority by right-clicking the desktop icon and selecting the 
Run as Administrator option.  
2. From the Help menu (in the menu bar), select Upgrade System. 
3. A checklist will appear. Go through it carefully and ensure that all items have been 
fully taken care of. Once you confirm the message, the file transfer from Eshbel's 
Customer Center will commence. This may take several minutes to complete.  
4. Indicate whether you wish to Upgrade Now or Save File anywhere in the server (so 
as to run the upgrade later). If you choose the latter option, you will need to double-
click the file in the server in order to run the upgrade. 
5. When running the upgrade, wait a few minutes as the upgrade file is extracted. 
Subsequently, a login window will open with the superuser's name; indicate the 
proper password. 
6. Once the message "Executing the upgrade" appears, the upgrade has begun 
running, and you no longer need to wait by the computer. 
3.3 Completing the upgrade 
Before beginning to work in the system, make sure you have received the upgrade 
completion message, which reads: "Priority upgrade succeeded".

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
3/6 Ver.07 Cat.No. LB130092  
 
If this message does not appear, or if the screen displays an error message, attach the 
relevant error report to the service call, and refrain from using Priority until you receive 
instructions from the Eshbel support staff. 
3.4 Completing the upgrade for WMS 
WMS Users: Upon completing the upgrade, contact the Eshbel support staff for instructions 
on installing another update. 
After installing this update and before you resume working in Priority, log in to the system 
and do the following: 
1. Enter the User Permissions form (menu path: System Management > System 
Maintenance > Users) and retrieve any users who will be working with WMS. 
2. Click the Licenses tab and make sure that the Storekeeper License column is 
flagged for these users. 
3. Run the View License Details report (menu path: System Management > System 
Maintenance > Software License >). 
4. In the displayed report, make sure that the Qty Utilized does not exceed the Qty of 
Licenses on any of the following lines: 
 WMS users 
 Bins per warehouse 
 No. of WMS companies 
Also ensure that there is a sufficient number of interface licenses for the various 
document types. 
Note: If the Qty of Licenses on a given line is "0", this indicates an unlimited number 
of licensed users for the license type in question. 
5. If you have exceeded the licensed number of WMS users, return to the User 
Permissions form and clear the check mark from the Storekeeper License column 
for any users who do not need to work with WMS. 
6. If you have exceeded the licensed number of WMS companies, enter the 
Companies form (System Management > System Maintenance > Companies) 
and clear the check mark from the WMS Company column for any companies in 
which you do not need to work with WMS. 
7. If you have exceeded the licensed number of bins per warehouse or document 
interfaces, please contact the Eshbel support staff. 
4. Upgrading Priority Lite and/or Priority Rich 
4.1 Preliminary Instructions 
 If you previously worked in the Silverlight interface (in Version 15): As of 
Version 16, Priority's web-based interface is HTML5 compliant, and may be 
run in any web browser; we recommend Chrome. 
If you choose to use Internet Explorer, version 9 or higher is required. 
 Make sure that .NET Framework 4 (or higher) has been installed on the 
application server.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
4/6 Ver.07 Cat.No. LB130092  
 
 Priority Lite users: reinstall the Priority Lite package. 
 If IIS is installed on the workstation, run the Update Priority Executables 
program from Start > All Programs > Priority. 
4.2 Installing Priority Rich/Lite (application server) 
1. Enter Priority as the tabula superuser and run the Install Application Server 
program (menu path: System Management > System Maintenance > Internet 
Definitions > Application Server Maintenance). 
2. In the Install Options input screen, choose the relevant option:  
 If you work with the Priority Lite package and the Windows interface, select 
Priority Lite only. 
 If you work with the Priority Rich interface, select Priority Lite+Rich. 
Notes: 
 After performing the upgrade, users should be instructed to enter the system by 
means of the Web Site URL that is designated when running the Install 
Application Server program. It is recommended that users add this URL to their 
list of Favorites, instead of the one that was used previously. 
 For additional details, see the Installing the Application Server document, 
available in the Customer Service Area on the Eshbel web site. This document is 
also relevant if you did not work with the Silverlight interface but would like to 
work with the HTML5 interface. 
5. Word Templates – Important Notes 
As a result of changes made by Microsoft, certain changes had to be made to Priority 
version 16 regarding MS-Word templates. 
 In Priority version 16, users will no longer be able to edit Word templates created in 
previous versions of Priority. Any user who attempts to open a previously defined 
template will receive the message "Design of this template is no longer supported". 
 Users may define new Word templates using: 
o Word 2013 
o Word 2007/2010 with an add-on. The add-on may be downloaded from 
http://xmlmapping.codeplex.com/. 
Please note: This add-on has not been written by Microsoft or Eshbel. 
 Word templates created in earlier versions of Priority may be used (but not edited) 
in Office 2010 and below. 
 To design or use new Word templates, make sure that .NET Framework 4.0 is 
installed on the workstation on which Priority's Windows interface is installed. 
 In Priority Rich version 16, Word templates may be sent via e-mail, even if Office is 
not installed on the workstation from which it is being sent. To display or print the 
document, Office must be installed. 
 In Priority's Windows interface, Office must be installed on all workstations that use 
Word templates.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
5/6 Ver.07 Cat.No. LB130092  
 
6. Important Notes 
 As of version 12, Priority supports documents in HTML format only. Customers 
with customizations involving documents in the old format are requested to switch 
to HTML format to prevent problems in producing the reports. Printouts in the old 
format will no longer be covered by service contracts. 
 If users connect to Priority via a terminal server, you must restart the terminal 
server after upgrading the system, log in as an administrator and enter Priority. 
 Users of the E-Documents module should run the Set Up PDF Document 
Signature program (menu path: Office Management > Mail). After running the 
program, you will no longer be asked to enter your password each time an e-
document is sent, and a copy will be saved as an attachment to the original for easy 
retrieval (i.e., you will no longer need to perform a synchronization in order to save 
a copy of the sent document). 
 In version 16, Priority has done away with the concept of a human resources 
company, and employee details may be viewed and revised from any company. As 
such, customizations involving the Personnel File may require adjustment.  
The upgrade program checks for customizations to the Personnel File and its sub-
level forms. If adjustments are required, you will receive a message in the error 
report that appears at the conclusion of the upgrade.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
6/6 Ver.07 Cat.No. LB130092  
 
Appendix: Upgrading without Internet Access on the 
Application Server 
Download License File 
1. On a workstation with Internet access, enter the Customer Service Area on the 
Eshbel web site and click Download License File. 
2. In the page that opens, log in using the e-mail address and password of a contact 
that is authorized to enter the Eshbel web site. 
3. In the next page that opens, right-click the download link and save the license file to 
the server. 
4. From the server, double-click the saved license in order to execute the file. 
5. Once the file finishes running, a report appears. Check the last line of this report to 
ensure that your license to run upgrades is currently valid. 
Install the License File 
1. To obtain an upgrade file, contact the Eshbel support staff. 
2. Before installing the upgrade, take the preliminary steps outlined in sections 1 
(backing up the system), 2 (upgrading on the test server) and 3.1 (preliminary 
instructions) of this document. 
3. To install the upgrade, log into the server and double-click the file in order to run the 
upgrade. 
4. When the upgrade finishes running, make sure you have received the upgrade 
completion message, which reads: "Priority upgrade succeeded". If this message 
does not appear, or if the screen displays an error message, attach the relevant error 
report to the service call, and refrain from using Priority until you receive instructions 
from the Eshbel support staff. 
5. Continue with the instructions appearing in this document, starting with section 4.
