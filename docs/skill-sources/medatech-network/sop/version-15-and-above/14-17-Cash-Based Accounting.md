# 14-17-Cash-Based Accounting

- **Source:** `14-17-Cash-Based Accounting.pdf`

www.priority -software.com   
1/4 ‏Mar. 03,'15 Ver. 02 Cat.No. LB10000438 
 
 SOP: Cash-Based Accounting 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
This document describes the work process for cash-based accounting. This process entails working 
with pro forma invoices – recording a pro forma invoice for the customer, recording a receipt when 
payment arrives for this invoice, and recording a regular invoice (with a journal entry that is posted 
in the ledger) based on the receipt. 
Setups 
 Make sure the ProFormaBasis constant has a value of “1”. 
 Ensure that the value of the OneInvPerPrj constant meets your requirements. 
 Set properties for pro forma invoices in the Financial Documents form. 
Procedure 
Stage I: Automatic Recording of Pro Forma Invoices 
This stage is relevant if you work with the Project Management and/or Customer Service 
modules. 
1. Run the Prepare Pro Forma Invoices program, and select one of the following options from the 
dialogue box: 
 Selected Projects: If you are working with the Project Management module, the program will 
prepare invoices for all documents linked to a specific project: reported hours, payment for 
finished products, service calls, payment for service contracts. In the form that opens, retrieve 
all projects for which you wish to prepare pro forma invoices, then exit the form. 
 Selected Documents: Choose this option to create pro forma invoices for select service calls 
and service contracts. In the form that opens, retrieve all service documents for which you 
wish to prepare pro forma invoices, then exit the form. 
 All Documents: Select this to create pro forma invoices for all service calls and service 
contracts up to a designated payment date (as indicated in the next dialogue box). 
2. Indicate the relevant payment dates and the pro forma invoice date. 
Result 
 Pending pro forma invoices that are linked to the project or the service documents have been 
recorded. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/4 ‏Mar. 03,'15 Ver. 02 Cat.No. LB10000438 
 
Stage II: Finalizing and Printing the Pending Pro Forma Invoices 
1. Enter the Pro Forma Invoices form and retrieve the invoices created by the program. 
2. Verify the invoice details: quantities, payment terms, transaction type, payment dates, and so 
on. 
3. Select Finalize Invoice/Memo or Finalize & Print Invoice from the list of Direct Activations. 
Results 
 A pro forma journal entry is recorded for each invoice. The entry debits the customer account and 
credits the relevant income account. 
 If the invoices are linked to a project, project profitability increases, as the pro forma invoices are 
added to projected revenue (in the Open Pro Forma Invs. column). 
 A/R aging for the customer takes the pro forma invoice in account. 
Stage III: Recording a Receipt Based on a Pro Forma Invoice 
Note: Execute this stage once payment is received from the customer. 
1. Enter the Receipts form. 
2. Choose the Customer's Account. The Customer/Acct Name is filled in automatically. 
3. Ensure that the correct Cashier appears. When recording a receipt of payment by bank transfer 
or by credit card, you can use this column to record the bank account number to which payment 
is being made. 
4. In the Project tab, record the relevant project number. 
5. Enter the Flag Pro Forma Invoices sub-level form. 
6. Flag all pro forma invoices for which payment is being made (either in full or in part). 
7. Enter the parallel Invoice Amounts Being Paid sub-level form. All invoices that were flagged in 
the previous step appear. 
8. If necessary, modify the recorded Sum. 
9. To itemize cash receipts: 
 Return to the upper-level form and click the Receipt Data tab. 
 In the Cash Receipts column, record the amount of cash received. 
10. To itemize check receipts: 
 Enter the parallel Check Payment (Details) sub-level form. 
 For each check, record all necessary details. 
11. To itemize receipts for other forms of payment: 
 Move to the parallel Other Forms of Payment (Details) sub-level form. 
 In the Payment Code column, select the appropriate payment code (e.g., bank transfer). 
12. To finalize the receipt:  
 Return to the Receipts upper-level form. 
 Select Finalize Receipt (or Finalize & Print Receipt) from the list of Direct Activations. 
13. To finalize a group of receipts:

www.priority -software.com   
3/4 ‏Mar. 03,'15 Ver. 02 Cat.No. LB10000438 
 
 Run the Finalize Receipts program. 
 In the query form that opens, retrieve the receipts that you wish to finalize. If receipts which 
you do not wish to finalize were also retrieved, they can be erased from the form using F7. 
 Exit the form and confirm the Continue system message. 
 At the end of the program, you will receive a message about the number of receipts finalized. 
If an error was detected during finalization of the receipts, a message refers you to the errors 
report. 
 To review the errors, run the Prepare Invoices - Errors report. 
Results 
 A journal entry crediting the customer and debiting the cashier is recorded for each receipt. 
 If the receipt is linked to a project, projected revenue (Open Pro Forma Invs.) is decreased by 
the amount of payment. 
 Those pro forma invoices that were flagged for payment in full no longer appear in the 
Unreconciled Pro Forma Entries form for the account (a sub-level form of Chart of Accounts 
Receivable) or in aging reports. 
 The receipt and its linked invoice(s) are reconciled, in keeping with reconciliation definitions 
recorded during system setup. 
Stage IV: Manually Recording an Invoice for the Receipts 
1. Enter the Multi-Shipment Invoices form. 
2. Select the customer in the Customer No. column and indicate the relevant Contact. 
Notes: 
 The Date column is filled in automatically with today's date, but may be revised. 
 A pending invoice number is displayed in the Invoice No. column, with the prefix “T”. 
3. If the invoice is based on a sales order, enter the References tab and record the Order. 
4. In the Price tab, make sure the Currency of the invoice is correct. The customer's billing 
currency appears automatically, but may be revised. 
5. In the Project tab, record the relevant Project Number. 
6. Enter the Link Receipts to Invoice sub-level form. 
7. Flag the receipts against which you are issuing the invoice and return to the upper-level form. 
8. Enter the Invoice Items sub-level form. The invoice is itemized with the lines from the pro forma 
invoices for which the flagged receipts were issued. 
9. Ensure that the Part Number, Quantity, Unit Price, and % Item Discount are correct. 
10. Return to the upper-level form. In the Price tab, review the total price and discounts. 
11. Select Finalize Invoice/Memo or Finalize & Print Invoice/Memo from the list of Direct 
Activations. 
Note: You can also prepare multi-shipment invoices based on receipts automatically, by running the 
Prepare Invoices program. In the first input screen of the program, select the option to prepare for 
Selected Receipts.

www.priority -software.com   
4/4 ‏Mar. 03,'15 Ver. 02 Cat.No. LB10000438 
 
Results 
 A journal entry is posted to the ledger. 
 If the invoice is linked to a project, actual revenue for the project increases (under Customer 
Invoices) and projected revenue decreases (under Open Pro Forma Invs.). 
 Project profitability is correct at any given moment. 
 The A/R account ledger gives a complete picture of the customer account: In the Ledger 
Transactions - YTD form, you can view receipts and multi-shipment invoices. In the Pro Forma 
Entries form, you can view pro forma invoices and receipts. In the Unreconciled Pro Forma 
Entries form, you can view all pro forma entries that were recorded against the account and 
have not yet been reconciled.
