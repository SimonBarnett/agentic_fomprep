# service_contracts_installments_batch

- **Source:** `service_contracts_installments_batch.htm`

Service Contracts - Calculating Batch Payment Installments.1 
 
 
- 
 
 
 
# Calculating Payment Installments in a Batch

 
## Before you begin:

 

 1 .  Run the Calc. Paymt Installments-Preview report. 
 

 2 .  Check the results of the report. Click if you encounter any problems . 
 

 3 .  If you corrected problems, run the report again. Make sure you are satisfied with the results. 
 

 4 .  Print the final report for later reference. 
 
## To calculate the payment installments:

 

 1 .  Run the Calculate Payment Installments program, which automatically opens one installment for each contract. You can calculate payments for this month, next month or another month. 
 

 2 .  To check the results, enter the Service Contracts form and retrieve the contracts in question.
 Tip: Use the printout of the preview report to identify the contracts in question. 
 

 3 .  For each contract, enter the Payment Installments sub-level form and check that all information is correct. 
 

 4 .  The serviced part that will appear in the invoice for the contract payment appears automatically in the Part to Charge column, according to the value of the InvContPart constant. You can override the constant and specify a different part, as needed. 
 

 5 .  To exempt a customer from part (or all) of the installment, add a line to the Payment Installments form. Record the sum to write off and flag the Exempt from Payment column. 
 

 6 .  If an installment still needs to be checked (e.g., with the customer), flag the Checking column. When you are ready to bill the customer, remove the flag. 
 
## Notes:

 

 ·        D ual-currency users: If the contract is linked to a foreign currency, currency basket or price index, the program automatically takes the linkage into account when calculating payments. Use the Linkage Calculations sub-level form to view these calculations. For more information about linking service contract payments, run the Price Adjustment Wizard . 
 

 ·        Click to prepare the invoice. 
 

 ·        Click to return to the main screen.
