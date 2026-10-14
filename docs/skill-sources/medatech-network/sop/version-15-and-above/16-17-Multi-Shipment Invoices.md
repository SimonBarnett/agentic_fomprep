# 16-17-Multi-Shipment Invoices

- **Source:** `16-17-Multi-Shipment Invoices.pdf`

www.priority -software.com   
1/5 Feb. 19, '15 Ver. 2 Cat.No. LB130515  
 
 SOP: Multi-Shipment Invoices1 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To produce a batch of multi-shipment invoices based on customer shipments. 
 To produce a single multi-shipment invoice based on an original document, or not based on any 
preceding document (see pp. 3-4 of this document). 
 To produce an over-the-counter invoice, see the SOP Over-the-Counter Invoices. 
Setups 
 Define f inancial parameters for customers  in the Financial P arameters for 
Customers  form.  
Procedure 
Preparatory Stage: Checking Pending Multi-Shipment Invoices 
1. Before you begin the process of preparing multi-shipment invoices in batch, we recommend 
finalizing all pending multi-shipments invoices that can be finalized, and canceling any invoices 
you intend to cancel. During the process we will retrieve all pending multi-shipment invoices, thus 
it is preferable that all ending invoices that are in the system should be "real". 
2. Enter the Multi-Shipment Invoices form. 
3. Specify T* in the Invoice No. column, to retrieve all pending (temporary) invoices. 
4. Check the pending invoices. If there is an invoice that should be finalized, click Finalize 
Invoice/Memo from the list of Direct Activations. 
5. If there is a pending invoice that needs to be canceled, click Delete Pending Invoice/Memo 
from the list of Direct Activations. 
6. If there is a pending invoice that you are still not sure whether to finalize or cancel, change its 
status to "Checking". Invoices that are being checked are not included in the automatic 
finalization process discussed later. 
Stage I: Preparing Multi-Shipment Invoices 
Option A: Preparing Multi-Shipment Invoices Automatically 
1. Run the Prepare Invoices program. 
2. Choose the appropriate option: 
 To prepare multi-shipment invoices for all open shipping and return documents, choose All 
Documents 
                                                 
1 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/5 Feb. 19, '15 Ver. 2 Cat.No. LB130515  
 
 To prepare multi-shipment invoices for specific shipping documents, choose Selected 
Documents. 
3. If you chose the All Documents option, an input window opened. In the From Date and To Date 
columns, specify the range of shipping document dates for which to open multi-shipment 
invoices. Specify the desired date for the resulting invoices in the Invoice Date column, and click 
OK. You will receive a system message displaying the numbers of the invoices opened by the 
program. 
4. If you chose the Selected Documents option, a query form opened in which you can retrieve 
those shipping documents for which you want to open multi-shipment invoices. Leave in the form 
only those documents that you want to invoice. 
5. If a problem is encountered preparing an invoice, you will receive a message referring you to the 
errors report. To view the error, run the Prepare Invoices - Errors report. 
6. To check the pending invoices that were created, repeat the steps listed in the Preparatory 
Stage section above. 
Option B: Preparing a Multi-Shipment Invoice Based on an Existing One 
If you repeatedly open multi-shipment invoices with the same contents, you can copy an existing 
one: 
1. Enter the Multi-Shipment Invoices form and retrieve the invoice to be copied. 
2. Run the Copy Invoice program from the list of Direct Activations. This program opens a new 
invoice for today's date based on the current invoice, including the same items, quantities and 
prices. 
3. To check the pending invoice that was created, repeat the steps listed in the Preparatory Stage 
section above. 
Stage II: Approving a Multi-Shipment Invoice via Another User 
Aim: To have another user approve a multi-shipment invoice so that it may be finalized. 
Note: If your company does not require that an additional user approve a multi-shipment invoice 
before it may be finalized, you may skip this stage. 
To assign the multi-shipment invoice to another user for approval: 
1. Enter the Multi-Shipment Invoices form and retrieve the document in question. 
2. Assign the document to the user who needs to approve it by selecting their user name in the 
Assigned to column. 
To approve multi-shipment invoices assigned to you: 
1. Enter the Multi-Shipment Invoices form and retrieve all pending documents assigned to you. 
2. Change the status of each document to “Approved”. 
3. If it is company policy to have a third user finalize the document, transfer each multi-shipment 
invoice to a third user by selecting their user name in the Assigned to column. Otherwise, move 
directly to Stage III. 
Notes: 
 To restrict multi-shipment invoices from being finalized by the user who created them, enter the 
Financial Documents form and make sure that Disallow Single User is flagged for the Multi-
Shipmt Inv line.

www.priority -software.com   
3/5 Feb. 19, '15 Ver. 2 Cat.No. LB130515  
 
 To additionally require that a third user finalize the multi-shipment invoice after the second user 
approves it, flag Auth. Can't Finalize as well. 
Stage III: Finalizing Pending Multi-Shipment Invoices 
1. Run the Finalize Invoices program. 
2. In the query form that opens, retrieve the pending invoices that you want to finalize. You can 
retrieve all the pending invoices, or those with a given date, customer, etc. 
3. Close the form and click OK on the Continue Execution message. 
4. If a problem is encountered finalizing an invoice, you will receive a message referring you to the 
errors report. To view the error, run the Prepare Invoices - Errors report. 
Stage IV: Printing a Batch of Multi-Shipment Invoices 
1. Run the Print Invoice/Credit Memo program.  
2. To define a batch of invoices to print, press F6 in the Invoice/Memo Number column. The Multi-
Shipment Invoices form opens. Press F11 and retrieve the invoices that you want to print. 
3. Close the form and click OK on the Continue Execution message. 
4. Select the desired method of sorting the invoice printouts.  
5. Select the desired print format. 
6. In the Print dialogue box, specify the number of copies and the appropriate printer. 
Note: The first printout of an invoice is printed as the original. Every additional printout is 
considered a copy. 
Results 
 At the end of the process, journal entries are created automatically against the finalized invoices 
prepared by the system. 
 Shipping and return documents for which the invoices were prepared are flagged as Billed or 
Credited, respectively. 
 After the original of a multi-shipment invoice is printed, the invoice is flagged as Printed. 
Recording a Single Multi-Shipment Invoice Based on a Shipping 
Document 
Aim 
 To produce a single multi-shipment customer invoice, based on a shipping document. 
Setup 
 Define financial parameters for customers in the Financial Parameters for Customers form. 
Procedure 
Preparing a Single Multi-Shipment Invoice 
1. Open the Multi-Shipment Invoices form. 
2. Select the customer for which you want to prepare an invoice.

www.priority -software.com   
4/5 Feb. 19, '15 Ver. 2 Cat.No. LB130515  
 
3. If you do not want the invoice to be taken into account during credit calculations, enter the 
Invoice - Add'l Details sub-level form and make sure the Consider Credit column is not 
flagged. 
4. If the invoice is based on one shipping document, specify the document in the Document column 
in the References tab. 
5. If the invoice is based on more than one shipping document, specify the relevant documents in 
the Documents for Invoice sub-level form: 
 In the Document Code column, select the type of document that you want to bill (e.g., 
customer shipment, customer return, service call). 
 In the Document column, specify the numbner of the document that you want to bill. 
6. Move to the Invoice Items sub-level form. The invoice is itemized automatically from the 
documents on which it is based. 
7. If necessary, delete any lines that you do not want to bill, or change their quantities. 
8. Return to the upper-level form. 
9. Finalize and/or print the invoice by selecting Finalize Invoice/Memo or Finalize & Print Invoice 
from the list of Direct Activations. 
Note: The first printout of an invoice is printed as the original. Every additional printout is 
considered a copy. You cannot print more than one original document.  
10. To delete a pending invoice, select Delete Pending Invoice/Memo from the list of Direct 
Activations. 
11. To cancel a final invoice for the original invoice date, select Cancel Document (Original Date) 
from the list of Direct Activations. To cancel a final invoice for a designated date, select Cancel 
Document For Date from the list of Direct Activations (indicating the date in question). 
Results 
 At the end of the process, a journal entry is created automatically against the finalized invoice. 
 Shipping and return documents for which the invoice was prepared are flagged as Billed or 
Credited, respectively. 
 After the original of a multi-shipment invoice is printed, the invoice is flagged as Printed. 
Recording a Single Multi-Shipment Invoice Not Based on a Shipping 
Document 
Aim 
 To produce  a single multi -shipment customer invoice that is not based on a ny 
shipping document.  
Setups 
 Define financial parameters for customers in the Financial Parameters for Customers form. 
Procedure 
Preparing a Single Multi-Shipment Invoice 
1. Open the Multi-Shipment Invoices form.

www.priority -software.com   
5/5 Feb. 19, '15 Ver. 2 Cat.No. LB130515  
 
2. Select the customer for which you want to prepare an invoice. 
3. If you do not want the invoice to be taken into account during credit calculations, enter the 
Invoice - Add'l Details sub-level form and make sure the Consider Credit column is not 
flagged. 
4. Enter the Invoice Items sub-level form. 
5. Specify the number of the part for which you want to bill the customer (a part not subject to 
inventory control), its quantity and its price.  
Note: You can choose to specify the total Price Incl. Tax for the full quantity of parts in a given 
line or the Unit Price (before tax) for a single unit of the part. 
6. Return to the upper-level form. 
7. Finalize and/or print the invoice by selecting Finalize Invoice/Memo or Finalize & Print Invoice 
from the list of Direct Activations. 
Note: The first printout of an invoice is printed as the original. Every additional printout is 
considered a copy. You cannot print more than one original document.  
8. To delete a pending invoice, select Delete Pending Invoice/Memo from the list of Direct 
Activations. 
9. To cancel a final invoice for the original invoice date, select Cancel Document (Original Date) 
from the list of Direct Activations. To cancel a final invoice for a designated date, select Cancel 
Document For Date from the list of Direct Activations (indicating the date in question). 
Result 
 At the end of the process, a journal entry is created automatically against the finalized invoice.
