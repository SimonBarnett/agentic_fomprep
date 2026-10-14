# 14-15-Cash-Based Accounting (Vendors)

- **Source:** `14-15-Cash-Based Accounting (Vendors).pdf`

Cat.No. LB10000718 1 Ver.1 – Oct. 25,’10 
 
SOP: Cash-Based Accounting  Vendors* 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
This document describes how to work with vendors that operate on a cash basis. This 
process entails working with vendor pro forma invoices – recording the pro forma invoice 
received from the vendor, issuing a payment for this invoice, and subsequently recording 
a regular purchase invoice (resulting in a journal entry that is posted to the ledger) once 
a regular invoice is received from the vendor. 
Setups 
 Set properties for pro forma invoices in the Financial Documents form. 
 For any vendors that work with pro forma invoices, flag the Pro Forma Invoices 
column of the Vendors form. 
Procedure 
Stage I: Recording a Vendor Pro Forma Invoice 
1. Enter the Vendor Pro Forma Invoices form. 
2. Specify the number of the vendor that is billing you, record a Date for the invoice and 
specify the vendor's Invoice Number (the number appearing on the original invoice).  
3. Do one of the following: 
 If the invoice is based on a single GRV or purchase order, specify its number in the 
Document Number or Order Number column of the References tab, 
respectively. 
 If the invoice is based on several GRV and/or any vendor returns, enter the GRV's 
for Invoice and/or Return Documents for Invoice sub-level forms, respectively. 
In the relevant form, record a line for each GRV or return document being 
billed/credited in this invoice. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

 If the invoice is based on several purchase orders, or on lines from within several 
different purchase orders, enter the Choose Order Items sub-level form and 
select the desired order items. 
4. Enter the  Invoice Items sub-level form, which automatically displays the lines from 
any GRVs, return documents and/or purchase orders selected for this invoice. 
5. Record any additional items manually by specifying the relevant Part Number, Inv. 
Quantity and Unit Price. 
6. To record remarks pertaining to this invoice that will appear in the printout, use the  
Invoice/Memo - Remarks sub-level form. 
7. To define payment installments for the invoice that differ from the vendor's standard 
payment terms, enter the Payment Installments sub-level form. 
8. Return to the upper-level form, click the Price  tab and make sure that the Amount 
Owing is correct. 
9. Select Finalize Invoice/Memo or Finalize & Print Invoice from the list of Direct 
Activations. 
Results 
 A 
unique Internal Invoice number is assigned to the invoice. 
 If the invoice is linked to a project, project profitability decreases, as the invoice total 
is added to projected costs (in the Open Vend Pro Formas column). 
 A pro forma journal entry (with the "VPF " entry code) is recorded for the invoice, and 
assigned an entry number with the prefix P. 
Note: To run aged payable reports for the vendor, run the reports as usual and, in the 
appropriate input screen, flag the option to base the report on Pro Forma Entries. 
Stage II: Recording a Payment Based on a Vendor Pro Forma Invoice 
Payment by Check 
1. Enter the Check Payments form. 
2. Choose the Vendor's Account. The Vendor Name is filled in automatically. 
3. In the Paying Bank Account column, choose the bank account number from which 
payment is being made. 
4. Ensure that the correct Check Date and Currency appear. 
5. Enter the Flag Pro Forma Invoices sub-level form and flag all pro forma invoices for 
which payment is being made. 
6. Enter the parallel Payment Details  sub-level form and, if necessary, modify the 
recorded Sum. 
7. Return to the upper-level form and select Finalize Check Payment from the list of 
Direct Activations. 
8. To print the check, select  Print Checks Via Word Template from the list of Direct 
Activations, specifying the desired Check Number. 
Cat.No. LB10000718 2 Ver.1 – Oct. 25,’10

Note: The Check Number is filled in automatically based on the Next Check to 
Print column of the Bank Accounts form, but may be revised. 
Payment by Bank Transfer 
1. Enter 
the Payments by Bank Transfer form. 
2. Choose the Vendor's Account. The Vendor Name is filled in automatically. 
3. In the Paying Bank Account column, choose the bank account number from which 
payment is being made. 
4. Ensure that the correct Payment Date and Currency appear. 
5. Enter the Flag Pro Forma Invoices sub-level form and flag all pro forma invoices for 
which payment is being made. 
6. Enter the parallel Payment Details  sub-level form and, if necessary, modify the 
recorded Sum. 
7. Return to the upper-level form and select Finalize Bank Transfer Payment from the 
list of Direct Activations. 
Results 
 
The payment and its linked invoice are reconciled. 
 The paid invoice will not appear in aged payable reports based on pro forma entries. 
 The pro forma invoice can no longer be flagged for payment when preparing vendor 
payments. 
Stage III: Recording a Multi-GRV Invoice for the Payments 
1. Enter the  Multi-GRV Invoices form. 
2. Select the vendor in the Vendor Number column. 
3. In the Date column, indicate the date of the purchase invoice. 
4. Specify the vendor's Invoice Number. 
5. A temporary Internal Invoice number (with the prefix T) is filled in automatically and 
the Debit/Credit column is flagged with a D (revise this in the case of a credit 
memo). 
6. By default, the transaction date in the journal entry for the invoice is the invoice date. 
To use a different date, click the Payment Info tab and indicate the desired 
Transaction Date. 
7. In the Payment Info tab, the Payment Date is filled in automatically on the basis of 
the payment terms agreed upon with the vendor, but may be revised by doing one of 
the following: 
 To revise the payment date only, indicate the desired Payment Date. 
 To revise the payment terms and, in turn, the payment date, use the Invoice - 
Add'l Details sub-level form. 
 To define payment in installments, enter the Payment Installments  sub-level 
form.  
Cat.No. LB10000718 3 Ver.1 – Oct. 25,’10

8. In the upper-level form, click the References tab and, in the Details column, record 
a brief remark regarding this invoice. 
9. Do one or more of the following: 
 To base the invoice on a single GRV or vendor return, specify its number in the 
Document Number column of the References tab. 
 To base the invoice on multiple GRV's and/or return documents, enter the GRV's 
for Invoice and/or Return Documents for Invoice sub-level form, respectively. In 
the relevant form, record a line for each document being billed/credited in this 
invoice. 
 If the invoice was received before the goods were delivered, you can base the 
invoice on one or more purchase orders, or on lines from within several different 
purchase orders. 
o If the invoice is based on a single purchase order, specify its number in the  
Order Number column in the References tab. 
o If the invoice is based on several purchase orders, enter the Choose Order 
Items sub-level form and select the desired order items. 
Note: You can include both GRV's and return documents in a single invoice. 
10. Enter the  Invoice Items sub-level form, which automatically displays the lines from 
any GRVs, return documents and/or purchase orders selected for this invoice. For 
each item: 
 Make sure that the Inv. Quantity , which is filled in based on the corresponding 
GRV or return document, reflects the quantity recorded in the original invoice. 
Revise if necessary. 
 Make sure that the Unit Price, which is filled in based on the price source 
determined by the PurchDocPrice constant, is correct. Revise if necessary. 
 Make sure that the % Item Discount, which is filled in based on the corresponding 
GRV or return document, is correct. Revise if necessary. 
Note: If the invoice includes both received and returned goods, the former are 
debited and the latter are credited (appear with negative quantities). 
11. Use the Invoice Item - Remarks sub-level form to record any remarks pertaining to 
an individual line item, if desired. 
12. Return to the upper-level form and select Finalize Invoice/Memo or Finalize & 
Print Invoice/Memo from the list of Direct Activations. 
Result 
 
A unique internal invoice number is generated, replacing the temporary number that 
appeared when the invoice was opened. 
Stage IV: Reconciling the Payment Entry with the Purchase Invoice 
1. Run the  Prepare for Reconciliation program. Choose the A/P Ledger and then 
indicate the number of the A/P account to be reconciled. 
Cat.No. LB10000718 4 Ver.1 – Oct. 25,’10

Cat.No. LB10000718 5 Ver.1 – Oct. 25,’10 
2. When the program finishes running, enter the Reconciliation Worksheet, retrieve the 
entries for the vendor payment and subsequent purchase invoice and assign both 
the same number in the Reconciliation Num. column. 
3. Select Finalize Reconciliation from the list of Direct Activations. 
Result 
 
The payment entry has been reconciled with the purchase invoice, and the invoice 
will no longer appear in aged payable reports.
