# PP_CustShip_Only_one_line

- **Source:** `PP_CustShip_Only_one_line.htm`

PP_CustShip_Only_one_line 
 
 
- 
 
 
 

When a shipping document is itemized automatically on the basis of an order, Priority "recommends" which inventory to use by displaying available quantities by warehouse, bin, work order and receiving status. For example, if there is insufficient inventory for a given item in one work order, a second line is created for another work order. Likewise, if there is available inventory of more than one receiving status (e.g., some in the customer's name and some with Goods status), quantities for each status appear on separate lines. The same holds for quantities of the same part in different bins. 
 

This feature creates multiple lines in the shipping document for the same order item. The SOnlyOneLine constant enables you to disable this mechanism, thereby obtaining one line per order item. In this case, manual adjustments may have to be made to the shipped items (e.g., switching to a different work order that has a sufficient quantity of the part).
