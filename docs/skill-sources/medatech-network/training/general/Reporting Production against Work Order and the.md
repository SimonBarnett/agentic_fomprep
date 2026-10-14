# Reporting Production against Work Order and the

- **Source:** `Reporting Production against Work Order and the.docx`

Reporting Production against Work Order and the “Extra Issues”

Inventory > Inventory Transactions > Inventory Transaction Wizards > Issues Wizard

Production > Production Control > Work Orders

SOP: Work Orders*

Customer:   Company Inc.

Assigned to: Dept./Position

Aim  To open work orders manually, and release them for production.  Work orders serve to document and track the production of a given quantity of a manufactured part. Each work order contains data regarding the quantity of parts produced, the child parts used in the work order's production routing and a progress report.

Setups  Production modeling, by which all aspects of production are defined: the factory, work cells, operations, routings and parts.  Linking each part to a work order template.

Procedure

Stage I: Opening a Work Order Manually 1. Enter the Work Orders form. 2. Record the Part Number and Work Order Qty (in factory units). A new work order is opened, numbered automatically according to the part's work order template. Note: Work orders are also opened automatically by the MRP program. In such work orders, the Opened Auto column is flagged in the Details column.

Stage II: Releasing a Work Order In order to begin production, you need to release the work order. An unreleased work order is not active within the system. When the work order is released, it is assigned a bill of materials (BOM) and production routing as defined for the part during production modeling. In addition, the work order's status is changed automatically to "Released". 1. In the Work Orders form, click the Prod. Data tab and record the Begin Production date. 2. Click the Details tab and flag the Release column.

* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not to use them without prior testing to make sure that they fit their own requirements and work practices.

Cat.No.A8000090 2 Ver.1 – Dec.8,’08

3. You can make certain revisions to the work order even after it is released, such as increasing (but not decreasing) the work order quantity. 4. You can see all of the required child parts in the Kit List sub-level form. You can change the part quantities in the kit list in the Qty (Factory Units) column.

Stage III: How Production Reports Affect the Work Order Production reports document the work order's progress, by recording the performance of operations in the production routing. See the operating procedures for production reports.  When the first production report is recorded, the Status of the work order is changed automatically to "First Report".  When production is reported for the full quantity of parts in the last operation in the work order routing, the Status of the work order is changed automatically to "Last Report".  You can track the progress of the work order in the Progress Report sub-level form.

Result  When the work order is fully reported, all of the child parts used during production of the work order part are reduced from inventory, and the finished quantity of the work order part is added to the existing inventory.

7. Production reporting: Reports of execution of an operation on parts in the work order record the quantity of parts that have undergone the operation (as well as manual issues, if needed).

Tracking Production and Inventory

Priority offers a variety of forms and reports that enable you to track the progress of work orders and monitor all related inventory transactions.

      To view all production reports recorded for a work order, do one of the following:

            Enter the Work Orders form, retrieve the desired work order and enter the Progress Report sub-level form.

            Enter the View Reported Production form and retrieve production reports by the desired work order.

            Run the Work Order Progress report.

      To view all transactions involving the inventory produced by this work order, enter the Work Orders form, retrieve the desired work order and enter the Work Order Audit Trail sub-level form.

      To view details regarding inventory in progress (i.e., parts that have not completed their routing) in one or more work orders, run the Floor Inventory by Work Order report.

      To view stuck work orders (i.e., all work orders that have not progressed beyond a specified date), run the Work Orders Not in Use report.

      To view all parts that have not yet been issued to the kits of designated open work orders, run the Issues Needed per Work Order report.

      To view all parts (including bulk) that have not yet been issued to an open work order, run the Issues Needed per Parent Part report.

      To view only those parts with available inventory that have not yet been issued to the kits of designated work orders, run the Pick List for Kits report.

Reporting Production

Production reports are used to record the execution of an operation on a certain quantity of parts, for a specific work order.

For each production report, the Backflush program performs two basic operations:

      Reduces the quantities of child parts involved in the operation from the floor inventory (according to their issue type – parts issued to kits are reduced from the kit warehouse; parts issued in bulk are reduced from the relevant floor warehouse).

      Adds the reported quantity of parent parts to the inventory of produced parts (in the reported operation). Example.

Certain production reports affect the status of the work order. For example, the first and last production reports for a work order automatically change its status to that flagged as the First Report and Last Report, respectively. If the latter is also flagged in the Close Work Order column, the last production report will cause the automatic closure of the work order.

For detailed instructions on production reporting, run the Production Report Wizard.
