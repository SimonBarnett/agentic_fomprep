# Price_Adjustment_5_Order_Currency_Basket_cont

- **Source:** `Price_Adjustment_5_Order_Currency_Basket_cont.htm`

Price Adjustment Wizard - Linking to Currency Basket.2 
 
 
- 
 
 
 
# To link an entire order to a currency basket:

 

 1 .  Enter one the following forms to record the order: 
 Sales Orders 
 Purchase Orders 
 Blanket Sales Orders . 
 

 2 .  In the Payment Info tab, select the currency you've defined for the basket in the Linked Curr column.
 Note : If no such currency has been defined, you can manually define the make up of the basket in the Linkage Details sub-level form. 
 
## For sales orders only: 

 

 ·        To change the default linkage option , record the desired value in the Link Option column. 
 
## For sales and blanket sales orders only: 

 

 1 .  To change the default linkage date , revise the value in the Price Linkage column. 
 

 2 .  If the Negative Linkage column is flagged, linkage will take place even if the exchange rate has dropped. A check mark appears automatically if the LinkNegative constant is set to 1 , but may be removed. 
 

 3 .  To define a minimum percentage of exchange rate fluctuation, beneath which linkage will not take place, specify the percentage in the Minimum Linkage% column. 
 

 4 .  Enter the Linkage Details sub-level form to view the make up of the basket. The Base Rate displays the exchange rate in effect for each currency on the order date. Revise this, or any other columns, as necessary. 
 Tip: To automatically revise the Base Rate to the exchange rate in effect on a desired date, change the Base Date to that date. 
 

 5 .  Do one of the following: 
 

 ·      If there is an agreement to stop linkage of this currency a certain number of months prior to an order item's delivery or due date, indicate the number of months in the Latest Linkage-mnths column. Explanation. 
 

 ·      To use the Exchange Rate Date defined for this currency in the upper-level form, flag the Linkage from Header column. The Latest Linkage-mnths column will be set automatically to 0 and will not affect linkage.
