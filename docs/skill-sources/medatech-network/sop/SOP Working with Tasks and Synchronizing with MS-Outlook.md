# SOP Working with Tasks and Synchronizing with MS-Outlook

- **Source:** `SOP Working with Tasks and Synchronizing with MS-Outlook.pdf`

Cat.No. LB110521 1 Ver.3 – Dec. 04,’12 
 
SOP: Working with Tasks and  
Synchronizing with MS-Outlook* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Recording and Completing Tasks  
Aims 
 To open and complete tasks for a specific customer or vendor in order to document 
communications with them (e.g., as a result of a price quote, order or telephone call). 
 To open tasks automatically, based on e-mails  received from customer or vendor 
contacts. 
Setups 
 Make sure task codes are defined in the Task Codes  form, which allow you to 
retrieve and report on tasks per category, and which fill in task subjects 
automatically. 
 Make sure task statuses (e.g., Draft, Current, Checking, Done) are defined via the 
BPM Flow Chart-CVRM Tasks program. 
 Make sure groups are defined in the Groups form. 
Procedure 
Stage I: Opening a Task Manually 
1. Enter the Tasks form. 
2. Select the Task Code for the new task. The Task Number appears automatically. 
3. The task Subject and Start Date also appear automatically. Revise as needed. 
4. Link the task to the appropriate customer or vendor in the Customer No. (and 
Contact) or Vendor Number (and Vendor Contact) columns (in the Definitions or 
Vendor tab, respectively). 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

5. Your username appears automatically in the  Assigned To column. Assign a different 
user, as needed. 
6. To assign the task to multiple users, click the Participants tab and specify the 
various users, or select one or more groups. 
7. If you want the task to appear in your Calendar, make sure its Start Date (or Start 
Time) differs from its End Date (or End Time). 
8. To link the task to a given document, click the References tab, choose the relevant 
Document Type and specify the Document Number. 
9. To alert the users assigned to this task, flag the Remind column; indicate the 
Hrs/Minutes in Advance for notification to be given. The system will send a mail 
message to every user assigned to the task reminding them of the approaching task. 
10. To link a marketing campaign to the task, click the Campaign tab, and select the 
appropriate Campaign Code. 
11. Enter the Notes sub-level form and record a description of the task. If the task has 
been assigned to multiple users, this is where they can participate in a discussion 
about the task by clicking the Add a Comment icon to add their signature and time 
stamp, and writing their comment. 
12. If you want to attach a document to the task, record it in the Customer Documents 
for Task or Vendor Documents for Task sub-level form. 
13. In the Task List sub-level form, you can manually define sub-tasks for the current 
task, such that closing the upper-level task (e.g., changing the status to “Completed”) 
is dependent on closing all of its sub-tasks. If sub-tasks have already been assigned 
to the selected Task Code (in the Check List for Task Code sub-level of the Task 
Codes form), these tasks will appear here automatically, but may be revised.  
14. Return to the upper-level form and change the Status to the next status, as defined 
in BPM workflow rules. 
15. Select Print Task from the list of Direct Activations to view and/or print the task. 
Stage II: Completing a Task or Appointment 
To complete an open task or appointment: 
1. Enter the Tasks form and retrieve the desired task, using the Assigned To and/or 
Task Code column. 
Tip: You can predefine queries in the Query Generator. 
2. Record the steps taken to complete the task in the Notes sub-level form. Click the 
Add a Comment icon to add the date and username to each revision or addition to 
the task. If the task is assigned to multiple users, you can send a mail message to all 
users after updating the task by clicking Send Link to Participants from the Mail 
menu on the  Menu Bar.  
3. When the task is complete, flag the Done column, or change the task's Status to 
"Completed". The completion date appears automatically (in the References tab), 
together with your username. 
Note: To close a batch of tasks that have been assigned to a given user over a given 
period, run the Close Tasks program. 
Cat.No. LB110521 2 Ver.3 – Dec. 04,’12

To view all open or completed tasks: 
1. To view a summary of tasks recorded for the current customer or vendor, select 
Task Summary for Customer or Task Summary for Vendor from the list of Direct 
Activations. Or enter the Tasks sub-level of the Customers or Vendors form. 
2. To view a summary of all open tasks assigned to a given user, enter the To Do List 
form and retrieve all items assigned to that user whose Document Type is "Task". 
3. You can run the Tasks per User - Detailed  report for a specified assigned user and 
period. 
4. You can run the Tasks per Task Code report for a designated period, code and 
customer. 
5. You can print tasks by selecting  Print Task from the list of Direct Activations for the 
Tasks form, or run the Print Task program from the menu. 
Stage III: Working with Priority's Calendar 
Aim: To schedule, manage or update appointments for a given employee or group. 
1. Enter the Task Codes form. In the Color in Calendar column, choose the color to 
associate with each task code. 
2. Run the Calendar program. 
3. To toggle between horizontal and vertical display of hours in the calendar, click the 
upper View menu and select Change View. 
4. Use the vertical and horizontal scroll bars to scroll through the different days and 
times. 
5. To scroll back and forth by days and weeks, use the arrow icons (<, >, <<, >>) in the 
Top Bar. 
6. To move to the Next Month or Next Week, or to a specific date, open the upper 
Dates menu and select the desired option. 
7. To view all open appointments that have been scheduled for a specific employee or 
employees: 
 Click the upper View menu and select Group Schedule. 
 Click the upper File menu and select Select Employees to choose the desired 
employee. To select multiple employees, hold down the Shift or Ctrl key while 
highlighting the employees in question with the cursor. 
8. To add an appointment, double click in the appropriate time slot. The Tasks form 
opens with certain data already filled in. Complete the necessary information as 
explained in Stage I and exit the form. The new appointment will automatically 
appear in th
e calendar. 
9. To change the date or time of an appointment, drag it to the desired slot. The task is 
updated accordingly.  
10. To color or print a specific appointment or view the task summary for the 
appointment, right-click its time slot and select the desired operation. 
Cat.No. LB110521 3 Ver.3 – Dec. 04,’12

11. You can save up to five different view settings (e.g., timescale, number of columns 
and resources) for future retrieval. To save the current setting in a buffer, click the 
upper View menu and select Save View Settings. To retrieve saved settings, select 
Get View Settings. 
Recording Tasks on the Basis of Mail Messages  
and Synchronizing with MS-Outlook  
Aims 
 To export tasks from Priority to MS-Outlook in order to synchronize tasks. 
 To record new tasks automatically on the basis of mail messages received in MS-
Outlook. 
 To import customer and vendor contact details from MS-Outlook to Priority. 
Setups 
 Set up your e-mail account in MS-Outlook. 
 Make sure your e-mail address is recorded correctly in the Personnel File, in the E-
mail column in the Address & Phone tab. 
 Make sure that the e-mail addresses of customer and vendor contacts are recorded 
correctly in the Customer Contacts and Vendor Contacts sub-levels of the 
Customers and Vendors forms, respectively. 
 In the Task Codes form, make sure the Interface w/Outlook column is flagged for 
the appropriate task codes. 
 Make sure that the e-mail addresses of users with whom you have communicated 
regarding a given customer are recorded in the Additional Contacts sub-level form 
for that customer. 
 Open the Mail menu in the Priority Menu Bar and select Mail Options. Flag the 
option Record e-mail as customer/vendor tasks. 
Procedure 
Stage I: Recording Synchronization Definitions in Priority 
1. Run the Update Data for Synch w/Outlook program. 
2. Run the Synchronize with Outlook program. 
Note: You can also run the program by selecting Synchronize with Outlook from 
the Mail menu on the Menu Bar. 
3. In the window that opens, define the following: 
 In the Calendar Synchronization column, indicate whether there will be mutual 
synchronization between Priority and Outlook, or only one system will be updated. 
Important! If a given user accesses Priority from several different workstations, 
Cat.No. LB110521 4 Ver.3 – Dec. 04,’12

make sure the Update Both option is not selected. This will ensure that tasks are 
not deleted when this user logs on to Priority from a different workstation. 
 If you want to open new  Priority contacts on the basis of Outlook contacts, flag the 
Import Contacts box. 
 In the Company column, select the Priority company that will be synchronized 
with Outlook (regardless of the company from which the synchronization is 
activated). 
 Select the Outlook Folder to which e-mail is to be sent during synchronization. 
 Specify the desired interval at which automatic synchronization with Outlook will 
occur. 
Stage II: Recording Synchronization Definitions in Outlook and 
Synchronizing E-Mail Messages to Priority 
Note: The following features are supported by MS-Office 2007 and higher. 
1. Open the Mail folder in Outlook and change the view settings as follows: 
 Right-click on a column in the message window (e.g., Subject) and select Field 
Chooser. 
 In the windows that opens, from the drop-down box, choose User-defined fields 
in [folder]. 
 Drag the Synchronize with Priority field into the message window. 
 Drag additional Priority-related fields into the message window, as desired. 
2. To enable editing of the columns you just added: 
 Right-click on any columns you added, and select View Settings. 
 Click Other Settings. 
 In the Other Settings dialogue box, flag Allow in-cell editing. 
3. Flag the Synchronize with Priority column for any messages that you wish to 
synchronize with Priority. Select additional parameters for synchronization, such as 
the Customer Number for which the task will be opened, and who the task is 
Assigned To. 
Tip: You can also right-click on a single message and select Synchronize with 
Priority. If you choose this method, select the desired options in the window that 
opens, such as the name of the customer for which to open the task, or whether to 
open a service call (instead of a task). 
4. If you want an e-mail to be linked to a particular document in Priority automatically 
(e.g., a sales order or existing service call), make sure that the document number 
appears in the subject line of the message (e.g., Service Call number SC12000007). 
5. Synchronization of selected messages will take place at the interval specified when 
you ran the Synchronize with Outlook program. To manually synchronize Priority 
with Outlook, select Synchronize with Outlook in the Priority Mail menu (from the 
Menu Bar) and click the Sync Now button.  
Cat.No. LB110521 5 Ver.3 – Dec. 04,’12

Cat.No. LB110521 6 Ver.3 – Dec. 04,’12 
6. To view the tasks that were added or revised, enter the Tasks form and retrieve all 
tasks to which you are assigned. You can also use the Start Date column, which 
displays the date the mail message was received in Outlook. 
7. To view your to-do items in Outlook, at the bottom of the Navigation Pane, click 
Tasks. 
Results 
When Outlook is synchronized with Priority: 
 Mail messages that were received in Outlook (and assigned the appropriate flag) are 
recorded in Priority's Tasks form and linked to the assigned customer.  
 The contents of the mail messages are recorded in the Notes  sub-level form. 
 If the task's start date (or time) differs from its end date (or time), an appointment is 
opened automatically in the Priority Calendar. 
 Mail messages that that were received in Outlook are linked to the relevant 
document in Priority, provided that the full document number appears in the subject 
line (e.g., "Quote No. A91000011"). They will appear in the Task List sub-level form, 
and the contents of the message will appear in the Notes sub-level of the Task List. 
 Any Outlook task that is marked as complete will cause the parallel Priority task to 
be flagged as Done, unless the Leave Priority Document Opened column is 
flagged in Outlook. 
 If a Priority task's status is defined as Canceled, the corresponding task is deleted 
from Outlook.
