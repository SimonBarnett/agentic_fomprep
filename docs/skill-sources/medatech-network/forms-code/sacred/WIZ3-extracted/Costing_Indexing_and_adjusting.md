# Costing_Indexing_and_adjusting

- **Source:** `Costing_Indexing_and_adjusting.htm`

Costing for Businesses - Indexing and Adjusting Part Costs 
 
 
- 
 
 
 
# Indexing and Adjusting Part Costs 

 

The costing program calculates the local-currency cost, second-currency cost, and average adjusted cost of every inventory transaction, which are then used to calculate average part cost. 
 

The FIFO method records the cost of each inventory transaction on the day it was recorded. This allows the system to adjust the transaction cost at any point in time, and to calculate the part's adjusted cost. Priority also offers the FIFO Adjusted option, which uses the FIFO method and adjusts local-currency costs as follows: costs that were initially converted from the second currency are adjusted according to the exchange rate on the costing date, while costs that were initially recorded in the local currency are adjusted according to the index on the costing date. 
 

The Moving Average method, on the other hand, adjusts the cost of inventory transactions recorded since the last costing run, but not the average cost from the previous costing run, which is derived from a variety of costs that may have originally been recorded in different currencies. Since adjusting only part of the data will not yield accurate results, the Moving Average method does not adjust second-currency costs , though it does link local-currency costs to the index . 
 
## Note:

 

In order for costing to calculate accurate indexed costs, monthly index values must be up-to-date for the relevant period. Similarly, in order to produce accurate adjusted costs, currency exchange rates must be kept up-to-date. Both values are maintained in the Exchange Rates form.
