# Fashion_Sales_Data_2

- **Source:** `Fashion_Sales_Data_2.htm`

Fashion - Viewing Sales Rate Data.1 
 
 
- 
 
 
 
# Viewing Rate of Sales Data

 

Rate of sales data are calculated on the basis of significant dates (e.g., when the part entered inventory, when it was first sold, when it was last sold). Consequently, you need to set a constant that determines the period (in days) over which the system will gather data, and define a specific time period over which sales rates are calculated for each style. These definitions, which can be updated at any time, allow you to take the total sales for the entire period defined by the constant, and divide them into a smaller period (e.g., a fashion season). Example. 
 

An additional constant determines whether the calculated sales amounts include taxes, and parameters are available to determine whether individual part families and warehouses are included in sales rate analysis. 
 
## To set the analysis period:

 

 1 .  Enter the Logistic Constants form and move to the SRateRepDays constant. 
 

 2 .   Set the number of days back that you want the system to provide sales rate data. The default is 365. 
 
## To set the calculation period:

 

 1 .  Enter the Sales Rate Period per Style form. 
 

 2 .  Open a line for each fashion style and designate the From Date and To Date of the calculation period. 
 
## Note:

 

The date goods first enter inventory is determined by GRVs and vendor invoices bearing a status flagged in the Entered Inventory column.
