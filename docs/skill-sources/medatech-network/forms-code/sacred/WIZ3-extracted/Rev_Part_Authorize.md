# Rev_Part_Authorize

- **Source:** `Rev_Part_Authorize.htm`

Revisions - Authorizing a Part Revision 
 
 
- 
 
 
 
# Authorizing a Part Revision

 

Part revisions require authorization by a select list of users in a defined order, except in the following cases: 
 

 ·        when the part revision is linked to an ECO, in which case the revision is authorized automatically when the ECO is authorized, and 
 

 ·        when it is linked to a BOM revision (and the IdentRevs constant is set to 1 ), in which case it is authorized automatically when the BOM revision is authorized. 
 

 ·        In such cases, the following instructions are not relevant ! 
 
## Instructions for part revision authorizers:

 

 1 .  Enter the Parts form and retrieve the desired part. 
 

 2 .  Enter the Part Revisions sub-level form and move to the latest revision. If your name appears in the Next Signature column you may proceed to authorize the revision. 
 

 3 .  Enter the Revision Authorization sub-level form and flag the Authorize column next to your name. 
 

 4 .  If the part revision is based on a new BOM revision, enter the BOM Revisions form (parallel to the Part Revisions sub-level form) and specify the new part revision in the Part Revision No. column. 
 
## Notes:

 

 ·        When the first of several authorizers has approved the revision (i.e., the revision is partially authorized), a P appears in the Authorized column. After the last authorizer has signed, a Y appears. 
 

 ·        Click to put the authorized part revision into effect.
