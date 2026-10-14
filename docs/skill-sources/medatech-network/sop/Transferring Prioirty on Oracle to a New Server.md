# Transferring Prioirty on Oracle to a New Server

- **Source:** `Transferring Prioirty on Oracle to a New Server.pdf`

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
1/3 Ver.08 Cat.No. A5000273  
 
 
Transferring Priority on Oracle to a New Server 
Introduction 
The following instructions can be used for a number of related purposes: 
 to transfer the server to a different computer 
 to transfer data to a test server 
 to recover backup files to a new server if the old one cannot be used. 
Note: They can also be used to install Priority on a new drive in the existing server. 
However, in that scenario, some of the steps are slightly different. For details, see the 
last section of this document. 
Before you begin 
 Make sure the target computer is running properly and connected to the network. 
 Make sure all users exit Priority.  
 Ensure that the following are on the target computer: (1) backup capabilities; (2) remote 
support capabilities (for details, see the Priority: Hardware and Support Systems 
document; download available from the Customer Area on 
http://www.eshbel.com/customerarea.htm). 
 Download the appropriate installation file from the Customer Area. 
Transferring the system 
1. Install Priority on the new server; its home directory will hereafter be referred to as 
x:\priority (for assistance, see the Installing Priority 12 (Oracle) document). 
2. Have the Database Administrator (DBA) replace the database created during the 
installation process with the original database. 
3. Make a backup copy of the file: x:\priority\system\srvpath in a different directory (not 
under x:\priority). This file stores data on the location of the server and the mapping 
of Priority files. 
4. Delete the entire contents of the x:\priority directory and copy the contents of the priority 
directory in the old server to x:\priority. (The deletion is highly important; you must not 
copy new data onto old data.) 
Notes:  
 In the case of recovery in a new server, or if you are setting up a test server, copy 
the contents of your backup tape to x:\priority. 
 You must copy the entire priority directory – do not attempt to transfer only part 
of the data.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
2/3 Ver.08 Cat.No. A5000273  
 
5. Copy the tabula.ini file from the Windows directory of the source computer to that of 
the target (generally in c:\Windows or c:\WinNT). 
6. Copy the backup file for srvpath (see step 3) back under x:\priority\system. 
7. Open the tabula.ini file in Notepad and do the following: 
 Make sure the Priority Directory is x:\priority\system\prep. 
 Check that the name of the server (Tabula Host) corresponds to the 
correct Oracle Connection String on the new server (consult the DBA for 
this information). 
 Revise and save the file, as necessary. 
8. While in Notepad, open the srvpath file in the x:\priority\system directory and do the 
following: 
 Make sure the first line contains the correct path to the Priority directory 
(e.g., c:\priority). 
 Make sure the third line contains the correct Oracle Connection String on 
the new server (see step 7 regarding Tabula Host). 
 Revise and save the file, as necessary, and exit Notepad. 
9. If the target computer has been used as a Windows terminal server and had a 
previous installation of Priority on it, it is possible that the tabula.ini file has been 
copied into the terminal users’ home directories (e.g., c:\Documents and 
Settings\John_Smith). If this is the case, you should find and delete all these files, so 
the tabula.ini file you have just corrected will be copied again (the file is copied 
automatically by Windows when the user enters Priority for the first time). 
10. Define appropriate Windows permissions to Priority’s program files on the new 
server. For details (and other installation information), see the relevant installation 
instructions document (download available from the Customer Area on 
http://www.eshbel.com/customerarea.htm). 
11. Perform a system check of Priority by generating a few reports. These checks are 
designed to detect missing information or any other problems with document 
numeration: 
 Check J. Entry No. Continuity (menu path = Financials  General 
Ledger  Financial Statements  Auxiliary Reports) 
 Check Finance Doc No. Continuity (same menu path; run the report for 
the most commonly used document in your system) 
 Document No. Continuity Check (menu path = Inventory  Inventory 
Maintenance; again, run this report for the most commonly used 
document in your system). 
12. If there are Priority companies that were not transferred as Oracle tablespaces (e.g., 
practice sites), delete these companies by running the Delete Company program in 
Priority (menu path: System Management   System Maintenance   Companies). 
Please ask your DBA to determine which companies have been transferred. 
13. To prevent unintentional use of the old server, if it is still connected to the network, 
change the name of its priority directory and disconnect the old server from network

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
3/3 Ver.08 Cat.No. A5000273  
 
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
 Before step 2: Before installing Priority on the new drive, make a backup copy of 
the tabula.ini file, as this file will be revised as a result of the reinstallation.  
 Instead of step 5: After the installation, use Notepad to revise the tabula.ini file. 
Specifically, restore the lines from the backup file for: Organization, License and 
Concurrent Users. Remember to also check the Priority directory and the host 
server (see step 7).
