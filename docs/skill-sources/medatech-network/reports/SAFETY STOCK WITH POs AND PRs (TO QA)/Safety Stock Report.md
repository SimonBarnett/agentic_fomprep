# Safety Stock Report

- **Source:** `Safety Stock Report.docx`

Medatech Safety Stock Report

Overview:

This Report Provides Monitoring of Safety Stock Levels, and shows Purchase Orders and Purchase Requisitions against Parts below Safety Stock Level.

Thus this allows an effective build/order to stock mechanism for manufacturers/distributers who stock accordingly to Raw Material Safety stock levels.

Installation:

Install the ZEMG_STOCKCHECK.sh shell file and associated .RV file (Optional).

Log-out of Priority and log in again.

A number of tick boxes now require checking:

For Parts to be included in the report ensure that 'On Stock Check Rpt' is ticked against the Parts Status on the Parts BPM.

For Inventory to be included against the safety stock ensure that:

a) 'On Safety Stock Rpt' is checked against the warehouse.

b) 'On Safety Stock Rpt' is checked against the inventory status.

For Purchase Orders’ to be included: Ensure that 'On Safety Stock Rpt' is ticked against the Purchase Order Status in the Purchase Order BPM.

For Purchase Requisitions to be included: Ensure that the 'On Safety Stock Rpt' is ticked against the status in the Purchase Demands BPM. Note: In addition, 'Closed' Requisition Items will not be included in the report.

OPTIONAL: Would recommend auto-emailing the report to a group in Priority using the tabula task scheduler.

Location:

The same report in two locations:

Purchasing > Purchase Planning > Purchase Planning Reports > Safety Stock with POs and PRs

Inventory > Warehouse Control > Current Inventory > Safety Stock with POs and PRs
