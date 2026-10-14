# service_contracts_installments_single

- **Source:** `service_contracts_installments_single.htm`

Service Contracts - Calculating Single Payment Installments Automatically.1 
 
 
- 
 
 
 
# Calculating a Payment Installment for a Single Contract

 
## Before you begin:

 

 1 .  Enter the Service Contracts form and retrieve the desired contract. 
 

 2 .  Click the Dates in Effect tab and make sure that the contract has a Status that permits you to record payments.
 Note: Payment installments can only be previewed and calculated when the contract has a status flagged as Can Record Payments in the Statuses for Service Contracts form (e.g., Active , Approved ). 
 

 3 .  Run the Calc. Paymt Installments-Preview report for the desired contract. 
 

 4 .  Check the results of the report. Click if you encounter any problems . 
 

 5 .  If you corrected problems, run the report again. Make sure you are satisfied with the results. 
 
## To calculate the payment installment:

 

 1 .  Return to the Service Contracts form, select Calc. Installmts for This Month or Calc. Installmts for Next Month from the list of Direct Activation s . 
 

 2 .  Enter the Payment Installments sub-level form and check that all information is correct. 
 

 3 .  The serviced part that will appear in the invoice for the contract payment appears automatically in the Part to Charge column, according to the value of the InvContPart constant. You can override the constant and specify a different part, as needed. 
 

 4 .  To exempt the customer from part (or all) of the installment, add a line to the Payment Installments form. Record the sum to write off and flag the Exempt from Payment column. 
 

 5 .  If the installment still needs to be checked (e.g., with the customer), flag the Checking column. When you are ready to bill the customer, remove the flag. 
 
## Notes:

 

 ·        D ual-currency users: If the contract is linked to a foreign currency, currency basket or price index, the program automatically takes the linkage into account when calculating payments. Use the Linkage Calculations sub-level form to view these calculations. For more information about linking service contract payments, run the Price Adjustment Wizard . 
 

 ·        Click to prepare the invoice. 
 

 ·        Click to return to the main screen.
