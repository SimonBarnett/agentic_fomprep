# Market_Tasks_Outlook_Interface

- **Source:** `Market_Tasks_Outlook_Interface.htm`

CRM - Outlook: Setting Up the Interface 
 
 
- 
 
 
 
# Interfacing With MS-Outlook - Setups

 

Certain setups must be performed once before running the Outlook interface: users must be authorized to perform synchronizations; you must define how those users access Priority from external programs; and you must determine whether new contacts are created automatically when synchronizing e-mails received from a new address. 
 
## To authorize a user to perform synchronizations with Outlook:

 

 1 .  Enter the User Permissions form and retrieve the desired user(s). 
 

 2 .  Click the Permissions tab and do one or both of the following: 
 

 ·              Flag the Synch w/Outlook-In column to allow the user to update Priority with data from Outlook. 
 

 ·              Flag the Synch w/Outlook-Out column to allow the user to update Outlook with data from Priority . 
 
## To define how users access Priority from external programs:

 

 ·        The OUTLOOKBLOCKACC system constant allows you to determine whether users will have to record their Priority username and password whenever accessing Priority data from an external program. If you leave the pre-set value of 0, users can access Priority from external programs without having to log in to Priority again. Change the constant value to 1 to force users to log in every time they access Priority data from an external program. 
 
## To determine whether additional contacts are created automatically during synchronization with Outlook:

 

 ·        The ADDCONTACTS system constant allows you to determine whether additional contacts are created automatically when synchronizing e-mails for a specific customer from a contact linked to a different customer. If you leave the preset value of 1, when synchronized messages are received from an existing contact that is linked to a different customer, additional contacts are created for the current customer automatically (in the External Contacts sub-level of the Customers form). Change the constant value to 0 to disable automatic creation of additional customer contacts during synchronization with Outlook.
 Note: Regardless of the value assigned to the constant: 
 

 ·              If synchronized messages were sent from a completely new e-mail address and the synchronization is for a specific customer, the sender will be added as one of the customer's regular contacts (in the Customer Contacts sub-level of the Customers form). 
 

 ·              If synchronized messages were sent from a completely new e-mail address and the synchronization is not for a specific customer, a lead will be opened with the e-mail address in question (provided the sender has an identifiable name). 
 
## Note:

 

Have your system manager set the correct constant values in the System Constants form.
