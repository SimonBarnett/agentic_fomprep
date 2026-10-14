# TSCosting_Std_P_Otr_Hrs_1

- **Source:** `TSCosting_Std_P_Otr_Hrs_1.htm`

Troubleshooting Costing - Std Cost, Type P.12 
 
 
- 
 
 
 
# Checking Work Hour Costs for Employees and Machines

 

In order to check the costing results for a processed part, you need to calculate its production costs on the basis of the processing parameters defined for each operation in the part’s routing. 
 

The standard work hours required to perform a given operation on a single part unit is determined by the processing parameters T (machine hours and skilled labor) and E (unskilled labor hours). This value may be the same for all parts undergoing the operation, or differ for each individual part. 
 
## Before you begin

 

 1 .  Enter the Parts form and retrieve the part in question. 
 

 2 .  Move to the Routing column and press F6 twice to enter the Routings form. 
 

 3 .  Enter the Operations in Routing sub-level form and note the operations listed in that form. 
 

 4 .  Enter the Operations form and retrieve each of the operations noted in the previous step. 
 

 5 .  Enter the Operation Processing Parameters sub-level form, and do one of the following for each parameter: 
 

 ·      If the value of the Operand column is C , note the value of the Coefficient column. This value represents the number of minutes required to perform this operation on a single unit of any part in the system. 
 

 ·      If the value is M or D , note the values of both the Variable and the Coefficient column.
 Notes : 
 

 ·      The coefficient value defined for the operation and the variable, together with the part’s defined value for the operation and the variable, determine the work hours for the operation and for the part in the following manner: if M is defined, the coefficient value is multiplied by the part value. If D is defined, the coefficient value is divided by the part value. 
 

 ·      To define the part value for any of the part’s production operations, use the Part Processing Parameters form.
