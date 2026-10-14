# SOP U.S Tax Codes

- **Source:** `SOP U.S Tax Codes.pdf`

Cat.No.LB130461 1 Ver.1 – Oct. 16,’13 
 
SOP: U.S. Tax Codes* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Background 
Sales tax is collected on all sales made to customers in locations in which the company 
maintains a tax nexus. For sales made outside of a company's nexus, sales tax is not 
collected.  
Note: This SOP is intended for companies located in the United States that sell to 
customers in the U.S. It is not relevant for companies located outside the United States. 
Aims 
 To load U.S. tax codes into Priority. 
 To define tax accounts and associate them with tax codes based on state, county 
and zip code.. 
 To associate a tax code with a customer, customer site or sales document. 
 To generate sales tax reports. 
Procedure 
Stage I: Loading Sales Tax Codes into the System 
 Run the Update Tax Codes program. 
Notes: 
o The first time the program is run, all available tax codes and their respective 
rates will be automatically loaded into Priority, and are available in the Taxes 
form and its Rates per Tax Group sub-level. Subsequent running of the program 
will update the form with the most current data. It is recommended that the 
program be run on a monthly basis. 
o When the program is run, the following columns in the Taxes form are filled in 
automatically: Zip Code, County, City, State and State Code. 
                                                
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No.LB130461 2 Ver.1 – Oct. 16,’13 
Stage II: Associating Tax Codes with Tax Accounts 
1. Create a tax account in the general ledger for each state in which the company 
operates.  
2. Open the Countries form and retrieve the record for the United States. 
3. In the States sub-level form, associate a tax account with each relevant state using 
the Sales Tax Account column. 
Note: You can also associate an account with a specific tax code using the Taxes 
form. In such a case, this definition will override the one at the state level. 
Stage III: Assigning Sales Tax Codes Based on Customer Addresses  
Tax codes may be assigned at multiple levels – to customers, customer sites and 
individual sales documents. A definition at the customer site level overrides one made at 
the customer level, while a definition at the sales document level only affects the 
document itself or other documents linked to it. 
When a zip code is recorded, the Tax Code column will be filled in automatically with the 
appropriate code. If the column remains blank, it means that there are multiple tax codes 
for the given zip code, and the appropriate one must be selected from the Choose list. 
 To define a tax code for a customer, enter the Customers form, retrieve the desired 
customer and record their Zip Code. The Tax Code will be filled in automatically. 
 To define a tax code for a customer site, enter the Customer Sites sub-level of the 
Customers form, and record the Zip Code of the site. The Tax Code will be filled in 
automatically. 
 To define a tax code for a sales document, enter the Shipping Address sub-level 
within the relevant sales document and record the Zip Code for this document. The 
Tax Code will be filled in automatically.  
Stage IV: Generating Sales Tax Reports 
You can run sales tax reports from the Sales Tax menu (menu path: Financials > 
General Ledger > Financial Statements > Taxes). For example: 
o Tax by State – Displays all sales tax collected over a given period, by state. 
o Tax by State (Detailed) – Displays all sales tax collected over a given period, by 
state and customer.
