# WorkOrders_issues_to_kit

- **Source:** `WorkOrders_issues_to_kit.htm`

Work Orders - Issuing to the Work Order Kit.1 
 
 
- 
 
 
 
# Issuing to the Kit

 

Issues to kits are recorded in the Issues to Kits form. A line is automatically opened in this form for every part listed in the Kit List that is flagged for issues to a kit. The number of lines opened for each part depends on the required quantity and existing inventory balances of the part. Example. 
 

If inventory is available for the part from several different sources, the system chooses the issued parts according to a defined order of precedence . 
 

In the event that there is insufficient inventory of a part, the system tries to complete the issue with alternate parts (if any have been defined and if the relevant parameters allow their use). 
 

For more information on issues to kits: 
 

 ·        Run the Pick List for Kits report to view a list of all kit components that are needed for open work orders and are fully available in inventory, together with the warehouses from which they can be supplied. 
 

 ·        Run the Issues Needed per Work Order or Issues Needed per Parent Part report to view all required kit components regardless of their availability in inventory. 
 
## Notes:

 

 ·        If you want to be informed whenever a missing kit component is received from the vendor, make sure the part in question is flagged in the Check Kit List column of the Inventory Parameters for Parts form ( Manufacturing tab). Consequently, a message will appear to the user recording the receipt of the purchased part. Keep in mind, however, that the check (which is run on each received part) is time-consuming. 
 

 ·        Click if you have not yet checked the kit list. 
 

 ·        Click to define alternates for a child part. 
 

 ·        Click to change the constant affecting the use of alternate parts.
