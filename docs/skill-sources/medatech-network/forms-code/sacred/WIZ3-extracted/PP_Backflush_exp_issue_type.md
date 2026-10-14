# PP_Backflush_exp_issue_type

- **Source:** `PP_Backflush_exp_issue_type.htm`

PP_Backflush_exp_issue_type 
 
 
- 
 
 
 

The Backflush program "knows" in which warehouse to seek inventory balances of child parts, taking into account the warehouse linked to the operation, the operation’s Inv./Costing Control method, and whether the work order has been assigned to a subcontractor. 
 

However, any child part that is flagged (in the kit list) as issued to a kit requires a report of that issue. An insufficient issued quantity to the kit will create missing issues (once the parent is reported in a production report or a GRV), even if there is sufficient inventory of the issued part on the plant floor (unless the TakeNonKit constant is set to allow completion of kit issues).
