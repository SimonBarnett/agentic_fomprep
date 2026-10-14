# 12-17-Working with a Bonded Warehouse

- **Source:** `12-17-Working with a Bonded Warehouse.pdf`

www.priority -software.com   
1/3 ‏Feb. 02,'15 Ver.02 Cat.No. A8000040 
 
 SOP: Working With a Bonded Warehouse 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To receive goods into a bonded warehouse, create a shipping voucher and release the goods 
from the warehouse. 
A bonded warehouse is a warehouse for storing imported goods before they are released by 
customs. These goods are not included in the company's inventory valuations, although the 
purchase order is already closed. 
The shipping voucher serves to link shipping and other expenses to specific purchase invoices, 
allowing the costing program to distribute the burden among the cost of the purchased goods. 
Working Assumptions 
 Purchase invoices have been recorded for the imported goods. To open a purchase invoice on 
the basis of a purchase order or GRV, see the relevant standard operating procedures. 
 Multi-GRV invoices have been recorded for the customs agent (see the relevant standard 
operating procedure for multi-GRV invoices). 
 The necessary setups have been performed for shipping vouchers (see the relevant standard 
operating procedure). 
Setups 
 Define a bonded warehouse: 
 Define a warehouse (see the relevant standard operating procedure).  
 Flag the Bonded Warehouse column, and remove the check marks from the Inventory 
Valued and Transaction Costing columns. 
 Run the Set Extra Import Costs (%) program to determine the standard percentage to be added 
to the cost of parts released from the bonded warehouse. This percentage will appear 
automatically in the Release from Bonded Warehouse document (see Stage IV, Step ‎9), where 
it may be revised manually. 
Procedure 
Stage I: Opening a Shipping Voucher  
1. Open a shipping voucher (see the relevant standard operating procedure). 
2. Link the relevant purchase invoices and customs invoices to the voucher. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 ‏Feb. 02,'15 Ver.02 Cat.No. A8000040 
 
Stage II: Receiving Goods into the Bonded Warehouse  
1. Enter the Goods Receiving Voucher form and open a document, as usual. 
2. Specify the bonded warehouse in the Receiving Warehouse column.  
Stage III: Itemizing the Imported Goods in the Shipping Voucher  
1. Once all invoices for purchased goods have been linked to the shipping voucher, enter the 
Shipping Vouchers form and retrieve the relevant voucher. 
2. Specify the Bonded Warehouse in which the goods are being stored. 
3. Select Auto Record Bonded Ware Contents from the list of Direct Activations. 
4. Enter the Contents of the Bonded Warehouse sub-level form and specify the Platform 
Number assigned to each part by the customs authorities. 
5. Close the shipping voucher. 
Notes: 
 The costing program only takes into account closed shipping vouchers. 
 Since the goods in the bonded warehouse are not included in the company's inventory 
valuations, the costing program does not calculate the cost of these items according to the 
costs recorded in the shipping voucher linked to the bonded warehouse, so long as a Release 
from Bonded Warehouse document has not been recorded. 
 If you want to link an additional invoice to the closed shipping voucher, you need to reopen the 
voucher by retrieving it in the Shipping Vouchers form and selecting Reopen Shipping 
Voucher from the list of Direct Activations. After linking the invoice, reclose the voucher. 
 If an additional invoice was linked to the voucher after costing was run, the calculated cost of the 
parts will only be updated after costing is run again. 
 Canceling an invoice linked to a shipping voucher does not affect the shipping voucher; you 
need to retrieve the voucher and delete the link to the canceled invoice manually, or link the 
voucher to a corresponding credit memo. 
Stage IV: Releasing Goods from the Bonded Warehouse 
1. Enter the Release from Bonded Warehouse form. 
2. Specify the release date in the Date column. The Document number appears automatically. 
3. Specify the Shipping Voucher. The Bonded Warehouse and Vendor Number appear 
automatically. 
4. Check the default To Warehouse and Bin and revise as needed. 
5. Click the References tab and specify the Manifest Number assigned to the current release of 
goods. 
6. Specify the internal number of the Customs Invoice, in which the customs charge is recorded 
for the released goods. Make sure that the invoice is for the "Customs" part, and not for some 
other general part. 
7. Enter the Released Items sub-level form. This form displays the balances of goods stored in the 
bonded warehouse. 
8. Do one of the following for each item: 
 If the entire balance is to be released, flag the Approve column.

www.priority -software.com   
3/3 ‏Feb. 02,'15 Ver.02 Cat.No. A8000040 
 
 If only part of the balance is to be released, record the released quantity in the Quantity 
column. Then enter the Import Costs per Line Item sub-level and record the part value as it 
appears in the customs manifest (use the correct currency). 
9. Check the value appearing in the Extra Costs (%) column, and revise it as needed. If you know 
the exact sum, you can record it directly in the Extra Costs column, without recording a 
percentage. 
10. The General Import Costs column displays the sum of the costs for the shipment of the 
imported goods prior to their receipt into the bonded warehouse, as recorded in the customs 
invoices linked to the shipping voucher. You can revise this sum manually. 
Tip: If you revised the sum manually and wish to restore the sum calculated by the system, flag 
the Recalculate column and press Ctrl+F11 to refresh the screen. 
11. Return to the upper-level form and select Record Import Costs per Ln Item from the list of 
Direct Activations. 
Note: The shipping voucher must be closed before running this program. 
12. To view the sum calculated by the program, enter the Import Costs per Line Item sub-level of 
each line item in the Released Items sub-level form. The sum is displayed in the Total Cost 
column. 
13. In the upper-level form, change the Status to "Final". 
Stage V: Printing the Release Document 
 Select Print Receipt from Bonded Warehs from the list of Direct Activations: 
 To display the balances in the bonded warehouse (e.g., so you can order them from the 
warehouse), choose the Order of Goods print format. 
 To display the goods received from the bonded warehouse, choose the Receipt of Goods 
print format. 
Results 
 Supply balances in the relevant purchase order is reduced according to the quantities of 
released goods. 
 As a result of itemizing the goods in the shipping voucher linked to the bonded warehouse, the 
system can maintain balances in the warehouse when a release document is recorded. 
 The system distributes the shipping burden proportionally among the imported goods, according 
to the customs invoices and the part's defined percentage of additional expenses. 
 Inventory balances in the receiving warehouse are increased according to the quantities of 
released goods.
