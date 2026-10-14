# Rev_BOM_Authorize

- **Source:** `Rev_BOM_Authorize.htm`

Revisions - Authorizing a BOM Revision 
 
 
- 
 
 
 
# Authorizing a BOM Revision

 
## Note:

 

If the BOM revision is linked to an ECO, the instructions on this page are not relevant ! The BOM revision will be authorized automatically with the ECO to which it is linked, regardless of the authorizer list. 
 

When the BOM revision is not linked to an ECO, it requires authorization by a select list of users in a defined order. Authorization allows the revision to go into effect on its defined effect date. All revisions must be authorized, whether or not an authorizer list has been recorded. 
 
## Instructions for BOM revision authorizers:

 

 1 .  Enter the Parts form and retrieve the desired part. 
 

 2 .  Enter the BOM Revisions sub-level form and move to the revision in question. 
 

 3 .  Do one of the following: 
 

 ·      If no name appears in the Next Signature column (i.e., no authorizer list was defined and you are the sole authorizer), flag the Authorized column. 
 

 ·      If your name appears in the Next Signature column, enter the Revision Authorization sub-level form and flag the Authorize column next to your name. 
 
## Notes:

 

 ·        When all authorizers have approved the revision, a check mark will appear automatically in the Authorized column. 
 

 ·        If the IdentRevs constant (in the Planning Constants form) is set to 1 , a new part revision based on the BOM revision is created automatically and put into effect (unless the effect date of the BOM revision is sometime in the future).
