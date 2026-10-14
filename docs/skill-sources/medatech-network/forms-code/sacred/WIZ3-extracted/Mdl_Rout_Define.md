# Mdl_Rout_Define

- **Source:** `Mdl_Rout_Define.htm`

Modeling - Defining a Routing 
 
 
- 
 
 
 
# To define a routing:

 

 1 .  Enter the Routings form. 
 

 2 .  For each new routing, specify an identifying code and description. 
 

 3 .  Enter the Operations in Routing sub-level form. 
 

 4 .  When the WorkOrdNum constant is set to 1 , the Release operation appears automatically as the first operation in the routing. Open a new line for each operation and assign it a Step number, in order of execution. The corresponding Work Cell appears automatically. 
 

 5 .  If the current step is not a real operation but rather a placeholder for bureaucratic purposes (i.e., it does not require production reporting and has no effect on inventory or costing), flag the Info Only column. 
 

 6 .  If there are other operations that may be performed for this step in the current routing (in addition to those alternates defined per operation in the Alternate Operations form), enter the Alternate Operations in Routing sub-level form and specify each one on a separate line. If you do not want the planning programs to take an alternate operation into account, flag the Ignore When Planning column. Return to the upper-level form. 
 

 7 .  For the final operation in the routing, specify the target warehouse to which the finished parts or sub-assemblies will be transferred in the To Warehouse column . 
Note: By default, the final product is stored in the warehouse with its work order number (for reference vis-a-vis quality control and expiration date). If you do not want to keep the work number, flag the Remove Wk Order No. column. 
 
## Notes

 

 ·        Run the Operations in Routing report to view the operations included in one or more routings. 
 

 ·        Click to return to the main screen.
