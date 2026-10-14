# ExRep_OLAP_Constant

- **Source:** `ExRep_OLAP_Constant.htm`

Executive Reports - Setup: Constant for BI Reports 
 
 
- 
 
 
 
# Setting the Constant for BI Reports

 

If you want all BI data to be updated on a daily basis, ensure that the appropriate constant is properly defined. 
 

The constant determines how far back to begin the update of BI data whenever the Prepare All for Analysis (BI) program is run. As the update always begins on the first day of the month, the constant value, in effect, determines which month to start from. It is pre-set at 30 days, which causes the update to begin in the previous month. Example . 
 
## To determine how far back to begin the update:

 

 1 .  Enter the Logistic Constants form. 
 

 2 . Move to the EDays BI constant and specify the number of days back to update in the Value column (e.g., 14). 
 
## Note:

 

The Prepare All for Analysis (BI) program can be run manually (e.g., at the end of every work day), or automatically via the Tabula Task Scheduler.
