# Hardware and Supporting Systems

- **Source:** `Hardware and Supporting Systems.pdf`

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
1/8 Ver.26 Cat.No. LB10000758  
 
 
 
Priority v16: Hardware and Supporting Systems 
Introduction 
The following provides minimal system configuration requirements for Priority with respect 
to three types of installations:  
 On-premise Priority Rich web-enabled (hereafter Web) 
 Hosted Priority Rich web-enabled (hereafter SaaS) 
 Client-server with Windows GUI (hereafter CS). 
The main portion of the document refers to three layers: 
 client layer 
 application layer 
 database layer. 
Notes: 
 In the SaaS installation, only requirements for the client layer are pertinent. 
 In Web installations, the application layer refers to Priority Rich and to Priority Lite. 
In CS installations, it refers only to Priority Lite.  
 Requirements for the database layer are identical for CS and Web installations. 
 Related information, relevant to all installations, is included at the end of the 
document. 
These requirements do not take into account requirements for other programs or systems 
supported by the server and/or workstations. The final configuration is determined by the 
needs of the organization and the scope of its activities, that is, the expected number of 
users/database size. To determine your optimal configuration, please consult your DBA. 
In order to prevent misunderstandings regarding areas of responsibility for the maintenance 
of hardware, operating systems and particularly the communications network, it is best to 
purchase all hardware, network installation and components (including cables, network 
server, terminals, network cards), operating systems and their configurations (including 
communication protocols, terminal operating systems, backup software, remote server 
access, printer/fax drivers, etc.) from a single supplier. 
All Priority systems (except SaaS installations) must include a testing environment (see 
requirements on p. 6), which is used to: 
 Check private customizations (developed either by Eshbel, an external programmer 
hired by the customer or the customer) before running them on the production 
environment 
 Periodically check the recovery procedure based on backups 
 Test new version upgrades before running them on the production environment.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
2/8 Ver.26 Cat.No. LB10000758  
 
Client Layer 
Web/SaaS Installations 
 Operating System: any Microsoft-supported Windows platform (with latest service 
pack installed). 
 CPU: Intel® Core™ i3 Processor or above.  
 RAM: 4 GB. 
 Network: 30 Mbps download, 3 Mbps upload. 
 Broadband width = 2 Mbps per user. 
 MS-Office 2007 or above, to populate Word documents (e.g., when using Word 
templates for check printing) and Excel spreadsheets and for Outlook 
synchronization.  
Note: Working with Word templates in Office 2007 and Office 2010 requires an add-
in to be installed. For more information, see the User Interface Guide. 
 Supported Browsers: Chrome, Firefox, IE9 or above. 
 ADSL: 1.5 Mbps download, 0.5 Mbps upload (SaaS only). 
CS Installation 
 CPU: Intel® Core™ i3 Processor or above. 
 RAM: 2 GB. 
 Hard Drive: 1 GB free volume. This includes room for both installation and swap files. 
 Network Card: Ethernet. 
 Operating System: any Microsoft-supported Windows platform (with latest service 
pack installed). 
 In the event a Terminal Server is installed, you can work via terminals. 
 MS-Office 2007 or above, to populate Word documents (e.g., when using Word 
templates for check printing) and Excel spreadsheets and for Outlook 
synchronization.  
Note: Working with Word templates in Office 2007 and Office 2010 requires an add-
in to be installed. For more information, see the User Interface Guide. 
 Internet Explorer 8 or above. 
Application Layer 
Web Installation (including Priority Lite)1 
 Operating System: Windows Server 2008 SP2 or above (with latest service pack 
installed). 
 CPU: Intel® Xeon® Quad Core. 
 RAM: 4 GB. 
                                            
1 In small production environments with less than 10 users, the Application Server can be on the same 
machine as the Relational DB Server.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
3/8 Ver.26 Cat.No. LB10000758  
 
 Network: 1 Gbps Ethernet Card – teamed or fail-over configuration. 
 Hard Drive: 40 GB (upgradeable). A RAID system with at least 3 disks is 
recommended. The hard disk can be divided into two partitions in order to prevent 
Priority and the operating system from competing for disk access. 
 IIS 
Note: If you are using Windows Server 2008, also install the following components: 
 ISAPI Extensions 
 IIS Management Console 
 IIS Management Script and Tools 
 IIS 6 Metabase Compatibility. 
 .NET Framework 4. 
 SSL Certificate: To apply for a certificate, please refer to an "SSL certificate 
authority." 
Tip: Use a Google search to locate one. 
CS Installation (Priority Lite only) 
 Operating System: Windows Server 2008 R2 or above (with latest service pack 
installed). 
 IIS 
Note: If you are using Windows Server 2008, also install the following components: 
 ISAPI Extensions 
 IIS Management Console 
 IIS Management Script and Tools 
 IIS 6 Metabase Compatibility. 
Database Layer 
Requirements vary for each database configuration. They hold for both Web and CS 
installations. 
SQL Server Standard, Enterprise or Workgroup Edition  
Up to 10 Users or 5 GB Data 
 SQL Server 2008 R2 with Service Pack 2, or above. 
 A single Intel® Xeon® Quad Core CPU (or a corresponding CPU from a different 
company) with the capability to add another processor to the motherboard. It is 
recommended to use 64-bit processors (upgradeable1). 
 RAM: 4 GB (upgradeable2). 
 Disks: Two disk arrays. 
                                            
1 Consult with your DBA about the correct number of CPUs. 
2 Consult with your DBA about the possibility of expanding memory further.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
4/8 Ver.26 Cat.No. LB10000758  
 
 A RAID system that supports two arrays, with at least 256 MB memory, and a 
backup battery. 
 A 72 GB mirror array for the operating system and the database Log files. 
 An additional 72 GB mirror array for the database Data files. 
 Operating system: Windows Server 2008 SP2 or above (with latest service pack 
installed). 
 Backup Tape: In accordance with disk volume. 
 Ethernet Network Card. 
 CD-ROM Drive. 
 Uninterruptible Power Supply (UPS). 
 Remote support capabilities (see p. 8). 
Up to 50 Users or 15 GB Data 
 A dedicated server, that is, a member server in the domain that has no other task. 
 SQL Server 2008 R2 with Service Pack 2, or above. 
 Two Intel® Xeon® CPUs (or corresponding CPUs from a different company). It is 
recommended to use 64-bit processors (upgradeable1). 
 RAM: 8 GB (upgradeable1). 
 Disks: Two disk arrays. 
 A RAID system that supports two arrays, with at least 256 MB memory, and a 
backup battery. 
 A 72 GB mirror array for the operating system and the database Log files. 
 A 140 GB mirror or RAID 5 array for the database Data files. 
 It is recommended to use fast disks (15 KB RPM) and the SAS disk configuration. 
 Operating system: Windows Server 2008 SP2 or above (with latest service pack 
installed). 
 Backup Tape: In accordance with disk volume. 
 Ethernet Network Card. 
 CD-ROM Drive. 
 Uninterruptible Power Supply (UPS). 
 Remote support capabilities (see p. 8). 
Over 50 Users or 15 GB Data 
 A dedicated server, that is, a member server in the domain that has no other task. 
 SQL Server 2008 R2 with Service Pack 2, or above. 
 Two Intel® Xeon® CPUs at least Dual Core (or corresponding CPUs from a different 
company), with 64-bit architecture (upgradeable1). 
 RAM: 16 GB (upgradeable1). It is recommended to use a 64-bit system that supports 
greater memory allocation, resulting in a significant increase in performance. 
                                            
1 Consult with your DBA about the correct number of CPUs.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
5/8 Ver.26 Cat.No. LB10000758  
 
 Disks: At least two disk arrays (three are recommended). 
 A RAID system that supports at least two arrays, with at least 256 MB memory, and 
a backup battery. 
 A 72 GB mirror array for the operating system and the database Log files. 
 A RAID 5 system, at least 5 times larger than the expected size of the databases, for 
the database Data files. 
 An additional 72 GB mirror array for the database Log files. 
 It is recommended to use fast disks (15 KB RPM) and the SAS disk configuration. 
 Operating system: Windows Server 2008 SP2 or above (with latest service pack 
installed). 
 Backup Tape: In accordance with disk volume. 
 Network Card: A 1 Gbps Ethernet Card (make sure the switch also supports a speed 
of 1 Gbps). 
 CD-ROM Drive. 
 Uninterruptible Power Supply (UPS). 
 Remote support capabilities (see p. 8). 
Oracle (up to 50 users)2 
 Oracle Version: Oracle Standard Edition version 10 (10.2.0.4 or above) or Oracle 
Standard Edition version 11 (11.1.0.6 or above). 
 CPU: Intel® Xeon® Quad Core (upgradeable3). 
 RAM: 
 Up to 10 users – 4 GB (upgradeable4). 
 Over 10 users – 8 GB (upgradeable4). 
 Hard Drive: 6 X 40 GB disks (RAID 0+1).  
 Virtual Memory: Free space on the disk for Swap files. It is recommended to use 3 
times more volume than the RAM. 
 Operating System: You have three options -  
 Windows Server 2003 or above (with latest service pack installed). 
 Unix Server. 
 Linux Server. 
 Backup Tape: In accordance with the disk volume. 
 Network Card: Ethernet. 
 CD-ROM Drive. 
                                                                                                                                                   
1 Consult with your DBA about the possibility of expanding memory further.  
2 For over 50 users, consult with your DBA and Eshbel. 
3 Consult with your DBA about the possibility of using a second CPU. 
4 Consult with your DBA about the possibility of expanding memory further.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
6/8 Ver.26 Cat.No. LB10000758  
 
 Uninterruptible Power Supply (UPS). 
 Remote support capabilities (see p. 8). 
SQL Express (up to 10 users) 
 CPU: Intel® Core™ i5 Processor or above. 
 RAM: 3 GB. 
 Hard Drive: 40 GB (upgradeable). A RAID system with at least 3 disks is 
recommended. The hard disk can be divided into two drives in order to prevent 
Priority and the operating system from competing for disk access.  
 Virtual Memory: Free space on the disk for Swap files. It is recommended to use 3 
times more volume than the RAM. 
 Operating System: Windows Server 2008 SP2 or above, or Windows Vista 
SP2 or above (with latest service pack installed).  
 Windows Installer 4.5 (required for new installations of SQL Server 2012 Express). 
 Backup Tape: In accordance with the disk volume. 
 Network Card: Ethernet. 
 CD-ROM Drive. 
 Uninterruptible Power Supply (UPS). 
 Remote support capabilities (see p. 8). 
Testing Environment1 
Web/CS Installations 
 CPU: Intel® Core™ i5 Processor or above. 
 RAM: 2 GB. 
 Hard Drive: A disk at least 8 times the size of the SQL Data directory on the real 
server (for two instances of SQL – one for customizations and the other for periodic 
testing). It is recommended to use a fast disk. 
 Virtual Memory: Free space on the disk for Swap files. It is recommended to use 3 
times more volume than the RAM. 
 An operating system identical to that used on the real server (you can also use a 32-
bit processor with the corresponding operating system). 
 Ethernet Network Card. 
 CD-ROM Drive. 
 Remote support capabilities (see p. 8). 
 Supported Browsers: Chrome, Firefox, IE 9 or above (Web); IE 8 or above (CS). 
                                            
1 The testing environment must be on a different machine than the production environments . There is no need 
for a special workstation for the testing environment.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
7/8 Ver.26 Cat.No. LB10000758  
 
Remote Terminals 
Web/CS Installations 
Server for Remote Terminals (if required) 
 Installation of Windows 2008 Terminal Server. 
 CPU: Intel® Xeon® Quad Core. 
 RAM: 2 GB per user (upgradeable1). 
 Hard Drive: 40 GB. 
 Virtual Memory: Free space on the disk for Swap files. It is recommended to use 3 
times more volume than the RAM. 
 Network Card: Ethernet. 
 CD-ROM Drive. 
 Supported Browsers: Chrome, Firefox, IE 9 or above (Web); IE 8 or above (CS). 
Direct Connection to Remote Terminals 
 The central Priority server can connect directly with remote terminals using leased 
lines. The configuration of the leased lines is determined by the required bandwidth 
and the number of remote users. 
 Remote users connect directly to central terminal servers. The number of required 
terminal servers is a function of the number of remote users (about 15-20 users per 
server; it is best to consult with your technician when installing the servers). If there 
is more than one terminal server, it is recommended that a system be installed to 
balance the load, so as to optimize response times. 
 The remote workstations are run in the same manner as Windows 2008 Terminal 
Server, with the addition of Metaframe, if necessary.  
Printers 
Printers are set up within the operating system independently of the Priority system (the 
system makes use of Microsoft Print Manager as it does other Microsoft software). No 
adaptation of the software is necessary, and the set up is done on the level of hardware 
and infrastructure only. 
Printers that are activated by Windows stations print in graphic mode (it is not 
recommended to use a slow non-graphic printer). To print labels with bar codes in the 
current system, you need to purchase the appropriate software and a suitable printer. To 
print checks in the current system, you need to purchase special paper and a suitable 
printer.  
Fax Modem 
In the Windows environment you can send a fax directly from Priority, by defining the fax 
modem as the local or network printer (the system makes use of Microsoft Print Manager, as 
                                            
1 Consult with your DBA about the possibility of expanding memory further.

Eshbel Technologies  ■  12 Amal St, Rosh HaAyin 4809245, Israel     +972.3.925.1000   
   +972.3.925.1001  
  www.priority-software.com 
8/8 Ver.26 Cat.No. LB10000758  
 
it does other Microsoft software). No adaptation of the software is needed; set up is on the 
level of hardware and infrastructure only. 
For more information, download the document “Sending Faxes from the System” from the 
Customer Area on the Eshbel web site (http://www.eshbel.com/customerarea.htm), on the 
Priority Documentation page under the subject ‘Getting Started’. 
Remote Support 
In order to receive remote support from Eshbel, one of the following communication utilities 
must be installed: 
 Remote Desktop with console session capability. 
 LogMeIn. 
 Ammyy Admin. 
 VNC. 
Eshbel also supports connecting via VPN using one of the following utilities: 
 VPN Checkpoint. 
 VPN Microsoft. 
 VPN Cisco. 
 VPN Fortigate.
