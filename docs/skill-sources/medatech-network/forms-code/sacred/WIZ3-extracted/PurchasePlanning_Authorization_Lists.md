# PurchasePlanning_Authorization_Lists

- **Source:** `PurchasePlanning_Authorization_Lists.htm`

Purchase Planning - Setting Up Authorizer Lists 
 
 
- 
 
 
 
# Setting Up Purchase Demand Authorizer Lists

 

 Priority offers the option of working with authorizers whose signatures are required before you can link a purchase demand to an RFQ or purchase order. You can create a single authorizer list for all demand documents, or multiple lists (e.g., one for each department). 
 
## To create a single authorizer list:

 

 1 .  Enter the Authorizer Lists for PRs form and move to the predefined 00 code. 
 

 2 .  List the authorizers in the Authorizers sub-level form, recording each authorizer' s username, an alternate authorizer (where applicable) and the total amount above which this user's signature is mandatory.
 Note: The list must contain one user whose authorization is required starting from the sum 0 . 
 
## To create multiple authorizer lists:

 

 1 .  Use the 00 code to define your main list of authorizers (see above). 
 

 2 .  In the Authorizer Lists for PRs form, record a code and a short description for each additional list. 
 

 3 .  Use the sub-level form to list the authorizers. 
 
## Notes:

 

 ·        It is not always necessary for all authorizers to sign off on a purchase demand – if an authorizer for a higher amount signs off, those authorizers responsible for smaller amounts do not need to. 
 

 ·        The 00 code will automatically be assigned to each purchase demand document opened by the Purchase Planning program; however, if no authorizers are defined in the list, no action need be taken to authorize the document. To use a different list, you must change the Auth. List Code .
