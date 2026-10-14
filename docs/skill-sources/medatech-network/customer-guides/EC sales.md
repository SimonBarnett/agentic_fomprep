# EC sales

- **Source:** `EC sales.pdf`

EC Sales 
11 Feb. 21 
1 
EC SALES  
OVERVIEW  
Using Priority, you can produce a quarterly EC Sales List (ECSL), which displays the sales made 
to VAT registered customers in EC member states 
If you are registered for VAT and you supply goods to businesses registered for VAT in other 
European Community (EC) member states, you must declare these sales on an EC Sales List 
The information provided is used by EC member states to ensure that VAT has been correctly 
accounted for 
SETUP  
DEFINE CUSTOMS ITEMS  
Financials > Cost Analysis for Manufacturers > Shipping Expense Burdening > Data for 
Shipping/Import Voucher > Itemised Customs Rates 
Use this form to record customs rates and Intrastat settings per customs item, according to 
the customs category from which to item is imported (the European Community, North 
America and the Rest of the World) 
 
Ensure the items are flagged as included in the Intrastat report

EC Sales 
11 Feb. 21 
2 
Populate the percentage rates either in the upper level, or the Special Customs Rates sub-
level form 
Here you can define the rate per country 
Flag the Supplementary Units column if supplementary units are required for this item in the 
Intrastat declaration 
Note: This column should be flagged if the standard unit of weight for parts that are assigned 
this customs item is not the kilogram (e.g., gold, which is measured in ounces). If this column is 
not flagged, the weight of all parts that are assigned this customs item will appear in the 
Intrastat report in kilograms. 
Note: The requirement for Supplementary Units is part of the Intrastat Classification 
Nomenclature (ICN), and only applies to certain classes of goods.  
Note: The nature of the Supplementary Unit depends on the product; it may be the number 
of units, the volume in liters, or the area in square meters. For example, in the case of live 
animals the supplementary unit would be the number of animals shipped; in the case of skis it 
would be the number of pairs. 
ASSIGN CUSTOMS ITEMS  TO IMPORTED PARTS  
Financials > Maintenance of Financials > Basic Data > Default Values > Financial Parameters 
for Parts 
Move to the Shipping Expenses tab, fill out the Customs Item and the rest of the shipping 
expense data 
You should assign kg as the unit of weight  
Note: For exceptional cases, define the weight as required 
COUNTRIES  
Inventory > Inventory Maintenance > Countries 
Assign Intrastat Codes for all countries (except your own)

EC Sales 
11 Feb. 21 
3 
Assign EC Sales List Codes to any country you are required to file EC Sales List declarations 
using a different country code 
Note: In many cases, this is the same as the Country Code 
Also fill out the VAT number length and format 
CUSTOMERS  
CRM > Customers > Customers 
In the Customers form, make sure a Country is defined for each customer 
If a given customer maintains more than one site in various EU countries, enter the Customer 
Sites sub-level form and define a Country for each site

EC Sales 
11 Feb. 21 
4 
Note: If a given site is located in the same country as the customer's main address (defined in 
the upper-level form), leave this column blank 
Verify that the customer have been assigned a VAT number 
Under the ‘Company Data’ tab there is a column for VAT Number-Cust 
 
Note: To check the validity of customer VAT numbers before creating the EC Sales List report, 
run Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports > Check 
Customer VAT Numbers 
Note: This report compares the Customer VAT Numbers to the conditions defined in the 
Countries form 
COMPANY DATA  
System Management > System Maintenance > Companies > Company Data 
 Check your companies VAT Number is entered correctly

EC Sales 
11 Feb. 21 
5 
EC SETTINGS ON AN INVOICE  
Financials > Accounts Receivable > Customer Invoices > Multi-Shipment Invoices > Multi-
Shipment Invoices -> Invoice - Add'l Details 
Fill out EC Sales List Flag if any of the below apply to the invoice:  
 
Specify “N” to exclude the invoiced transaction from the EC Sales List 
Specify “2” to indicate that this invoice was recorded for a triangular transaction in which 
your company is an intermediary supplier 
Specify “3” to indicate that this invoice was recorded for a service 
In all other cases, leave this column blank  
 
You can also enter these details in the form Invoice Data for Intrastat Rep if an invoice item is 
different from the rest of the invoice

EC Sales 
11 Feb. 21 
6 
i.e. if, for example, you wish to exclude one item from the EC Sales List, you would flag N in 
Invoice Data for Intrastat Rep for that invoice item, which would override what is set in 
Invoice – Add’l Details 
REPORT  
Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports > EC Sales List 
The EC Sales List displays the sales made to VAT registered customers in EC member states 
 
Chose the period of the report by selecting the From Date and To Date 
Define a Contact Name that will appear on the report and choose the Type of Report 
This is either Report + .csv File or Detailed Report

EC Sales 
11 Feb. 21 
7 
If you choose the detailed report, this report will show invoices within a defined period, for 
customers and parts defined for EC sales 
 
Choose this if you want a breakdown of your EC Sales 
 
Otherwise, you can save the file as a .csv   
The EC Sales List will be displayed in HTML format in addition to being saved where specified
