# TSCosting_Act_P_Otr_W_Zero_Hrs

- **Source:** `TSCosting_Act_P_Otr_W_Zero_Hrs.htm`

Troubleshooting Costing - Actual Cost, Type P.11 
 
 
- 
 
 
 
# To check production costs:

 

 1 .  Enter the Work Orders form and retrieve the work orders in question. 
 

 2 .  For each work order, enter the Progress Report sub-level form and note the work cell in which the reported operation is performed. 
 

 3 .  Enter the Work Cells - Std Costs form, retrieve the relevant work cell and note the following: 
 

 ·      direct and indirect machine costs 
 

 ·      direct and indirect labor costs (unskilled employees) 
 

 ·      setup time (as a percentage of machine time) and cost 
 

 4 .  Return to the Progress Report form and note the machine and labor hours reported for the current operation, in the Span and Labor Span columns, respectively. 
 

 5 .  If a value appears in the Employee ID column (in either the Progress Report form or its sub-level), press F6 twice to enter the Company-Specific Information sub-level of the Personnel File form. 
 

 6 .  Check the Skill column in the Details tab. If a skill is defined for the employee, retrieve it in the Skilled Labor - Std Costs form. Then enter the Skilled Labor Costs sub-level form and note the direct and indirect costs that were in effect the date of the costing run. 
 

 7 .  Calculate the correct production costs according to the following formulas: 
 

 ·      Direct machine cost = span * machine cost/hour, in production reports where the Set-up /Break column is blank or marked B (breaks). 
 

 ·      Indirect machine cost = span * indirect machine cost/hour, in production reports where the Set-up /Break column is blank or marked B (breaks). 
 

 ·      Direct labor cost = labor span * labor cost/hour (based on the cost of a regular employee at the work cell if no skill is assigned to the employee, or based on the cost of a skilled worker if a skill is recorded) * shift rate, in production reports where the Set-up /Break column is blank or marked B (breaks). 
 

 ·      Indirect labor cost = labor span * indirect labor cost/hou r(based on the cost of a regular employee at the work cell if no skill is assigned to the employee, or based on the cost of a skilled worker if a skill is recorded) * shift rate, in production reports where the Set-up /Break column is blank or marked B (breaks). 
 

 ·      Setup cost = machine span * standard setup cost for operations marked S in the Set-up /Break column.
 Note: If labor hours are reported in the same record, they will be multiplied by direct and indirect labor costs and the result added to the setup cost. 
 

 ·      Rework cost = (setup cost + direct labor cost + indirect labor cost) * labor span + (setup cost + direct machine cost + indirect machine cost) * span, in production reports of operations flagged in the form as Rework .
