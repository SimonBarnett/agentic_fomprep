# OutgoShip_Setup_ImpFileDates

- **Source:** `OutgoShip_Setup_ImpFileDates.htm`

Outgoing Shipping Vouchers - Setting Up the Exchange Conversion Date 
 
 
- 
 
 
 
# Setting the Default for Currency Conversion Dates

 

Set the ImpFileDates constant to determine which exchange rate the system will use when converting the currency of outgoing shipping vouchers: that in effect on the date of the invoice, or that in effect on the date the goods were removed from inventory. 
 
## To set the date default:

 

 1 .  Enter the Financial Constants form. 
 

 2 . Move to the ImpFileDates constant. 
 

 3 . Do one of the following: 
 

 ·     Leave the default value of 0 to use the exchange rate in effect on the date the goods were removed from inventory. 
 

 ·     Change the value to 1 to use the exchange rate in effect on the date of the invoice. 
 
## Note:

 

This constant also affects incoming shipping vouchers, with the default value representing the exchange rate in effect on the date the goods were received into inventory.
