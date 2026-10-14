# 17-Installing the Search Service

- **Source:** `17-Installing the Search Service.pdf`

www.priority -software.com   
1/3 ‏July 02,'15 Ver.04 Cat.No. LB140212 
 
 
SOP: Installing the Search Service* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To install, set up and maintain the Priority Search Service, making it available to users in the 
Priority Rich Interface as a means to rapidly locate records in a variety of documents. 
Important Note:  
 The following instructions are to be carried out by a user with Administrator permissions on the 
workstation, after logging in as the Priority superuser (tabula). 
Setup 
 On the computer in which the application server is installed (usually, the Priority server), make 
sure the Java SE Runtime Environment is installed. If not, install it in keeping with instructions at 
www.java.com.  
 Make sure that Microsoft .NET Framework 4.5 or higher is installed on the computer in which the 
application server is installed. 
Procedure 
Stage I: Installing the Search Server 
Notes:  
 The search server is to be installed on the computer in which the application server is 
installed, on a local drive (e.g., C:\). 
 The search index requires 1 GB of data storage for every million documents and another 1 
GB of data storage for every 100,000 attachments. 
1. Log in as Administrator, either on the server or remotely via CONSOLE.  
2. Enter Priority as the tabula user and run the Install Search Server program. 
3. Specify your Windows Username. 
4. In the Password column, designate your Windows password. 
5. In the Installation Folder column, indicate the directory on which to install the search server. 
Note: Select a local drive and not a network drive. 
                                                
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 ‏July 02,'15 Ver.04 Cat.No. LB140212 
 
Result: The Priority Search Service is installed.  
Stage II: Activating the Priority Search Service 
 Run the Activate Search Service program. 
Result: The Priority Search Service is defined as active in the list of services on the computer on 
which the search server was installed.  
Stage III: Creating the Search Index 
Aim: To define indexing parameters and to create the index. 
1. Run the Set Start Date for Search program, indicating the date from which to include documents 
in the index. 
2. Enter the Document Types in Search form. 
3. Move to the document type you wish to be included in the index and flag the Include in Search 
column. 
Note: Sub-level text forms and attachments are automatically included in the index for all 
flagged document types. 
4. Enter the sub-level Columns to Search form. 
5. Flag the Search column next to any form columns to be included in the index. For instance, for a 
Sales Order, flag the Search column on the Contact line to have the search locate sales orders 
whose recorded contact matches the user-designated search string. 
Note: The document number is always included in the search. 
6. Flag the Autocomplete column next to the (single) form column you wish to be used to provide 
autocomplete suggestions. For instance, if the Customer Name is flagged as Autocomplete for 
a Sales Order, when the user types "Med" in the search bar, displayed suggestions will include 
all orders by customers whose names include that string. 
Note: The document number always serves as an autocomplete column, in addition to the 
flagged form column.  
7. Enter the File Types in Search form and make sure the file types you want to include in the 
search index appear. Remove any file type to exclude it from the index and/or add file types to 
be included. The system will search text files (including PDFs), as well as the metadata of other 
files, such as the file name of JPEGs. File types are limited to the list found here. 
8. Run the Build Search Index program. 
Result: The search index has been created, including the data in the selected document types and 
columns. 
Stage IV: Updating the Search Index Automatically 
Aim: To schedule incremental updates of the index on a regular basis, using the Tabula Task 
Scheduler. 
 Include the task that updates the search index in the Tabula Task Scheduler, with appropriate 
definitions. In addition to defining scheduled frequency and company, record PRISINDE 1 in the 
command line. 
Tip: For details on using the Tabula Task Scheduler, see the appropriate document in the 
Documentation Library, under Downloads in the Priority Customer Zone. 
Note: To build the index from scratch, manually rerun the Build Search Index program, flagging the 
Rebuild column.

www.priority -software.com   
3/3 ‏July 02,'15 Ver.04 Cat.No. LB140212 
 
Result 
The search setup is complete. Users in the Priority Rich Interface can search documents in the 
system. 
Note: For details on running a search, refer to the User Interface Guide (accessed from the Help 
menu).
