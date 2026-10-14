# Installing the Search Service

- **Source:** `Installing the Search Service.pdf`

Medatech UK Ltd 
Anchor House, School Lane, 
Chandlers Ford 
Hampshire 
SO53 4DY 
Tel.: +44 2380 460 400 
Fax: +44 2380 261 078  
 
                                                                    
 URL: http://www.medatechuk.com   
                                                                             E-mail: info@medatechuk.com  
 
 
  
 
. 
 
 
 
 
Installing the Search Service 
Checks 
1. On the IIS server, make sure Java is installed. Make a note of the location of the java.exe file e.g.: 
C:\Program Files\Java\jre-1.8\bin\java.exe 
 
 
2. Make sure there is enough space on the C drive (we only need a couple of GB, so just check it’s not about to fill up!). 
 
3. Check with the customer what document types they want to be able to search for or whether they want the defaults: 
System Management > System Maintenance > Search > Search Definitions > Document Types in Search 
 
4. Check with the customer which companies they want to be able to search in. 
 
Install the service 
Note: you can skip this step if the service is already installed, though there is no harm reinstalling it. 
 
1. On the IIS server, run Priority as administrator

Medatech UK Ltd 
Anchor House, School Lane, 
Chandlers Ford 
Hampshire 
SO53 4DY 
Tel.: +44 2380 460 400 
Fax: +44 2380 261 078  
 
                                                                    
 URL: http://www.medatechuk.com   
                                                                             E-mail: info@medatechuk.com  
 
 
  
 
. 
 
 
 
 
 
2. Run System Management > System Maintenance > Search > Install Search Server 
Enter the Windows username, including the domain, the password for the Windows account, and the location of the 
java.exe file (you should have note of this from earlier or you can search using the file explorer). The installation folder 
location should be populated: 
 
 
 
You can check the service was installed by opening Services: 
 
 
3. In Priority, run System Management > System Maintenance > Search > Activate Search Service to start the service.

Medatech UK Ltd 
Anchor House, School Lane, 
Chandlers Ford 
Hampshire 
SO53 4DY 
Tel.: +44 2380 460 400 
Fax: +44 2380 261 078  
 
                                                                    
 URL: http://www.medatechuk.com   
                                                                             E-mail: info@medatechuk.com  
 
 
  
 
. 
 
 
 
 
Extra Steps if Priority is on Two Servers 
 
1. Open the tabula.ini file on both the SQL and IIS server. You should find a section for [PriSearch] e.g. 
 
Underneath this, add Host=WEBSERVERNAME where WEBSERVERNAME is the name of the web server e.g. 
 
Note: if you make any changes to the tabula.ini, afterwards check all the services are running (e.g. TTS) and check you can 
login to client 
 
2. Check PORT 8983 on the web server is open (https://www.alphr.com/how-to-check-which-ports-open-windows-10-
pc/) 
 
Creating the Index 
1. If the customer wants to be able to search on specific documents and fields, first tick the relevant documents and fields 
in the following form: System Management > System Maintenance > Search > Search Definitions > Document Types in 
Search 
Note: it is not necessary to select “Document Number” as this is always searchable. So are attachments and text sub-level 
forms. 
 
2. Run System Management > System Maintenance > Search > Search Definitions > Initialise Search Definitions

Medatech UK Ltd 
Anchor House, School Lane, 
Chandlers Ford 
Hampshire 
SO53 4DY 
Tel.: +44 2380 460 400 
Fax: +44 2380 261 078  
 
                                                                    
 URL: http://www.medatechuk.com   
                                                                             E-mail: info@medatechuk.com  
 
 
  
 
. 
 
 
 
 
 
Choose a start date (you will only be able to search for documents created after this date). 
Tick Default Documents, unless you have manually chosen documents as described above. 
 
3. Switch language to American English: 
 
 
Exit and re-enter Priority (as administrator again). 
 
4. Run System Management > System Maintenance > Search > Build Search Index 
Note: It is necessary to run this while logged in the system in American English

Medatech UK Ltd 
Anchor House, School Lane, 
Chandlers Ford 
Hampshire 
SO53 4DY 
Tel.: +44 2380 460 400 
Fax: +44 2380 261 078  
 
                                                                    
 URL: http://www.medatechuk.com   
                                                                             E-mail: info@medatechuk.com  
 
 
  
 
. 
 
 
 
 
Tick “Rebuild”: 
 
Repeat steps 2 and 4 in all companies you are setting up the search for. 
 
5. Change the system back to British English: 
 
 
 
Exit and re-enter Priority. 
 
Note: Don’t skip this step. It will affect user’s functionality and the TTS tasks if you don’t set the system back to British 
English.

Medatech UK Ltd 
Anchor House, School Lane, 
Chandlers Ford 
Hampshire 
SO53 4DY 
Tel.: +44 2380 460 400 
Fax: +44 2380 261 078  
 
                                                                    
 URL: http://www.medatechuk.com   
                                                                             E-mail: info@medatechuk.com  
 
 
  
 
. 
 
 
 
 
Updating the Index Automatically 
1. Open the Define TTS Tasks form: System Management > System Maintenance > Tabula Task Scheduler > Define TTS 
Tasks 
 
2. Add a task (or find if it already exists) with the command WINACTIV -P SEARCHINDEX. You can give it the description 
“Build search index”. 
 
3. Set a start time (if necessary), a frequency and tick the “every day” tick box. 
 
4. In the “Language” field, choose “American English”. 
Note: build search index only works in American English  
 
5. Tick “Active”. 
 
6. In the “Companies for task” sub-level, list all the companies you activated the search for.
