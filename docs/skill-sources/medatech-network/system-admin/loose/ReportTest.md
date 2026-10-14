# ReportTest

- **Source:** `ReportTest.docx`

Shell Testing

Shell Num: 2625

Shell Description: The Shell description from the "Remark" field in Revisions form

Programmer: Yosi

Preceding shell/s:

Scope

A new report will be created called:  "MultiCompany SO Approval Report – 1DB".

This report will be based on Sales Order report generator  > MultiCompany SO Approval Report

The path is System Management > System Maintenance > One DB Developments > MultiComp SO Approval Report-1DB

The report will display all the orders lines from logistic company (LUX) over a chosen date range.

All the order details will be taken from the logistic company

The company name will be the one that is linked to the customer group.

The orders will be grouped by company.

The credit limit will be taken from the logistic company

The credit: total credit used by customer calculated by adding open orders, unbilled shipments, uncredited returns, unbilled service calls, contract and project payment installments that have not been invoiced, reported project hours not yet billed, pending sales invoices and unpaid bills.

The open orders amount will be taken from the logistic company.

The unpaid bills will be the sum of the financial and logistic company

All the rest of the parameters will be taken from the logistic company

The credit balance = credit limit minus credit

Current – will be the sum of the financial and logistic company

Aging fields – will be the sum of the financial and logistic company

Test Cases

Setup

Create a customer in lux

Make an open sales order in lux

Set a credit limit in lux

Create a customer in inc

Create an open order in inc for that customer

Setup 1

Testing

Testing number 1 description.

Results

Testing number 1 results.

Testing number 2 description.

Results

Testing number 2 results.

.

.

.

Setup 2

Testing

Testing number 1 description.

Results

Testing number 1 results.

Testing number 2 description.

Results

Testing number 2 results.

.

.

.

Ticket Num.:115788 | Revision: | 1.0.0 | Date of issue | 

Server | System | Company

Test 6 | Priority | Luxemburg

Name of the Tester | Date | Results

Avivit |  | Success

Server | System | Company

Test 6 | Priority | Inc.

Name of the Tester | Date | Results

Avivit |  | Success
