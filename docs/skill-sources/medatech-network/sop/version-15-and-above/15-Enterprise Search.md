# 15-Enterprise Search

- **Source:** `15-Enterprise Search.pdf`

Cat.No. LB110566 1 Ver.3 – Dec. 11,’12 
 
SOP: Enterprise Search * 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To install the Enterprise Search Server (based on the Microsoft Search Server) and to 
set up, maintain and run the Enterprise Search tool. This tool performs full text search 
by keyword for all documents and attached files in the system. 
Important Notes: 
 It is recommended that you read through these instructions once before beginning 
this procedure. 
 Installation and initial setup of the Enterprise Search Server should be performed by 
the System Manager only. 
 The Enterprise Search Server can be used with Priority installations on an MS-SQL 
or Oracle database only. 
 Priority's Enterprise Search Server can run on an existing search server installation 
(i.e., Microsoft Search Server 2008, Microsoft Search Server Express 2008 or 
Microsoft Sharepoint Server 2007) or on a new installation of Microsoft Search Server 
Express, which is provided as part of the Enterprise Search Server installation 
process (see below). 
 The Enterprise Search Server can be installed on Windows Server 2008 or Windows 
Server 2008 R2 only. 
Setup 
 Ensure that you have received and installed the license for Priority’s Enterprise 
Search module. 
Procedure 
Note: If you have already installed Microsoft Search Server or Microsoft Sharepoint 
Server, skip this stage and continue to Stage II. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Stage I: Installing the Enterprise Search Server & Microsoft Search 
Server 
Note: It is recommended that you install the Enterprise Search Server on a separate 
machine (one which meets the same hardware and OS requirements as the Priority 
server), rather than on the Priority server itself. 
1. Log in as Administrator, either on the server or remotely via CONSOLE. 
2. Enter Priority as the tabula user and run the Install Enterprise Search Server 
program. 
3. In the Installation Method column, choose whether to install the Search Server 
using an installation package that was downloaded previously or download and 
install Microsoft Search Server Express now. 
4. If you chose to install the Search Server using an installation package that was 
downloaded previously, specify the name and path of the saved Installation File in 
the next input screen. 
Tip: Press F6 to browse to the file. 
5. In the Installation Folder column, indicate the directory on the server in which to 
install the Search Server. 
6. In the Windows Password column, specify the Windows password of the 
Administrator user.  
Note: The Enterprise Search Server will use the permissions of this user to access 
the database and provide other services. 
7. Continue to Stage III. 
Stage II: Installing the Enterprise Search Server over an Existing 
Microsoft Search Server Installation 
Note: This process is also used to modify an existing Enterprise Search Server 
installation (e.g., when you change the Windows password of the Administrator user or 
when a new service pack is released). 
1. Log in as Administrator, either on the server or remotely via CONSOLE. 
2. Enter Priority as the tabula user and run the Install Enterprise Search Server 
program. 
3. In the Installation Method column, choose "Update existing installation definitions". 
4. In the Search URL column, specify the URL of the Search Center site, as recorded 
during installation of Microsoft Search Server (or Microsoft Sharepoint Server).  
Note: This site provides access to pages from which you can configure search 
settings and access reports reflecting search usage and results. 
5. In the Administration URL column, specify the URL of the Administration site, as 
recorded during installation of Microsoft Search Server (or Microsoft Sharepoint 
Server). 
Note: This site is used to check the status of the Search Server, configure and 
manage indexing and searching and view detailed query reports. 
6. In the Installation Folder column, indicate the directory on the server in which to 
install the Search Server. 
Cat.No. LB110566 2 Ver.3 – Dec. 11,’12

Stage III: Creating a Search Index for Enterprise Search 
Aim: To define indexing parameters and to create a full index of all system data that falls 
within these parameters.  
1. Enter the Doc. Types in Enterprise Search form and flag the types of documents to 
be included in the search index used by the Enterprise Search program. 
2. Run the Set Start Date-Enterprise Search program and specify the date from which 
to maintain the search index. Only those documents and attachments that were 
recorded on or after this date will be crawled, indexed and made discoverable by the 
Enterprise Search program. 
3. Run the Create Search Index program. 
Note: This program must also be run any time you need to rebuild the search index 
from scratch (e.g., after modifying indexing parameters or restoring the system from 
a backup). 
Stage IV: Maintaining the Enterprise Search Server 
 To schedule incremental updates of the search index, run the Schedule Search Index 
Update program and specify the Hour at which to update the search index and the 
Weekday on which to schedule the update. The Update Search Index program will 
run automatically on the specified day and time. 
Note: Select "Daily" to schedule an update every day of the week. 
 To check the current status of the search server (e.g., to check whether the indexing 
process is currently running in the background), run the Check Search Server Status 
program. 
Stage V: Running a Search 
1. Run the Enterprise Search program. 
Notes: 
 If you work with the Windows interface, you can also click the 
  icon in the menu 
or form toolbar or select Run Enterprise Search from the upper Tools menu. 
 If you work with the Silverlight interface, you can click the 
  icon in the menu or 
form tool tray or select Run Enterprise Search from the upper Run menu. 
2. In the screen that appears, specify the appropriate search criteria and click OK. 
Note: For more information on running a search using the Enterprise Search program, 
see the User Interface Guide (accessed via the upper Help menu). 
Cat.No. LB110566 3 Ver.3 – Dec. 11,’12
