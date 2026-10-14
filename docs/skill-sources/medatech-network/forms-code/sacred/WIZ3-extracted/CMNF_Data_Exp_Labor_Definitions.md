# CMNF_Data_Exp_Labor_Definitions

- **Source:** `CMNF_Data_Exp_Labor_Definitions.htm`

Costing for Manufacturers - Data: Standard Labor Definitions 
 
 
- 
 
 
 
# Standard labor/machinery cost 

 

For each work cell in the factory (or for all work cells in a certain department), you need to define the standard hourly cost of employing unskilled labor and running machines. You can also define standard setup costs, as a percentage of the work time of each employee and machine, and mount/dismount times for each work cell, as well as any indirect costs incurred by the employee or machine. If an operation requires skilled labor, you can define special standard costs for each skill type. 
 

These costs will be taken into account both by standard and actual costing. In standard costing, they are multiplied by the standard work time defined for the employee and the machine. In actual costing, they are multiplied by reported production times. 
 
## Note:

 

Defining work shifts allows you to automatically multiply actual labor costs by a given percentage, for work performed under special circumstances (e.g., at night, during holidays). 
 
## Standard labor/machinery time 

 

For each operation performed in a work cell, you need to define the standard work time for unskilled employees ( E ) and for machines and the skilled employees who work them ( T ). You can also record the mount ( L ) and dismount ( U ) times required to set up the machines in the work cell. These values affect the calculation of setup costs, as well as indirect machine costs. 
 

Employee/machine time is recorded in minutes and can either be constant for an operation, or vary according to the part undergoing the operation. Example. 
 

When skilled employees are working the machines, you need to record the number of employees and their skills. 
 

The E , T , L and U parameters determine standard production times. If you need to adjust production times by a fixed factor (e.g., due to a change in season), Priority provides a time factoring mechanism that allows you to adjust these parameters without changing the recorded standard values. Example.
