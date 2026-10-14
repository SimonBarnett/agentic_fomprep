# Mdl_Oper_Standard_Work_Time_Per_Part

- **Source:** `Mdl_Oper_Standard_Work_Time_Per_Part.htm`

Modeling - Defining Variable Employee/Machine Time for Operations 
 
 
- 
 
 
 
# Defining Variable Employee or Machine Time

 

If the standard time required for the operation depends on some attribute of the part, you need to define a variable for the time parameter of the operation and later assign variable values to each part based on the attribute in question (see the “Define Parts for Production” section at the end of this wizard). Example. 
 
## To define variable employee or machine time:

 

 1 .  Enter the Operations form and retrieve the desired operation. 
 

 2 .  Enter the Operation Processing Parameters sub-level form. 
 

 3 .  In the Parameter column, specify E for employee time or T for machine/skilled employee time. 
 

 4 .  In the Variable column, specify the variable affecting employee/machine time.
 Note: If this parameter is only modified by one variable, you can leave the operation code as the variable name. 
 

 5 .  In the Operand(C/M/D) column, specify M (for multiplication) or D (for division).
 Tip: If the employee/machine time will increase as a result of the variable, choose M ; if the time will decrease, choose D . 
 

 6 .  In the Coefficient column, record the coefficient by which the variable affects the employee or machine time (e.g., if sawing one centimeter of board takes two minutes, specify 2 ). 
 

 7 .  Click to set up time factoring. 
 
## Notes:

 

 ·        Click to assign operations to a routing. 
 

 ·        Click to define constant labor and machine time for an operation. 
 

 ·        Click to return to the Processing Parameters menu.
