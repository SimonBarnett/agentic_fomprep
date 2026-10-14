# CommissionSales_2c_setup_type

- **Source:** `CommissionSales_2c_setup_type.htm`

Commission Sales - Types of Commission Sales 
 
 
- 
 
 
 
# Types of Commission Sales

 

You can define different types of commission sales, and different set text (remarks for price quotes and remarks for orders) for each type. This text will appear automatically in the remarks form of any documents assigned that type, where it may be revised. 
 
## Note:

 

Once a commission sale type is assigned to a price quote, the text for that sale type is used, overriding any set text defined for price quotes in the Set Text for Comm Sales Quotes form. If a commission order is based on such a quote and the SCommissRem constant is set to 1, the text for the price quote type will be copied to the order (provided there is no separate set text for orders of this type). 
 
## To define commission sale types:

 

 1 .  Enter the Types of Commission Sales form. 
 

 2 .  Record a code and description for each type.
 Tip for dual-currency users: If you are working in a language other than English, and wish to print out RFQs, price quotes or commission order confirmations in English, record a description in the Comm Sale Type-Lang2 column as well. 
 

 3 .  Enter the Set Text for Quotes of This Type and Set Text for Orders of This Type sub-level forms and record set text for price quotes and commission orders of this type, respectively.
 Tip for dual-currency users : If you are working in a language other than English, and wish to print out RFQs, price quotes and commission orders in English, record set text in the Set Text This Type Quotes-Lang 2 and Set Text This Type Orders-Lang 2 sub-level forms, respectively. Set text in English will appear in any commission sales document opened for a customer or vendor defined to receive Printouts in Lang 2 .
