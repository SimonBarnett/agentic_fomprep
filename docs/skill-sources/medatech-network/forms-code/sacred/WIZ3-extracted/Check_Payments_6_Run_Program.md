# Check_Payments_6_Run_Program

- **Source:** `Check_Payments_6_Run_Program.htm`

Check Payments - Preparing Batch Payments.6 
 
 
- 
 
 
 
# To prepare the payment documents:

 

 ·        Run the Prepare Payments program. 
 
## Notes:

 

 ·        The program will not prepare documents for vendors for which payments are blocked (i.e., whose status in the Financial Parameters for Vendors form does not allow for payment), or whose No Payment After date (in the same form) has expired. 
 

 ·        Dual-currency users : If the program is run to prepare payments in the vendor's billing currency or the bank account currency, the currency of the payment document may differ from the currency of the invoice(s) being paid. In such a case, the invoice amount will be adjusted according to the exchange rate in effect on either the invoice date or the payment date. The default adjustment date is determined by the value of the I nv PayExch constant, but can be revised by flagging the Link to Invoice Date column in the Check Invoice Data tab of the payment form. 
 

 ·        Click to review the prepared check payments. 
 

 ·        Click to return to the main screen.
