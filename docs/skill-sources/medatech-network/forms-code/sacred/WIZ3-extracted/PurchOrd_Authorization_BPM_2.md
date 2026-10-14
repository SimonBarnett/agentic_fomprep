# PurchOrd_Authorization_BPM_2

- **Source:** `PurchOrd_Authorization_BPM_2.htm`

Purchase Orders - Setup: Using BPM Rules to Authorize POs.2 
 
 
- 
 
 
 

 5 .  Draw a path between the Pending Auth and First Auth. statuses. Right-click the path itself and select Rules . 
 

 6 .  Define a rule allowing the first authorizer to change the status of the order from Pending Auth to First Auth. 
 

 7 .  Right-click the First Auth. status and define a second set of rules by which a second authorizer is assigned the order and notified when it receives the First Auth. status. You can also add a second condition to these rules, such as if the Final Price column exceeds a certain value.
 Tip: Save time by selecting a rule you have already defined in the List of Rules dialogue box and clicking Copy . You can then modify the original rule and it will automatically save under a new name. 
 

 8 .  Repeat this process for as many levels of authorization as you require. The process ends when the Authorized status is assigned to the purchase order. For example, a third rule may be added to the above example: if the order receives the First Auth. status and does not exceed the specified value, it is then assigned the Authorized status and the authorization process is completed. 
 
## Note: 

 

Click to perform additional setups.
