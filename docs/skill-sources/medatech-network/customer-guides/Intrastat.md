# Intrastat

- **Source:** `Intrastat.docx`

Intrastat

overview

An Intrastat declaration must be made whenever goods cross from one member state of the EU to another, as part of a commercial transaction

There are a variety of exemptions, such as temporary movements, or goods transiting through a country but not staying in it, but the bulk of normal commercial goods movements must be declared in both countries (in one country as an import, in the other as an export)

Setup

Define Customs Items

Financials > Cost Analysis for Manufacturers > Shipping Expense Burdening > Data for Shipping/Import Voucher > Itemised Customs Rates

Use this form to record customs rates and Intrastat settings per customs item, according to the customs category from which the item is imported (the European Community, North America and the Rest of the World)

Ensure the items are flagged as included in the Intrastat report

Populate the percentage rates either in the upper level, or the Special Customs Rates sub-level form

Here you can define the rate per country

Flag the Supplementary Units column if supplementary units are required for this item in the Intrastat declaration

Note: This column should be flagged if the standard unit of weight for parts that are assigned this customs item is not the kilogram (e.g., gold, which is measured in ounces). If this column is not flagged, the weight of all parts that are assigned this customs item will appear in the Intrastat report in kilograms.

Note: The requirement for Supplementary Units is part of the Intrastat Classification Nomenclature (ICN), and only applies to certain classes of goods.

Note: The nature of the Supplementary Unit depends on the product; it may be the number of units, the volume in liters, or the area in square meters. For example, in the case of live animals the supplementary unit would be the number of animals shipped; in the case of skis it would be the number of pairs.

Assign Customs Items to Imported Parts

Financials > Maintenance of Financials > Basic Data > Default Values > Financial Parameters for Parts

Move to the Shipping Expenses tab, fill out the Customs Item and the rest of the shipping expense data for the selected part

You should assign kg as the Unit of Weight

Note: For exceptional cases, define the weight as required

Delivery Terms

Financials > Cost Analysis for Manufacturers > Shipping Expense Burdening > Data for Shipping/Import Voucher > Terms of Delivery

Enter the Terms of Delivery form and for each delivery term, record the appropriate Intrastat Code

Shipping Methods

Financials > Cost Analysis for Manufacturers > Shipping Expense Burdening > Data for Shipping/Import Voucher > Shipment Codes

Enter the Shipment Codes form and for each shipping method, record the appropriate Intrastat Code

Countries

Inventory > Inventory Maintenance > Countries

Assign Intrastat codes for all countries (except your own)

Note: In many cases, this is the same as the Country Code

Also fill out the VAT number length and format

Customers

CRM > Customers > Customers

In the customers form, make sure a Country is defined for each customer

If a given customer maintains more than one site in various EU countries, enter the ‘Customer Sites’ sub-level form and define a Country for each site

Note: If a given site is located in the same country as the customer's main address (defined in the upper-level form), leave this column blank

Verify that the customer have been assigned a VAT number

Under the ‘Company Data’ tab there is a column for VAT Number-Cust

Note: To check the validity of customer VAT numbers before creating the EC Sales List report, run Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports > Check Customer VAT Numbers

Financials > Maintenance of Financials > Basic Data > Default Values > Financ. Parameters for Customers

In the Customer tab, assign the customer the desired delivery terms in the Delivery Terms field

Note: These terms will appear as the default terms in all orders opened for the customer but may be revised in the sales order or in the shipping document

Vendors

Purchasing > Vendors > Vendors

Define a Country and a default Shipment Mode and Terms of Delivery for each vendor

Company Data

Check your companies VAT Number is entered correctly

System Management > System Maintenance > Companies > Company Data

Intrastat settings on a Transaction Document

You can record Intrastat information that applies to all items in the transaction document, or you can record separate Intrastat information for each item

The inventory transaction document could be:

Inventory > Inventory Transactions > Sales Inventory Transactions > Customer Shipments

Inventory > Inventory Transactions > Sales Inventory Transactions > Customer Returns

Inventory > Inventory Transactions > Purchase Inventory Transactions > Goods Receiving Vouchers

Inventory > Inventory Transactions > Purchase Inventory Transactions > Returns to Vendor

Note: You can also record Intrastat information for parts that were sent for processing or returned afterwards in a sub-level of the Service Report-Parts form

For example, in Customer Shipments, enter the Intrastat Definitions sub-level form

In the Terms of Delivery field, choose the appropriate code for the delivery terms applying to the transaction

Record the Country to/from which the goods have been sent

In the Nature of Trans-1st column, choose the transaction type for this document (e.g., change of ownership, return of goods)

In the Nature of Trans-2nd column, choose the secondary nature of the transaction (e.g., credit, transaction not shown in the VAT return report)

To record different Intrastat details for individual transaction items, move to the line item in question

Fill in the relevant columns in the next sub-level form, Intrastat Definitions

Note: You can apply this to any of the inventory transactions mentioned

Intrastat settings on an invoice

You may need to fill out Intrastat details for invoices, which do not involve an inventory transaction

Otherwise, the Intrastat declaration is based on the inventory transaction document

Financials > Accounts Receivable > Customer Invoices > Multi-Shipment Invoices > Multi-Shipment Invoices

In the Invoice - Add'l Details sub-level form, you can record Intrastat definitions

The Intrastat report will use the Intrastat Date (if defined) over the invoice date

Fill this out if you want to declare the invoice on a different date to the invoice date

You can record different Intrastat details for individual invoice items

In the sub-level of Invoice Items, Invoice Data for Intrastat Rep, fill out details for the highlighted invoice item

What is filled out here will override what is filled out in Invoice – Add’l details for this invoice item

Report

In the input screen that opens, choose the appropriate report type:

Arrivals - For a report of incoming transactions (GRVs, vendor invoices, customer returns or items in customer shipments that were recorded with a negative quantity)

Dispatches - For a report of outgoing transactions (customer shipments, sales invoices, vendor returns)

In the For Month Ending on column, indicate the last day of the month for which to report Intrastat data

The Intrastat data will be displayed in HTML format and will be saved in a defined location
