# 13-17-Project Billing

- **Source:** `13-17-Project Billing.pdf`

www.priority -software.com   
1/2 18/02/15 Ver. 02 Cat.No. LB10000142 
 
 SOP: Billing to a Project 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To record payments to a project. 
Setups 
 Open the project and create a project plan. 
 Ensure that the OneInvPerPrj constant in the HUFinancial ConstantsUH form has the desired value: 1 
– one invoice for each document type, 2 – one invoice for all orders linked to the project, 0 – a 
separate invoice for each type of document (project payments, reported hours, service contracts, 
etc.). 
 Ensure that the value of the InvoiceDate constant in the HUFinancial ConstantsUH form meets your 
requirements. This constant determines whether the invoice date will be the date you run the 
program or the date of the original sales document. 
Procedure 
Stage I: Documenting Set Payments 
1. Enter the HUProjectsUH form and retrieve the desired project. 
2. Enter the Payments for Project sub-level form. 
3. Record the payment Date and the Payment Amount. If the payment is for a sales order, select 
the order number in the Order column.  
Note: You can also record these payments from the Sales Order form. 
4. If the payment is for an activity that is a milestone, enter the Projects/Accounts sub-level form 
and select the activity in the WBS column. The Checking field in the Payments for Project 
sub-level form will be flagged automatically. 
Note: Once work on the activity is completed (in other words, 100% completion is reported), the 
flag will automatically be cleared and the payment will be released. 
5. Enter the History of Changes sub-level of the Payments for Project form to track revisions 
made to this payment. All revisions made to any of the columns in the current record are 
displayed. 
Stage II: Checking Relevant Project Reports 
1. Enter the Reports of Project Hrs/Expenses sub-level form. The form displays all reports for 
this project. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 18/02/15 Ver. 02 Cat.No. LB10000142 
 
2. Verify that reports for which payment will be received are flagged in the Billable column. Further 
information on the subject is available in standard operating procedures for project reporting. 
Stage III: Preparing Invoices 
1. Run the HUPrepare InvoicesUH program. The program prepares multi-shipment invoices (and credit 
memos) for reported project hours and expenses, project payments and the like. 
2. Choose the option to prepare invoices for Selected Projects. The program opens a query form 
for listed projects. Retrieve the project for which invoices should be prepared and exit the form. 
3. Define the Dates for which invoices should be opened. The program will prepare invoices for all 
payments and reports falling within the defined period. 
Notes:  
o Invoices will not be prepared for payments flagged as Checking. 
o You are notified of the number of invoices opened and their invoice numbers. 
4. Enter the Multi-Shipment Invoices form and retrieve the pending invoices according to the date 
prepared. 
5. The invoices that were prepared have a status of “Draft.” To finalize them, select Finalize 
Invoice/Memo from the list of Direct Activations. As a result, the invoice will be finalized, its 
Status will become “Final,” and it will receive a permanent invoice number. In addition, a 
corresponding journal entry will be created. 
Note: Detailed instructions on preparing invoices are available in standard operating procedures 
on multi-shipment invoices. 
Results 
 In the Payments for Project sub-level form, each payment is linked to the relevant invoice 
number. In the Invoices/Credit Memos for Item sub-level form, full invoice details appear for 
each payment line item. 
 For each work hour report for which an invoice has been prepared, the Reports of Project 
Hrs/Expenses sub-level form displays the number of the invoice.
