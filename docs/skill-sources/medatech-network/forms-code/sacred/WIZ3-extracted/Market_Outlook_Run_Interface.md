# Market_Outlook_Run_Interface

- **Source:** `Market_Outlook_Run_Interface.htm`

CRM - Outlook: Running the Interface from within Priority 
 
 
- 
 
 
 
# Running the Interface

 

If you have set the interval for automatic synchronization when defining synchronization options, the interface will run automatically. You can also run it manually. 
 

 Tip: Click to set the interval for automatic synchronization. 
 
## To run the interface manually:

 

 ·        Open the Mail menu on the Priority Top Bar, select Synchronize with Outlook , and click Sync Now . 
 

 ·        Or run the Synchronize w/MS-Outlook program. 
 
## To view results:

 

 ·        To view appointments added or updated in Priority , run the Calendar . 
 

 ·        To view updated contact data, enter the Contacts form. To view new contacts, open the Leads form. 
 

 ·        To view added or updated tasks, enter the Tasks form. 
 

 ·        To view added or updated service calls, enter the Service Calls form. 
 
## Notes:

 

 ·        If mail was received from a completely new e-mail address and no customer is indicated, the sender will be added as a lead. 
 

 ·        If mail was received from a new contact for the indicated customer, the sender will be added as a customer contact. If this is an existing e-mail address (a contact for another customer), the sender will be defined as an additional contact (provided that the ADDCONTACTS system constant is left with the preset value of "1"). If this is a completely new e-mail address, the sender will be defined as a regular contact. 
 

 ·        Tasks whose start and end times are identical will not be exported to the Outlook calendar. Instead they will appear as Outlook tasks (provided your to-do list is used to update Outlook tasks). 
 

 ·        To-do items based on tasks whose start time differs from their end time will be automatically assigned to the “Appointment” category in Outlook. 
 

 ·        The number of to-do list items that can update Outlook tasks is limited by the MAXTODOLIST system constant. If you are unable to synchronize with Outlook because of the length of your to-do list, have your system manager change the constant value. 
 

 ·        Click to return to the Outlook menu.
