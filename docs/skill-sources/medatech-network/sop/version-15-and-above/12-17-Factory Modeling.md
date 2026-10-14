# 12-17-Factory Modeling

- **Source:** `12-17-Factory Modeling.pdf`

www.priority -software.com   
1/3 ‏Feb. 03, '15 
'15 
Ver.02 Cat.No. A8000061 
 
 SOP: Factory Modeling 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To set up the production process at your factory. 
Setup 
 Bills of materials (BOM) have been defined. 
Procedure 
Stage I: Defining Work Patterns 
Work patterns define the days and hours of activity at the factory's work cells. 
Note: A given work pattern can be linked to several work cells. For example, if all the factory's work 
cells are in operation during the same days and hours, you should define a single work pattern and 
link it to all work cells. 
1. Enter the Work Patterns form. 
2. Record a code in the Work Pattern column. 
3. Record a Pattern Description. 
4. Enter the Pattern Timetable sub-level form. 
5. In the Day column, specify the days on which the work cell for which this pattern is defined is 
active.  
6. In the Start and End columns, specify the hours when activity begins and ends on each day. 
7. Open a new line for each day. 
Stage II: Defining Production Departments 
Production departments are defined for informative purposes, and appear in production and 
workload reports for work cells. 
1. Enter the Departments form. 
2. Record a code for each department in the Department column. 
3. Record a Department Desc. 
4. Assign a Work Pattern to the department, which will apply by default to the work cells attached 
to the department. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 ‏Feb. 03, '15 
'15 
Ver.02 Cat.No. A8000061 
 
Stage III: Defining Work Cells 
A work cell is a machine, group of machines or group of employees that performs certain production 
operations. 
1. Enter the Work Cells form. 
2. Record a code for each work cell in the Work Cell column. 
3. Record a WorkC Description. 
4. Specify the appropriate Inv./Costing Control: 
 R: If the production operations performed in the work cell are always performed in the factory. 
 T: If the production operations performed in the work cell are performed by a subcontractor. 
 Leave the column blank if the production operations performed in the work cell (whether in 
the factory or by a subcontractor) are not reported. 
 C: If you do not want to maintain inventory control in the work cell (i.e., production quantities 
are not reported), but you do want the work cell to be taken into account during costing. 
5. Select the Warehouse (Type F) in which the production process will be performed (i.e., in which 
the plant floor inventory used by the work cell is maintained). 
6. Assign the work cell to a Department. 
7. Specify a Work Pattern for the work cell, if you do not want to use the default work pattern 
defined for the department to which the work cell belongs. 
Stage IV: Defining Production Operations 
1. Enter the Operations form. 
2. Define a code for each operation in the Operation column. 
3. Record the Operation Descrip.. 
4. Specify the Work Cell in which the operation is performed. 
Note: An operation can only be assigned to a single work cell. 
5. Specify the appropriate Inv./Costing Control: 
 Leave the column blank to use the default setting defined for the work cell in which the 
operation is performed. 
 R: If the operation is always performed in the factory. 
 T: If the operation is performed by a subcontractor. 
 C: If you do not want to maintain inventory control for this operation (i.e., production quantities 
are not reported), but you do want the operation to be taken into account during costing. 
Note: If the operation is never reported, leave this column blank and make sure it is blank in the 
work cell as well. 
Stage V: Defining Production Routings 
A routing is a series of operations that must be performed in order to produce a given part. 
1. Enter the Routings form. 
2. Define a code for each routing in the Routing column.

www.priority -software.com   
3/3 ‏Feb. 03, '15 
'15 
Ver.02 Cat.No. A8000061 
 
3. Record a Routing Description. 
4. Enter the Operations in Routing sub-level form. 
5. In the Step column, record a number signifying the chronological order of each operation in the 
routing (e.g., Step 10 – Operation X, Step 20, Operation Y). 
Note: It is recommended not to assign consecutive numbers, in order to leave room for 
additional operations that may need to be added to the routing later on (e.g., Step 15 – 
Operation XX). 
6. For each step, record the relevant Operation. The Operation Descrip., Work Cell and WorkC 
Description are filled in automatically. 
7. In the To Warehouse column, specify the warehouse to which the manufactured parts will be 
transferred when the operation is completed. 
Note: This column is generally used only for the last operation in the routing, in which case it 
defines the warehouse that receives the finished product. Nonetheless, you can also use it for 
an intermediary operation when the next operation in the routing requires that the parts be in a 
different warehouse. 
8. In the last operation in the routing: 
 Flag the Remove Oper. Number column. 
 If your organization does not maintain finished product inventory with work order numbers, flag 
the Remove Wk Order No. column. 
Stage VI: Linking a Routing to a Part 
1. Enter the Parts form. 
2. Retrieve the part for which you want to assign a routing. 
3. Specify the appropriate Routing in the General tab. 
Stage VII: Linking a Work Order Template to a Part 
1. Enter the Parts form. 
2. Retrieve the part to which you want to link a template. 
3. Move to the Part Number column. 
4. Select Assign WO/Lot Templates to Parts from the list of Direct Activations. 
5. In the form that opens, assign the appropriate Wk Ord/Lot Template to the part.
