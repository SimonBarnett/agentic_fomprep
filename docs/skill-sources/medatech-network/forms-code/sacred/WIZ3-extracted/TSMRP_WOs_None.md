# TSMRP_WOs_None

- **Source:** `TSMRP_WOs_None.htm`

Troubleshooting MRP Wizard - Why Work Orders Were Not Opened 
 
 
- 
 
 
 
# Why Work Orders Were Not Opened

 

Work orders are not opened in the following cases: 
 

 ·        The part routing is Phantom or Assembly. 
 

 ·        There is not sufficient demand to open a work order, based on MRP definitions for the part. 
 
## To check part definitions:

 

 1 .  Enter the Parts form, retrieve the part in question and click the General tab. Make sure the part’s Routing is neither “Phantom” or “Assembly”. 
 

 2 .  Enter the Purchase/MRP Parameters for Part form, retrieve the part in question and click the MRP Definitions tab. Check the value in the Qty to NotOpen WkOrd column. If that value is less than or equal to the required quantity, no work order will be opened.
