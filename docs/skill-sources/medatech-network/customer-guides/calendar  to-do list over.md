# calendar  to-do list over

- **Source:** `calendar  to-do list over.docx`

Tasks in PRIORITY

Tasks can be raised on any document in Priority in the Task for Document sub level form or on specific customer or vendor records using the tasks for customer/vendor sub levels.

Also these can be raised directly in the task form without linking to a document in Priority. This is most useful for internal tasks that you wish to keep track of, assign to your colleagues or report upon.

Raising a task linked to a customer record

Load the Customers form with the relevant customer record

Access the Tasks for Customer sub level form

Populate the following fields:-

Start Date

End Date

Status - configurable via the BPM

Assigned To - change to alternative user if not for yourself

Subject - Free format field for summary of action required

Task Code - configurable by you for your requirements

Task Type - configurable by you for your requirements

Customer Contact - select the relevant contact at the customer links to the contacts that are already set up on the customer record.

Start Time & End Time - These must specify different times if you wish the task to appear in your or the assigned user’s Priority calendar.

Note: The assigned user can then easily drag and drop the task to the time in their calendar best suited to them

Location and additional participants in the task can be added in the relevant fields across the sub level form.

Further explanatory notes can be added in the Notes sub level.

For reminders ensure that the Remind column is checked and that the amount of hours and minutes in advance of the task that you wish to be reminded about is defined in the Hrs/Mins in Advance column.

Reminders are issued via email to the assigned users email address (as defined on their personnel record).  There are no pop up type reminders in the Priority application itself.

At the defined time ahead of the task start time an email as per below will be sent to the Assigned to user

Example below

Task added to CDavey calendar at 16.30 25/06/19 for a task to be completed at 17.00 on 26/05/19 with a reminder requested for 24hrs15mins ahead of the start time…

Email received at 16.49 with a hyperlink in the body of the email to the task concerned

Task will now exist linked to the customer record and in the To-Do list of the assigned user and any participants that are Priority users.

Viewed from customer record

Viewed from users calendar

Viewed from users To-Do List

When using Priority in conjunction with MS Outlook additional settings to check are located in the Options menu in the top right hand corner of the Priority home screen

Mail > Mail Options > Outlook > Mail Options

Notifying PRIORITY users that tasks have been added for them

The BPM functionality can be utilised to send notifications to both the assigned user for the task or participants.

NB: Multiple rules are required to pick up all the participant fields but these can be easily copied and edited to achieve the required functionality easily.

The regularity of the emails notifying this change in status is controlled by a routine within the Tabula Task Scheduler and this can be configured to suit the regularity you require.

Priority will send emails based on the email addresses defined for the users selected and attach a document showing the basic information regarding the task if defined in the BPM rule.

Any changes made to the time defined originally on the task are also notified to the users concerned.

accessing the to-do list

The To-Do list in Priority brings together all incomplete tasks into one workplace along with any other items assigned to a user that are at a status which is flagged for inclusion in To-Do List.

From the pull-down menu in the top right hand corner of the Priority home screen access Mail and then select To Do List  -  Shortcut CTRL + [

Retrieve items assigned to you/others by entering query mode (F11) and selecting the relevant user name in the Assigned to column.

From here you can access specific tasks by drilling through on the document number column.

Changes to assigned to and the status can be made directly in this form if the TODOREVISE constant is set to 1 in the System Constants

A printed copy of any users To-Do List can be created using the direct activation To Do List

reporting on tasks

Standard reporting on Tasks in Priority that is available is detailed below

Tasks per Customer - Gives a summary of all tasks raised for a specific customer between date ranges defined when generating the report.  Additional flags cater for reporting incomplete tasks only, or tasks assigned to a certain user.

Reported To-Do List Items - Gives a report showing the current and last assigned to and status of items on a to-do list for a specific user and time range defined when you generate the report.

Tasks per Assigned User - Gives a summary of tasks assigned to a specified user over the date range defined when running the report.  An additional flag caters for reporting incomplete tasks only.

Tasks per User - Detailed - As the above report but with added detail of the Task description and anything added by users to the Notes sub level form.  This report does not give any details of text recorded in the Internal Dialogue sub level form.
