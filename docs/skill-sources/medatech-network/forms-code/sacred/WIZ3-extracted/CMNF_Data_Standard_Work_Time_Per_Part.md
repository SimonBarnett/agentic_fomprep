# CMNF_Data_Standard_Work_Time_Per_Part

- **Source:** `CMNF_Data_Standard_Work_Time_Per_Part.htm`

Costing for Manufacturers - Data: Standard Time of Machines/Unskilled Labor per Part 
 
 
- 
 
 
 
# Defining the Standard Time of an Employee or Machine per Part 

 

Defining standard time per part involves defining a variable that will revise the operation's standard time for that part, according to a given coefficient. This is calculated by multiplying or dividing the coefficient (as per the defined operator) by the variable value defined for the part (and multiplying the result by the time factor, if one is defined). Example. 
 
## To define standard employee or machine time for a part:

 

 1 .  Enter the Operations form and retrieve the desired operation. 
 

 2 .  Enter the Operation Processing Parameters sub-level form. 
 

 3 .  In the Parameter column, specify E for employee time, T for machine/skilled employee time, L for mounting time or U for dismounting time. 
 

 4 .  In the Variable column, specify the variable affecting employee/machine time (e.g., the thickness of a board, which affects the time required to cut it with a saw). 
 

 5 .  In the Operand(C/M/D) column, specify M (for multiplication) or D (for division).
 Tip: If the employee/machine time will increase as a result of the variable, choose M ; if the time will decrease, choose D . 
 

 6 .  In the Coefficient column, record the coefficient by which the variable affects the employee or machine time (e.g., if sawing one centimeter of board takes two minutes, specify 2 ). 
 
## To initialize the variable for a part:

 

 1 .  Enter the Parts form and retrieve the desired part. 
 

 2 .  Enter the Part Processing Parameters sub-level form. Move to the variable you defined and specify the appropriate Value .
