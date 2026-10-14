# Price Quotations Script

- **Source:** `Price Quotations Script.pdf`

Price Quotations Script 
Clip Link: http://www.eshbel.com/Movie_Search/Price_Quotations_Clip.htm 
Note: Yellow highlights indicate action instructions.  
Introduction (00:00-00:22) 
This clip demonstrates how to record customer price quotations in Priority and 
follow up on existing quotes. Specifically, we'll show yo
u how to open a new quote; 
how to base prices on an existing document; how to record quoted items and their 
prices; and how to follow up on quotes via a BPM flow chart.  
Recording a New Quote (00:23-01:07) 
Begin by opening the Price Quotations for Customers form from the Sales > 
Price Quotations menu. Select the Customer No., and several columns will be 
filled in automatically: the Quote Date is today's date; a Quote Number is assigned 
in keeping with the document numeration template defined for price quotes; and 
this customer's Contact for price quotes appears. In addition, the Expiration Date 
column is filled in based on the value of the SQuoteDays constant, but can be 
revised. 
In the Price tab, the Currency is filled in automatically with the customer's billing 
currency.  
Linking the Quote to Another Document (01:08-02:10) 
In the References tab, you can link the prices in the quotation to a given Price List. 
If the column is left empty, prices will be taken from the price list assigned to the 
customer or the base price list. Additional information on the price hierarchy can be 
found elsewhere.  
You can also base this price quotation on an existing quote by selecting it in the 
Quote to Copy column. Items and prices recorded in that quote will then appear 
here. 
Finally, you can link the quote to a sales opportunity, so that parts and prices will be 
taken from there. The status of the sales opportunity will change in keeping with the 
status of the quote to which it is linked, as defined in the Statuses for Price 
Quotations form and its sub-level, Additional Status Definitions. For example, 
you can set it up so that when a quotation receives the "Approved" status, its linked 
sales opportunity will be assigned the "Quote" status.  
Additional Quote Details (02:11-03:48) 
In the Deta
ils column, you can record a brief note which will appear on the printout 
of the quote and will also be copied to any sales order based on this quote.  
In the Vendor No. column, you can record the vendor from which you intend to 
order the items being quoted.  
Cat.No. LB130473  Ver.1 – Oct. 30,’13 
 
1

If your company classifies sales by Type of Sale, you can select the type here. The 
type recorded here will be copied to sales orders based on the quote, and can be 
used for various analyses of sales and marketing.  
In the Price Quotations – Remarks sub-level form, set text may appear, if it was 
defined for price quotations or for the type of sale selected in the upper-level form, 
you can revise the text as needed.  
The Sales Rep defined for the customer appears automatically, but can be revised.  
The Site column is filled in with the main site defined for the customer, but can be 
revised. The address of the site recorded here appears in the Shipping Address 
sub-level form and will be included in the printout of the quotation.  
In the Payment Info tab, the default payment terms defined for the customer 
appear, but can be revised. You can also record the payment terms requested by 
the customer for informative purposes only. The requested terms will not appear in 
the printout of the quotation.  
In the Internal Dialogue sub-level form, you can record notes to other staff 
members responsible for handling the quote. This text will not appear in printouts 
nor be copied to documents based on the quote.  
Recording Quoted Items and Prices (03:49-06:13) 
Let's move to the Itemized Quotation sub-level form. Since this quote is not based 
on any document, the form is empty, and needs to be filled in manually. Press F6 in 
the Part Number column to open a list of those items that have been defined 
elsewhere as the customer's part list. Press Ctrl+F6 to open the full list of items in 
the system. 
After selecting the part, record the Qty being quoted; the customer must order at 
least this quantity to receive the quoted price. The Unit Price is then filled in 
according to the price hierarchy defined in the system, which you can read about by 
pressing F1. In the Price Source column, you can see the type of document from 
which the price is derived. In any case, you can revise the price manually.  
Alternatively, you can have the system calculate the item's recommended price 
from the part cost and a specified markup. To do so, return to the upper-level form 
and record the desired profit margin in the Markup (%) column, then run the 
Estimate/Recommend Prices program from the list of Direct Activations. In the 
Itemized Quotations sub-level form, you can see that the Estim'd/Rec'd Price 
column has been filled in automatically. To approve this price, first delete the 
current Unit Price, then flag the Approve Estimate/Rec column.   
Use the sub-level forms of the Itemized Quotation to view additional data per item: 
In the Part Availability form, you can see the available and projected inventory, 
taking into account future inventory transactions expected from sales and purchase 
orders.  
In the Part Price Options form, you can see prices recorded for the part in various 
documents. Use it together with the Additional Quotes for Part form to arrive at 
the desired price for this quote. For every part, you can use the Quoted Items – 
Remarks form to record text that will appear next to the item in printouts (when the 
proper print format is selected).  
Cat.No. LB130473  Ver.1 – Oct. 30,’13 
 
2

Cat.No. LB130473  Ver.1 – Oct. 30,’13 
 
3
Let's quickly record a few more parts for this quote.  
Statuses and Printing (06:14-07:44) 
Now let's return to the upper-level form. In the Price tab, you can see the Final 
Price, after discounts and tax. You can also compare this with the overall 
Purchase Price.  
In the Follow-up tab, change the Status of the price quote to one that enables you 
to open an order. You can see the status definitions by pressing F6 and moving to 
the Statuses for Price Quotations form, or by selecting BPM Flow Chart – 
Customer Quotes from the list of Direct Activations. Right-click any status and 
select Properties to view and revise the status definitions. The BPM chart also 
allows you to change the sequence of status allocations and define automatic e-
mails sent under certain conditions. For instance, you can have a reminder sent to 
the customer or sales rep if the quote status hasn't changed in a long time, so that 
the opportunity won't be missed. A detailed explanation of how to work with BPM 
flow charts is provided elsewhere.  
You can Assign the quote to another employee, such as the sales rep in charge of 
this customer.  
Finally, print the price quotation using the appropriate Direct Activation.  
Follow-up (07:45-08:34) 
In the Revisions for Final Price Quotes form, you can make minor changes
 to 
quotations that have a "Final" status, such as revising their expiration date.  
You can also print one or more price quotations from the Price Quotation Reports 
menu.  
From the same menu, you can run the Active Price Quotations report to view any 
quotes for which no order has yet been opened or the Quotes in Preparation 
report to view quotes that have not yet been sent to customers. These reports are 
based on quote statuses, so it's important to maintain an accurate BPM process. 
You can also design your own customized report using the Price Quote Report 
Generator.  
For more information on working with quotes, you can run the Price Quotations 
Wizard.  
Related Documentation 
 Prices and Discounts clip 
 Opening a Sales Order clip 
 BPM clip 
 Prices and Discounts wizard
