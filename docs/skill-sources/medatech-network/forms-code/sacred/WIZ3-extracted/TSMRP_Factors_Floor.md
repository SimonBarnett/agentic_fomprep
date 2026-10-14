# TSMRP_Factors_Floor

- **Source:** `TSMRP_Factors_Floor.htm`

Troubleshooting MRP Wizard - Analyzing Use of Floor Inventory 
 
 
- 
 
 
 
# Analyzing Use of Floor Inventory

 

MRP takes floor inventory into account only when the following conditions are met: 
 

 ·        When MRP was run, it was defined to take floor inventory into account. 
 

 ·        The inventory in question is issued in bulk. 
 

 ·        The inventory's status is defined as Available Inventory . 
 
## To check MRP run definitions:

 

 ·        Run the View Dates & Chosen Options report and check if the last run of MRP took floor inventory into account. 
 
## To check the part's issue type:

 

 ·        Enter the Parts form, retrieve the child part in question and click the Additional Details tab. If the part is issued in bulk, it will not be flagged in either the Issues to Kits or the Manual Issue column. 
 
## To check inventory status:

 

 1 .  Enter the Inventory Statuses form, and note which statuses are flagged in the Available Inventory column. 
 

 2 .    Enter the Parts form and retrieve the part in question. 
 

 3 .  Enter the sub-level form, Inventory Balance for Part . Only inventory in a floor warehouse (Type F) with a status flagged as Available Inventory is taken into account by MRP.
