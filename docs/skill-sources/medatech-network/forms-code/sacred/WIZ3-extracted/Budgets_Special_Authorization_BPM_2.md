# Budgets_Special_Authorization_BPM_2

- **Source:** `Budgets_Special_Authorization_BPM_2.htm`

Budgets - Authorizing Special Budget Appropriations via BPM.2 
 
 
- 
 
 
 

 6 .  Draw a path between the Pending Auth and First Auth. statuses. Right-click the path itself and select Rules . 
 

 7 .  Define a rule allowing the first authorizer to change the status of the appropriation from Pending Auth to First Auth. 
 

 8 .  Right-click the First Auth. status and define a second set of rules by which a second authorizer is assigned the appropriation and notified when it receives the First Auth. status. You can also add a second condition to these rules, such as if the Appropriated Amount column exceeds a certain value.
 Tip: Save time by selecting a rule you have already defined in the List of Rules dialogue box and clicking Copy . You can then modify the original rule and it will automatically save under a new name. 
 

 9 .  Repeat this process for as many levels of authorization as you require. The process ends when the Authorized status is assigned to the budget appropriation. For example, a third rule may be added to the above example: if the appropriation receives the First Auth. status and does not exceed the specified amount, it is then assigned the Authorized status and the authorization process is completed. 
 

 Note: 
 

Click to return to the Special Budgets menu.
