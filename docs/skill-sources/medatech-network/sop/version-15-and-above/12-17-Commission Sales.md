# 12-17-Commission Sales

- **Source:** `12-17-Commission Sales.pdf`

www.priority -software.com   
1/4 Feb. 11,'15 Ver.02 Cat.No. LB09000199 
 
 SOP: Commission Sales 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
Commission sales are sales transactions where the company acts as a liaison between the 
customer and vendor in return for a commission paid by the vendor. The aim of this procedure is to 
document these transactions, from the request for a price quote, to the vendor quote and purchase 
order, and finally to the credit note. 
Setups 
 Make sure the percentage of commission to be paid by the vendor has been defined in the 
Financial Parameters for Vendors form. If the vendor pays a fixed percentage of commission for 
all commission sales, this percentage should be recorded in the Commission column. If the 
vendor pays a varying percentage of commission for sales of different part families, enter the 
Order Commissions per Family sub-level form and record the appropriate percentage of 
commission for each family. 
 Make sure the value of the SCommissType constant in the Logistic Constants form is in 
keeping with how commission should be calculated for an order. 
Procedure 
Stage I: Opening Price Quote Requests for Commission Sales 
1. Enter the Price Quotes for Commiss'n Sales form. 
2. In the Customer Number column, specify the customer for which the price quote is intended. 
The Customer Name, Date, Expir. Date and Price Quote are filled in automatically. The dates 
can be revised if necessary. 
3. Click the Vendor & Prices tab and specify the vendor that is to supply the ordered parts in the 
Vendor No. column. Choose a vendor Contact, if desired. 
4. Click the References tab. If the goods are to be delivered to a site other than the customer's 
primary address, indicate the Site to which they should be shipped. Alternatively, you can record 
a shipping address manually in the Shipping Address sub-level form. 
5. Enter the Quoted Items (Commission Sales) sub-level form. For each item, specify the Part 
Number, requested Quantity, and requested Delivery Time, in days or weeks. 
6. Return to the upper-level form. 
7. To print the RFQ, select Print RFQ to Vendor (Comm Sales) from the list of Direct Activations. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/4 Feb. 11,'15 Ver.02 Cat.No. LB09000199 
 
Stage II: Opening Price Quotes for Commission Sales 
1. Enter the Price Quotes for Commiss'n Sales form.  
2. Select the Customer for which the price quote is being recorded. 
3. Click the References tab. In the Quote to Copy column, record the RFQ on which this quote is 
based. 
Tip: Press F6 to access an empty form and retrieve the RFQ in question (e.g., by customer 
number, by date). With the cursor on that line, press F8 to copy the number into the Quote to 
Copy column. 
4. Record the Vendor's Reference, as it appears on the vendor's price quote. 
5. Revise the quote's Date and Expir. Date, if necessary. 
6. Click the Vendor & Prices tab and make sure the value recorded in the Commission % column 
is correct. If a different percentage was agreed upon, adjust this value accordingly. 
7. Enter the Quoted Items (Commission Sales) sub-level form. For each item, specify the Unit 
Price quoted by the vendor, as well as the Delivery Time to which the vendor has committed. 
8. Make sure the values recorded in the Quantity and Curr columns are correct. If the vendor has 
offered a discount on a given part, indicate this in the Discount% column. 
9. Return to the upper-level form. Click the Follow-up tab and adjust the quote’s Status. 
Stage III: Opening Commission Orders 
1. Enter the Commission Orders form. 
2. Click the References tab. In the Price Quote column, indicate the number of the quote on 
which the order is based. Once you leave this column, the order will be itemized automatically 
on the basis of the price quote. 
3. Today's date appears automatically as the order's Date. Revise it as necessary. 
4. Record the Site, Shipment Mode and Sales Rep Number, if desired. 
5. Choose a vendor contact and a customer contact, if desired (to choose a vendor contact, click 
the Vendor & Prices tab). The names of these contacts will appear on printouts of the order. 
6. If a commission percentage was specified for the entire quote on which this order is based, that 
value appears in the Commission % column (in the Vendor & Prices tab). Revise it if 
necessary. 
Note: If a value appears here, you cannot record a different percentage for individual items in 
the Commission Order Items sub-level form. To record different percentages for each item in 
the order, leave this column blank. 
7. Enter the Commission Order Items sub-level form. This form lists the ordered items, as taken 
from the price quote. For each item in the order, ensure that the Quantity, Unit Price, 
Discount% and Curr are correct.  
8. The Due Date is calculated automatically, based on the delivery time designated in the price 
quote. Revise it as necessary. 
9. After you have finished itemizing the order, return to the upper-level form and click the Follow-
up tab. Change the Status of the order (e.g., to "Ready"). 
Notes: 
 If no commission percentage appears, and both the vendor's regular price list and the 
commission sales price list are maintained in the system, you can calculate the commission

www.priority -software.com   
3/4 Feb. 11,'15 Ver.02 Cat.No. LB09000199 
 
percentage and the total commission for each item in the order. To do so, select Calc. 
Commission by Vendor Price from the list of Direct Activations. 
 To view the commission calculated for each ordered item, return to the Commission Order 
Items sub-level form. 
Stage IV: Printing Commission Orders 
You can print a purchase order for a commission sale, which can then be sent to the vendor. Once 
the terms of transaction are confirmed, you can send the customer an order confirmation. 
Printing a purchase order to send to the vendor 
1. Enter the Commission Orders form and retrieve the desired order. 
2. Select Print Purchase Order to Vendor from the list of Direct Activations. 
Dual-currency users: If you wish to print the order in English when working in another 
language, select Print PO to Vendor-Foreign Lang. instead. 
Printing an order confirmation to send to the customer 
1. Enter the Commission Orders form and retrieve the desired order. 
2. Select Print Confirmation of Comm Order from the list of Direct Activations. 
Dual-currency users: If you wish to print the order in English when working in another 
language, select Print CommOrd Confirm-ForeignLng instead. 
Stage V: Recording the Vendor Invoice 
You record invoices for commission sales to indicate delivery of the ordered goods. The invoice is 
automatically itemized with the parts in the linked commission order(s). A line in an invoice which 
reports the full delivery of an ordered quantity closes the corresponding line in the commission 
order. 
1. Enter the Vendor Invoices-Commission Sales form. 
2. Specify the Vendor Number, Date and Invoice number.  
3. The Currency column is filled in automatically with the vendor's default currency. Revise, as 
necessary. 
4. Do one of the following: 
 If the invoice is for delivery of a single commission order, click the References tab and 
designate this order in the Commission Order column. 
 If the invoice is for delivery of several orders, enter the Commission Orders for Invoice sub-
level form and select the relevant orders. 
5. Enter the Invoice Items (Commission Sales) sub-level of the Vendor Invoices-Commission 
Sales form. All items in the specified commission order(s) appear. 
6. For each item in the invoice, record the supplied quantity in the Reported Delivery column. If 
the quantity delivered equals the balance to be supplied, flag the Approve Quantity column. 
7. Make sure that the percentage of commission and the total commission are correct. 
8. Return to the upper-level form and click the References tab. Change the Status of the invoice 
to "Commission".

www.priority -software.com   
4/4 Feb. 11,'15 Ver.02 Cat.No. LB09000199 
 
Stage VI: Recording Credit Notes 
A credit note lists the amounts of commission approved by the vendor. These amounts are based 
on vendor invoices.  
1. Enter the Credit Notes form. 
2. Designate the Date of the credit note and the Vendor Number. 
3. Record the Estimated Pay Date. 
4. Enter the Credit Note Details sub-level form and specify the relevant vendor invoices. 
5. For each invoice, check the value in the Commission Amount column. This should display the 
balance of the commission approved for this invoice. Revise the amount, if necessary. 
6. Return to the upper-level form and verify that the Total Amount column displays the balance of 
the commissions you are owed. 
Stage VII: Recording the Journal Entry for the Credit Note 
1. Enter the Entry Journal form and record a manual journal entry, debiting the vendor account for 
the total amount of the commission. 
2. Return to the Credit Notes form, and record the number of the journal entry in the Vend Debit 
Entry No. column.  
Result 
 The vendor account is debited in the amount of the commission owed. 
Follow-up 
 Once the commission is paid, record a Bank Transfer document for this payment. You can then 
record the journal entry posted for this transfer in the Credit Entry No. column of the Credit 
Notes form.
