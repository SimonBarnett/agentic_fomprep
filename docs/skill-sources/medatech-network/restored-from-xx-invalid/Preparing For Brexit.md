# Preparing For Brexit

- **Source:** `Preparing For Brexit.pdf`

LB20000019 - V1  
1 
 
PREPARING FOR BREXIT  
 
TABLE OF CONTENTS  
Weights and Lengths ............................................................................................................................................... 2 
VAT Import setup ...................................................................................................................................................... 5 
EORI Number ............................................................................................................................................................. 7 
Commodity Codes .................................................................................................................................................. 8

LB20000019 - V1  
2 
WEIGHTS AND LENGTHS  
TO GET WEIGHTS ONTO PRINTOUTS.  
Define weight and dimensions against parts. 
INVENTORY > PARTS > PART PARAMETERS > FINANCIAL PARAMETERS FOR PARTS 
Make sure to define a primary part weight unit for use in the system.  
INVENTORY > INVENTOR Y MAINTENANCE > AUXI LIARY PROGRAMS > FLA G 
PRIMARY WEIGHT UNIT  
 
This will update all your parts so long as you have ratios defined between thei r weight units and the 
primary weight unit. Check this here: 
INVENTORY > INVENTORY MAINTENANCE > PART UNITS 
Define Conversions here

LB20000019 - V1  
3 
 
 
 
 
 
 
INVENTORY > INVENTORY MAINTENANCE > UNIT CONVERSIONS

LB20000019 - V1  
4 
The weights and volume are populated.  
And displayed when the standard packing list is printed.

LB20000019 - V1  
5 
VAT IMPORT SETUP  
VAT CHANGES REQUIRED  FOR BREXIT  
BIN VERSION  
Your First Check is that you should be on Bin Version 27 or above on V 20.1 (see below)  
 
For the other versions, Bins are as follows 
V19.0 - 19.0.0.86 
V19.1 - 19.1.0.76 
V20.0 - 20.0.0.60 
If you are on a Priority version below this, please contact support to discuss . 
 
Once your bin is up to date all you have to do is go to Financial Parameters for Vendors  
FINANCIALS > MAINTENANCE OF FINANCIALS > BASIC DATA > DEFAULT VALUES > FINANCIAL 
PARAMETERS FOR VENDORS   
Select your EU Vendors and change the VAT Record Type from 5 to 6

LB20000019 - V1  
6 
Before 
 
After 
 
These simple changes should allow your boxes 1,4 and 7 to be populated in the VAT report for PVA 
(Postponed VAT Accounting) as required by HMRC 
 Note Please do not change VENDOR VAT RECORD TYPE until you have no further tra nsactions 
to make in 2020 
 
Final VAT Report Example

LB20000019 - V1  
7 
EORI NUMBER  
GB EORI NUMBER  
Priority have added a EORI number box to the company data form. 
SYSTEM MANAGEMENT > SYSTEM MAINTENANCE > COMPANIES > COMPANY DATA  
This is available as standard in Version 20.1 
 
 
All you need to do is fill in the above box and check that it appears on your standard reports

LB20000019 - V1  
8 
COMMODITY CODES  
ITEMISED CUSTOMS RAT ES  
Commodity codes are a requirement for dealing with customs duty and priority has built in 
functionality to deal with this. To access this go to  
Financials > Cost Analysis for Manufacturers > Shipping Expense Burdening > Data for 
Shipping/Import Voucher > Itemised Customs Rates 
 
 
You can add as many commodity codes as you need depending on different custom rates there 
are a few built in options for ROW, EU and NAFTA, once those are set up you can use the sub level to 
utilise any nations with trade deals with the UK.
