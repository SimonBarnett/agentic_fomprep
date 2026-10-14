# The Priority Enterprise Management System

- **Source:** `The Priority Enterprise Management System.pdf`

The Priority™ Enterprise Management 
System 
 
 
Production Control 
 
 
 
Contents 
Introduction ..................................................................................................................2 
Work Orders.................................................................................................................2  
Issues to the Plant Floor ..............................................................................................3 
Issues Plan ...............................................................................................................3 
Issues to Floor Stock ................................................................................................3 
Issues to Kits ............................................................................................................4 
Manual Issues...........................................................................................................4  
Issues of Supplies.....................................................................................................4  
Backflush (Maintenance of WIP)..................................................................................4  
Online Backflush.......................................................................................................5  
Tracking Production .....................................................................................................5 
Reports of Production ...............................................................................................5 
Subcontracting .............................................................................................................6 
Cat.No. LB110657 1 Ver. 2, Sept.24’13

Introduction 
Priority’s Production Control module provides the means for handling 
production from the maintenance of work orders, through the issue of materials 
to the floor (including issues to kits), to the reporting of finished jobs and the 
maintenance of plant-floor inventory (work in progress). 
The module can be used in conjunction with or independently of production 
planning and/or material requirements planning (MRP). When used separately, 
work orders and issues are prepared manually. Nonetheless, kit lists will be 
opened automatically for these work orders, and issues to kits will take into 
account the appropriate warehouse and lot of the material in question. 
Moreover, the system will display the balance of available inventory of this 
material in this warehouse and lot.  
A common production dilemma is: “Which work orders can be or need to be 
worked on in each work cell during the upcoming shift?” — a problem that most 
MRP packages are unable to handle. Priority’s production planning program 
provides the answer. It generates a work plan displaying precisely those work 
orders that can (and ought to) be executed, taking into account production 
priorities and the availability of required materials for each operation. 
The detailed results provided by Priority's Production Planning module are 
transferred to the Production Control module, enabling you to compare 
planned and actual production. 
Work Orders 
Work orders are automatically opened by the system either by production 
planning or material requirements planning (MRP). You can revise results as 
well as open work orders manually.  
Each work order is assigned a unique number based on the template defined 
for the part (note that you can maintain work order numbers for certain parts 
and not for others). Production is then reported per work order, so that 
processed quantities are attached to the work order number. It is thereby 
possible to maintain warehouse balances separately for each work order. 
Specifically, it is possible to save information such as: production date, 
expiration date, the bill of materials revision used in its production, and the like.  
When opening a work order, the routing defined for the part to be produced is 
recorded automatically. You can revise the routing for a particular work order, if 
the desired routing is different from the standard. Production reports as well as 
the Backflush utility will take the special routing into account. 
Priority enables you to glean various types of information regarding work 
orders: 
 The sales order(s) for which this work order was opened (if opened 
automatically). 
 The components (raw materials and sub- assemblies) required to create 
the part in a given work order. One report displays the work cells from 
which needed components can be obtained (planned receipts); another 
Cat.No. LB110657 2 Ver. 2, Sept.24’13

specifies all work cells to which the components processed in the current 
work cell need to be transferred (planned issues). 
 The list of kit components required by the work order, balances yet to be 
issued, and missing components. 
 The status of a work order. Work order status is updated automatically at 
each of the following stages: 
 When it is opened (manually or automatically) 
 When it is released 
 When reporting its first and last operation 
 When it is printed 
 When it is closed.  
You can also use the status to freeze a work order. 
 The planned progress of the work order (based on production planning 
results). 
 Jobs that have been completed for the work order based on reports of 
production for the steps in the routing. 
 Work orders that are “stuck” in the mi dst of their processing (i.e., there are 
no recent reports of job production for them). 
 WIP (work in progress) inventory attached to a closed work order. 
A printout of the work order displays such details as the required quantity of the 
part, production time, production steps (in order of execution), the work cell in 
which each is to be carried out, engineering data for each step (blueprints, 
required tools), and the expected time of completion.  
 Issues to the Plant Floor 
Plant-floor inventory transactions mainly refer to various types of issues to the 
floor. These are primarily distinguished from one another by the degree of 
tracing (which child parts are issued to which parents). Issues to the plant floor 
can be made according to an issues plan, as an issue to a kit, as a manual 
issue or as an issue of supplies. Items for which vendor lot numbers or work 
order numbers are maintained are issued in accordance with expiration dates 
and by the FIFO (first in, first out) method.  
Issues Plan 
The issues plan deter
mines what materials are needed on the plant floor, in 
what quantities and on what date. The plan is generated by the results of 
production planning or material requirements planning (MRP). 
Issues to Floor Stock 
Issues to floor stock entail the periodic issue of materials in bulk to the plant 
floor for use in produc
tion. These materials are available for use in any work 
order, and their usage is calculated automatically (by the Backflush) based on 
production reports for their parents, taking into account parent-child ratios in the 
Cat.No. LB110657 3 Ver. 2, Sept.24’13

bill of materials.  
Issues to Kits 
Issues to ki
ts are issues of materials and/or sub-assemblies that are targeted for 
a specific work order. They are generally recorded for relatively expensive 
components (like electronic parts) or when the job is sent to a subcontractor. 
A kit list is a list of all the child parts required by a processed part in a work 
order. The list includes the required quantity of components in the kit (based on 
parent-child ratios in the bill of materials), as well as the production step at 
which each component is issued to the parent part.  
Issues to kits are created for each work order once it has been released. They 
may be revised manually, enabling you to create a specific bill of materials for 
an individual work order. The children and quantities appearing in the kit list will 
then be taken into account by the Backflush utility in the calculation of floor 
inventory.  
Manual Issues 
In some cases, a parti
cular work order requires less than the quantity of items 
that comes in the standard package for this part, and the fragility of the part 
precludes removing it from the package until needed. In such a circumstance, 
you can issue the material to floor stock manually, and then report a manual 
issue to the work order (designating exact quantities, as well as the specific 
child lot). This prevents all the goods that are in the standard package from 
“disappearing” from the balance in the warehouse. This is important when 
dealing with items that are too expensive to issue to stock and which are 
supplied in packaging that should not be opened until actual use requires 
specific quantities per work order. 
The Backflush facility does not perform automatic calculations for manual 
issues, but rather takes into account the details that are manually specified. 
Issues of Supplies 
Supplies ar
e raw materials that are not included in any bill of materials, but 
rather are consumed during the production process or other peripheral activities 
of the business (e.g., lubricating oil, rubber gloves, lavatory soap and the like). 
The warehouse balance of the consumed parts is reduced once the supplies 
are issued. 
Backflush (Maintenance of WIP) 
The Backflush program adds or subtracts quantities on the basis of production 
reports for specific jobs. Taking into account the bill of materials and routing of 
the part undergoing processing, the Backflush adds to the inventory of the 
reported job and subtracts from the inventory of any child jobs. This allows, 
among other things, for the management of work in progress. 
The Backflush facility is able to calculate inventory levels for all processing 
steps, even those for which there is no reported production, so long as 
production is reported for a later stage in the manufacturing process. 
The Backflush maintains WIP at a subcontractor's warehouse just as it does 
Cat.No. LB110657 4 Ver. 2, Sept.24’13

for your own plant floor, taking into account the documentation of shipments to 
and receipts from the subcontractor. 
The Backflush creates automatic inventory transactions in keeping with the 
progress of production and the demand for child parts at each step. For 
example, when production is reported for an interim stage in processing, only 
those materials that are needed for this particular production step are deducted 
from inventory. That is, child parts that are joined to the parent in later stages of 
production are not yet deducted and continue to appear as inventory on the 
plant floor. Moreover, the inventory of the parent part at that particular 
production step is increased (with the last operation appearing in the warehouse 
balance).  
Following activation of the Backflush program, the system warns of any 
negative balances calculated for plant-floor inventory. This is generally an 
indication of inaccurate or missing reports of production. 
Online Backflush 
You can set up the system to run the Backflush automatically, in a localiz
ed 
manner. This provides you with a highly accurate, while not comprehensive, 
picture of the current floor inventory without tying up the resources required to 
run the full program. The online program adjusts floor inventory balances on the 
basis of the following events: 
 Raw materials entering or leaving t he plant floor (e.g., via warehouse 
transfer) 
 Automatic transfer of completed part s from the plant floor upon execution 
of their final operation 
 Production reports. 
When the full Backflush is subsequently run, it confirms or adjusts these online 
calculations. 
Tracking Production 
The progress of production is recorded and tracked by means of reports of jobs 
processed on your plant floor. In addition, Priority has a special mechanism to 
keep track of components sent to subcontractors, as well as processed parts or 
assemblies received from them. 
Reports of Production 
The main objective of reporting production is to provide an accurate picture of 
plant-floor operation. Reporting enables Priority to keep track of floor inventory 
and the progress or completion of work orders, which are taken into account in 
the next cycle of production planning. It also allows for tracing of re
work on a 
completed work order or a portion of it. Finally, reported production affects cost 
analysis. 
Production reports are recorded per job. Generally, production is reported with 
respect to the completion of jobs for a work order carried out in a given work 
cell. During factory modeling, you can designate, per production step, whether 
or not reporting is required for the purposes of inventory control and/or costing. 
Cat.No. LB110657 5 Ver. 2, Sept.24’13

During production reporting for any given job, you can specify the lot number of 
issued materials or the work order number of an issued sub-assembly. This 
allows for full traceability of the work order's components. 
Each report of production details the results of the operation being reported and 
can include the following information: 
 Quantities processed 
 Quantities scrapped 
 Quantities with MRB status 
 Processing time (affects machinery costs) 
 Labor time and the number of any em ployee (skilled or unskilled) who 
performed the job (affects labor costs) 
 Usage of tool (affects next cycle of production planning) 
 Rework (affects rework costs) 
 Set-ups (affects next cycle of production planning and set-up costs) 
 Work breaks 
 The warehouse and bin into which the part was transferred upon 
completion of this operation (if a default warehouse and bin have been 
designated for the production step being reported, usually true of the last 
operation in the routing) 
 The shift in which the job was carried out (affects labor costs) 
 The work order or lot numbers of components manually issued for the 
purpose of traceability 
 Serial numbers of processed par ts and of their component parts. 
Priority’s Production Control module can be linked to external plant-floor data 
collection systems (a separately priced option). 
Subcontracting 
Subcontractors are managed in the system as a sub-group of vendors. This 
allows for the purchasing, billing and payment processes to be managed within 
regular vendor transactions, alongside the production process. Specifically, 
inventory currently held by the subcontractor can be considered and managed 
as work in progress. 
A vendor who is a subcontractor is unique in that a plant-floor warehouse has 
been designated for him/her. The system identifies purchase orders and 
receipts of goods (or rework) from subcontractors and relates to their costs as 
subcontracting costs. In addition, components and partially processed parts 
sent to the subcontractor's warehouse are managed as work in progress, and, 
more importantly, are deducted from the subcontractor’s inventory once the 
receipt of processed goods is documented.  
You can create a kit warehouse for a subcontractor. This is an area used to 
prepare shipments of kits to the subcontractor in accordance with the work 
orders scheduled to be processed. As it is prepared, inventory is moved into the 
Cat.No. LB110657 6 Ver. 2, Sept.24’13

Cat.No. LB110657 7 Ver. 2, Sept.24’13 
kit warehouse and, once all component parts are available, the entire kit is 
shipped to the subcontractor’s warehouse. 
You can also custom-design a bill of materials for each subcontractor. For 
instance, you can make assemblies in the original BOM into phantom parts and 
disregard raw materials that do not need to be issued (because they are 
purchased independently by the subcontractor). This customized bill of 
materials is taken into account in the creation of kit lists, as well as by MRP, 
production planning and the Backflush facility. 
Both production planning and material requirements planning relate to the 
subcontractor's work cell just like any other and execute planning accordingly. 
Subcontractors are incorporated into the production process as follows: 
1. One of the planning programs — material requirements planning (MRP) 
or production planning — is run. 
2. Purchase planning is run. 
3. Any components that need to be sent to the subcontractor are obtained 
(i.e., ordered or manufactured). 
4. Work orders are opened manually (if not automatically) and released. 
5. Kit components are issued to the subcontractor's kit warehouse in 
preparation for shipment. 
6. A purchase order is opened and sent to the subcontractor based on 
purchase requisitions generated by purchase planning. 
7. The parts required by the work order (kit components and other parts) 
are sent to the subcontractor. A shipping document is created and 
printed to accompany the shipment. 
8. The receipt of processed parts fr om the subcontractor is recorded upon 
its arrival. The receipt is linked to the work order for which the purchase 
order was made, and the components that were sent to the 
subcontractor are reduced from inventory in the subcontractor's 
warehouse. 
9. The cost of the work performed by the subcontractor, as well as the cost 
of the components sent, are added to the cost of the work order when 
cost analysis is run.
