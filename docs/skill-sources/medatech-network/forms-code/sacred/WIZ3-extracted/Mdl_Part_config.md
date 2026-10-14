# Mdl_Part_config

- **Source:** `Mdl_Part_config.htm`

Modeling - Limiting BOM Changes 
 
 
- 
 
 
 
# Restricting Customized BOMs

 

When recording a price quotation or sales order, you can create a customized bill of materials in which one or more of the part's components are altered, at the customer's request. However, if there is a specific child part that should never be deleted from a part's BOM, you can put a restriction on it. Any users that try to delete the restricted part will then receive a warning. 
 
## To restrict deletion of a child part from a custom BOM:

 

 1 .   Enter the Parts form and retrieve the desired parent part. 
 

 2 .   Enter the Custom BOM for Item: Conditions sub-level form. 
 

 3 .   Select the child part in question. 
 

 4 .   Flag the Deletion Warning column. A warning message will appear whenever an attempt is made to delete this child part from a custom BOM. 
 
## Note: 

 

To make the warning into an error message for any group of users, run the Privilege Explorer . For more details, run the Privilege Explorer Wizard .
