# Transferring Priority on Tabula to a New Server

- **Source:** `Transferring Priority on Tabula to a New Server.pdf`

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
1/3 Ver.10 Cat.No. A2000011  
 
 
Transferring Priority on Tabula to a New Server 
Introduction 
The following instructions can be used for a number of related purposes: 
 to transfer the server to a different computer 
 to transfer data to a test server 
 to recover backup files to a new server if the old one cannot be used. 
Notes:  
 They can also be used to install Priority on a new drive in the existing server. However, 
in that scenario, there is a slight variation in the instructions. For details, see the last 
section of this document. 
 The process described below should only be performed by someone who has the 
necessary technical knowledge. 
Before you begin  
 Make sure the target computer is running properly and connected to the network. 
 Ensure that the following are on the target computer: (1) backup capabilities; (2) 
remote support capabilities (for details, see the Priority: Hardware and Support 
Systems document; download available from the Customer Area on 
http://www.eshbel.com/customerarea.htm). 
 Download the appropriate installation file from the Customer Area. 
Transferring the system 
1. Have all users exit Priority. Shut down the Tabula Server from within Services 
(usually under Administrative Tools in the Control Panel). 
2. Create a backup copy of the tabula.ini file from the old server (generally in 
c:\Windows or c:\WinNT). 
3. Run the Recovery program on the old server to ensure that the system is running 
properly prior to the transfer: 
 Run the program: Start > Programs > Priority > Recovery. (Click Start.) 
 Make sure there are no error messages at the end of the run. If there are, do 
not continue without first consulting with Eshbel Technologies’ customer 
support. 
4. Install Priority on the new server; its home directory will hereafter be referred to as 
x:\priority.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
2/3 Ver.10 Cat.No. A2000011  
 
5. Make a backup copy of the file: x:\priority\system\srvpath in a different directory (not 
under x:\priority). This file stores data on the location of the server and the mapping 
of Priority files. 
6. Delete the entire contents of the x:\priority directory and copy the contents of the priority 
directory in the old server to x:\priority. (The deletion is highly important; you must not 
copy new data onto old data.) 
Notes:  
 In the case of recovery in a new server, or if you are setting up a test server, copy 
the contents of your backup tape to x:\priority. 
 You must copy the entire priority directory – do not attempt to transfer only part 
of the data. 
7. Copy the backup file for srvpath (see Step 5) back under x:\priority\system. 
8. Open the tabula.ini file in the new server (generally in c:\Windows or c:\WinNT) in 
Notepad. Using the same file from the old server (see step 2), copy the following 
lines into the current file: Organization, License and Concurrent Users. Save the file 
after making the changes. 
9. While in Notepad, open the srvpath file in the x:\priority\system directory and do the 
following: 
 Make sure the first line contains the correct path to the Priority directory (e.g., 
c:\priority). 
 Make sure the third line contains the name of the new server (see step 8 
regarding Tabula Host). 
 Revise and save the file, as necessary, and exit Notepad. 
10. If the target computer has been used as a Windows terminal server and had a 
previous installation of Priority on it, it is possible that the tabula.ini file has been 
copied into the terminal users’ home directories (e.g., c:\Documents and 
Settings\John_Smith). If this is the case, you should find and delete all these files, so 
the tabula.ini file you have just corrected will be copied again (the file is copied 
automatically by Windows when the user enters Priority for the first time). 
11. Define appropriate Windows permissions to Priority’s program files on the new 
server. For details (and other installation information), see the relevant installation 
instructions document (download available from the Customer Area on 
http://www.eshbel.com/customerarea.htm). 
12. After installation is complete and before working in Priority, rerun the Recovery 
program (this time on the new server): 
 Make sure the Tabula Server is closed (see step 1). 
 Run the program: StartProgramsPriorityRecovery. (Click Start.) 
 Make sure there are no error messages at the end of the run. If there are, do 
not open the Tabula Server without first consulting with Eshbel 
Technologies’ customer support. 
13. Once the Recovery runs without errors, open the Tabula Server from within 
Services (as in step 1).

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
3/3 Ver.10 Cat.No. A2000011  
 
14. Perform a system check of Priority by generating a few reports. These checks are 
designed to detect missing information or any other problems with document 
numeration: 
 Check J. Entry No. Continuity (menu path = Financials  General Ledger 
 Financial Statements  Auxiliary Reports) 
 Check Finance Doc No. Continuity (same menu path; run the report for the 
most commonly used document in your system) 
 Document No. Continuity Check (menu path = Inventory  Inventory 
Maintenance; again, run this report for the most commonly used document in 
your system). 
15. To prevent unintentional use of the old server, if it is still connected to the network, 
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
tabula.ini file for “Priority Directory,” “Priority RemoteRoot” and “TabulaHost” into the 
tabula.ini files of all remaining clients. 
Installing the Tabula Task Scheduler 
The tabula.tsk file holds definitions of all tasks in the Scheduler. Rather than manually 
redefining scheduled tasks in the new server, simply copy this file from the Windows 
directory of the old server to the same directory in the new server. 
Note: This is only necessary if you are using the new server as your main server. 
Transferring Priority from one drive to another 
Follow the above instructions (replacing “server” with “drive”), with the following addition: 
 After Step 8: Check that the line for "Priority Directory" contains the path 
x:\priority\data\company, where "company" is one of the companies in Priority 
(e.g. x:\priority\data\demo), and that the line for "Tabula Host" contains the correct 
server.
