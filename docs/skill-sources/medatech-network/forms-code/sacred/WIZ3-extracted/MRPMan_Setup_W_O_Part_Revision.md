# MRPMan_Setup_W_O_Part_Revision

- **Source:** `MRPMan_Setup_W_O_Part_Revision.htm`

MRP for Manufacturers - Work Order Setup: Part Revision 
 
 
- 
 
 
 
# Determining the Part Revision

 

If you work with part revisions, it is possible that the part revision in effect when the work order is opened differs from the part revision for which the original sales order was made. A production constant determines which part revision MRP will use in such a case. 
 
## To define the source of part revisions:

 

 1 .  Enter the Production Constants form. 
 

 2 .  Move to the PartRevByOrd constant and do one of the following: 
 

 ·      Leave the default value 0 to open work orders for the part revision that is in use at the time (based on the Use From column in the Part Revisions form). 
 

 ·      Select the value 1 to open work orders for the part revision recorded in the sales order. 
 
## Note:

 

If you leave the default value and a new part revision is scheduled to go into effect before production begins on the work order, the new revision is used, even if it is not actually in effect at the time. The same is true of BOM revisions; however, if that revision has not been authorized, the work order will open for the last authorized BOM revision.
