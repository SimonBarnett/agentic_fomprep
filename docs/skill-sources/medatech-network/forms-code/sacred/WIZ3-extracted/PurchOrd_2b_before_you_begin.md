# PurchOrd_2b_before_you_begin

- **Source:** `PurchOrd_2b_before_you_begin.htm`

Purchase Orders - Setup: Defining the Range of Days for a Last Part Price Search 
 
 
- 
 
 
 
# Defining the Range of Days for a Last Part Price Search

 

When you itemize a purchase order (or purchase requisition), the system can fill in part prices automatically, according to various price sources, as defined in the system. When no other price source is found, the system seeks the last price at which the part in question was purchased from any vendor. You can use the PPriceDays constant to define the number of days in the past that the system can search for a last part price. If no purchase of that part is recorded within the permitted number of days, the Unit Price column remains empty. 
 
## To define the range of days:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Move to the PPriceDays constant and specify the desired number of days.
