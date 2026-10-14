# SalesOrd_17_attach_project

- **Source:** `SalesOrd_17_attach_project.htm`

Sales Orders - Orders for Projects 
 
 
- 
 
 
 
# Orders for Projects

 

You can link an order to a project or to a specific project activity (when the entire order is for a single activity). The cost of the order can be added to the cost of the activity or project to which it is linked. 
 

Once the order is linked to a project or activity, you can change the income account attached to the sales order if it differs from the project's default income account. You can also plan the schedule of project payments to cover the order; this automatically updates the payment installments recorded for the project. 
 

Project linkage appears automatically in the following cases: 
 

 ·        When a single project is recorded for the customer making the order, and the SLinkProject constant is set to 1 . 
 

 ·        When the order is recorded on the basis of a price quotation linked to a project. 
 
## Notes:

 

 ·        When itemizing the order, you can also link single line items to specific project activities. 
 

 ·        Whether or not the order cost is included in the project cost is initially determined by the SProjCost constant (see the Project Management Wizard for details). However, if you normally include open order items when calculating project costs, you can omit a given item from cost calculations by removing the check mark from the Incl. in Proj. Cost column when itemizing the order. Conversely, if you normally do not take order costs into account, yet want to include a particular order item in project calculations, make sure that column is flagged for that order item. 
 

 ·        If you prepare invoices for the project by order, payments recorded for the order will be billed in a separate invoice. 
 

 ·        If the order is for work hours that are billed as they are reported (rather than according to a payment schedule), do not record payment installments so as to avoid double billing. 
 
## What do you want to do?

 

 Link the order to the entire project or check the linked project 
 

 Link the order to a project activity or check the linked activity 
 

 Change the attached income account 
 

 Record project payments for the order
