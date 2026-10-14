# 12-17-Multi-Shipment Invoices for Projects

- **Source:** `12-17-Multi-Shipment Invoices for Projects.pdf`

www.priority -software.com   
1/2 Feb.10,'15 Ver. 02 Cat.No. LB09000138  
 
 SOP: Multi-Shipment Invoices for Projects 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To create a batch of multi-shipment invoices for customers based on shipping documents, 
project reports and project payments. 
Setups 
 Define financial data for customers in the Financ. Parameters for Customers form. 
 Set the OneInvPerPrj constant (method of preparing invoices for a project) according to 
company needs in the Financial Constants form. You can choose from the following options: a 
separate invoice for each type of document, one invoice per project, or a separate invoice for 
each order and document type. 
Procedure 
Preliminary Stage: Checking Pending Multi-Shipment Invoices 
Before beginning the process of preparing multi-shipment invoices, you should finalize all pending 
multi-shipment invoices that can be finalized and cancel any pending multi-shipment invoices that 
should be cancelled. When preparing a batch of multi-shipment invoices, you will retrieve all 
pending invoices. It is therefore recommended that all pending invoices existing in the system at the 
time of this process should be truly pending. 
1. Enter the Multi-Shipment Invoices form and switch to Query mode (press F11). 
2. In the Invoice No. column, specify “T*” to retrieve all pending invoices. 
3. Check the pending invoices. 
4. For any invoice that should be finalized, select Finalize Invoice/Memo from the list of Direct 
Activations. 
5. For any pending invoice that should be cancelled, select Delete Pending Invoice/Memo from 
the list of Direct Activations. 
6. If you are unsure whether an invoice should be finalized or cancelled, change its Status to 
“Checking.” Invoices that are being checked will not be finalized when the automatic finalization 
program is run (see below). 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 Feb.10,'15 Ver. 02 Cat.No. LB09000138  
 
Stage I: Automatic Preparation of Multi-Shipment Invoices 
1. Run the Prepare Invoices program. Select the Selected Projects option to enable preparation 
of invoices for a group of projects selected by document type: customer shipments, customer 
returns, service calls, service contracts, project reports and project payments. 
2. In the query form that opens, retrieve any projects for which you wish to prepare invoices. 
3. Exit the form. 
4. In the dialogue box that opens, indicate the range of dates for which multi-shipment invoices 
should be produced, in the From Date and To Date columns, as well as an Invoice Date, and 
click OK. You will receive a message indicating the numbers of the new invoices. 
5. If a problem was detected during invoice preparation, you will receive a message that includes 
reference to the error report. To review the problem, run the Prepare Invoices - Errors report. 
6. To check the pending invoices that were created, repeat the steps described in the Preliminary 
Stage above. 
Stage II: Finalizing Pending Multi-Shipment Invoices 
1. Run the Finalize Invoices program. 
2. In the query form that opens, retrieve the pending invoices you wish to finalize. You can retrieve 
all pending invoices or retrieve invoices by date, customer, etc. 
3. Exit the form. 
4. Confirm the Continue message. 
5. If a problem was detected during invoice preparation, you will receive a message that includes 
reference to the error report. To review the problem, run the Finalize Invoices - Errors report. 
Stage III: Printing a Group of Multi-Shipment Invoices 
1. Run the Print Invoice/Credit Memo report, choosing a New report. 
2. To define the batch of invoices to print, press F6 in the Invoice/Memo Number column of the 
dialogue box. 
3. The Multi-Shipment Invoices form opens. Press F11 to retrieve the invoices you wish to print. 
4. Exit the form. 
5. Define the sort order for printing. 
6. Select the desired printing format. 
7. In the printing input window, define the number of copies and the appropriate printer. 
Results 
 Journal entries are automatically created for the final invoices created in the system. 
 Once an invoice has been printed, the Printed column in the invoice is flagged.
