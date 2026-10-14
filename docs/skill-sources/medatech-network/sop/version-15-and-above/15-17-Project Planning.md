# 15-17-Project Planning

- **Source:** `15-17-Project Planning.pdf`

www.priority -software.com   
1/2 ‏Mar. 12,'15 Ver. 02 Cat.No. LB110545 
 
 SOP: Project Planning 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To record project plans in the system and manage planning versions. 
Setups 
 The value of the SWBSAutoNum constant in the Logistic Constants form should be set at “1,” so 
that WBS activities will be numbered automatically. 
 A project in the customer’s name must be created in the system. 
 Activity types should be listed in the Project Activity Types form. 
 There is a plan for the project. 
Procedure 
Stage I: Recording the Project Plan 
1. Enter the Projects form and retrieve the desired project. 
2. Enter the Project Planning sub-level form. 
3. Record the WBS Code of each activity, the Name of Activity, Start Date and End Date. 
4. If the activity is a milestone, flag the Milestone column. 
Note: A milestone is an activity to which project payments can be linked. When it is completed, 
the payment can be automatically released for invoicing. 
5. In the Owner column, select the employee responsible for the activity. 
6. In the Activity Type column, select the relevant type of activity (e.g., training, supervising, 
project management). 
7. Enter the Resources for Activity sub-level form and record the names of all employees 
assigned to the activity and the number of planned hours for each one. 
Important note: The work hour part number that appears is that defined in the employee’s 
personnel file. If no part number was defined, a default work hour part number appears. This will 
affect project costs. 
8. Return to the Project Planning form, and select the relevant Activity Status (“Active”, “In 
Progress”, “Completed”, “Canceled”). 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 ‏Mar. 12,'15 Ver. 02 Cat.No. LB110545 
 
9. If needed, return to the upper-level form Projects and select Upload Project Plan from the list 
of Direct Activations to export the current planning version of the current project to an external 
file. 
Notes: 
 You can open employee tasks based on project activities:  
 With the cursor in the project activity for which the task should be opened, move to the Tasks 
for Project Activity sub-level form. 
 In the Assigned to column, select the relevant employee.  
 Indicate the task date and Task Code. 
 If the task’s Start Time differs from its End Time, an appointment will be opened in the 
employee’s calendar. The task opened for the employee will appear in his/her Tasks. When 
it is defined as completed, the Done field will be flagged. 
 You can print a copy of the project plan and its activities directly from the Projects form. 
 You can view and update project activities and related work hour reports in the Project Activities 
form. 
 You can view documents that have been linked to the project activities in the Links to 
Documents form, a sub-level of the Project Planning form and of the Project Activities form. 
 You can run various planning and execution reports (Project Management > Reports on 
Projects > Planning and Execution Reports) to view which projects are nearing completion, to 
analyze project costs and the like. 
Stage II: Creating Planning Versions 
You can manage the project plan by opening planning versions to track changes. When you use 
planning versions, you can make revisions that will not affect the project plan until the version is fully 
authorized and goes into effect. 
1. Enter the Projects form and retrieve the desired project. 
2. Select Save Version from the list of Direct Activations. As a result, the current project plan is 
saved as the first planning version.  
3. Enter the Planning Versions sub-level form, and place the cursor on the version just opened.  
Note: To see the project plan in this version, enter the Project Planning sub-level form. 
4. To put this version into effect, first change the Version Status (in the Planning Versions form) 
to “Fully Authorized.” 
5. Select Put Planning Version Into Effect from the list of Direct Activations. As a result, the 
version will be put into effect and it will not be possible to make changes to it, except via an 
additional planning version. 
6. To save changes to the project plan in a new version, you can make the changes directly in the 
Project Planning form and then select Save Version from the list of Direct Activations in the 
upper-level Projects form. In this fashion, you will receive two versions: a previous one and a 
new one with revisions. 
7. After modifying the project plan, you can select Calculate Cumulative Planning from the list of 
Direct Activations in the Projects form, with which you can update work hour data and 
cumulative costs, as well as calculate the projected profit for the project accordingly. The 
program will calculate the costs and planned work hours for all activities in the project (including 
sub-activities).
