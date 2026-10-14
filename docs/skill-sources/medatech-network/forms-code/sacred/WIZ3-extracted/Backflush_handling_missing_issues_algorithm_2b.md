# Backflush_handling_missing_issues_algorithm_2b

- **Source:** `Backflush_handling_missing_issues_algorithm_2b.htm`

Backflush - Troubleshooting Missing Issues.4 
 
 
- 
 
 
 
# IIIa. If the part is defined as issued to the kit:

 

 1 .  Check in the Issues to Kits sub-level form if the part was actually issued and, if so, in what quantity and to which warehouse. 
 

 ·      If the part was never issued: Record a new issue to kit for the required quantity. 
 

 ·      If the part was issued in insufficient quantity or to the wrong warehouse : Record an additional issue, or correct the recorded issue. 
 

 ·      If the part was fully issued and the TakeNonKit constant is set to allow parts issued to a kit to be used by another kit, it is possible that inventory was taken to complete another work order. In that case, record an additional issue. 
 

 2 .  If the child part is intended to enter the parent part in a specific operation (other than Issue ), check in the issue line if the correct Operation is specified. 
 

 If the correct operation is not specified: 
 

 ·      Delete the quantity issued and exit the line. 
 

 ·      Return to the line and specify the correct operation in the From Operation column. 
 

 ·      Rerecord the issued quantity. 
 
## Notes:

 

 ·        To see if this has resolved the missing issue, rerun the Backflush program. 
 

 ·        Click if the problem was not resolved. 
 

 ·        If the problem was resolved: 
 

 ·      Click to handle additional missing issues. 
 

 ·      Click to handle negative inventory. 
 

 ·      Click to return to the main screen.
