# SOP Intrastat

- **Source:** `SOP Intrastat.pdf`

Cat.No. LB110031 1 Ver.1 – Feb.22,’11 
 
SOP: Preparing the Instrastat Report  
(dual-currency package)* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
The procedures described below will assist your financial officers in setting up Intrastat 
definitions, completing required Intrastat information in shipping, receiving and return 
documents, and producing monthly reports for Intrastat Declarations. 
Procedure 
Stage I: Setting Up for Intrastat Declarations 
1. Enter the Countries form. For each country that is a member of the European Union, 
record the appropriate Intrastat Code.  
Tip: In many cases, this is identical to the international country code appearing in the 
Country Code column. 
2. Enter the Terms of Delivery form. Record needed delivery terms and assign the 
appropriate Intrastat Code to each one. 
3. Enter the Itemized Customs Rates form and define the appropriate customs items. 
For each item: 
 Flag the Incl. in Intrastat column to ensure that any parts that are assigned this 
customs item (see below) will be included in Intrastat reports. 
 If supplementary units are required for this item in the Intrastat declaration, flag the 
Supp Units-Intrastat column. 
Note: This column should be flagged if the standard unit of weight for parts that 
are assigned this customs item is not the kilogram (e.g., gold, which is measured 
in ounces). If this column is not flagged, the weight of all parts that are assigned 
this customs item will appear in the Intrastat report in kilograms. 
4. Enter the Customers form and make sure a Country is defined for each customer. 
5. If a given customer maintains more than one site in various EU countries, enter the 
Customer Sites sub-level form and define a Country for each site. 
Note: If a given site is located in the same country as the customer's main address 
(defined in the upper-level form), leave this column blank. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

6. Return to the upper-level form and select the Financ. Parameters for Customers 
form from the list of Direct Activations. In the Customer tab, assign the customer the 
desired delivery terms (in the Freight Terms column). 
7. Enter the Vendors form. For each vendor: 
 Make sure a Country is defined (in the Address and Phone tab). 
 Click the Shipments tab and define the vendor's default Shipment Mode. 
 Click the Payments tab and define the vendor's Payment Terms. 
8. Enter the Financial Parameters for Parts form, assign each imported part the 
appropriate customs item and define the part's Weight Unit as "kilogram". 
Note: For exceptional cases (e.g., gold), define a different weight unit (e.g., ounces). 
Stage II: Completing Intrastat Information in Customer Shipment & 
Return Documents 
1. Enter the inventory transaction document in question (for example, Customer 
Shipments) and retrieve the desired transaction. 
2. Make sure that the correct Site is defined for the transaction, as this can affect the 
transaction's Country in the Intrastat report. 
3. To record Intrastat details for individual transaction items that differ from the default 
definitions assigned to the transaction, move to the line item in question (e.g., in the 
Shipped Items form) and then enter the next sub-level form, Intrastat Definitions. 
Make sure that the correct values are defined in the following columns: 
 Nature of Trans-1st - choose one of the predefined transaction types 
 Nature of Trans-2nd - choose one of the predefined secondary transaction types. 
 Terms of Delivery for the item 
 The Country to/from which the item has been sent 
Stage III: Completing Intrastat Information in GRVs & Vendor Return 
Documents 
1. Enter the inventory transaction document in question (for example, Goods Receiving 
Voucher) and retrieve the desired transaction. 
2. To record Intrastat details for individual transaction items that differ from the default 
definitions assigned to the transaction, move to the line item in question (e.g., in the 
Received Items form) and then enter the next sub-level form, Intrastat Definitions. 
Make sure that the correct values are defined in the following columns: 
 Nature of Trans-1st - choose one of the predefined transaction types 
 Nature of Trans-2nd - choose one of the predefined secondary transaction types. 
 Terms of Delivery for the item 
 The Country to/from which the item has been sent 
Cat.No. LB110031 2 Ver.1 – Feb.22,’11

Stage IV: Generating Intrastat Declarations 
1. Run the Intrastat report. 
2. In the input screen that opens, choose the appropriate report type: 
 Arrivals - For a report of incoming transactions (GRVs, vendor invoices, customer 
returns or items in customer shipments that were recorded with a negative 
quantity). 
 Dispatches - For a report of outgoing transactions (customer shipments, sales 
invoices, vendor returns). 
3. In the For Month Ending on column, indicate the last day of the month for which to 
report Intrastat data. 
4. In the Download File Name column, specify the file name and path to which the 
report data will be saved, in a comma delimited text (.csv) file. 
Cat.No. LB110031 3 Ver.1 – Feb.22,’11

Cat.No. LB110031 4 Ver.1 – Feb.22,’11 
Appendix: The Format of the Intrastat Report 
The Intrastat report includes the following data: 
 Header - Displays VAT data for the company from which the report was run 
 Type of Report - The report type chosen when running the report (i.e., Arrivals or 
Displatches). 
 The customs item defined for the part in this transaction 
 The total value of the current item, as defined in the invoice or memo recorded for 
this transaction (or in the transaction document itself, if no invoice/memo was 
recorded). 
 Delivery terms - as defined for the relevant customer or transaction 
 Nature of transaction ("10" indicates an outgoing transaction, "20" indicates an 
incoming transaction) 
 Net mass (kg) - the part's weight, in kilograms 
 Supplementary units - the quantity that was sent or received, if supplementary units 
are defined for this item 
 Country - the country to/from which the item was shipped 
 An external reference number/document number
