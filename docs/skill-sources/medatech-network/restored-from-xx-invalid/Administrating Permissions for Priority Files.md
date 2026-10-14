# Administrating Permissions for Priority Files

- **Source:** `Administrating Permissions for Priority Files.docx`

Administrating Permissions for Priority Files

Note: The following permissions are minimal. We recommend that you do not deviate from the list. If you nevertheless decide to change permissions, ensure that you have not reduced them. Reducing permissions any further is likely to impair the proper functioning of the system!

In order to install clients, it is also necessary to execute Sharing of the priority folder on the server. When defining the Sharing, assign Full Control permission to everyone.

Permissions that should be assigned to Priority files on the server: *

User/ Group | Directory | Directory Contents | Permission

Administrator | Priority |  | Full Control

Administrator | Priority/fusioncharts | Used to display flash charts & graphs | Full Control

System | Priority |  | Full Control

Everyone | Priority |  | Read

Everyone | Priority/bin.95 | Priority programs | Read

Everyone | Priority/client | Files used to install new Clients | Read

Everyone | Priority/system/document (and all sub-directories) | Non-HTML documents and screen-painted forms | Full Control

Everyone | Priority/system/html | HTML documents | Full Control

Everyone | Priority/system/images | Images for HTML docs/webs | Read

Everyone | Priority/system/java | Java programs | Read

Everyone | Priority/system/javachart | Java programs for graphs | Read

Everyone | Priority/system/javahelp | Java client help files | Read

Everyone | Priority/fusioncharts | Used to display flash charts & graphs | Read

Everyone | Priority/system/load | Preferred path for files related to external interfaces | Full Control

Everyone | Priority/system/macros | Users’ macro definition files | Full Control

Everyone | Priority/system/mail | Files attached to e-mails | Full Control

Everyone | Priority/system/prep | Compiled forms and reports | Full Control

Everyone | Priority/system/reports | Saved reports | Full Control

Everyone | Priority/system/sched | Accessory files for programs | Full Control

Everyone | Priority/system/upgrades | Results of software upgrades | Full Control

Everyone | Priority/system/util | Utility queries | Read

Everyone | Priority/tmp | Priority’s temporary files | Full Control

Everyone | Directory defined as Tabula Tmp in the tabula.ini file | Priority’s temporary files for local use | Full Control
