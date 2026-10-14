# Market_Setup_Campaign_SalesOpp_Status_2

- **Source:** `Market_Setup_Campaign_SalesOpp_Status_2.htm`

CRM - Campaign Setup: Linking Opp. Status to Marketing Activities.1 
 
 
- 
 
 
 
# Defining the Effect of Marketing Activities on the Status of Sales Opportunities

 

The progress of a sales opportunity is measured by the marketing activities performed for it. The completion of any of these activities – tasks (defined by task codes ), price quotations or sales orders – is reflected in the status subsequently received by the sales opportunity. The range of task codes that you define is thus an important factor determining the various statuses you need to define. 
 
## To link opportunity status to marketing tasks (based on the task code):

 

 1 .  Enter the Task Codes form. 
 

 2 .  Retrieve the desired task code or record a new one. 
 

 3 .  In the Opp Status When Done column, specify the status to be assigned automatically to the sales opportunity when a task with the current code is successfully completed (i.e., flagged in the Done column).
 Note: To define new statuses, run the BPM Flow Chart-Sales Opps program. 
 
## To link opportunity status to marketing tasks (based on the task status):

 

 1 .  Enter the Statuses for Tasks form. 
 

 2 .  Move to the desired status and enter the Sales Opportunity Status sub-level form. 
 

 3 .  In the Sales Opp Status column, select the status to be assigned automatically to a sales opportunity when a task linked to the opportunity receives the status in the upper-level form. 
 
## Note:

 

If a given opportunity status is linked to a task via both the task code and the task status, the latter will go into effect and the former will be disregarded.
