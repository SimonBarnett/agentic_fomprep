# Market_Tasks_Outlook_Interface_Categories

- **Source:** `Market_Tasks_Outlook_Interface_Categories.htm`

CRM - Outlook: Setting Up Data.4 
 
 
- 
 
 
 
# To use colors and categories to define messages:

 

 1 .  If any e-mail recipients or senders are linked (as contacts) to more than one customer in Priority , use Outlook categories to distinguish between the customers. That is, create a category in Outlook for each one. Do the same for any contact linked to more than one vendor. Then assign the appropriate category to each message. Example. 
 Note s : 
 

 ·      The same categories are used when importing contacts. 
 

 ·     For proper synchronization, default category names should not be changed. Synchronization will function as desired only when the category names match in Priority and Outlook. 
 

 2 .  Choose a color and assign it to each Outlook message (incoming or outgoing) you want to import as a task. Choose a second color and assign it to each Outlook message you want to import as a service call. These will be changed (or cleared) when the synchronization program ends.
 Note: The color assigned for tasks is also used to import contacts. 
 

When synchronization occurs: 
 

 ·              If mail was received from a completely new e-mail address and no customer is indicated (by category), the sender will be added as a lead. 
 

 ·              If mail was received from a new contact for the indicated customer, the sender will be added as a customer contact. If this is an existing e-mail address (a contact for another customer), the sender will be defined as an additional contact (provided that the ADDCONTACTS system constant is left with the preset value of "1"). If this is a completely new e-mail address, the sender will be defined as a regular contact.
