# TSBackflush_Changing_the_Method_of_Issuing_Child_Parts

- **Source:** `TSBackflush_Changing_the_Method_of_Issuing_Child_Parts.htm`

Troubleshooting Backflush Wizard - Change in Method of Issuing Child Parts 
 
 
- 
 
 
 
# Change in the Method of Issuing Child Parts

 

Missing issues can result when the child part is defined as a bulk issue in the work order kit list (that is, it is not flagged in the Issued to Kit column of the Kit List form), but it is defined as being issued to the kit (that is, it is flagged in the Kit Component column) in the Parts form. 
 

This means that the child part in question was defined as a bulk issue (that is, it was not flagged for issue to kits or manual issue in the Parts form) at the time the work order was released, but it is now defined in the Parts form as a kit component. 
 
## If this is the case:

 

 1 .  If the work order is closed, reopen it. 
 

 2 .  Flag the part in the Issued to Kit column of the Kit List form. 
 

 3 .  Rerun the Backflush program.
