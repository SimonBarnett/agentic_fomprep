# 15-17-Setting Up Hot Replenishment (WMS)

- **Source:** `15-17-Setting Up Hot Replenishment (WMS).pdf`

www.priority -softwar e.com   
1/2 ‏Jan. 04, '15 Ver.04 Cat.No. LB 110625 
 
SOP: Setting Up Hot Replenishment (WMS) * 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To set up definitions required for working with hot replenishment when running pick waves for 
orders. 
Working Assumptions 
 The full WMS module has been installed in Priority. 
 The necessary setups have been performed for using the WMS module (see the relevant 
standard operating procedure). 
 The necessary setups have been performed for running pick waves ending in a shipping 
document or packing slip (see standard operating procedures for Pick Tasks by Order (Ship 
Docs) and Pick Tasks by Order (Pack Slips), respectively). 
 Mobile devices have been purchased and programmed (by the supplier) to work with Priority's 
WMS module, including hot replenishment functionality. 
Procedure 
Stage I: Setting Up Aisle Bins 
1. Enter the Storage Zones form and retrieve the relevant storage zone. 
2. Move to the Bins in Storage Zone sub-level form. 
3. Define a bin for each Aisle in the storage zone, indicating 0 in the Row, Level and Slot 
columns. The bin will be assigned a number automatically, based on the zone and aisle number 
(e.g., bin 20.1 indicates an aisle bin in aisle 1 of zone 20). 
Stage II: Running a Pick Wave Using Hot Replenishment  
1. Run a PIK wave as per the standard operating procedures for Pick Tasks by Order (Ship 
Docs) and Pick Tasks by Order (Pack Slips), and flag the Hot Replenishment parameter in 
the first input screen. 
2. In the second input screen, indicate the Velocity of bins that can be used for pick tasks. If 
additional velocities (besides A) are indicated, the hot replenishment algorithm is activated (see 
above). 
Result 
 Replenishment tasks are opened as necessary, in accordance with the hot replenishment 
algorithm. Corresponding pick tasks are opened for the target bins (i.e., the bins to be 
replenished). 
                                                
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -softwar e.com   
2/2 ‏Jan. 04, '15 Ver.04 Cat.No. LB 110625 
 
Stage III: Activating Hot Replenishment via Mobile Device 
While performing a pick task, if the bin indicated in the task does not contain the required inventory, 
the user selects the hot replenishment option on the mobile device.  
Upon verifying that the indicated bin is empty, that no nearby bins can be used to pick the required 
inventory and that no replenishment tasks have already been opened for the required inventory 
(with the "Execute" status), the system creates and/or releases a warehouse task, as follows: 
 If a replenishment task has already been opened for the part in question and assigned the 
"Draft" status, the target bin is changed to the designated bin and the task's status is changed to 
"Execute", so that inventory will be replenished to that bin. 
 If no replenishment task has been opened for the part in question, a MOV task is created and 
used to transfer the required inventory from its current location to the designated bin. 
Result 
 A task is opened/updated, indicating the bin in which inventory will be replenished.
