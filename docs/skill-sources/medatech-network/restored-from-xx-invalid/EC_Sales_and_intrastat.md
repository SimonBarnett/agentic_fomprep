# EC_Sales_and_intrastat

- **Source:** `EC_Sales_and_intrastat.docx`

EC Sales

Using Priority, you can produce a quarterly EC Sales List (ECSL), which displays the sales made to VAT registered customers in EC member states.

Setup

Define the Customs Items

Financials > Cost Analysis for Manufacturers > Shipping Expense Burdening > Data for Shipping/Import Voucher > Itemised Customs Rates

Ensure the items are flagged as included in the intrastat report.

Populate the percentage rates either in the upper level, or the special rates sub level.

Flag the Supp Units-Intrastat column if supplementary units are required for this item in the Intrastat declaration

(The requirement for Supplementary Units is part of the Intrastat Classification Nomenclature (ICN), and only applies to certain classes of goods. The nature of the Supplementary Unit depends on the product; it may be the number of units, the volume in liters, or the area in square meters. For example, in the case of live animals the supplementary unit would be the number of animals shipped; in the case of skis it would be the number of pairs)

Assign Customs Items to Imported Parts

Financials > Maintenance of Financials > Basic Data > Default Values > Financial Parameters for Parts

Fill out any of the applicable shipping expense data for the part and assign the customs items against the relevant parts.

Countries

Inventory > Inventory Maintenance > Countries

Assign ECSL codes for all countries (except yours)

Also fill out the VAT number length and format.

Ensure valid VAT reg no for customers

(There is no need to append the country code before the VAT number)

CRM > Customers > Customers

Ensure own VAT reg no is correct.

(There is no need to append the country code before the VAT number)

System Management > System Maintenance > Companies > Company Data

EC settings on an invoice – in sub level add’l details

You can also revise this in a final invoice:

Financials > Accounts Receivable > Customer Invoices > Invoice Revisions

(sub level of invoice items called invoice data for intrastat rep)

Running the report

Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports (Europe) > EC Sales List

Intrastat

Using Priority, you can produce monthly reports for Intrastat Declarations of the movement of goods between member states of the European Community. Extended declarations, including mode of transport and delivery terms, are generated automatically.

Setup

Intrastat Codes need to be assigned to countries, terms of delivery and shipping methods.

Inventory > Inventory Maintenance > Countries

Financials > Cost Analysis for Manufacturers > Shipping Expense Burdening > Data for Shipping/Import Voucher > Terms of Delivery

Inventory > Inventory Transactions > Sales Inventory Transactions > Shipping > Shipment Codes

Applying this to documents!

You can record Intrastat information that applies to all items in the transaction document or invoice, or you can record separate Intrastat information for each item.

The transaction document in question can be any one of the following:

      Customer Shipments

      Customer Returns

      Goods Receiving Vouchers

      Returns to Vendor

Note:

You can also record Intrastat information for parts that were sent for processing or returned afterwards in a sub-level of the Service Report-Parts form.

To complete Intrastat details for a transaction document:

1. Enter the inventory transaction document in question (for example, Customer Shipments) and retrieve the desired transaction.

2. Go to the Intrastat Definitions sub-level form.

3. In the Terms of Delivery column, choose the appropriate code for the delivery terms applying to the transaction.
Tip: Use the Terms of Delivery form to record additional delivery terms.

4. In the Country column, record the country to/from which the goods have been sent.

5. For any transaction document, in the Nature of Trans-1st column, choose the transaction type for this document (e.g., change of ownership, return of goods).

6. In the Nature of Trans-2nd column, choose the secondary nature of the transaction (e.g., credit, transaction not shown in the VAT return report).

To record different Intrastat details for individual transaction items:

1. Move to the line item in question (e.g., in the Shipped Items form).

2. Fill in the relevant columns in the next sub-level form, Intrastat Definitions.

To complete Intrastat details for an invoice:

1. Enter the invoice form in question (for example, Sales Invoices) and retrieve the desired invoice.

2. Go to the Invoice - Add'l Details sub-level form.

3. In the Delivery Terms column, choose the appropriate code for the delivery terms applying to the invoiced transaction.
Tip: Use the Terms of Delivery form to record additional delivery terms.

4. For any invoice, in the Nature of Trans-1st column, choose the transaction type for this invoice (e.g., change of ownership, return of goods).

5. In the Nature of Trans-2nd column, choose the secondary nature of the transaction (e.g., credit, transaction not shown in the VAT return report).

Notes:

      If the invoice in question is based on an inventory transaction document such as a shipping document, make sure the same Intrastat information is also recorded in the transaction document.

      For certain invoices, you can specify an Intrastat Date, which will be used in place of the invoice date to determine which transactions are included in each monthly Intrastat report.

Running the report

In addition to specifying the month for which to report Intrastat data, you can also specify the file name and path to which to save this data in a comma delimited file (e.g., C:\Priority\Intrastat_June.txt). The Intrastat data will be displayed in HTML format in addition to being saved where specified.

Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports (Europe) > Intrastat
