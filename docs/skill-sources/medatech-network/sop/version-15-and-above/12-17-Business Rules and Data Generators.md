# 12-17-Business Rules and Data Generators

- **Source:** `12-17-Business Rules and Data Generators.pdf`

www.priority -software.com   
1/2 Feb. 09,'15 Ver. 03 Cat.No. A8000908 
 
 SOP: Business Rules and Data Generators 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To become familiar with the Business Rules Generator and the Data Generator. 
Explanations 
Business Rules Generator: A tool which enables you to define warning messages, error messages 
and e-mail messages that are activated automatically when certain conditions are met in a given 
form. 
Using business rules, it is possible to generate any of the following messages: 
 An error message preventing the user from completing an operation which he or she attempts to 
perform. 
 A warning message alerting the user of possible consequences that may result from the 
completed operation. 
 An e-mail message to which a printout of the current record can be attached and sent to a user, 
group, e-mail address or specific contact. 
 An SMS message that can be sent to a user, group, cellular telephone number or specific 
contact. 
Data Generator: A tool which enables you to preset values that will appear automatically in a form’s 
columns based on other data appearing in the form. 
Working Assumptions 
 It is possible to define more than one rule in each generator. 
 It is possible to create different rules for different companies and users. 
Setups 
 The only users authorized to define rules applying to all users are those defined as such in their 
Personnel File. That is, the Write Business Rules column must be flagged in the Permissions 
tab. 
 You can only send e-mail messages to groups for which you are authorized (in the Groups 
form). Groups are defined in the Groups form, and can include system users as well as external 
e-mail addresses. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 Feb. 09,'15 Ver. 03 Cat.No. A8000908 
 
Procedure 
Stage I: Using the Business Rules Generator 
The Business Rules Generator checks, within the form for which it is defined, whether predefined 
condition(s) have been met, and if so, operates according to the defined rule (e.g., displays a 
warning or error message or sends mail). 
1. Enter the desired form. 
2. From the Design menu, select the Business Rules Generator. 
3. Define an operation (Display warning, Display error message, Send e-mail, Send SMS). If you 
choose to send a message, also define to whom it should be sent (a user, group, e-mail address 
or a user defined by one of the form's column). 
4. Define the content of the message to be displayed/sent. The message can include fields from 
within the form. To add such a field, open the Choose List appearing in the field beneath the text 
window, choose the field from which the desired value should be taken, and click Add Field. 
Example: You can include the order number in a message sent about a specific order. 
5. Use the If section to define the condition or conditions which will cause the message to be sent 
or displayed (e.g., when a specific column receives a specific value or range of values). 
Note: To define a condition based on values appearing in a sub-level form, you must be in the 
sub-level form when opening the Business Rules Generator (upper-level form columns will also 
be available). 
6. Specify the users/companies that the rule is Valid for by completing the fields at the bottom of 
the screen: 
 Myself: For regular users with regular privileges, select this definition to create messages that 
are sent to yourself only. 
 Only…: Privilege group leaders can use this definition to create messages sent to all users in 
the group (or to a single member of the group). The system administrator can use this field to 
send messages to members of any group. 
Stage II: Using the Data Generator 
1. Enter the desired form. 
2. From the Design menu, select Data Generator. 
3. Proceed in a similar fashion to the procedure outlined above for the Business Rules Generator.
