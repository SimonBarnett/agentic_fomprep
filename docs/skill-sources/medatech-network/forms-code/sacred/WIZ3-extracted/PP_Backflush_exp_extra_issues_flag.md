# PP_Backflush_exp_extra_issues_flag

- **Source:** `PP_Backflush_exp_extra_issues_flag.htm`

PP_Backflush_exp_extra_issues_flag 
 
 
- 
 
 
 

The flag appears automatically in lines that are added to the Kit List form manually, and causes inventory to be issued with the Reject status, on the assumption that the added line is intended to replace parts that were issued to the plant floor and found to be defective. In the case of an erroneous flag (i.e., the line was not added because defective parts were rejected, but because a greater quantity is being manufactured than that for which the original work order was opened), missing issues will be recorded, because the Backflush program only reduces child parts with a status flagged as Available Inventory in the Inventory Statuses form.
