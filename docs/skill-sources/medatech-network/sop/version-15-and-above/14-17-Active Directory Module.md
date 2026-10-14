# 14-17-Active Directory Module

- **Source:** `14-17-Active Directory Module.pdf`

www.priority -software.com   
1/2 Feb. 02, '15 Ver.02 Cat.No. LB10000444 
 
 SOP: Working with Priority’s Active Directory Module1 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To define working parameters for Priority‘s Active Directory module. 
Setups 
 Set up privilege group leaders in Priority and define appropriate application privileges for these 
group leaders – see Standard Operating Procedures for user setup. 
 Install a license for Priority‘s Active Directory module. 
Procedure 
Currently each employee who uses Priority is defined twice; once as a user in Windows Active 
Directory (AD) and again as a user in Priority. The aim of this module is to act as a single system 
for creating users in the organization, in order to avoid redundant user definitions and to maintain 
passwords for a single system only (Active Directory), so that users who have logged in to Windows 
do not need to log in separately to Priority. 
Stage I: Defining Working Parameters 
Aim: To define initial (one-time) parameters before commencing work on the Active Directory 
module. 
1. Enter the Users form. 
2. Retrieve the user record linked to the system manager (Employee Name = Manager) and move 
to the User Permissions sub-level form.  
3. Record the Windows Login that will be linked to the system manager.  
4. Return to the upper-level form and select Update Windows Login from the list of Direct 
Activations. 
5. If active users exist in the system, retrieve their user records, re-enter the sub-level form and 
record their Windows Login as well; then return to the upper-level form and select Update 
Windows Login from the list of Direct Activations. 
6. Run the Activate Use of Active Directory program. 
7. Enter the System Constants form and change the value of the ADAUTOOPEN system constant 
to “2”. This will enable setup of employees in the system, and users linked to them will be able to 
access Priority only once a Windows Login is recorded in their user record. 
Stage II: Linking Active Directory Groups to Priority Group Leaders  
Aim: To define user privileges for the Active Directory groups. 
                                                
1 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 Feb. 02, '15 Ver.02 Cat.No. LB10000444 
 
1. Enter the Groups in Active Directory form. 
2. Specify the group leader in Priority that corresponds to each privilege group by changing the 
value of the Priv. Group Leader column for the appropriate AD group. 
3. If an employee is linked to a number of AD groups, his or her privilege group is determined 
according to the Order defined in this form. 
Stage III: Accessing Priority for Routine Work 
When accessing Priority after logging in as a network user, no user identification or password is 
required, and the employee’s privilege profile is identical to that defined for his or her Active 
Directory group.
