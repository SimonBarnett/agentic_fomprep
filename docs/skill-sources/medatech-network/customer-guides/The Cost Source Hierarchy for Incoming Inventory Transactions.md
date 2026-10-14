# The Cost Source Hierarchy for Incoming Inventory Transactions

- **Source:** `The Cost Source Hierarchy for Incoming Inventory Transactions.pdf`

Costing for Manufacturers 
10/03/2021 
1 
THE COST SOURCE HIER ARCHY FOR 
INCOMING INVENTORY 
TRANSACTIONS  
1. TRANSACT . 
This cost source appears: 
· When the cost of a transaction is recorded manually in the Audit Trail form 
 
· When a cost is recorded manually in a line of a GRV 
 
· For dual-currency users: When the cost of a line in a Release from Bonded 
Warehouse document is recalculated or recorded manually. 
Note: Manual costs are never updated by the costing programs. 
2. SHIPPIN G VOUCH ER (DUAL -CURRENCY US ERS)  
This cost source appears when a release transaction from a bonded warehouse is recorded 
for inventory received into the banded warehouse in an invoice linked to a final shipping 
voucher.  
The cost is calculated according to the unit price recorded in the invoice, without the 
shipping expenses imposed by the voucher. 
3. INVOICE  
If a vendor invoice was recorded, part cost is calculated according to the unit price 
recorded in the invoice (after reducing all discounts).  
This cost source also appears for invoices linked to a final shipping voucher.  
In such a case, the transaction cost will include the shipping costs recorded in the voucher, 
and will affect the part's average price, provided the transaction was not recorded for a 
bonded warehouse.  
When the inventory is received first into a bonded warehouse, the release transaction and 
the resulting burden costs affect the part price.

Costing for Manufacturers 
10/03/2021 
2 
4. GRV  
This cost source appears when an item is recorded in a GRV that has not yet been linked to a  
purchase invoice, in which case part cost is calculated according to the unit price recorded 
in the GRV. 
5. PURCH ORD  
This cost source appears when a GRV is linked to a purchase order, but the price that was 
copied automatically into the GRV has been erased.  
In such a case, the part cost is calculated according to the unit price recorded in the 
purchase order (after reducing all discounts). 
6. PRICE LIST  
This cost source appears when a GRV is not linked to a purchase order, and the price that 
appeared automatically has been erased. 
In such a case, part cost is calculated according to the unit price in the vendor's most 
current price list. 
7. QUOTE  
This cost source appears when a GRV is not linked to a purchase order, there is no vendor 
price list, and the price that appeared automatically has been erased.  
In such a case, part cost is calculated according to the unit price in the last valid price quote 
received from the vendor. 
8. PREVIOUS  
This cost source appears if no incoming transactions with a cost exist for a given part, in 
which case the part cost is calculated according to its cost in the previous past balance.  
9. STD COST  
This cost source appears if no incoming transactions with a cost exist for a given part, and no 
cost was calculated for it in the previous past balance.  
In such a case, part cost is calculated according to the standard cost defined for that part.
