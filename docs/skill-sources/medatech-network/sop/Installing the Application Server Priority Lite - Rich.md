# Installing the Application Server Priority Lite - Rich

- **Source:** `Installing the Application Server Priority Lite - Rich.pdf`

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
1/12 Ver.06 Cat.No. LB110469 
 
 
Installing the Application Server                               
(Priority Lite/Rich) 
This document provides instructions for the installation of the Priority Lite and Priority 
Rich application server on a corporate Intranet and Internet; the installation of IIS; and in 
the case of an Intranet, the installation of the required self-signed SSL certificate. In either 
case, IIS must first be installed. In the case of an Intranet installation, you must then install 
a self-signed SSL certificate on IIS, followed by the installation of the application server. In 
Internet installations, after installing IIS, skip to section ‎4 to install the application server. 
1. Prerequisites 
Hardware Requirements 
For information on the hardware and supporting systems required for this installation, 
please see the Priority: Hardware and Supporting Systems document, available from 
the Customer Area on the Eshbel web site (http://www.eshbel.com/customerarea.htm), on 
the Priority Documentation page (topic = Installations (Doc.)). 
Additional Requirements 
Server: 
Intranet Installation (self-signed certificate) 
 Operating systems: 
Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, Windows 
7. 
Internet Installation (CA certificate) 
 Operating systems: 
Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, Windows 
Server 2008 R2, Windows Server 2012, Windows 7. 
 A static IP address for your server, purchased from your Internet Service Provider. 
 Ports 80 and 443 forwarded to your internal server address. 
 A domain name. Domain names may be purchased from www.godaddy.com, or 
other domain name providers. 
 Create a DNS A record administered by the domain for the server. 
 An SSL certificate purchased from a Certificate Authority (e.g., www.godaddy.com, 
www.sslmatic.com) with identical information to the A record in the DNS registration. 
Note: For instructions on acquiring and installing the SSL certificate, please refer to 
the Certificate Authority. 
Existing Customers: The Rich interface requires you to work with named user licenses or 
with Priority Rich user licenses, which allow you to continue working with concurrent users. 
To view the types of licenses with which you are currently working, do the following:

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
2/12 Ver.06 Cat.No. LB110469 
 
1. Run the View License Details report (menu path: System Management > System 
Maintenance > Software License). 
2. In the window that opens, make sure you see a row for Total named users. If this 
line does not appear, please contact the Eshbel sales department for more 
information about acquiring the necessary licenses. 
Workstations: 
 Priority Rich is supported on the following browsers: 
o Internet Explorer version 9 or higher 
o Google Chrome version 22 or higher 
o Mozilla FireFox version 15 or higher 
2. Installation of IIS 
In order to install the Priority application server, IIS must first be installed. Before 
beginning the installation, ensure that the IIS is for the sole use of Priority. If installing IIS 
on Windows 7, skip to page 4. 
On Windows Server 2008 and higher, perform the following: 
1. Open the Server Manager, and choose Roles > Add Roles: 
 
2. Choose Server Roles > Web Server (IIS).

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
3/12 Ver.06 Cat.No. LB110469 
 
 
 
3. In the Select Role Services dialogue box, flag the following options: 
 Static Content 
 Default Document 
 ASP.net 
 ASP 
 IIS6 Management Compatibility 
a. IIS 6 Metabase Compatibility 
b. IIS 6 WMI Compatibility 
c. Scripting Tools 
d. Management Console 
4. Click Next. In the dialogue box that opens, choose Add Required Role Services. 
 
After clicking Add Required Role Services, additional services will be automatically 
selected:

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
4/12 Ver.06 Cat.No. LB110469 
 
 
 
To work on a Windows 7 workstation acting as a server: 
1. Select: Control Panel > Programs and Features > Turn Windows Features On or 
Off, and verify that the following options are selected: 
 
2. Install Microsoft.Net 4 via the Microsoft web site.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
5/12 Ver.06 Cat.No. LB110469 
 
If installing the application server on an Intranet, continue with section ‎3 to first install the 
self-signed SSL certificate. Otherwise, proceed directly to section ‎4. 
3. Installing a Self-Signed SSL Certificate (Intranet) 
IIS Server: 
1. Open the IIS management tools: 
Start > Control Panel > Administrative Tools > Internet Information Manager (IIS). 
2. Choose Server Certificates. 
 
3. Choose Create Self-Signed Certificate. 
4. Record a friendly name (nickname) for the certificate, and click OK.  
 
5. Move to the Default Web Site, select Bindings, and c lick Add.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
6/12 Ver.06 Cat.No. LB110469 
 
 
 
6. The Add Site Binding dialogue box will open. Under Type, choose https. In SSL 
certificate, choose the certificate that you created previously, then click OK and 
finally Close. 
 
Workstations 
Please note: The examples below are based on Internet Explorer. If you are using another 
supported browser, please perform similar steps for your browser. 
1. Open your web browser, and navigate to the site for Priority. When the error 
message appears, select “Continue to this website (not recommended).” 
 
2. In the address box in the browser, click Certificate error.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
7/12 Ver.06 Cat.No. LB110469 
 
 
3. Select View certificates. 
 
4. Click Install Certificate. 
 
5. Choose: Next > Place all certificates in the following store > Browse > Trusted 
Root Certification Authorities > OK > Next > Finish.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
8/12 Ver.06 Cat.No. LB110469 
 
 
6. When you receive the warning message, click Yes then OK. 
 
4. Installing the Application Server (Intranet & Internet) 
1. Log in to the application server as a member of the administrator group.  
2. Start Priority by right-clicking on the desktop shortcut, and clicking Run as 
administrator. 
 
3. Run the Priority client on the Application Server as the tabula user.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
9/12 Ver.06 Cat.No. LB110469 
 
4. Run the Install Application Server program from the menu path: System 
Management  System Maintenance  Internet Definitions  Application Server 
Maintenance. 
5. A Parameter Input dialogue box opens. 
 
 Specify the Windows Login of a user with system manager privileges and the 
corresponding Password. 
Note: The Application Server will use the permissions of this user to access the 
database and provide other services. 
 In the Web Site URL column, record the URL as defined for the SSL Certificate 
(see above). This URL will be used to run Priority. 
 Make certain that the In Hosting Framework column is not flagged. 
6. Click OK. The Install Options window opens. 
                  
          
7. Choose whether to install Priority Lite only, or with Priority Rich, and click 
OK. The Priority Internet Setup window opens.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
10/12 Ver.06 Cat.No. LB110469 
 
 
IIS Options 
a. Record the number of minutes you are willing to wait for Priority to respond (it 
is recommended that you leave the default value). 
b. Record the path of the HTML page containing the error message that you 
defined for when the system does not respond. 
c. Flag the It supports the https protocol (SSL) checkbox. 
Note: It is recommended that you use a secure https protocol, as explained 
above. 
d. If the current Application Server will be used to provide access only via your 
organization's internal network (Intranet), flag the Intranet Only checkbox. 
Otherwise, leave this checkbox empty to enable access over the Internet. 
 
Priority Options 
a. Record the appropriate Password for the tabula user. The name and password 
of the Windows user will be filled in automatically. 
b. Record the number of minutes that the engine between IIS and Priority should 
run without activity. 
Note: Whenever a customer/vendor or company user enters the site and 
establishes a connection with Priority, an engine is opened between IIS and 
Priority. For every new user entry, an additional engine is activated. When the 
user leaves the site, the connectivity engine becomes inactive; after a few 
minutes, it closes down. 
c. Record the path of the HTML page containing the error message that you 
defined for when the licenses run out.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
11/12 Ver.06 Cat.No. LB110469 
 
8. Click OK. You will receive a message that the installation finished successfully: 
Note: If you are installing Priority Rich, you will be asked to enter the tabula 
password. 
5. Running Priority Lite and Priority Rich for the First 
Time 
Priority Lite 
Enter Priority Lite from the following url: 
https://[Your Server Name] 
/priority/prihtml.dll?WWWIPHONE&_portal=1&tabulaini=tabula.ini 
 
where [Your Server Name] is the name of the server as recorded on the SSL certificate.  
 
Alternatively, you can send users a link to Priority Lite by running the Send Link to 
Tablet/Smartphone program from menu path: 
System Management  System Maintenance  Users. 
Installing Priority Rich on a Client 
Important! To install this application on a local client or to run it for the first time, you must 
be logged in to Windows with an administrator-level account. 
 Open a supported browser to the URL address that you defined earlier (step 5 of 
section 4), and follow the instructions that appear on the web page that opens. 
Notes:  
 A password must be defined for each user before he or she can log in to Priority. 
 When installing Priority on old workstations, there may be a problem verifying the SSL 
Certificate. In such a case, access 
http://www.microsoft.com/download/en/search.aspx?q=kb931125 and follow the 
instructions suitable for the version of Windows running on the workstation in question.  
6. Setting Up Synchronization with Gmail 
The following is meant for the Google Apps domain administrator when your organization’s 
mail is based on Gmail, so that users may synchronize Priority with Gmail. 
Follow the instructions found at the following address: 
https://developers.google.com/google-apps/extensions-console/?hl=iw-IL 
Please note the following: 
1. The manifest.xml and extractor.xml files are located in the IIS/priority/google 
directory on your server. 
2. You must upload the extractor, even though the Google Apps instructions say it's 
optional. 
3. End with the section labeled Installing the application in your domain.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
12/12 Ver.06 Cat.No. LB110469 
 
 
When the process is completed, users who enter Gmail through your mail domain will see 
the following button, which allows them to synchronize with Priority:
