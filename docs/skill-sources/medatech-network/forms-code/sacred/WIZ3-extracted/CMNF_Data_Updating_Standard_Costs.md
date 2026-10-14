# CMNF_Data_Updating_Standard_Costs

- **Source:** `CMNF_Data_Updating_Standard_Costs.htm`

Costing for Manufacturers - Data: Updating Standard Costs 
 
 
- 
 
 
 
# Updating Standard Costs 

 

The standard cost of raw materials appears in the Part Catalogue and Parts - Std Costs forms, where they serve both as input data to costing calculations (together with standard shipping costs) and as default values for actual raw material costs. 
 

The standard cost of a processed part is calculated according to the standard costs of its child parts, depending on the Standard Part Costs option chosen when running the Set Costing Parameters program. 
 

 Note: 
 

Costing does not update the values recorded for Type R parts according to the calculated standard cost (which includes shipping costs), but it does update the standard costs of Type P parts, provided that the UpdStdCost constant is set to 1 . 
 
## To update standard material costs manually:

 

 1 .  Do one of the following: 
 

 ·              To update costs according to the parts' buy/sell units, enter the Part Catalogue form. 
 

 ·              To update costs according to the parts' factory units, enter the Parts - Std Costs form. 
 

 2 .  Retrieve the desired part or parts.
 Tip: To check for parts that have not been assigned a standard cost, retrieve all parts with 0 in the Std Cost column (for dual-currency users, with 0 in both Std Cost columns). 
 

 3 .  Record part prices in the Std Cost column. Dual-currency users can choose either the local or second currency Std Cost columns, according to their company's method of price management.
 Note: If you specify the cost of a part in both the local and second currency Std Cost columns, you thereby set the exchange rate for that part. That is, costing reports will display its local-currency costs according to the exchange rate derived from the values recorded here, and not according to the exchange rate in effect on the report date. 
 
## To update standard costs automatically:

 

 ·        Run the Update Part Costs program for the desired part(s) and select the appropriate option.
 Notes: 
 

 ·              Click to review and update last prices as a source for standard costs . 
 

 ·              If you chose to update costs according to one of the available options, part costs are updated until the next costing run, when they are recalculated. 
 
## To update standard processed part costs on the basis of standard material costs:

 

 ·        Run the Calculate/Update Standard Cost program for the desired part(s).
 Notes: 
 

 ·              The program only updates the standard cost if the existing standard cost was 0 . 
 

 ·              If the UpdStdCost constant is set to 1 , the calculated cost is overwritten by the standard cost calculated during the next costing run.
