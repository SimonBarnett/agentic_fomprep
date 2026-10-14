# PP_Subcont_exp_calc_and_recording_issue_to_floor

- **Source:** `PP_Subcont_exp_calc_and_recording_issue_to_floor.htm`

PP_Subcont_exp_calc_and_recording_issue_to_floor 
 
 
- 
 
 
 

The program calculates the required quantity of each child part issued in bulk (taking into account the value of the IFloorInv constant) and then tries to fill this demand when itemizing the document. 
 

If several inventory balances are available for the part, the program chooses the balance from which to issue the part according to a defined order of precedence. If the chosen balance is not sufficient, the program opens an additional issue line, until the demand has been filled or until no inventory balances of the part remain. 
 
## The order of precedence by which the program chooses the inventory balances to issue:

 

 1 .  Inventory of the desired part revision (as recorded in the kit list) takes precedence over other part revisions. 
 

 2 .  Lots/work orders with earlier expiration dates take precedence over those with later dates. 
 

 3 .  Inventory from closed work orders takes precedence over that from open work orders. 
 

 4 .  Work orders with earlier closure dates take precedence over those with later dates. 
 

 5 .  Work orders with earlier opening dates take precedence over those with later dates. 
 

 6 .  Inventory from a warehouse with a shorter lead time takes precedence over that from a warehouse with a longer lead time. 
 

 Note: If no inventory of the part is recorded in the system, the Main warehouse appears automatically.
