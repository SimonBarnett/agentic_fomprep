# NEOVII Financials Analysis V3

- **Source:** `NEOVII Financials Analysis V3.docx`

1

1	Introduction	5

1.1	Objectives	5

1.2	Base Assumptions for design:	5

1.2.1	Priority version and interface	5

1.2.2	Companies	5

1.2.3	Currencies	6

1.3	Fiscal periods	6

1.3.1	Definition, Opening and closing	6

1.4	Chart of accounts	7

1.5	Chart of accounts payable	7

1.6	Chart of accounts receivable	7

1.7	Journal entries	7

2	Currencies	7

3	Purchasing	8

3.1	Purchase Invoices	8

3.1.1	Overview	8

3.1.2	Part numbers	8

3.1.3	Utility bills	8

3.1.4	Invoices for services	9

3.1.5	Invoice for goods	9

3.1.6	Unapproved invoices	9

3.1.7	Tax / VAT	10

3.1.8	Reverse VAT	11

3.1.9	(*) LZB codes	12

3.1.10	Scanning invoices	12

3.1.11	(*) Shipping Vouchers	13

3.2	Payments	13

3.2.1	Prepare payments	13

3.2.2	Prevent payment (Checking)	14

3.2.3	SEPA payment file for domestic and EU payments	14

3.2.4	Credit Swiss	14

3.2.5	Remittance advice	14

3.2.6	Early payment discount	14

3.3	Exchange rate adjustments	15

4	Taxes	16

4.1	VAT	16

4.1.1	NP VAT	16

4.1.2	VAT in NBT	16

4.1.3	ZMEN report	17

4.2	GDPdU	17

4.3	Intrastat	17

5	Sales	18

5.1	Customers	18

5.1.1	Customer Credit Limit	18

5.1.2	Debt Collection Process	18

5.1.3	Customer statements	18

5.2	Sales to NEOVII Pharmaceuticals (NP):	19

5.3	Sales invoices	19

5.3.1	Invoice Legalisation	19

5.3.2	Credit notes	20

5.4	Customer definitions	21

5.4.1	Customer groups	21

5.5	Profit and loss / Balance sheet reports	21

5.5.1	Company standard	21

5.5.2	GAAP / Personalised reports	21

6	Fixed assets	23

6.1	Setup	23

6.2	Pool of assets	23

6.3	Posting to the ledger	23

6.4	Reports	23

7	Budgets	24

8	Profit and cost centres	24

8.1	Profit centres	24

8.2	Cost centres	24

9	Costing analysis	24

9.1	Costing method	24

9.2	Stock valuation	25

9.3	Cost of goods sold	25

10	Payroll journal entry	25

11	Bank Reconciliations	25

12	Management reports	26

12.1	BI reports	26

12.2	Dashboards	26

12.3	Financial reports	26

12.4	Excel templates	27

13	Technical instructions:	27

13.1	Update cross exchange rates	27

13.1.1	Procedure design	27

13.1.2	The process will fail with an error message if:	27

13.2	Scanning module	28

13.3	LZB development	28

13.3.1	New LZB codes table	28

13.3.2	New LZB codes form	29

13.3.3	LZB code on invoices table	29

13.3.4	New LZB code field purchase invoices	29

13.3.5	New LZB report	29

13.4	Shipping vouchers	29

13.4.1	Raising shipping voucher from purchase orders	30

13.4.2	Check for existing shipping voucher	30

13.4.3	Shipping voucher on purchase invoices	30

13.5	Modifications for SEPA file creation	30

13.5.1	Add classification to suppliers	30

13.5.2	Payment classification form	30

13.5.3	Add a field to suppliers table	30

13.5.4	Financial parameters for vendors	30

13.6	Definition of early payment discount	31

13.6.1	Definition of payment terms:	31

13.6.2	Link to customer:	31

13.6.3	Invoice:	33

13.6.4	Invoice journal entry:	33

13.6.5	Receipt:	34

13.6.6	Receipt journal entries:	35

13.7	Exchange rate adjustments	36

13.7.1	Procedure input	36

13.7.2	Report output	36

13.7.3	Updates	36

13.7.4	Exchange rate adjustment	37

13.8	VAT	37

13.8.1	Definitions	37

13.9	NP VAT	38

13.9.1	VAT in NBP	39

13.9.2	ZMEN report	39

13.10	Credit limit	39

13.10.1	Mail message	39

13.11	GAAP and personalised reports	41

13.11.1	Report Types table	41

13.11.2	Report Types form	42

13.11.3	P&L/BS Item Per Report Type Table	42

13.11.4	P&L/BS Item Per Report Type from	42

13.11.5	Defaults	42

13.11.6	Reports	42

13.12	Fixed assets	43

13.12.1	Pool Assets	43

13.12.2	Pool Assets form	43

13.12.3	New Filed On Assets	43

13.12.4	A new assets report	43

13.12.5	New report to compile:	43

13.13	Costing – inventory valuation	44

13.13.1	New table to be created:	44

13.13.2	Add a form for reduced values	45

13.13.3	Reduction Percent	45

13.13.4	Inventory Status Percent	45

13.13.5	Procedure to calculate reductions	45

13.14	Payroll Journal Entry	45

14	Appendix URS	47

Introduction

The document below is a detailed design for the financials module of the Priority™ system for Neovii Biotech (NBT) the company in Germany and Neovii Pharmaceuticals (NP) the company in Switzerland.

This design is meant to cover FRE and NH as well. However, these companies have not been discussed in the meetings under the assumption that they will comply with the same rules as the rest.

The document describes the solution introduced by Priority™ ERP.

The document was written based on details as introduced by the key personnel of the company who participated in the design meetings.

The document does not detail every capability of the system but rather concentrates on main processes and outlines of the required modifications to the standard system.

All customizations will be marked with a (*) sign.

Objectives

The business deliverables are as follows:

Manage the day to day accounting processes

Comply with German GAAP and Swiss GAAP key reports

Provide reporting tools

To be capable of managing products cost

Be able to receive system reports and analyse consolidated data

Base Assumptions for design:

Priority version and interface

The Priority™ version that will be installed is version 17.1, the user interface can be either indows client or web client. This document’s presentation is over the web client.

Companies

There will be two logistic companies opened in the system: one NBT and one for NP, and two additional financial environments: Fuhrer Real Estate, Neovii Holdings. At a later stage of the project NBT North America will be implemented.

NBT will have its own customer, for example: Germany, Lebanon, Iran and Syria

End-customers outside of Germany (besides the countries above) will be managed in the NP environment.

Currencies

The primary currency will be set to the local country’s currency whereas the secondary currency will be set to € for consolidation purposes, as illustrated in the following table:

Fiscal periods

Fiscal periods will be defined according to the calendar year: beginning 01/01/YY ending 31/12/YY.

It is imperative that all companies in the multi company array will have the same fiscal period definitions.

Definition, Opening and closing

Every year the financial controller will define the next fiscal year.

When the time comes, fiscal periods will be opened for journal entry transactions by the financial controller.

Equally, closing of these fiscal periods will be done as part of end of month procedure.

Specific users may be defined as special users which are allowed to post transactions into specific fiscal periods even if closed as illustrated in the following screenshot:

Chart of accounts

In order to run consolidated reports, Trial Balance Items & Bal Sheet/ P&L Items would need to be identical in all companies in the array.

Although it is not essential for consolidated reports, it has been decided that accounts numbers will also be kept the same across all companies.

Accounts can be assigned a “not in use” status, however history against this account will remain forever and cannot be deleted.

Ledger reports can be found on Financials > General Ledger > Financial Statements > Ledger Reports

Chart of accounts payable

Every supplier on the system will be associated with an account on the chart of accounts payable. The link between account and supplier is a 1 to 1 relationship where the account number & description match the supplier’s number and description.

There’s no sales control ledger account, instead every supplier has its own account.

Chart of accounts receivable

Every customer that isn’t a temporary customer (its number doesn’t start with a ‘T’) will be associated with an account on the chart of accounts receivable. The link between account and customer is a 1 to 1 relationship where the account number & description match the customer’s number and description.

There’s no sales control ledger account, instead every customer has its own account.

Journal entries

Journal entries are generated automatically primarily by the various financial documents:

Invoices, receipts, payments, deposits, transfers etc.

In addition there are a few programs on the system which generate journal entries:

Transfer prepaid expenses to expense account, exchange rate adjustment, fixed assets (depreciation / write off) etc.

However, from time to time, journal entries may be recorded manually in the “entry journal” form.

Generally, once a journal entry is posted to the ledger, it cannot be revised.

However, certain elements can be revised once posted on “Entry revisions” form.

Fields that can be revised are for example: profit/cost centre, budget, details, payment date and more.

Transaction amount, transaction account and most of the properties of a journal entry cannot be revised once posted.

Currencies

The consolidated reports will be in €

Exchange rate interface will be assigned to NBT and a batch process will update the cross rates in the all other subsidiaries according to their primary currency.

As mentioned above, primary currency across all companies will be Euros (€).

The main company will be NBT and the exchange rates will be loaded to this company from the European central bank.

The rest of the companies will be updated according to the exchange rate (cross rates) from the main company.

(*) a procedure, needs to be created and put on the scheduler to calculate and load the cross exchange rates to each company according to its primary currency.

See technical instructions on ‎13.1

Purchasing

Purchase Invoices

Overview

Currently, purchase invoices arrive and scanned automatically in to the ERP system. In Priority™ this functionality will no longer be available. Therefore, the invoices would need to be typed in manually and then for future reference, scanned as attachment to the relevant document.

(*) note: the scanning needs to be purchased, installed and configured.

See technical description on ‎13.2

Part numbers

In order to make invoice entry quicker, easier and more accurate it has been decided that part numbers will be created for the various services, utilities and items that are purchased.

Items are associated with accounting families and both items and families have an array of defaults:
 Expense/purchase/asset account, cost/profit centre, VAT group (0%, 7% or 19%) and more.

The initial list will be given to NEOVII by Neopharm according to company standards.

This means that some items would need to bear two codes. For example: Taxi fare as illustrated bellow:

Utility bills

However, some of the utility bills are made known in advance and the provider is scheduling the payments across equal bills for the whole year. 
Some of the utility bills are paid by direct debit.
At the end of the year there’s an adjustment bill that is posted manually.

The recurrent utility bills will be set in advance and every month post the relevant amount as a Journal entry.

Once the bill has been paid, this normally transpires through the entry of bank statement.

Therefore, the person who is processing the bank statement will specify the supplier as the “adjustment” account and therefore post the payment against the supplier as illustrated bellow:

Once the supplier is debited due to the payment/bank reconciliation as above mentioned, the account would need to be reconciled: matching invoices with payments.

(*) Please note that “Recurring journal entry” module is required.

Invoices for services

When a purchase order is received, it will be booked into Priority ™ by using a GRV (see the logistic analysis document).

Services are not inventory controlled and some services are recoded directly as invoices (No PO).

In these instances, there will be a list of optional part numbers that correspond with expense accounts to select from. These part numbers are also determining the VAT rate in case of special VAT (7% for example).

Invoice for goods

As a rule, in most cases, goods and services that have a purchase order need to be booked to the system via a good receiving voucher (GRV) document.

The GRV is confirming the arrival of the goods or the render of services. This document is not raised by accounts but by warehouse / logistics.

When accounts receive a purchase invoice, it is referred back to the purchase order (PO).

In order to close the purchase cycle, the selection of PO number by the user will retrieve the relevant GRV number into the reference tab. This will populate the multi GRV invoice with the assumed received quantities and if there’s any discrepancy between the invoice and the GRV/PO it have to be escalated to the relevant body.

In case that the invoice is arriving before the GRV, the invoice will not be posted until the GRV is booked on the system.

Once the GRV is recorded, the invoice will be raised, linked and finalised by an overnight batch process. GRVs and invoices that remain un-reconciled will be sent as email messages to designated mailing lists in the organisation. This process is described in more details under the logistic analysis document. See chapter 3.2:
(*) A warning message if there is no GRV to be retrieved (Business rule).

Unapproved invoices

Invoices that have not been approved for any reason: dispute, mismatch quantities, mismatch prices etc., will be marked as such. This will prevent these invoices from being processed for payment.

Purchasing personnel should automatically a system notification with regard to the mismatch. This process is covered under the logistics analysis document.

Tax / VAT

VAT is referred to in more details on VAT

Purchase invoices may have several different tax percent.
 be 7%, 19% or 0%. 
Each one of these brackets would require a part number that is assigned the right tax group. 
i.e. group 007 for 7%, group 999 for tax exempt and 000 or left blank for the default.
The default tax percent is according to the supplier’s tax code, for domestic suppliers the tax code will be 19% and for foreign suppliers it would be 0%. 
Please note: If the supplier’s code is 0% then not matter what tax group the item, the percentage will be 0%.

In case of variable tax percent which is undetermined due to special tax (France, Belgium, others), the tax will be entered manually as lump sum.

For each one of these groups, there will be a nominal account which will be used for posting the VAT. This will ensure a separation of different VAT categories in the nominal ledger.
For example:

Reverse VAT

In some instances, the invoice has reverse VAT.
Reverse VAT is referring to the entire invoice, in which case, a journal entry code of reverse VAT will be selected by the user and as a result, the invoice’s VAT will debited and credited to a reverse credit VAT account and debited to a reverse debit VAT account as demonstrated to the team during the analysis meetings.

For example:

Create two accounts for reverse tax under chart of accounts:

Reverse tax credit

Reverse tax debit

Define reverse tax journal entry code and use the new accounts in the pattern definitions:

When raising a multi GRV invoice, select the above JE code under “Invoice Add’l” details:

Once the invoice is finalised, the JE posted will credit and debit the pre-defined VAT accounts accordingly as illustrated in the following screenshot:

(*) LZB codes

A report needs to be designed and compiled.

A breakdown of all import purchases by country of origin and activity code (marketing, technical services, consultancy etc.)

This report is issued on a monthly basis.

On every import invoice (Multi GRV) there will be a drop down list of LZB codes, allowing the user to choose the relevant LZB code for the specific invoice. It at the user’s discretion to select the right LZB code according to the best of their knowledge.

(*) development is required to support LZB reporting as described in section ‎13.3

Scanning invoices

All purchase invoices (hardcopy) should be scanned and attached to the multi GRV invoices form.

(*) MedatechUK scanning module is required as described in section ‎13.2

(*) Shipping Vouchers

At the moment, NBP & NP are not using shipping vouchers. However, in order to collect import cost and allocate them accurately to the imported goods, shipping vouchers must be assigned.

In order to make it easier, the following process is suggested:

Effectively, asking the user to decide whether the newly raised purchase order is an import or not. From that point on, the system is taking care of the links between PO, Invoice and shipping voucher.

(*) In order to implement this process see required developments on section ‎13.4

Payments

Prepare payments

Payments are prepared on a weekly basis. A file is created and transferred to the bank as a lump sum for all suppliers. This is how it will also be presented in the bank statement.

Therefore, prepare invoices will be done using an interim bank account. This will be used as a suspense account until the bank statement has been loaded and then reconciled as lump sum.

In the reconciliation work area the suspense account will be selected as the adjustment account to be credited against the transfer amount.

The suspense account would then need to be reconciled manually on a regular basis as it currently is.

Prevent payment (Checking)

Invoices can be flagged at any point in time as “Checking”. This check box will prevent any payments to be made for this invoice. This flag can be applied on “Flag invoices for payment” form as per the following example:

Check box in Green is flagged for payment, payment will be raised automatically when running “Prepare payments” procedure

Check box in Red is flagged for prevent payment, payment will not be raised automatically when running “Prepare payments” procedure and also will be blocked when trying to pay manually.

Check boxes in Grey are not flagged at all, no payment will be raised automatically, payments will not be raised automatically but won’t be blocked either.

SEPA payment file for domestic and EU payments

SEPA is a format used for electronic bank transfers in Germany and other European countries.

The current process of creating a SEPA file includes a step to select the relevant payments (bank transfers) to be downloaded in the SEPA format.

It is our intention to keep the same mechanism, however allow selecting only payments to suppliers that are marked for SEPA payments.

Most payments will be done by bank transfer. Therefore the default for a supplier will be: “pay by bank transfer”.

(*) Every supplier will have a classification on “Financial parameters for vendors” to identify the payment method as: SEPA, ROW (Rest of the world) or any others for future use.
This will allow the user to identify and capture the vendors for a specific payment run.

(*) The standard SEPA file procedure would need to be slightly modified to allow selection of specific classification (SEPA) from “Financial parameters for vendors” as described in section ‎13.5

Bank transfers will be uploaded to the various bank accounts in a pre-defined SEPA file format.

For details on these modifications please refer to section ‎13.5

Credit Swiss

At the moment all transactions are being processed manually.

Phase 1 of the project will continue to adopt this approach with the view that an automated payment functionality is planned for phase 2

Remittance advice

At this point in time there’s no intention to produce remittance advices to suppliers. However, should this be reconsidered, the facility is there.

Early payment discount

For some customers and/or suppliers, discount is given on early payments.

For these specific accounts (Receivables or payables) an appropriate payment terms code will be assigned with the early discount definitions and a special journal entry code will be created as per the following example in order to separate VAT and Value before VAT into two lines. 
The VAT line would have the refundable VAT account designated as the contra account whereas the value before VAT will have the discount account as the contra account. As per the example below.

Once the payment is made, the journal entry will be posted which will refund the discounted VAT to the relevant VAT account.

(*) Settlement discount module is required (Medatech)

See detailed description on section ‎13.6

Exchange rate adjustments

According to German GAAP the Profit or loss due to exchange rate adjustments on accounts receivables & payables can only be recognised once the invoice has been paid in full.

Other accounts, such as bank accounts for example, will be adjusted according to their pre-defined check box regardless of the account balance (Credit or Debit).

In Priority, exchange rate adjustments apply to accounts that are checked to undergo an exchange rate adjustment. And vice versa in order to exclude accounts from the procedure run, the check box needs to be un-checked.

The work process would be:

Run a report that will display which accounts are going to be adjusted and the amount to be posted.

Check A/R & A/P accounts with a negative adjustment (debit)

Un-check A/R & A/P accounts with positive balances (Credit)

Check A/R & A/P accounts with a balance of zero in account currency (fully paid)

In companies where the primary currency is not € this procedure would need to be ran twice:

Once in order to adjust the main currency according to the account currency’s exchange rate and once in order to adjust the secondary currency according to the account’s exchange rate.

In both cases the same work process will apply but with different reports and procedures:

For adjusting the both main and secondary currency use: Adjustments to foreign accounts

For adjusting the secondary currency use: Adjustment to Swiss Franc accounts

In order to include / exclude accounts from the adjustment procedure use Exch. Rate adjustment definition form and check / un-check the box next to the account:

(*) In order to make this work process easier and automatic the following modification will be done:

A procedure would need to be created in order to post the exchange rate adjustment as per the above mentioned set o rules. See section ‎13.7

Taxes

VAT

For other references to VAT in this document see: Tax / VAT, Reverse VAT.

VAT report will be based on the values recorded on the balance sheet.

VAT rates in Germany are generally 0%, 19% or 7%. VAT rates in Switzerland normally 8%.

Every supplier, customer and invoice will be assigned a VAT code which will determine the VAT percent and the VAT accounts that the tax will be posted to.

There are many other reports available on the system such as:

Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports (Europe) > Journal of Customer Invoices

Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports (Europe) > Journal of Vendor Invoices

Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports (Europe) > EC Sales List

Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports (Europe) > Intrastat

And more.

See section ‎13.8.1

NP VAT

The required report for NP Switzerland consists of:

The total revenue of domestic sales (Domestic sales accounts)

The total output VAT of domestic sales (Output VAT account)

The total expenses of domestic purchases (According to Journal of vendor invoices)

The total input VAT of domestic purchases (Input VAT account)

Total revenue from export (Export sales account)

See section ‎13.9

VAT in NBT

TAX is reported manually to the German government on their website.

The required report for NBT Germany consists of:

The total revenue on domestic sales (Domestic sales accounts)

The total output VAT on domestic sales (Output VAT account)

The total expenses on domestic purchases (According to Journal of vendor invoices)

The total input VAT on domestic purchases (Input VAT account)

The total expenses on reverse charge purchases (According to Journal of vendor invoices)

The total input VAT of reverse charge purchases (According to Journal of vendor invoices)

ZMEN report

Total purchases from the NBT is reported manually to the German government website on a monthly basis:

The total revenue = 0

The total output VAT = 0

The total expenses on German purchases

The total input VAT on German purchases

Additionally 2 reports are required:

A detailed report which presents the expenses and the income taxes from all German vendors.

A report which presents a total revenues sorted by EU/non-EU union and then by the countries.

See section ‎13.9.2

GDPdU

The tax authorities in Germany require access to company data. The authorities may also demand that all tax-relevant data be handed over on a data carrier (CD/DVD).

If this tool will not suffice then there are other options and a different option will have to be devised.

Intrastat

Intrastat reports are part of EU regulations.

Every inventory transaction has Intrastat codes that define the nature of the transaction.

As per the following tables:

Nature of transaction code 1

Nature of transaction code 2

Terms of delivery

Country

Sales

Customers

Customer Credit Limit

For some customers a credit limit will be defined. Some will be defined as an error message which will stop them dead on track as sales orders are being processed, shipments and invoices as well.  Some will be defined as a warning message which will allow processing the order / shipment / invoice but with a warning.

(*) The system would need to be set to send an email to pre-defined group of users when such a credit warning is prompted. See ‎13.10.1

Debt Collection Process

The debt collection process begins by running aging reports. It is recommended that both companies will use the aging work area in order to prioritise the collection process and in order to record tasks against customers with chasing information. Aging reports will be run in account currency (which is more relevant).

Customer statements

Customer Statement will be sent to customers on a quarterly basis by using the “Print Customer Statement w/Aging” report. This report can be sent directly by email according to the contact definitions in customer contacts form as illustrated in the following screenshot. The documents will be sent as HTML or as PDF as per user selection (PDF is recommended).

Sales to NEOVII Pharmaceuticals (NP):

NEOVII Pharmaceuticals (NP) are trading with NEOVII Biotech (NBT) under two different VAT numbers:

German VAT number which draws VAT

Swiss VAT number without VAT

These will be set as two different logistic customers associated with one paying financial customer.

As a result, there’s going to be one aging report for both customers and both customers will have the same currency (EUR).

At the point of order entry, the user must select the correct logistic customer NP with VAT or NP without VAT.

Sales invoices

Invoice Legalisation

According to regulations, some customers require legalisation of their invoices prior to shipment.

An invoice must be raised on the system for the customer (for example: Iran) and after legalising the invoice, goods can be shipped out. The legalisation process may take some time and therefore shipments cannot be raised before the invoice.

Sales between NP to outside of Europe
- Invoice and customer shipment from NBT to NP will be raised at the same time and finalised (no legalisation process needed).
- Invoice from NP to end customer will be based on the sales order, before customer shipment is raised. 
The invoice will have to be identical in the number of lines (part numbers, and quantities) to the NBT invoice and will be linked to the corresponding sales order lines. 
(*) For printing purpose, "Batch number" field will be added to the Multi Shipment Invoice Items form. 
The invoice will be finalised but the journal entry will not be posted to the ledger. 
Only after the legalisation process, the customer shipment will be raised, and the lines of the shipment will be matched to the lines of the invoice. 
The journal entry will then be posted. 
Shipment lines will be linked to invoice lines on Shipmts/Rtrns form. 
(*) This process will be automated.

Sales from NP to Europe
- Invoice from NBT to NP will be booked with the customer shipment (no legalisation required)
- Invoice from NP to customer will be booked with the customer shipment (no legalisation required)

Sales between NBT and Europe (Germany)
Customer shipment will be raised with the invoice. 
The invoice from NBT to the customer will be booked (no legalisation required).

Sales from NBT to outside of Europe (~4 customers)
The invoice from NBT to the customer will be based on the order, before the customer shipment and after the packing slips. The user will be notified (by a warning) that needs to split the lines in the invoice (in case there is more than one batch per order line in the packing slips that are linked to the order). 
(*) A report will be developed that will display how lines should be split. 
The invoice will be finalised, but the journal entry will not be posted. 
Only after the legalisation of the invoice, a customer shipment will be booked.

This process is described in detail in the logistic analysis document. The above mentioned is a recapitalisation of the logistic analysis document.

The standard invoicing process will be as described in the following diagram:

Credit notes

Occasionally credit notes will be raised, sometimes on their own and sometimes as a result of customer return.

A credit note is raised by changing the type of invoice from D (Debit) to C (Credit). As a result, the customer will be credited and the line account will be debited.

These credit notes are normally raised either with a customer return document as reference or on their own, i.e. no sales order / other reference.

When a customer return is specified, the lines will be populated in the same manner as they would for a customer shipment, listing the returned items, their quantities and prices.

When no reference is specified, it is up to the user to key in the relevant details: part number, quantity, price, reason, manual reference etc.

Customer definitions

Customer groups

NBT:

In order to maintain default income accounts and default profit centres, each customer will be assigned a unique customer group.

It is through this customer group that the defaults are then applied to the invoice.

NP:

Only two groups are required at the moment to represent the two types of customers.

These customer groups will be linked to profit centres which will allow running P&L by profit centre and other analysis reports by profit & cost centres.

Equally, the income accounts will be populated by these defaults allowing other analysis reports as well as P&L reports to be used and analyse by income accounts.

These definitions are done on:

Financials > Maintenance of Financials > Basic Data > Default Accounts > Accounts for Customer Groups

Profit and loss / Balance sheet reports

Company standard

The system’s default balance sheet and profit and loss reports will be according to company standards given by Neopharm.

Every account on the system has a link to its BS or P&L item, according to these definitions this account will appear on the various reports.

The system will then be able to run a variety of P&L reports and BS reports as standard.

In addition, there is a set of multi company consolidated reports based on these standard account definitions.

The consolidated reports will only work with the above mentioned standard definitions given by Neopharm.

GAAP / Personalised reports

In order to comply with German GAAP and Swiss GAAP each one of the above mentioned reports will have another set of definitions.

These definitions will be done for each and every account on the system, including A/P and A/R.

(*) There’s going to be a list of personalised report types, some of which will be GAAP reports, some will be any personalised report type.

For example:

Every account will then have P&L / BS definitions per type of report. For example:

Account 102-0 by default will appear under “CASH IN BANK”, however on the personalised report it will appear under “Cash” as illustrated in the following screenshot.

When running a report, the user will be prompted to select the personalised format:

The report will then display the values according to the personalised definitions:

(*) It is required to copy and modify the following reports in order to comply with the above mentioned functionality:

Balance sheet

Balance sheet in Primary & secondary currency

Profit & loss

Profit & loss in Primary & secondary currency

P&L - Designated Period vs YTD

P&L - Current vs Previous Year

Quarterly Profit & Loss (Table)

Monthly Profit & Loss (Table)

P&L Statement per Profit Centre

See section: ‎13.11

Fixed assets

Setup

Fixed assets will be setup on the system with their original purchase value, purchase date, current up-to-date depreciation, depreciation date, depreciation percent and other relevant information.

The system will calculate the depreciation in straight line and post to the ledger according to each assets pre-defined set of accounts: Asset, accumulated depreciation and depreciation expenses.

Pool of assets

Some small assets are grouped under a pool of assets and need to be reported as a pool of assets. The various asset, depreciation and accumulated depreciation accounts will be identical anyway, only dates and description will be different.

(*) Add table for “Pool of assets” and a field to the assets register form in order to define the pool.

(*) Add a report to display asset depreciation for the entire pool of assets.

See section: ‎13.12‎13.12.4

Posting to the ledger

In order to depreciate assets, users must run a procedure to calculate the depreciation table for the foreseen future periods. Thereafter, journal entries will be generated based on this calculation.

In addition, when assets are scrapped or sold, the system will generate the appropriate journal entries as per definitions of scrap date, selling price and the pre-defined accounts.

Reports

There are some standard reports for fixed assets and depreciation. However another report needs to be compiled as per the following example:

See section: ‎13.12.5

Budgets

Priority™ has a budget mechanism that can be quite complex.

It has been decided, during the analysis meetings to implement this module in its most simplistic configuration, i.e. every P&L nominal ledger account will be assigned a budget item.

Budgets will enable allocated the forecasted expense against the budget item and thereafter run reports to compare planned vs execution.

In addition when a budget is selected, the system will check its balance and alert if the current expense is exceeding the budget.

Going forward, it is possible and easy enough to improve the configuration and consolidate accounts and / or budget items.

The full hierarchy and high level of configuration will be considered for phase 2 of the project.

Profit and cost centres

Profit and cost centres will be set in order to analyse sales and purchases.

Profit centres

Profit centre will be defined on the system as customers (NBT) or as customer groups (NP). Additional profit centres will be defined going forward as product groups.

Cost centres

Cost centres will be defined as various different categories which will be brought over from the current SAP system after some data cleansing.

Costing analysis

Costing method

Costing analysis is used in order to work out materials and products actual costs.

This is then used in order to calculate inventory valuation and thereafter cost of goods sold.

Costing will be set to moving average method, however, since the manufacturing processes are not yet in place, it would be impossible to determine the actual moving average cost of manufactured products. Therefore, the cost of the products will be estimated and set manually in whilst the cost of materials will be calculated automatically.

The figures will be updated in:

Financials > Cost Analysis for Manufacturers > Costing Programs > Initial Product Costs

And

Financials > Cost Analysis for Manufacturers > Costing Programs > Update PartCost by Initial Costs

This method may present some issues and inconsistencies but this is the method that Neopharm requires Neovii to employ.

The idea is that raw materials and products will be managed completely separately according to inventory adjustments to either raw materials or products. And their costs will be completely detached.

Stock valuation

Stock valuation will be calculated according to the balances calculated by the past balance routine times the cost calculated by costing analysis or assigned to products and intermediate products by the financial controller as mentioned above.

However, stock in specific statuses will be displayed at a reduced value.

(*) Inventory statuses will have a percent set against them which will be used in order to calculate the rate of reduction in percent.

For example:

Status “Goods”, reduction percentage 0%

As a result inventory valuation will be calculated at the standard rate.

Status “Hold”, reduction percentage 12%

As a result inventory valuation will be calculated at a reduced value (by 12%)

This percentage can be adjusted from time to time according to the regulations.

When costing analysis is run, the system will automatically calculate the stock values according to the above mentioned rules.

See section: ‎13.13

Cost of goods sold

Costing analysis will run for the end of the month as part of the month end procedure after running the “Past balance” procedure that is locking all inventory transactions up to that point.

The values that will be calculated will be used according to periodic COGS accounting.

E.g. COGS = Open inventory + Purchases – Closing inventory

Since each group of items will have its own accounting definitions, the purchasing accounts will reflect the various types of purchases according to the type of product / materials.

Payroll journal entry

In large, most journal entry transactions will be generated and posted by the various financial documents and procedures. Nevertheless, in some instances Journal entries will be posted manually.

The monthly payroll will be uploaded to Priority ™ from a file and post a journal entry as per pre-defined set of accounts that will be configured on the payroll package an exported on a monthly basis.

(*) A loading routine needs to be written according to the file format that will be provided by Neovii

See section: ‎13.14

Bank Reconciliations

NBT are using Deutsche Bank, NP are using Swiss Bank.

Currently in SAP bank statements are recorded manually.

In Priority™ it is our intention to download statements from the banks’ websites and upload to Priority.

The loading procedure will have to be generated according to the relevant file formats. Otherwise, these uploads will be designed in excel with the intention to copy & paste them to the system.

Bank reconciliation is referenced in other paragraphs of this document.

See: Utility bills, Prepare payments

Management reports

BI reports

Priority™ is equipped with a set of business intelligence reports which enables managers to run analysis on various areas of the business such as:

Sales analysis (Invoices)

Sales analysis (Orders)

Purchase Analysis (Invoices)

Purchase Analysis (Orders)

Budgets, Profit and cost centres, CFO reports

Inventory valuation

Production

And more

For example:

Quarterly sales report with the ability to drill down to the individual customers / products / other criteria and change the reported period.

Dashboards

Priority™ has also the ability to present data in dashboards. This data can also be displayed as a shortcut on outlook, enabling management to see at a glance the business performance. For example: Sales Manager Dashboard

Financial reports

There’s an array of financial reports and report generators which user can use, generate and manipulate, depending on their level of permission.

Please see section ‎5.5

Excel templates

The Priority™ system allows users to create their own xcel templates which are based on specific reports. These templates are quite often used in order to create pivot tables and graphs from data that is extracted directly from Priority™ by running a report with search and filter criteria.

Technical instructions:

Update cross exchange rates

Back to section 2: Currencies

In reference to paragraph ‎2, a procedure is required for updating cross exchange rates.

Base Exchange rates will be recorded in NBT as per the European central bank. For example:

On the Swiss company, the main currency is CHF and therefore the cross exchange rate between the EUR and the CHF needs to be uploaded for all currencies except the main currency (CHF).

For example in NP (Switzerland) the following exchange rates will be loaded:

For example in NA (USA) the following exchange rates will be loaded:

Procedure design

The procedure will run for each company individually and have the following input:

From Date, To Date, Company of origin for exchange rates.

The procedure will use a form load in order to upload the exchange rates as described above from company of origin to the current company.

The process will fail with an error message if:

No exchange rates for the given dates in company of origin.

Main currency code of company of origin isn’t referenced in current company.

Main currency code of current company isn’t referenced in company of origin.

If there’s no cross reference for currencies in current company then their exchange rate will not be loaded. No message.

Scanning module

Back to section 3 Purchas

Single entity scan module will allow work stations that have a Twain scanner to scan documents and store them as attachments.

The module is available for a range of different Priority forms:

Invoices - both sales and purchase

Orders - Sales and purchase

Customers and Vendors

Quotations

Inventory transactions

And more.

Each one of these forms has a direct activation. For example, Multi GRV invoices.

As the user is processing the invoice, as part of the process, he will place the hard copy of the vendor invoice in the scanner’s feeder and click the direct activation “Scan document”.

As a result, the user will be prompted and asked to key in a title for the attached document.

Once the user has entered the title and pressed “Ok”, the scanner will automatically be activated, scan the document, convert it to PDF and associate it with the Invoice that is being processed.

The scanned document itself will be saved in a pre-defined path.

It is recommended to use a scanner with a feeder in order to allow scanning documents with multiple pages.

LZB development

Back to section 3.1.9 LZB Codes

The following developments are required in order to cater for the LZB codes & report requirement specified in section ‎3.1.9

New LZB codes table

New table to be created:

New LZB codes form

Create a form based on the above table with a drop down list (CHOOSE-LIST) to exclude inactive codes and ordered by the sort column. LZB description should be mandatory.

LZB code on invoices table

A new field to be added to invoices table:

New LZB code field purchase invoices

A new field will be added to the following forms: vendor invoice, multi GRV invoice.

The drop down box should appear automatically.

New LZB report

A new report will be written to display the following information:

Input:

From invoice date

To invoice date

Output:

LZB code

LZB description

Country

Expense amount

For example:

Shipping vouchers

Back to section 3.1.11 Shipping Vouchers

This section is a minor modification aimed to improve the process flow from purchase order to multi GRV invoice and introduce and easier way for raising and linking shipping vouchers to invoices.

Raising shipping voucher from purchase orders

A procedure is required as direct activation from Purchase orders form in order to raise a shipping voucher and associate it with the Purchase order.

This will be implemented by mean of a “form load” that will populate the shipping voucher date to be the purchase order’s date and the purchase order number as reference.

Check for existing shipping voucher

If there’s already a shipping voucher that’s been raised for the purchase order, a message will be displayed, informing the user of its number and ending the procedure without raising another one.

Shipping voucher on purchase invoices

A new trigger is required as POST-FIELD on the purchase order reference field in the multi GRV invoice and vendor invoice forms.

When a multi shipment or a vendor invoice is associated with a purchase order, the shipping voucher will automatically populate.

Modifications for SEPA file creation

Add classification to suppliers

Back to section 3.2.2 SEPA file

New table to be created:

Payment classification form

Create a form based on the above table with a drop down list (CHOOSE-LIST) to exclude inactive codes and ordered by the sort column. Payment Class description should be mandatory.

Add a field to suppliers table

A new field to be added to suppliers table:

Financial parameters for vendors

Add a join and a field to financial parameters for vendors, to allow selection of a payment class.

If the user selected an inactive class, warning message will be displayed.

Definition of early payment discount

Back to section 3.2.5 Early Payment Discount

Example:

Definition of payment terms:

Code, Description,

Number of months or days as per payment terms,

Discount percentage,

Number of days early than the agreed payment terms to apply the discount

In this example, the payment terms are 1 month

If the customer is paying at least 1 day earlier then he is eligible to a 10% discount

Journal entry code:

Link to customer:

Invoice:

When an invoice is posted to the ledger, the journal entry is posted according to the entry code designated on the invoice:

Invoice journal entry:

Thus debiting the customer by separating the amount to:

Amount owing for goods: 100

Amount owing for VAT: 20

Receipt:

When the receipt is being booked:

The two amounts will display separately

This will allow the system to apply the discount separately.

The corresponding discounted values will be posted back according to the contra account

For the goods – to a discount account (P%L)

For the VAT – debiting output VAT

Receipt journal entries:

As a result, 3 journal entries will be posted:

Receipt:

Discount:

VAT:

Exchange rate adjustments

Back to section 3.3 Exchange Rate Adjustments

A new procedure will be written on the system to incorporate the following steps in one process: Calculate the required adjustment as the Adjustments to Foreign Accounts report would do.

Include / Exclude accounts from adjustment

Check A/R & A/P accounts with a negative adjustment (debit)

Un-check A/R & A/P accounts with positive balances (Credit)

Check A/R & A/P accounts with a balance of zero in account currency (fully paid)

Apply exchange rate adjustments as Record Adjs for Foreign Curr Acc would do

Procedure input

Fiscal period (Mandatory)

Fiscal year (Mandatory)

Currency (Mandatory)

Exchange rate

Account

Refer 1

Refer 2

Post entry? (Boolean)

Report output

Account No.

Account Description

Bal (Foreign Curr)

Bal (EUR)

Adjusted Bal (EUR)

Variance (EUR

Updates

Updating check boxes as per A/R & A/P balances

Exchange rate adjustment

Will post to the ledger as would the standard procedure: Record Adjs for Foreign Curr Acc and the input mentioned above.

VAT

Definitions

Back to section 4.1 VAT

VAT definitions will be done in Taxes form:

Financials > Maintenance of Financials > Basic Data > Financial Attributes > Taxes

It is important to separate the various VAT codes in order to allow running VAT reports that will differentiate purchase invoices and sales invoices by their categories.

In addition, it is important to define VAT groups:

This will allow us to separate various tax rates and post them to different VAT accounts according to their rate and definitions.

Account groups:

NP VAT

Back to section 4.1.1 NP VAT

Input:

From Date (begin of period)

To Date (end of period)

VAT group (For filtering domestic purchases)

Output:

Total revenue of domestic sales for the designated period.

The figures will be taken from monthly balances for all domestic sales accounts as specified in the chart of accounts under accounts group:

Total output VAT on domestic sales

The figures will be taken from monthly balances for output VAT specified in the chart of accounts under accounts group as mentioned above.

Total expenses of domestic purchases

The figure will be taken from purchase invoices posted in the given period as per:

Financials > General Ledger > Financial Statements > Taxes > VAT Reports (Europe) > Journal of Vendor Invoices

This figure will be split according to the VAT code:

Domestic purchases

EU Purchases

Rest of the world Purchases

Reverse VAT purchases

VAT recorded manually

Tax exempt

Basically any type of VAT code that is defined for purchases:

The user would be able to filter only domestic purchases if so wishes.

Total Input VAT on domestic purchases

Total revenue on export

The figures will be taken from monthly balances for export sales specified in the chart of accounts under accounts group as mentioned above.

VAT in NBP

Total revenue of domestic sales

Total output VAT on domestic sales

Total expenses of domestic purchases

Total Input VAT on domestic purchases

Total expenses on reverse charge purchases

Total input VAT on reverse charge

All above figures will be taken from either the relevant account group (VAT, sales) or from the journal of vendor invoices (purchases) as described in the previous paragraph.

ZMEN report

Back to section 4.1.3 ZMEN Report

German purchases will have a separate VAT code in NP in order to be able to filter these purchases in the journal of vendor invoices report. This will allow updating the figures on line.

Credit limit

Mail message

Back to section 5.1.1 Customer Credit Limit

In order to send mail messages automatically on customer credit alerts, a mail group needs to be defined and assigned to these messages:

Set up a mailing group, for example:

Setup a mailing rule for the warning message, for example:

It is required to set the mail message on sales orders, customer shipments and Multi shipment invoices.

GAAP and personalised reports

Back to section 5.5.2 GAAP and personalised reports

Report Types table

New table to be created:

Report Types form

Create a form based on the above table with a drop down list (CHOOSE-LIST), description should be mandatory.

P&L/BS Item Per Report Type Table

P&L/BS Item Per Report Type from

Create a form based on the above table as sub level form to: Chart of Accounts, Chart of Accounts Receivable, and Chart of Accounts Payable.

The form will display:

Report Type Code

Report Type Desc (Read Only)

Bal Sheet/P&L Item

Defaults

A trigger will be added to Report Types form which will automatically populate account defaults every time that a new type is added.

A trigger will be added to the accounts forms (Chart of Accounts, Chart of Accounts Receivable, and Chart of Accounts Payable) to populate the default Bal Sht/P&L Item whenever a new account is added.

Reports

New reports will be compiled for:

Balance sheet

Balance sheet in Primary & secondary currency

Profit & loss

Profit & loss in Primary & secondary currency

P&L - Designated Period vs YTD

P&L - Current vs Previous Year

Quarterly Profit & Loss (Table)

Monthly Profit & Loss (Table)

P&L Statement per Profit Centre

In addition to the standard input that each of the reports currently have, these new reports will have a new input for: Report type.

The report will then refer and display from the definitions specified for this report type.

Fixed assets

Pool Assets

New table to be created:

Pool Assets form

Create a form based on the above table with a drop down list (CHOOSE-LIST), description should be mandatory.

New Filed On Assets

A new field will be added to the assets form in order to link it to the asset and used as a sub division for asset group.

A new assets report

Back to section 6.2 Pool of assets

A report is required to display asset data & pool data.

Input:

From Period [1, 2, 3 … 12]

To Period [must be greater than from period]

From Year [2015, 2016…]

Asset group

Output:

Asset/Pool total price

Asset/Pool total depreciation for the period

Asset/Pool total accumulated depreciation

Asset/Pool total Scrap for the period

New report to compile:

Back to section 6.3 Reports

Input:

From Period [1, 2, 3 … 12]

To Period [must be greater than from period]

From Year [2015, 2016…]

Asset group

Output:

Column A: Heading = Parent group.

Assigned on asset groups in order to identify a hierarchy for asset groups.

Column B: Asset group.

Defined on asset groups form, assigned per asset.

Column C: Opening balance for period

This calculation is based on the opening balance of all asset accounts for the designated asset group.

Column D: Additions = Increase in asset group between open and closed date

This figure is based on the closing figure – opening figure

Column E: Disposals = Total asset write off for period

This figure is calculated according to all Asset Sale/Scrap (DED) journal entries for the period, segregated by asset groups.

Column F: Closing balance for period

This figure is a consolidated amount taken from the monthly balances of all group assets accounts.

Column H: Prior depreciation

This is the opening balance for the asset group depreciation account

Column I: Depreciation in period

The depreciation for the above given period as per closing balance – opening balance

Column J: Disposals = Total asset write off for period

This figure is calculated according to all Asset Sale/Scrap (DED) journal entries for the period, segregated by asset groups.

Column K: Closing balance for the period

This figure is a consolidated amount taken from the monthly balances of group assets depreciation accounts.

Column M: Net Value

Column F – Column K

Column N: Previous year’s figures.

Same as above just for previous year

Costing – inventory valuation

New table to be created:

Back to section 7.2 Stock Valuation

Add a form for reduced values

Add 2 query forms based on the above table:

Product Inventory Valuation Reduced filtering only P type parts

Materials Inventory Valuation Reduced filtering only R type parts

Use MAKEWARHSCOST and RAWWARHSCOST as reference.

Reduction Percent

Add a field to customers table:

Inventory Status Percent

Add the above field to Inventory Statuses form

Procedure to calculate reductions

A procedure is required to calculate inventory reduced values, based on inventory valuation done by standard Priority.

These values will be populated in the above new table according to the above mentioned rules.

Once costing results are deleted, the values in this new table must also be deleted.

Payroll Journal Entry

Back to section 8 Payroll Journal Entry

A payroll journal entry will be uploaded on a regular basis from a tab delimited file in the following format:

The standard journal entry loading procedure will be used for loading the payroll transaction

Infrastructure would need to be set up accordingly for:

WAG JE code

Source program

Check boxes and defaults for the interface per company

Appendix URS

User requirement specifications.

Please note:

N/A = Not available

Phase 2 has not been discussed yet

Currencies: Environment | Main Currency | Secondary Currency

NBT | EUR | €

NP | CHF | €

NBNA | USD | €

FRE | EUR | €

NH | EUR | €

Account/Pattern | Description | Debit Code | Credit Code | Description | % of Credit/Debit | Divide? | Contra Account | Contra Acct Descrip

A/P | Payables |  | 2 | Sum before tax | 100 | Y | LineItems | Accts by Line Item in Document

LineItems | Accts by Line Item in Document | 2 |  | Sum before tax | 100 |  | A/P | Payables

205-3 | Input VAT Reverse tax Debit | 3 |  | VAT | 100 |  | 205-5 | Input VAT Reverse tax Credit

205-5 | Input VAT Reverse tax Credit |  | 3 | VAT | 100 |  | 205-3 | Input VAT Reverse tax Debit

Date 09/09/15 | Euro (€) Exchange rate | Cross Exchange |  | CHF = (CHF cross exchange) X (currency exchange) |  | USD = (USD cross exchange) X (currency exchange)

USD | 1.1139 | 0.897747 |  | 0.918021 X 1.1139 = 1.022583 |  | Not relevant

GBP | 0.7251 | 1.37912 |  | 0.665657 |  | 0.918021 X 1.1139 = 0.650956

CHF | 1.0893 | 0.918021 |  | Not relevant |  | 0.977915

ILS | 4.324 | 0.231267 |  | 3.969522 |  | 3.881857

EUR | Not loaded | Not relevant |  | 0.918021 |  | 0.897747

Date 09/09/15 | Exchange

USD | 1.022583

GBP | 0.665657

ILS | 3.969522

EUR | 0.918021

Date 09/09/15 | Exchange

GBP | 0.650956

CHF | 0.977915

ILS | 3.881857

EUR | 0.897747

Table Name | Table Type | Title

ZNEO_LZBCODES | 0 | LZB Codes

Column Name | Type | Width | Title | Decimal Precision | Remark

LZB | INT | 13 | LZB (ID) | 0 | (AU)

LZBNAME | CHAR | 10 | LZB Code |  | (U)

LZBDES | CHAR | 32 | LZB Description |  | 

SORT | INT | 17 | Sort |  | 

ACTIVE | CHAR | 1 | Active |  | (Boolean)

Column Name | Type | Width | Title | Decimal Precision | Remark

LZB | INT | 13 | LZB (ID) | 0 | 

Purpose of expenditure  (Account description) Zweck der Zahlung | Identification code (LZB) Kennzahl | LZB description | Country Land | Country code Land code | Amount Belrage In Tsd Euro

Travel | 017 | Tourism | Belgium | BL | 500.00

Commissions | 573 | IT services | United Kingdom | UK | 10,000.00

Services | 573 | IT services | Israel | IL | 50,000.00

News and information services | 613 | Usage of software | Switzerland | SW | 6,000.00

… Expense 1 | 613 | Usage of software | Denmark | DN | 1,000.00

… Expense 2 | 613 | Usage of software | United Kingdom | UK | 2,000.00

Table Name | Table Type | Title

ZNEO_PMTCLASS | 0 | Payment Classification

Column Name | Type | Width | Title | Decimal Precision | Remark

PMT | INT | 13 | PMT Class (ID) | 0 | (AU)

PMTNAME | CHAR | 10 | Payment Class Code |  | (U)

PMTDES | CHAR | 32 | Payment Class Description |  | 

SORT | INT | 17 | Sort | 0 | 

ACTIVE | CHAR | 1 | Active |  | (Boolean)

DEFAULT | CHAR | 1 | Default |  | (Boolean)

Column Name | Type | Width | Title | Decimal Precision | Remark

PMT | INT | 13 | PMT Class (ID) | 0 | 

Table Name | Table Type | Title

ZNEO_ RTYPE | 0 | Report Type

Column Name | Type | Width | Title | Decimal Precision | Remark

RTYPE | INT | 13 | Report Type (ID) | 0 | (AU)

RTYPENAME | CHAR | 10 | Report Type Code |  | (U)

RTYPEDES | CHAR | 32 | Report Type Description |  | 

Table Name | Table Type | Title

ZEMG_ACCRTYPE | 0 | P&L/BS Item Per Report Type

Column Name | Type | Width | Title | Decimal Precision | Remark

ACCRTYPE | INT | 13 | Item Per Report (ID) | 0 | (AU)

ACCOUNT | INT | 13 | Account |  | (U Column 1)

RTYPE | INT | 13 | Report Type |  | (U Column 2)

SECTION | INT | 13 | Bal Sht/P&L Item (ID) |  | 

Table Name | Table Type | Title

ZNEO_ ASSETPOOL | 0 | Asset Pool

Column Name | Type | Width | Title | Decimal Precision | Remark

POOL | INT | 13 | Asset Pool (ID) | 0 | (AU)

POOLNAME | CHAR | 10 | Asset Pool Code |  | (U)

POOLDES | CHAR | 32 | Asset Pool Description |  | 

Table Name | Table Type | Title

ZNEO_ WARHSCOST | 0 | Inventory valuation + reductions

Column Name | Type | Width | Title | Decimal Precision | Remark

PART | INT | 13 | Part (ID) |  | (U - column 1)

CURDATE | DATE | 8 | Date |  | (U - column 2)

SERIAL | INT | 13 | Work Order (ID) |  | (U - column 3)

WARHS | INT | 13 | Warehouse |  | (U - column 4)

CLOSED | CHAR | 1 | Cloesd |  | 

COST | REAL | 16 | Actual Value | 2 | 

REDUCED | REAL | 16 | Reduced Value | 2 | 

SECONDCOST | REAL | 16 | Actual Value ({F.F}) | 2 | 

SECONDREDUCED | REAL | 16 | Reduced Value {(F.F)} | 2 | 

ADJUSTED | REAL | 16 | Adjusted Value | 2 | 

BALANCE | INT | 17 | Balance | 3 | 

RAWCOST | REAL | 16 | Materials Value | 2 | 

RAWSECONDCOST | REAL | 16 | Material Value {F.F} | 2 | 

STDCOST | REAL | 16 | Std Value | 2 | 

STDSECONDCOST | REAL | 16 | Std Value ({F.F}) | 2 | 

STDEMPCOST | REAL | 16 | Std Labor Cost | 0 | 

STDSECONDEMPCOST | REAL | 16 | Std Labor Cost {F.F} | 0 | 

STDRAWCOST | REAL | 16 | Std Mat. Cost | 0 | 

STDSECONDRAWCOST | REAL | 16 | Std Mat. Cost {F.F} | 0 | 

PERCENT | REAL | 16 | Reduction Percent | 2 | 

Title Red = Mandatory | Position | Loaded Date Format | Maximum Width | Type in Interim Tbl | Comment

Journal Entry No. | 1 |  | 8 | CHAR | Alpha Numeric

Ln | 2 |  | 6 | INT | Whole Number

Entry Code | 3 |  | 5 | CHAR | Always WAG

Reference | 4 |  | 16 | CHAR | Free text

Refer. 2 | 5 |  | 16 | CHAR | Free text

Transaction Date | 6 | DD/MM/YY | 8 | DATE | 

Reference Date | 7 | DD/MM/YY | 8 | DATE | 

Due Date | 8 | DD/MM/YY | 8 | DATE | 

Account No. | 9 |  | 16 | CHAR | 

Contra Account | 10 |  | 16 | CHAR | 

Budget | 11 |  | 24 | CHAR | 

Profit/Cost Center | 12 |  | 16 | CHAR | 

Sum | 13 |  | 18 | REAL | 

Sum (€) | 14 |  | 18 | REAL | 

Exch. Rate (€) | 15 |  | 10 | REAL | 

Sum (Acct Curr) | 16 |  | 18 | REAL | 

Exch Rate-Acct Curr | 17 |  | 10 | REAL | 

Acct Curr | 18 |  | 3 | CHAR | 

Debit/Credit | 19 |  | 1 | CHAR | 

Source | 20 |  | 8 | CHAR | Always Wages

Remark | 21 |  | 32 | CHAR | 

Cash Flow Code | 22 |  | 8 | CHAR | 

Entry Item Group | 23 |  | 8 | CHAR | 

Ref. 1 - Entry Item | 24 |  | 16 | CHAR | Free text per line

Ref. 2 - Entry Item | 25 |  | 16 | CHAR | Free text per line

Details | 26 |  | 24 | CHAR | Free text per line

Profit/Cost Center 2 | 27 |  | 16 | CHAR | 

Profit/Cost Center 3 | 28 |  | 16 | CHAR | 

Profit/Cost Center 4 | 29 |  | 16 | CHAR | 

Profit/Cost Center 5 | 30 |  | 16 | CHAR | 

Requirement ID | Requirement Description | Analysis document reference | Remark

Finance |  |  | 

PRIO.FPR.FIN.GEN.001 | The following standard  ERP modules are required: |  | 

PRIO.FPR.FIN.GEN.001.A | General ledger | Paragraph 1.4 | Chart of accounts

PRIO.FPR.FIN.GEN.001.B | Non-stock/Service Site purchasing | Chapter 3 | 

PRIO.FPR.FIN.GEN.001.C | Service support office purchasing | Chapter 3 | 

PRIO.FPR.FIN.GEN.001.D | Accounts payable | Paragraph 1.5 | 

PRIO.FPR.FIN.GEN.001.E | Accounts receivable | Paragraph 1.6 | 

PRIO.FPR.FIN.GEN.001.F | Fixed assets | Chapter 6 | 

PRIO.FPR.FIN.GEN.001.G | Contract management Supplier rebates/accruals etc. from contract to AR] | N/A | Will be considered in Phase 2

PRIO.FPR.FIN.GEN.001.H | Project management [e.g. Capex planning / expenditure] | N/A | Will be considered in Phase 2

PRIO.FPR.FIN.GEN.001.I | Cash management | Paragraph 3.2 | 

PRIO.FPR.FIN.GEN.001.J | Management Reporting | Chapter 12 | 

PRIO.FPR.FIN.GEN.001.K | Statutory accounting / consolidation | Paragraph 5.5 | 

PRIO.FPR.FIN.GEN.001.L | Treasury | Chapter 11 | 

PRIO.FPR.FIN.GEN.001.M | Credit control | Paragraph 5.1.1 | 

PRIO.FPR.FIN.GEN.001.N | Budget & controlling | Chapter 7 | 

PRIO.FPR.FIN.SUP.001 | Invoices are scanned and using the data on the Invoice the system should automatically create an invoice record in the system with a preliminary status | Paragraph 3.1 & 3.1.10 | 

PRIO.FPR.FIN.SUP.002 | Once an invoice is scanned and verified by accounting it should be approved through a workflow process.  When the workflow ends successfully the invoice status should change to "approved for payment" | Logistic analysis document chapter 3.2 | 

PRIO.FPR.FIN.SUP.003 | If an invoice is created and connected to a purchase order that has been received in full then the invoice will automatically be approved for payment. If the purchase order wasn't received in full then a manual approval process is required | Logistic analysis document chapter 3.2 | 

PRIO.FPR.FIN.SUP.004 | Invoices that are approved for payment will be included automatically  for payment if the  payment date has been reached | Paragraph 3.2 | 

PRIO.FPR.FIN.SUP.005 | An invoice can be locked manually to prevent payment | Paragraph 3.2.2 | 

PRIO.FPR.FIN.SUP.006 | The user manually runs a program which creates a file including all the necessary data to create a bank transfer.  This program has to be run using a special password.  The invoices included are all the approved and unlocked invoices that have reached payment date. The system will allow to set the number of days that an invoice will be paid before it's payment date | Chapter 3.2 | 

PRIO.FPR.FIN.SUP.007 | The file that is created in the payment process is uploaded to Deutche bank that sees to the bank transfers | Paragraph 3.2.3 | 

PRIO.FPR.FIN.CUS.001 | The system will automatically create letters for customers with overdue payments together with all the necessary information | Paragraph 5.1.3 | 

PRIO.FPR.FIN.CUS.002 | Debt collection process | Paragraph 5.1.2 | 

PRIO.FPR.FIN.INT.001 | Currency rates will be automatically updated on a daily basis. | Chapter 2 | 

PRIO.FPR.FIN.INT.002 | The monthly  Tax report should be created from the system and entered manually into the German tax authorities web site | Chapter 4 | 

PRIO.FPR.FIN.INT.003 | For customers out of Germany only: A summary report lists sales by customer. Amount and VAT no. Entered Manually into a web site. TAX Authorities | Chapter 4 | 

PRIO.FPR.FIN.INT.004 | A Monthly report which is sent to the European Central Bank. The reports lists all payments made outside of Germany. 2 reports: Amount received and sent per country and amount due and liability per country | Paragraph 3.1.9 | 

PRIO.FPR.FIN.INT.005 | The Payroll accounting in the system will be created by an interface from a file created by the ADP system. Payroll accounting in the system have to be based on the German tax law. | Chapter 10 | 

PRIO.FPR.FIN.INT.006 | Bank interfaces : Deutche bank, Comerz bank | Chapter 11 | 

PRIO.FPR.FIN.GEN.001 | Automatic depreciation according to definitions in the system and automatic booking in the financial system | Paragraph 6 | 

PRIO.FPR.FIN.GEN.002 | The system should support The German GAAP but also be ready for American GAAP and IFRS | Paragraph 5.5.2 | 

PRIO.FPR.FIN.GEN.003 | The system will allow to open, close and re-open reporting periods in the system by authorized users only | Paragraph 1.3.1 | 

PRIO.FPR.FIN.GEN.004 | When an account is changed or deactivated, the history of the account has to be kept within the system and not deleted. | Paragraph 1.4 | 

PRIO.FPR.FIN.GEN.005 | The system will allow to generate a report that shows all the activity on the accounts by period | Paragraph 1.4 | 

PRIO.FPR.FIN.GEN.006 | The system will allow to update the details in existing entries | 1.7 | 

PRIO.FPR.FIN.BUD.001 | The system will allow to generate a budget based on each cost centre department and types of expenses within each department | Chapter 7, Chapter 8 | 

PRIO.FPR.FIN.BUD.002 | The system should provide tools for planning budget forecasts and measuring the planned budget against actual and previous year within the system. The planning will be done on the system with separate access rights for every dept. | Chapter 7 | 

PRIO.FPR.FIN.BUD.003 | The system will alert but not block when the expenses exceed the budget. The value for alert have to be defined in the system | Chapter 7 | 

PRIO.FPR.FIN.FIX.005 | The system will allow to manage fixed assets according to the German tax authorities | Chapter 6 | 

PRIO.FPR.FIN.FIX.006 | The system will allow managing fixed assets groups. Each group will have a default depreciation rate (changeable), pre-defined by authorized users | Paragraph 6.1 | 

PRIO.FPR.FIN.FIX.007 | The system will allow to allocate a purchase of fixed asset (when recording an invoice) to the relevant group and determine the relevant depreciation rate. The depreciation rate will be changeable. | Paragraph 6.1 | 

PRIO.FPR.FIN.FIX.008 | The system will allow to change the allocation of fixed assets and depreciation rate at any time by authorized users | Paragraph 6.1 | 

PRIO.FPR.FIN.FIX.009 | The system will be able to calculate the depreciation expenses and the net cost of fixed assets | Paragraph 6.3 | 

PRIO.FPR.FIN.FIX.010 | The system will allow to sell or delete items from the fixed asset list, and report gain / loss in the P&L report | Paragraph 6.3 | 

PRIO.FPR.FIN.EXC.002 | The system will allow to record a revaluation  of the relevant balance sheet items according to the relevant exchange rate | Paragraph 3.3 | 

PRIO.FPR.FIN.EXC.003 | The system will be managed with EUR as its main currency with USD and CHF as secondary currencies | Chapter 2 | 

PRIO.FPR.FIN.CTL.001 | The system should calculate automatically the cost of goods. All components of the cost of goods have to be represented in the system (main parameters: production volume, consumption volume, yield, direct material, department cost Production, Quality Control, Facility, labour) | Chapter 9 | 

PRIO.FPR.FIN.CTL.002 | The inventory costs should include a mechanism to calculate the stock value according to the German accounting standard. The stock value of a material is depending on the status.  Essential status of materials: blocked, in quarantine, temporary shelf life, risk of stock keeping a.s.o. | Paragraph 9.2 | 

PRIO.FPR.FIN.CTL.003 | The system should include a report generator which will be used for all the controlling dept. needs. | Paragraph 12.3 | 

PRIO.FPR.FIN.CTL.004 | The system will support all the legal financial regulations in Germany and Switzerland | Paragraph 5.5.2 | 

PRIO.FPR.FIN.CTL.005 | Separate access rights for profit centres |  | Phase 2

PRIO.FPR.FIN.CTL.007 | Automatic discount for invoice payed within X weeks. Specified in the payment terms | Paragraph 3.2.6 | 

PRIO.FPR.FIN.CTL.008 | Consolidation reports | Paragraph 5.5.1 | 

PRIO.FPR.FIN.CTL.009 | Internal transfer of costs from one cost centre to another | Paragraph 1.7 | 

PRIO.FPR.FIN.CTL.011 | P&L reports in excel format with the ability of automatic reports via mail | Paragraph 12.4 | 

PRIO.FPR.FIN.CTL.012 | Balance sheet in excel format  with the ability of automatic reports via mail | Paragraph 12.4 | 

PRIO.FPR.FIN.CTL.013 | Profit centre reports with the ability to drill down to individual invoices. | Paragraph 12.1 | 

PRIO.FPR.FIN.CTL.014 | Handling of goods that have stock but no value | Chapter 9 | 

PRIO.FPR.FIN.CTL.015 | The system will create an electronic balance sheet and profit and loss statement according to the standards of the German tax authorities | Paragraph 5.5.2 | 

PRIO.FPR.FIN.CTL.016 |  |  | 

PRIO.FPR.FIN.CTL.017 | P/L reports should be according to the German, Swiss  and American GAAP | Paragraph 5.5.2 | 

PRIO.FPR.FIN.CTL.018 | The system will provide Profit centre reports | Paragraph 5.4.1 | 

 | Payment per PO line or signing PO line as not for payment | N/A |
