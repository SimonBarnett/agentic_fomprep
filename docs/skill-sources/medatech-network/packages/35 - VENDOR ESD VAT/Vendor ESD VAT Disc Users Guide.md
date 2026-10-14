# Vendor ESD VAT Disc Users Guide

- **Source:** `Vendor ESD VAT Disc Users Guide.docx`

Vendor ESD VAT Discount Users Guide

1.	Description	2

2.	How to Set-Up	2

2.1.	A Journal Entry Item Group for Vat Discount called ‘VATDISC’	2

2.2.	For each different value of ESD a Journal Entry Code is required (Example if 2.5% discount).	2

2.2.1.	Create Journal Entry Code	2

2.2.2.	Entry Code Pattern	3

2.2.3.	A/P Credit of Sales Tax Line must have the VATDISC Entry Item Group.	3

2.3.	Early Settlement Payment Terms	4

2.3.1.	Set-up Suitable ESD Payment Terms	4

2.4.	Vendor Financial Parameters	4

2.4.1.	Set the vendors Payment terms.	4

2.4.2.	Set the vendors Entry Code for Invoices.	4

3.	Entering Vendor Invoices	5

3.1.	Adjust Invoice Details	5

4.	Finalizing Vendor Invoices	5

4.1.	Use the –ESD version of menu option and/or direct activation.	5

5.	Finalizing Multi-GRV Invoices	6

5.1.	Use the –ESD version of menu option and/or direct activation.	6

6.	Finalizing Debit Memos	6

6.1.	Use the –ESD version of menu option and/or direct activation.	6

7.	Flag Invoices for Payment	6

7.1.	Payment is in two parts; both should be paid to complete the process.	6

Description

These changes to Vendor Invoice finalising enable the system to cope with HMRC accepting that when early settlement discount (ESD) is offered the VAT is calculated assuming the discount is taken even if the settlement discount is not.

How to Set-Up

A Journal Entry Item Group for Vat Discount called ‘VATDISC’

Financials > Maintenance of Financials > Basic Data > Report Setups > Entry Item Groups

For each different value of ESD a Journal Entry Code is required (Example if 2.5% discount).

Create Journal Entry Code

Financials > Maintenance of Financials > Basic Data > Journal Entry Codes > Journal Entry Codes

Entry code details as normal, example code/description are just a suggestion.

Entry Code Pattern

A/P Credit of Sales Tax Line must have the VATDISC Entry Item Group.

Early Settlement Payment Terms

Set-up Suitable ESD Payment Terms

Financials > Maintenance of Financials > Basic Data > Financial Attributes > Payment Terms

Vendor Financial Parameters

Set the vendors Payment terms.

Financials > Maintenance of Financials > Basic Data > Default Values > Financial Parameters for Vendors

Set the vendors Entry Code for Invoices.

Financials > Maintenance of Financials > Basic Data > Default Values > Financial Parameters for Vendors

Entering Vendor Invoices

Adjust Invoice Details

If necessary you should adjust the Invoice values in the prices tab of the invoice details E.G.

Finalizing Vendor Invoices

Use the –ESD version of menu option and/or direct activation.

Financials > Accounts Payable > Vendor Invoices > Vendor Invoices > Finalize Vendor Invoices-ESD

Finalizing Multi-GRV Invoices

Use the –ESD version of menu option and/or direct activation.

Financials > Accounts Payable > Vendor Invoices > Multi-GRV Invoices > Finalize Multi-GRV Invoices-ESD

Finalizing Debit Memos

Use the –ESD version of menu option and/or direct activation.

Financials > Accounts Payable > Vendor Invoices > Debit Memos > Finalize Debit Memos-ESD

Flag Invoices for Payment

Payment is in two parts; both should be paid to complete the process.

NB. The VAT portion of the payment does not attract the early settlement discount thus paying the correct amount.
