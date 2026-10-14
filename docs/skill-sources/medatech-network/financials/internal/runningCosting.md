# runningCosting

- **Source:** `runningCosting.docx`

How to run the costing programs

Preparing to Run Costing for a Past Balance Date

To run costing for a past balance date, record a past balance for the desired costing date, and make sure that it does not include any negative inventory balances. In addition, record standard costs for all raw materials and close all completed shipping vouchers.

Why Do We Need a Past Balance?

The purpose of costing for past balance date is to compare part costs and inventory values at different points in time. To maintain the integrity of this data, inventory values must not be changed retroactively in the period preceding the costing date. The past balance program calculates inventory balances for a given date and "locks" the inventory system, such that you cannot record, revise or delete any inventory transactions recorded prior to that date.

The breakdown into past balance periods facilitates the analysis of results, and reduces the run time of the programs that calculate inventory balances and inventory valuations.

To check inventory balances on the past balance date:

·      Enter the Dates of Calculated Balances form. All existing past balances and their dates are displayed.

·            If there is no past balance recorded on the desired date, run the Inv. per Warehouse as of Date report. If there are negative balances in the warehouses in question, resolve them either by performing an inventory count, or by correcting any problematic inventory transaction documents. Then calculate a past balance for that date (regardless of whether negative balances were found).

·            If a past balance was recorded for the desired date, enter the Past Balances per Date sub-level form. If there are negative balances in the warehouse in question, delete the past balance and resolve them either by performing an inventory count, or by correcting any problematic inventory transaction documents, then calculate a new past balance for that date.

Note:

For assistance, run the Past Balances Wizard.

To check standard material prices:

1. Enter the Standard Costs form and retrieve all raw materials (R in the Type (P/R/O) column) with 0 in the Std Cost column (for dual-currency users, with 0 in both Std Cost columns).

2. Record any missing values.
Tip: Click to copy standard costs from a vendor price list, purchase invoice or actual cost.

To check shipping vouchers:

1. Enter the Shipping Vouchers form and retrieve all recent shipping vouchers.

2. In cooperation with the employee responsible for shipping vouchers, make sure that all completed vouchers have been closed, and that the details of all closed vouchers are correct.

Note: The costing program only takes into account shipping vouchers closed since the previous costing run. Dual-currency users: If you store imported goods in bonded warehouses, check (in cooperation with the employee responsible) that all release documents have been closed and that their recorded import costs are correct.

To view parameters affecting costing:

·      Run the View Costing Parameters program. It will display those parameters by which the costing program will calculate part costs and inventory values. It will also display the past balance date for which the last costing run was recorded.

Running Costing for a Past Balance Date

Before you begin

·      If you haven't recorded a past balance for the date for which you want to run costing, or if you deleted the existing past balance in order to make revisions, run the Calculate Balance for Date program for the desired date.
Note: For assistance recording a past balance, run the Past Balances Wizard.

To run costing for a past balance date:

1. Run the Costing for Past Balance Date program, specifying the last past balance date. If you want to run costing as of an earlier date, flag the All Past Balances runtime option.

2. If the costing program encounters problems, it will notify you at the end of its run. If this occurs, run the Warning Messages - Costing report to view the list of problems.
Tip: Most problems are caused by insufficient data.

Example:

The system cannot calculate the cost of a part that has entered inventory without a price (e.g., the invoice has not yet arrived), does not appear in any vendor price list or vendor price quote, appears with no cost in the previous past balance and is not assigned a standard cost.
