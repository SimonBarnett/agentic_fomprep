# CMNF_Setup_Costing_Option

- **Source:** `CMNF_Setup_Costing_Option.htm`

Costing for Manufacturers - Setup: Calculation Method.1 
 
 
- 
 
 
 
# Choosing the Method of Calculating the Actual Cost of Manufactured Parts

 

The method used to calculate the actual cost of a manufactured part is determined by the value appearing in the Costing Option column of the Parts - Std Costs form: 
 

 ·        If W appears, the part cost is calculated on the basis of closed work orders. 
 

 ·        If T appears, the part cost is calculated by multiplying the standard quantities of its child parts (i.e., those recorded in the BOM) by their actual costs, and adding standard production costs. 
 
## Notes:

 

 ·        The value assigned to the PActCostType constant determines the default costing option, which is thereafter applied to any new manufactured parts. 
 

 ·        It is possible to calculate work order costs for parts assigned costing option T . To do so, select Costing for Wk Ords when you run the Set Costing Parameters program. 
 

Usually, you assign W to all parts for which work orders are maintained. This method is most effective when work order definitions, part issues and production reports are orderly and complete. If they are not, you should use option T to calculate actual costs. It is advisable to use option T when you first begin to work in the system, then switch to option W when your company's production control system is running smoothly. 
 Note: You should only switch the costing option at the beginning of a new costing period .
