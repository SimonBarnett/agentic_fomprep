# 13-17-GRVs and Vendor Returns

- **Source:** `13-17-GRVs and Vendor Returns.pdf`

www.priority -software.com   
1/3 Feb.18,'15 Ver. 02 Cat.No. LB10000138 
 
 SOP: Receiving and Returning Vendor Goods 
Customer:   Company Inc. 
Assigned to:  Dept./Position 
Procedure 
Stage I: Recording a GRV on the Basis of a Purchase Order 
1. Enter the Goods Receiving Voucher form and select the relevant Vendor Number.  The Date 
and Document Number columns are filled in automatically. 
2. Click the General tab. The Receiving Warehouse column is filled in automatically with the 
default warehouse defined for GRVs. Revise as necessary. 
3. Do one of the following: 
 Click the References tab and specify the relevant purchase order in the Order No. column. 
The Choose list includes all open purchase orders from the designated vendor that have the 
appropriate status (flagged with the Allow Receipt attribute). 
 To link the GRV to multiple purchase orders, enter the Purchase Orders for GRV sub-level 
form and select the relevant orders. The form displays all open purchase orders for the 
designated vendor, with the appropriate status. 
 To link the GRV from specific lines in one or more purchase orders, enter the Choose Order 
Items sub-level form. The form displays all open line items in purchase orders for the 
designated vendor, with the appropriate status. Flag the items you want to include in the GRV 
in the Choose Item column. 
Note: You can add specific items from this form in addition to any purchase orders linked to 
the GRV. 
4. Enter the Received Items sub-level form. The form displays all the items linked to the current 
GRV. View the quantity of each part that has yet to be supplied in the Balance to Receive 
column. 
5. Specify the received Quantity of each part. 
Note: If the received quantity is identical to the balance to receive, flag the Approve column, and 
the value in the Balance to Receive column will be copied automatically to the Quantity column. 
6. Return to the upper-level form and change the Status column to the next status defined in the 
BPM workflow. 
7. To make changes to the GRV after it is closed, click Reopen Document from the list of Direct 
Activations. The program will return the document status to Draft. Make the necessary changes 
and move the document to the next status. 
Note: You can only make such changes if no invoice has been opened yet for the document. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 Feb.18,'15 Ver. 02 Cat.No. LB10000138 
 
Results 
 The supply balance of each part in the relevant purchase order is updated automatically. If the 
part is fully supplied as a result, the Closed column is flagged in the relevant line item. If the 
entire purchase order is fully supplied as a result, the Closed column is also flagged in the 
upper-level form. 
 The inventory balance in the designated receiving warehouse is increased by the received 
quantity. 
 Once this document is final, you can open a multi-GRV invoice on the basis of this and other 
documents. 
Stage II: Returning Goods to a Vendor on the Basis of a GRV or Purchase 
Order 
1. Enter the Returns to Vendor form. 
2. Select the relevant Vendor Number.  The Date and Document No. columns are filled in 
automatically. 
3. Click the General tab. The From Warehouse column is filled in automatically with the default 
warehouse defined for vendor returns. Revise as necessary. 
4. Click the References tab and link the document to the relevant purchase order or GRV in the 
Order Number or GRV column, respectively. 
5. In the Details column, record a brief remark pertaining to the document. 
6. Enter the Returned Items sub-level form. The form displays all the items recorded in the linked 
purchase order or GRV. You can view the received quantity of each part in the Balance to 
Return column. 
7. Specify the Quantity of each part to be returned, or flag the Approve column, and the value in 
the Balance to Return column will be copied automatically to the Quantity column. 
8. Return to the upper-level form and change the Status to the next status defined in the BPM 
workflow. 
9. To make changes to the return document after it is closed, click Reopen Document from the list 
of Direct Activations. The program will return the document status to "Draft". Make the necessary 
changes and move the document to the next status. 
Note: You can only make such changes if no credit memo has been opened for the document. 
Results 
 The supply balance of each part in the relevant purchase order is updated automatically. If the 
POpenOrder constant is set to 1, closed purchase orders are reopened automatically with the 
updated supply balances.  
 The inventory balance in the designated Warehouse is reduced by the returned quantity. 
 You can record a credit memo received from the vendor on the basis of this document once it is 
final. 
Stage III: Recording a Returns to Vendor Document Manually (Without Linking 
to a Purchase Order or GRV) 
1. Enter the Returns to Vendor form.

www.priority -software.com   
3/3 Feb.18,'15 Ver. 02 Cat.No. LB10000138 
 
2. Specify the relevant Vendor Number. The Date and Document No. columns are filled in 
automatically. 
3. Click the General tab. The From Warehouse column is filled in automatically with the default 
warehouse defined for vendor returns. Revise as necessary. 
4. Click the References tab. In the Details column, record a brief remark pertaining to the 
document. 
5. Enter the Returned Items sub-level form.  
6. Specify the Part Number and Quantity of each returned item. 
7. Return to the upper-level form and change the Status to the next status defined in the BPM 
workflow. 
8. To make changes to the return document after it is closed, click Reopen Document from the list 
of Direct Activations. The program will return the document status to Draft. Make the necessary 
changes and move the document to the next status. 
Note: You can only make such changes if no credit memo has been opened for the document. 
Results 
 The inventory balance in the designated From Warehouse is reduced by the returned quantity. 
 You can record a credit memo received from the vendor on the basis of this document once it is 
final. 
Follow-up 
 Record a multi-GRV invoice (see the relevant SOP).
