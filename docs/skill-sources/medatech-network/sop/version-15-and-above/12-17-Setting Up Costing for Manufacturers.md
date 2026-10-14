# 12-17-Setting Up Costing for Manufacturers

- **Source:** `12-17-Setting Up Costing for Manufacturers.pdf`

www.priority -software.com   
1/3 Feb. 08,'15 Ver. 04 Cat.No.  A8000109 
 
 SOP: Setting Up Costing for Manufacturers 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To set up the basic data required to run costing for manufacturers.  
Note: This document does not describe how the costing mechanism works, only how to set up the 
module. 
Working Assumption 
 Basic production data exist in the system, such that allow the management of work orders and 
production reports. 
Procedure 
Stage I: Defining Basic Data 
Aim: To define costing calculation methods, production times and standard costs. 
1. Enter the Warehouses form and make sure that the warehouse to be included in costing 
calculations are flagged in the Transaction Costing and Inventory Valued columns. 
2. Enter the Work Cells form and assign each work cell a value in the Inv./Costing Control 
column, which determines the default costing calculation method for all operations performed in 
that cell. Choose between the following values: 
 R: Reported for inventory control and costing 
 C: Reported for costing purposes only 
 T: For final operations reported in this type of cell – those that create inventory of the 
manufactured part – that are either performed in the factory or by a subcontractor. 
 L: For operations in the middle of the production routing that are either performed in the 
factory or by a subcontractor (costing does not take such operations into account, only T 
operations). 
Note: An empty column indicates that costing does not take this work cell into account at all. 
3. Enter the Operations form and assign each operation a value in the Inv./Costing Control 
column, as defined above. This value overrides the default value defined for the work cell in 
which the operation is performed. Leave this column empty to use the work cell default. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 Feb. 08,'15 Ver. 04 Cat.No.  A8000109 
 
Stage II: Recording Standard Part Costs  
You can record standard costs for Type R parts. The standard cost of a Type P part is calculated 
from the total standard costs of its child parts, plus any additional recorded costs, such as 
subcontracting costs, non-standard costs and supply costs. 
1. Enter the Parts - Std Costs form, retrieve Type P parts and define their standard costs in the 
Subcontract Costs, Non-std Costs, and Supply Costs columns. 
2. In the same form, retrieve Type R parts and do the following: 
 Make sure a value appears in the Std Cost column. 
Notes: 
o You can run the Update Part Costs program, which automatically copies standard part costs 
from a variety of sources (e.g., last price, vendor price). 
o Dual-currency users: You can also record the standard cost in the second currency. 
However, if you do, you are determining the exchange rate for this part with respect to 
costing. Leave that column empty, and costing will calculate data in the second currency 
based on the exchange rate in effect on the day costing is run. 
 If the standard cost of a single part unit is too low, you can define a larger Costing Unit.  
 You can define additional costs that will be added to the part's standard cost in the 
Subcontract Costs, Non-std Costs, and Supply Costs columns. 
3. Enter the Financial Parameters for Parts form and retrieve the parts that are usually shipped to 
you. 
4. For each part, click the Shipping Expenses tab and specify the Shipping Cost Type. Define 
the relevant cost percentage. For example, if you selected Cost Type A, fill in the Air Cost (%) 
column. 
Stage III: Standard Times and Costs for Work Cells and Operations 
1. Enter the Work Cells - Std Costs form and retrieve all work cells. 
2. Record the Machine Cost/Hour and Labor Cost/Hour. 
3. Enter the Operations form and retrieve all the relevant production operations. 
4. For each operation, enter the Operation Processing Parameters sub-level form to define the 
parameters used to calculate the costs of manufactured (Type P) parts. The value T appears 
automatically in the Parameter column of the first line, indicating that machine and skilled labor 
time will be calculated for this operation. 
5. If, for example, the duration of this operation for all parts is the same, specify C in the Operand 
(C/M/D) column and the time in minutes in the Coefficient column. 
6. For operations for which you want to calculate standard unskilled labor costs, add a line with the 
parameter E. 
Note: When standard costing is calculated, hourly machine cost is multiplied by the value defined 
for the operation's T parameter, while hourly labor cost is multiplied by the value defined for the 
operation's E parameter. 
Stage IV: Standard Time – Parts 
Note: Only perform this stage if the standard operation time is not identical for all parts. 
1. Do one of the following:

www.priority -software.com   
3/3 Feb. 08,'15 Ver. 04 Cat.No.  A8000109 
 
 To define standard times for a specific part, enter the Parts form. For each relevant part, enter 
the Part Processing Parameters sub-level form. A line is displayed for each operation in the 
part's production routing for which a variable was defined. If two parameters were defined for 
operations (e.g., T and E), two lines will appear for each operation. The variable receives the 
same code as the operation. 
 To record standard times for a list of parts, use the Part Processing Parameters form. 
2. In the Value column, record the time (in minutes) required to perform the operation on the part in 
question, according to the type of work defined by the Parameter. For example: If the parameter 
is T, the time referred to is the machine time; if E, unskilled labor. 
3. When a part routing or operation variables are revised, the list of part processing parameters is 
automatically updated. To update part processing parameters in a batch, run the Processing 
Param & Set-up Update program. This program adds processing parameter lines to parts based 
on their routings and definitions in the Operation Processing Parameters form. Moreover, the 
check mark is removed from the Valid column for any processing parameters that were 
removed from operations. 
Stage V: Defining the Actual Costing Method 
Costing always calculates according to actual costs. You can define an actual costing method for 
the desired Type P parts, by which costing takes into account actual production reports. 
1. Enter the Parts - Std Costs form and retrieve the desired Type P parts. 
2. In the Costing Option column, specify the appropriate value: 
 T: Part cost is calculated by multiplying the standard quantities of child parts by their actual 
costs, and adding the standard production costs. 
 W: Part cost is calculated on the basis of production reports recorded for closed work orders. 
Note: Use the PActCostType logistics constant to define the default costing method assigned to all 
new Type P parts. 
Stage VI: Initializing the Costing System 
Aim: To define the required parameters by which costing is run. This stage is only performed once, 
before the first costing run. 
 Run the Set Costing Parameters program. 
Note: The results of any costing runs performed before the initialization date will be deleted.
