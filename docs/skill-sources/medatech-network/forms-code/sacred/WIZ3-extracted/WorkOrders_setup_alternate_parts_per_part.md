# WorkOrders_setup_alternate_parts_per_part

- **Source:** `WorkOrders_setup_alternate_parts_per_part.htm`

Work Orders - Setup: Alternative Child Parts 
 
 
- 
 
 
 
# Defining Alternate Child Parts 

 

For every child part used in production, you can define parts that can replace it in the production of a particular parent part. If insufficient inventory of a particular child part is available, the system can complete the issue with inventory of the alternate part (if the planning constant UsePartAlt is set to allow this). 
 
## To define alternates for a part:

 

 1 .  Enter the Parts form. 
 

 2 .  If the alternate part is not yet defined in the system, open a new record for it and fill in its details. 
 

 3 .  Retrieve the original child part. 
 

 4 .  Enter the Alternate Parts sub-level form. 
 

 5 .  Record the number of the alternate part in the Alternate Part column, and the number of the parent part for which it can replace the original child part in the Parent Part Number column.
 Note: If you do not specify a parent part, the alternate part will be allowed to replace the current child part in all possible parent parts.
