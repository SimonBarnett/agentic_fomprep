# Multiple Language Support in Priority

- **Source:** `Multiple Language Support in Priority.pdf`

Multiple Language Support in Priority  
Unicode  
As of Version 13, Priority is available in Unicode. If your system was first 
installed in Version 13 or higher, no additional setup is required. If you have 
moved to Version 13 from an earlier release, it is possible to purchase an 
upgrade to Unicode – for information, contact your Eshbel representative. The 
following instructions differentiate between Unicode and non-Unicode systems. 
What Languages Can be Used? 
Systems With Unicode 
Multiple users can work on the same Priority application, on the same workstation, 
in many different languages. Thus, one can work in German, another in French, a 
third in Hungarian and a fourth in Russian. 
Systems Without Unicode 
Multiple users can work on the same Priority application, on different workstations, 
in many different languages. Thus, one can work in German, another in French, a 
third in Hungarian and a fourth in Russian. At any single workstation, the user can 
work in Priority both in English and in one other language. 
Note: Even on a single workstation, languages in the same "group" are 
supported. For instance, by setting your computer to German, you also support 
French, Spanish and other Romance languages; by setting it to Russian, you 
also support Bulgarian and other Cyrillic languages; by setting it to Hungarian, 
you also support Polish, Romanian and the like. 
Setups Required in Systems With Unicode 
If you are working in Hebrew, you must specify Hebrew for use in non-Unicode 
programs at your workstation. 
1. From 
the Control Panel, select Regional and Language Options. 
2. In the Advanced tab, under "Language for non-Unicode programs", select 
Hebrew. 
Cat.No.A6000459 1 Ver.6 – July 22,‘13

Cat.No.A6000459 2 Ver.6 – July 22,‘13 
Setups Required in Systems Without Unicode 
Setting Up Your Workstation 
In order to view fonts correctly in Priority, you must specify the (non-English) 
language for use in non-Unicode programs at your workstation.  
Note: If you are working via a terminal server, you must first run the MS 
AppLocale Utility (see below). 
3. From the Control Panel, select Regional and Language Options. 
4. In the Advanced tab, under "Language for non-Unicode programs", select 
the language in question. 
When Working via a Terminal Server 
If you are working via a terminal server, you are initially limited to a single 
regional option for all computers linked to the server. To override this restriction, 
you need to run the MS AppLocale Utility (for details, access 
http://www.microsoft.com/en-us/d ownload/details.aspx?id=13209). 
Note: This utility does not resolve the problem when one of the user languages is 
Hebrew. In that case, two separate servers are needed. 
For Priority on SQL Server Only  
In your tabula.ini file, add the following line under the [Environment] section: 
Auto Translation = FALSE 
Tips for Multiple Language Usage in Priority (All Systems) 
1. Use 
the Set Language option in the Options menu to select the language 
you wish to use (affects the current user only).  
Note: You can run certain printouts in English without changing the language 
in Priority. 
2. Select which language the data will be recorded in (company-wide). Then 
convert all predefined data in the system (e.g., status names, constant 
descriptions, predefined parts) into that language (affects all users in this 
company) by running the Transl Pre-def Data to Curr Lang program 
(System Management  System Maintenance  Companies). 
Note: Make sure you have set Priority to that language first (see Step 2). 
3. To set your local language as the base language (affects all users in this 
company), enter the Companies form (in the same menu), move to the line 
for the company in question and select the appropriate Lang. Code. This 
affects, for instance, titles displayed in financial statements.
