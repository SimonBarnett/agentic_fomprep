# Add_Expenses_Setup_ImpFileDates

- **Source:** `Add_Expenses_Setup_ImpFileDates.htm`

Shipping Expenses - Setup: Exchange Rate Conversion Date 
 
 
- 
 
 
 
# Setting the Default for Currency Conversion Dates

 

Set the ImpFileDates constant to determine which exchange rate the system will use when converting the currency of shipping vouchers: that in effect on the date of the invoice, or that in effect on the date the goods enter inventory. 
 
## To set the date default:

 

 1 . Enter the Financial Constants form. 
 

 2 . Move to the ImpFileDates constant. 
 

 3 . Do one of the following: 
 

 ·     Leave the default value of 0 to use the exchange rate in effect on the date the goods enter inventory. 
 

 ·     Change the value to 1 to use the exchange rate in effect on the date of the invoice. 
 
## Note:

 

This constant also affects outgoing shipping vouchers, with the default value representing the exchange rate on the date the goods are removed from inventory.
