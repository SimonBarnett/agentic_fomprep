# Market_Tasks_Outlook_Interface_Synch

- **Source:** `Market_Tasks_Outlook_Interface_Synch.htm`

CRM - Outlook: Setting Up Data.2 
 
 
- 
 
 
 
# Using the Synchronize with Priority Feature

 

If you work with Office 2007 or higher, you can use the Synchronize with Priority command to define Outlook messages even when working in Offline mode and even when Priority is not open. 
 

You can also add columns to Outlook based on any of the parameters used for synchronization with Priority . Such columns can be used to update synchronization parameters and flag messages for synchronization directly from Outlook's Messages pane, and to group and sort messages accordingly. 
 
## Before You Begin

 

The workstation on which you run Outlook needs to have updated Priority data (e.g., customer numbers). The first time you export Priority data for synchronization with Outlook, you need to run the program manually. After that, you can set up periodic updates, to be performed automatically each time you log in to Priority . 
 
## To export Priority data in preparation for synchronization:

 

 1 .  Run the Update Data for Synch w/Outlook program. 
 

 2 .  Choose whether data exported by this program are updated automatically each time you log in to Priority (recommended) or are only updated when this program is run manually. 
 

 3 .  If MS-Outlook is currently open on your computer, exit and then reenter Outlook. 
 
## Synchronize with Priority

 

Once customer data is updated, you can right-click any message in Outlook and select Synchronize with Priority . In the Synch Parameters dialog box that opens, specify the parameters to be used to create a task or service call from this item. For example, you can choose the customer for which the task or service call will be opened and the user to whom it will be assigned. 
 
## Note:

 

If mail is from a new contact for a given customer, select the customer for which you want to open the task. When synchronization occurs, the mail sender will be added as a customer contact. If this is an existing e-mail address, the mail sender will be defined as an additional contact (provided that the ADDCONTACTS system constant is left with the preset value of "1"). If this is a completely new e-mail address, the sender will be defined as a regular contact.
