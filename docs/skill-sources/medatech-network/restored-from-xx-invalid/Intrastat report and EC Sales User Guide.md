# Intrastat report and EC Sales User Guide

- **Source:** `Intrastat report and EC Sales User Guide.docx`

User Guide on Preparing intrastat and EC SALES REPORT

This user guide shows the procedure on preparing Intrastat and EC Sales report.

Open system.

Enter your ‘Username’, ‘Password’, and press ‘OK’ to login.

Click on ‘Company Name’ field. Select the company you wish to work in and press ‘OK’.

Setting Up for Intrastat Declarations

To define an intrastate code for each country member of the European Union, navigate to the ‘Countries’ Form via the following Path: Main > Inventory > Inventory Maintenance > Countries.

Go through the list of EC countries and F4 or  to change the view to a single record mode.

Tip: In many cases, this is identical to the international country code appearing in the Country

Code column.

Enter the ‘Terms of Delivery’ form through the following Path: Main > Financials > Cost Analysis for Manufacturers > Shipping Expense Burdening > Data for Shipping/Import Voucher > Terms of Delivery. Record needed delivery terms and assign the appropriate Intrastat Code to each one.

Enter the ‘Itemised Customs Rates’ form and define the appropriate ‘Customs Items’ (1) and ‘Description’ (2). For each item:

Flag the ‘Incl. in Intrastat’ (3) column to ensure that any parts that are assigned this customs item will be included in Intrastat reports.

If supplementary units are required for this item in the Intrastat declaration, flag the ‘Supp Units-Intrastat’ (4) column.

Note: This column should be flagged if the standard unit of weight for parts that are assigned this customs item is not the kilogram (e.g., gold, which is measured in ounces). If this column is not flagged, the weight of all parts that are assigned this customs item will appear in the Intrastat report in kilograms.

Use the sub-level form ‘Special Customs Rates’ (5) if it is required to define rate by country.

Enter the ‘Customers’ form using the following Path: Main > CRM > Customers > Customers. Search for all your EU customers and make sure a Country is defined for each customer.

Tip: To search for customer F11 (1) and type the customer ‘Number’ (2) or ‘Name’ (3) in the specific columns.

If a given customer maintains more than one site in various EU countries, enter the ‘Customer Sites’ sub-level form and define a Country for each site.

Note: If a given site is located in the same country as the customer's main address (defined in the upper-level form), leave this column blank.

Return to the upper-level form and select the Financ. Parameters for Customers form from the list of Direct Activations. In the Customer tab, assign the customer the desired delivery terms in the ‘Freight Terms’ column.

Note: These terms will appear as the default terms in all orders opened for the customer but may be revised in the sales order or in the shipping document.

Enter the ‘Vendors’ form through the following Path: Main > Purchasing > Vendors > Vendors. For each vendor:

Make sure a ‘Country’ under ‘Address and Phone’ (1) tab has been defined.

Click the ‘Shipments’ (2) tab, define the vendor's default Shipment Mode and the vendor's default Terms of Delivery.

Note: These terms will appear as the default terms in all purchase orders opened for the vendor, but may be revised.

Navigate to the following Path: Main > Financials > Maintenance of Financials > Basic Data > Default Values > Financial Parameters for Parts and enter the ‘Financial Parameters for Parts’ form. Under ‘Shipping Expenses’ (1) tab, assign to each imported part the appropriate ‘Customs item’ (2) and define the part's ‘Unit of Weight’ (3) as "kilogram".

Note: For exceptional cases define the weight as required.

Completing Intrastat Information in Customer Shipment

Navigate to ‘Customer Shipment’ form via the following Path: Main > Inventory > Inventory Transactions > Sales Inventory Transactions > Customer Shipments. Enter the Shipment form and retrieve the desired transaction F11/search Icon (1) -> enter the Doc. Number (2) -> Press Enter.

Make sure that the correct ‘Site’ is defined for the transaction, as this can affect the transaction's Country in the intrastat report.

To record intrastat details for individual transaction items that differ from the default definitions assigned to the transaction, move to the line item in question in the ‘Shipped Items’ sub-level form and then enter the next sub-level form, Intrastat Definitions. Make sure that the correct values are defined in the following columns:

Nature of Trans-1st - choose one of the predefined transaction types

Nature of Trans-2nd - choose one of the predefined secondary transaction types.

Terms of Delivery for the item

The Country to which the item has been sent

In the case of a multi-shipment invoice (or credit memo) that is to be included in the Intrastat report but is not based on an inventory transaction document (e.g., a credit memo without movement of goods), Following the Path: Main > Financials > Accounts Receivable > Customer Invoices > Multi-Shipment Invoices > Multi-Shipment Invoices enter the ‘Multi-Shipment Invoices’ form and retrieve the invoice/memo in question. In the ‘Invoice Items’ (1) sub-level form, move to the line item in question and then enter the next sub-level form, ‘Invoice Data for Intrastat Rep’ (2). Fill out the same details as above.

Completing Intrastat Information in GRVs

Enter the Goods Receiving Voucher form through the following Path: Main > Inventory > Inventory Transactions > Purchase Inventory Transactions > Goods Receiving Vouchers and retrieve the desired transaction F11/search Icon (1) -> enter the Doc. Number (2) -> Press Enter.

To record intrastat details for individual transaction items that differ from the default definitions assigned to the transaction, move to the ‘Received Items’ (1)sub-level form and then enter the next sub-level form ‘Intrastat Definitions’ (2). Make sure that the correct values are defined in the following columns:

Nature of Trans-1st - choose one of the predefined transaction types

Nature of Trans-2nd - choose one of the predefined secondary transaction types.

Terms of Delivery for the item

The Country to/from which the item has been sent

Generating intrastat declarations

To run the Intrastat report follow the Path: Main > Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports (Europe) > Intrastat.

In the input screen that opens, choose the appropriate report type:

Arrivals - For a report of incoming transactions (GRVs, vendor invoices, customer returns or items in customer shipments that were recorded with a negative quantity).

Dispatches - For a report of outgoing transactions (customer shipments, sales invoices, vendor returns).

In the For Month Ending on column, indicate the last day of the month for which to report

Intrastat data.

Report:

EC Sales Report

Note: If you are registered for VAT and you sell goods to businesses registered for VAT in other European Community (EC) member states, run this report to create a quarterly EC Sales List for these sales.

Data will only be displayed for customer invoices that meet the following conditions:

Verify that the customer have been assigned a VAT number. Go to Main > CRM > Customers > Customers, under the ‘Company Data’ tab there is a column for ‘VAT Number-Cust’.

They include parts assigned a customs item that has been flagged for inclusion in Intrastat/EC Sales List declarations. Please refer to section 2.8.

Their invoice date falls within the designated report period. Go to the following Path: Main > Financials > Accounts Receivable > Customer Invoices > Multi-Shipment Invoices > Multi-Shipment Invoices and search for the invoice.

Notes: 
- To check the validity of customer VAT numbers before creating the EC Sales List report, run the "Check Customer VAT Numbers" report. Path: Main > Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports (Europe) > Check Customer VAT Numbers
- If an invoice is flagged as Triangular Trade, this will be indicated in the EC Sales List report.

Running ‘EC Sales report’. Path: Main > Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports (Europe) > EC Sales List.

Customer: |
