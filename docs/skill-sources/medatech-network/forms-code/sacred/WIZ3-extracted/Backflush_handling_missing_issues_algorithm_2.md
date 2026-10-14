# Backflush_handling_missing_issues_algorithm_2

- **Source:** `Backflush_handling_missing_issues_algorithm_2.htm`

Backflush - Troubleshooting Missing Issues.2 
 
 
- 
 
 
 
## II. Check that the issued item was not mistakenly flagged as Extra Issues :

 

 1 .  Return to the current line in the Missing Issues form. 
 

 2 .  Move to the Warehouse column in the current line and press F6 twice, to access the floor warehouse in which the operation was performed. 
 

 3 .  Enter the Warehouse Balances sub-level form and check if there is any inventory of the current part that has the Reject status. 
 

 4 .  If such inventory exists, return to the Missing Issues form, move to the For Work Order column and press F6 to access the original work order. 
 

 5 .  Enter the Kit List sub-level form and check if the part is flagged in the Extra Issues column. 
 

 ·      If the part has been flagged erroneously: Remove the check mark, then delete the line for this part in the parallel sub-level, Issues to Kits , and record a new issue. 
 
## Notes:

 

 ·        To see if this has resolved the missing issue, rerun the Backflush program. 
 

 ·        Click if the problem was not resolved. 
 

 ·        If the problem was resolved: 
 

 ·      Click to handle additional missing issues. 
 

 ·      Click to handle negative inventory. 
 

 ·      Click to return to the main screen.
