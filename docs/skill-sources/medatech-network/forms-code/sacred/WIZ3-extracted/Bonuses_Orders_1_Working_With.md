# Bonuses_Orders_1_Working_With

- **Source:** `Bonuses_Orders_1_Working_With.htm`

Bonuses - Offering Bonuses in Orders 
 
 
- 
 
 
 
# Offering Bonuses in Orders

 

In order for a customer to be eligible for a bonus, the following conditions must be met: 
 

 ·        The customer must be flagged for regular bonuses OR be assigned special bonuses. 
 

 ·        The customer must order a part that offers a bonus and meet the minimum required quantity. 
 

 ·        The bonus must be in effect on the order date. 
 

 ·        The order cannot be based on a price quote or blanket order. 
 

When you record a sales order item for which a bonus is available, you receive a message informing you of this. 
 

 Note: 
 

If you want to prevent the appearance of the message when you leave an order line, change the value of the SOrdBonusMsg constant in the Logistic Constants form. 
 
## To indicate that the customer wants the bonus: 

 

 ·        Click OK to confirm the message. As a result, Priority adds a “bonus line” to the order, filling in the quantity and price (if not free) of the bonus part. In this line, the Bonus Item column is automatically flagged. 
 
## Notes:

 

 ·        If you don't want bonus items to be generated for a particular order, even though the customer is eligible, flag the Ignore Bonuses column for that order (in the Payment Info tab of the Sales Orders form). 
 

 ·        To view the line number(s) of any ordered part(s) that generated the bonus, enter the Lines Awarding the Bonus sub-level form from the line flagged as a Bonus Item .
