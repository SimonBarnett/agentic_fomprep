# Quat

- **Source:** `Quat.docx`

Background | Synergy wants to record transport cost for individual parts on packing slip and analyse the total costs of parts and work orders/lot on a new report, Work order costing form and Raw Material Lot form.

Customer Requirement | New field required to record transport cost and needs that data to be extracted in a report.

Pre-condition | Packing slip must be created with associated line items. Work orders/lots must be linked properly to packing slips.

User story | The user wants to enter transport cost at the time of packing slip creation so that they can accurately track the shipping costs per part, per work order/lot. The user also wants to see the transport cost on the work order costing form or lot costing form. At the end the user want this data to be exported into a report for further Analysis.

Post-condition | Once transport costs are entered and packing slip is finalized, the data becomes read-only and is pulled automatically into costing forms and margin report.

Development | New Field on Packed items called “Transport Cost” – Numeric Field which allows user to update transport cost for individual parts if required. Users are allowed to update the Transport Cost until the packing slip is finalized. Read-only field is required on work order costing form and lot costing form to show this transport costs value from the packing slip New Margin report needs to be developed for analysing the cost of the products and compare it with the revenue to calculate profit margins % The new report will have the following fields -  Invoice Number Invoice Date Customer Number Customer Name Part Number Part Description Quantity on the Invoice Work Order / Lot No. Word Order/Lot Qty Original Sales Order qty Work Order Material Cost Work Order Labour & Overhead Cost Transport Cost (New field) – average or repete or total? Total Work Order/Lot Cost (material + labour/burden + transport) Unit Cost of the work order/lot(calculation) Invoice Cost or Sales Order Cost Sales Order Unit Price Total Price on Invoice Value Line items Margin % = 1 - (Total cost of the Work Order or lot/ Total Invoice Value) Input Parameters for the above report -  Date Range (From Date & To Date) Customer Name – Dropdown to select the customer(s) Invoice No. – Dropdown to select invoice number(s) Work Order / Lot (optional filters) – dropdown to select work order/ lot number(s)

Validation | The new field on the packing slip must be numeric and non-negative and the default value is 0.  The fields on work order costing and lot costing should read only

Supporting document | • Margin Report Example (attached Excel file)

Background (Brief explanation of the business context or reason behind the development request) | 

Customer Requirement (A clear summary of what the customer is asking for — the functionality or change they need) | 

Pre-condition (Any system conditions, dependencies, or approvals that must be in place before development can begin) | 

Business Process (Description of the customer’s business process where the development will be used or is expected to add value) | 

Post-condition (The expected outcome after development is completed — how the customer’s process or system should behave) | 

Development (Summary of what will be developed — technical scope, objects involved (e.g. forms, fields, reports, procedures) | 

Validation (Conditions or Criteria for the developed field, form, report, procedure, etc) | 

Supporting document (Any reference material that supports the request — emails, process maps, sample data, etc) |
