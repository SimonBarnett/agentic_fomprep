# SOP Defining Branches

- **Source:** `SOP Defining Branches.pdf`

Cat.No. LB10000134 1 Ver.1 – June 17, ’10 
 
SOP: Defining Branches* 
Customer:  Company Inc. 
Assigned to: Dept./Position 
Aims 
 To divide the system into various company branches and distinguish between 
financial and inventory transactions recorded in the various branches. 
 To assign employees to branches and define each employee's regular office 
hours at each branch. These definitions can then be used to schedule shifts for 
employees at the designated branches. 
Setups 
 Define warehouses in the system. 
 Define cashiers. 
 Define profit/cost centers. 
 Define appointment durations. 
 Define task codes. 
 Define task types. 
 Define reasons for canceling shifts. 
Procedure 
Stage I: Opening a Branch 
1. Enter the Branches form. 
2. Define a Branch Code.  
3. Record a Branch Name. 
4. Record the relevant information in the Address and Phone tab. 
5. Click the Branch Details tab and link the appropriate Warehouse to the branch. 
6. In the Branch Identifier column, record a code (using letter and/or numbers) that 
will identify the branch. This code will be integrated in the numbers of transaction 
documents recorded for the branch, after you run the Open Numeration 
Templates program.  
7. If you work with walk-in customers, you can assign a different one to each 
branch. To do so, specify the appropriate A/R account in the Branch Walk-in 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their 
own requirements and work practices.

Cust column. This customer will appear automatically as the default in any 
transaction recorded by any user associated with this branch. 
Note: Make sure that multiple walk-in accounts have been set up. 
8. Click the Financial Data tab and fill in the Branch Cashier, Ret'd Checks 
Cashier and Profit/Cost Center columns. 
9. To view the employees linked to a given branch, enter the Branch Employees 
sub-level form.  
Note: Employees are linked to a branch in the Company-Specific Information 
form, a sub-level of the Personnel File. 
Results 
 
Inventory transaction documents opened in a given branch automatically display 
the warehouse defined for the branch to which the employee who opened the 
document is linked. 
 Designating a warehouse in a customer shipment or invoice automatically links 
the document to the branch for which that warehouse is defined, provided that 
the employee who opened the document, or the customer for which the 
document was opened, is not linked to a different branch. 
 When you open a document for a given branch, the document number will begin 
with the branch identifier. In this manner you can distinguish easily between 
branch documents and prevent duplication. 
 Financial documents opened by employees linked to a given branch 
automatically display the cashier defined for that branch. 
 The profit/cost center defined for a branch appears automatically in all documents 
opened for that branch. 
Stage II: Assigning Employees to Branches 
1. Enter the Branches form. Retrieve the branch in question.  
2. Enter the Employees in Branch sub-level form and indicate the user name of 
each employee who works at this branch. For each employee, specify the default 
Appointment Duration, Task Code and Task Type to be assigned to tasks 
opened by this user at the current branch. 
3. Move to the Work Hours at Branch sub-level form to record regular office hours 
for the current employee and branch. 
4. To define the frequency (in weeks) at which a shift should be scheduled for this 
employee and branch during the specified office hours on this day of the week, 
record the desired value in the Frequency (Weeks) column. 
Tip: You can also use the Branch Employees form to view or update the list of 
employees that work in different branches. 
Result 
 
A list of branch employees, and their regular office hours at each branch, has 
been defined in the system, together with default definitions for tasks that are 
opened for these users. 
Stage III: Scheduling Shifts for Branch Employees 
1. Run the Create Shifts program. 
Cat.No. LB10000134 2 Ver.1 – June 17, ’10

Cat.No. LB10000134 3 Ver.1 – June 17, ’10 
2. In the program input, specify the branch at which to schedule the employee shifts, 
the range of dates during which to schedule shifts and the user name of the 
employee for whom to schedule shifts. 
Results 
 
Shifts are recorded for the designated employee and branch in the Employee 
Shifts form, based on the office hours defined for the employee and branch in the 
Work Hours at Branch form. 
 Appointments that are created for each employee (in the Appointment 
Calendar) are scheduled according to employee shifts. 
Stage IV: Canceling Shifts for Branch Employees 
1. Enter the Employee Shifts form and retrieve the shift(s) to be canceled. 
2. Flag the Canceled column and choose the relevant Cancellation Code. 
Result 
 
Canceled shifts do not appear as available time slots in the Appointment 
Calendar.
