# SOP Fixed Assets

- **Source:** `SOP Fixed Assets.pdf`

Cat.No.A8000113 1 Ver.2 – Apr. 21,’10 
 
SOP: Fixed Assets* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
The Fixed Assets module enables you to manage company assets by: 
 Documenting the purchase of assets and opening records for them 
 Calculating an asset's depreciation and recording it in the ledger 
 Appreciating an asset's value 
 Recording its partial or total sale/scrapping 
 Performing revaluation of an asset 
 Generating reports that provide info rmation on the company's fixed assets. 
Priority maintains two parallel records for tracking of depreciation, in accordance with 
Generally Accepted Accounting Principles (GAAP): 
 Depreciation for accounting purposes 
 Depreciation allowed by the tax authorities 
Priority enables you to calculate depreciation by the Straight-Line method, the 
Accelerated Depreciation method, or as defined by the user. 
Setups 
Setting Up Fixed Asset Accounts 
 Enter the Chart of Accounts form, and define the following GL accounts: 
 an asset account  
 an accumulated depreciation account  
 a depreciation expense account 
 a capital gains account. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Setting Up Fixed Asset Groups 
Fixed asset groups include assets that share the same depreciation attributes and GL 
accounts. An asset is assigned to a group when it is recorded in the system.  
1. Enter the Fixed Asset Groups form. 
2. Specify a code identifying the group, and a brief description of the group. 
3. Specify the depreciation of assets in the group, calculated according to either federal 
depreciation rate tables OR the Straight-Line method. The depreciation method will 
be inherited by all assets in this group, but may be revised for individual assets. 
 For the ledger, use the % Depreciation column in the Depreciation-Acc'ting tab.  
 For tax purposes, use the % Depreciation column in the Depreciation-Tax tab. 
4. If the assets in the group are subject to accelerated depreciation for a certain period, 
specify the appropriate percentage for accounting. Also click the Depreciation-Tax 
tab and specify the appropriate percentage for tax purpose, together with the number 
of years and/or months that it remains in effect. 
Note: When accelerated depreciation ceases to be in effect, depreciation will be 
calculated according to the figures in the % Depreciation column. 
5. Click the  Acct Defs tab and assign an asset account, an accumulated depreciation 
account, a depreciation expense account and a capital gains account. 
Setting Up Accounting Families for Fixed Assets 
Accounting f
amilies should be set up for each asset account, so that purchased assets 
are automatically assigned to the appropriate asset account when a purchase invoice is 
recorded.  
1. Enter the Accounting Families form. 
2. Fill in the Family and Family Description columns. 
3. Place the cursor in the Family  column, and select Accounts for Families from the 
list of Direct Activations. 
4. Click the Income & Purchasing Accounts tab, and indicate the relevant asset 
account in the Purchases/Inventory column. 
Setting Up Parts for Fixed Assets 
Set up at le
ast one part for each fixed asset group. 
1. Enter the Part Catalogue form. 
2. Record a Part Number and Description. 
3. Click the Additional Details tab. Flag the Change Desc. column and make sure the 
Inv. Control column is not flagged. 
4. Place the cursor in the Part Number column and select Financial Parameters for 
Parts from the list of Direct Activations. 
5. In the General tab, specify the Asset Group to which the current part will belong 
and its Accounting Family, in keeping with its asset account. 
Cat.No.A8000113 2 Ver.2 – Apr. 21,’10

Setting the Interval for Recording Depreciation 
You can determine whether the recording of depreciation in the ledger will be annual, 
quarterly or monthly. 
1. Enter the Financial Constants form, and move to the AssetDates constant. 
2. Revise the value of the constant, if necessary. 
Setting the Intervals for Asset Replacement 
Two consta
nts determine the period between the sale of an asset and the purchase of 
its replacement, within which it is permitted to deduct the capital gains acquired for the 
old asset from the value of the new one.  
1. Enter the Financial Constants form. 
2. Move to the  AssetReplacementFrom constant and indicate the permitted interval 
between sale and purchase (in months). 
3. Move to the  AssetReplacementTo constant and indicate the permitted interval 
between purchase and sale (in months). 
Recording Monthly Index Values (Dual-Currency Only) 
If asset valu
es are linked to the index, you need to check that indexes are recorded in 
the system. 
1. Enter the Currencies form and move to the Price Index. 
2. Make sure the Past Exchange Rates  sub-level form displays entries for the first and 
last days of every month. 
3. If any entries are missing, return to the upper-level form and select Exchange Rates 
from the list of Direct Activations. 
4. Specify the required Date, and record the missing rate in the Itemized Rates sub-
level form. 
5. Enter the Index Bases form. 
6. Record the Index Code and Description of Index. 
7. In the Ratio to Main Index column, record the ratio between the base rate for the 
year in question and the base rate applied to the Price Index (in the Currencies 
form). 
8. To prevent adjustments due to a drop in the Price Index, enter the Financial 
Constants form and set the value of the AssetNegInd constant to 0. 
Updating Account Definitions and Depreciation Rates of Asset Groups 
1. Enter 
the Fixed Asset Groups form and retrieve the desired group. 
2. To update depreciation rates for the ledger, designate the depreciation of assets in 
the Depreciation-Acc'ting tab. 
3. To update depreciation rates for tax purposes, designate the depreciation of assets 
in the Depreciation-Tax tab. 
Cat.No.A8000113 3 Ver.2 – Apr. 21,’10

4. To update account details, click the Acct Defs tab and revise the GL accounts 
assigned to the asset group. 
5. If you wish depreciation expenses to be distributed among several GL accounts, 
leave the Depreciation Expense Account column blank and indicate the relevant 
accounts in the Depreciation Expense Accounts sub-level form.  
6. To copy depreciation rates to all assets in the group, select Revise Deprec for 
Asset Group from the list of Direct Activations. 
7. To copy account definitions to all assets in the group, select Update Accts for 
Assets in Group from the list of Direct Activations. 
Defining Sale/Scrapping Categories 
1. Enter 
the Sale/Scrapping Categories form. 
2. Specify a code and brief description for each category. 
Procedure 
Stage I: Recording Fixed Assets 
All fixed assets owned by the company are recorded in the Fixed Assets form. You can 
automatically open a fixed asset record for any part that appears in a purchase invoice 
and is assigned to an asset group. 
1. To open fixed asset records for purchased parts, open the invoice in the appropriate 
form (Multi-GRV Invoices or Vendor Invoices). 
2. When itemizing the invoice in the sub-level form, select the part number of the item 
for which a fixed asset should be defined. Record a part description and continue as 
usual. 
3. Dual-currency users: Enter the sub-level form, Invoice - Add'l Details, and change 
the VAT Code to VAT on fixed expenses (003).  
4. Finalize the invoice.  
5. Do one of the following: 
 Select Record Fixed Assets (1 per Line) from the list of Direct Activations to 
open one fixed asset record per line – i.e., a single record for the entire quantity of 
the line item. 
 Select Record Fixed Assets (1 per Unit) from the list of Direct Activations to 
open one fixed asset record for each individual unit of the part. 
6. To view the resulting asset records, enter the Fixed Assets form and retrieve the 
asset(s) that were created by the program. 
Note: You can also record a fixed asset manually (unrelated to an invoice) in the Fixed 
Assets form. 
Stage II: Recording Additional Details for an Asset 
Whether the asset is created from a purchase invoice or manually, you need to complete 
additional details: 
Cat.No.A8000113 4 Ver.2 – Apr. 21,’10

1. Enter the Fixed Assets form and retrieve the asset(s) in question. 
2. In the Details tab, specify the asset's Category and Location, if desired. If GL 
accounts for the asset are defined per state, be sure to indicate the State in which 
the asset is located. 
3. Specify the  Investment Plan and item to which the asset is linked, if desired. 
Note: To execute reports that take the category, location, and investment plan of an 
asset into account, use the Report Generator. 
4. If the asset is recorded for accounting or tax purposes only, indicate this in the 
Accting/Tax Only column. 
Note: An asset that is recorded solely for accounting purposes will not appear in 
income tax reports. No journal entries will be recorded for an asset that is maintained 
solely for tax purposes. 
5. Dual-currency users: Exchange rates and index information are updated 
automatically (in the Purchase tab) according to the purchase date of the asset. 
Revise as necessary. 
6. To view and/or revise depreciation definitions for the ledger, enter the 
Depreciation%-Accounting Records sub-level form. 
7. Specify the % Depreciation and % Accel Depreciation, and the number of years 
and months that accelerated depreciation applies to the asset, where relevant. 
8. If records have been transferred from another system, specify the prior nominal 
depreciation and the date until which it was calculated. 
9. To view and/or revise depreciation definitions for tax purposes, enter the 
Depreciation % - Tax Records form, another sub-level of Fixed Assets, and repeat 
steps  7 and  8. 
Stage III: Recording the Disposal of a Fixed Asset 
1. Enter the Fixed Assets form and retrieve the asset(s) in question. 
2. Click the Sale tab, and record the asset's Sale/Scrap Code. 
3. Specify the Sale/Scrap Date. 
4. Check whether an invoice has been recorded for the sale of the asset: 
 If so, indicate the internal number of the invoice in the Customer Invoice  column. 
The asset's price and sale date will be filled in automatically. 
 If not, specify the Value from Sale manually. 
5. Enter the Calculated Deprec.-Acc'ting Recs sub-level form and make sure that no 
journal entries have been recorded for the month of the sale/scrapping or later 
months (the Entry Number column should be blank for the period in question). 
 If no entries have been recorded, return to the upper-level form and select 
Calculate Depreciation from the list of Direct Activations. 
 If entries have been recorded, exit the form and run the Adjust Depr. Calcs (Prep. 
Stage) program for the asset and dates in question. You can then return to the 
asset record and run the Calculate Depreciation program. 
Note: Since you will need to manually revise depreciation recorded in the journal 
Cat.No.A8000113 5 Ver.2 – Apr. 21,’10

entry, it is recommended that you first run the Cost and Depreciation report for the 
asset in question, and save the report results.  
6. Run the Record Asset Trans. in Journal program to create a new entry for the asset. 
Note: Before running this program, make sure the Sale/Scrap J. Entry column in 
the Fixed Assets form (Sale tab) is flagged for the asset in question. 
Stage IV: Calculating Depreciations 
Depreciation is calculated, for both tax and accounting purposes, on a daily basis. 
1. To calculate depreciation of assets, run the Calculate Depreciation program. This 
program calculates the monthly depreciation of any number of designated assets – 
for both accounting and tax purposes – for the designated fiscal year.  
2. To view results, run the Cost and Depreciation report. 
Stage V: Recording Depreciation in the Ledger 
After depreciation is calculated and reviewed, it can be recorded in the ledger. 
Depreciation is recorded, in a pending journal entry, as a debit against the asset's 
depreciation account and a credit against its accumulated depreciation account. 
1. Before recording depreciation in the ledger: 
 Record the sale/scrapping of any relevant assets (see Stage III). 
 Dual-curre
ncy users: Make sure indexed values are up to date. 
 Calculate depreciation of assets (see Stage IV).  
2. Run 
the Record Asset Trans. in Journal program, indicating the range of fiscal 
periods for which entries will be recorded. 
3. Review the resulting pending entries in the Entry Journal form. Revise as necessary. 
Tip: Retrieve by the prefix T* in the Journal Entry No. column and DPR in the 
Transaction column.  
4. Once the entries have been defined properly, select Post Journal Entry  from the list 
of Direct Activations to post them to the ledger. 
Stage VI: Revaluation of Assets According to International Financial 
Reporting Standards (IFRS) 
1. Enter the Fixed Assets form and retrieve the asset(s) in question. 
2. Click the Accts tab, and make sure that the correct capital gains account and 
expense account are defined: 
 The GL account specified in the Reval. Reserve Acct column will be credited if 
the asset has increased in value following revaluation. 
 The GL account specified in the Reval Impairment Acc column will be debited if 
the asset has decreased in value following revaluation. 
Note: To define accounts for an entire asset group, use the corresponding columns 
in the Fixed Asset Groups form (Acct Defs tab), then select Update Accts for 
Assets in Group from the list of Direct Activations. 
Cat.No.A8000113 6 Ver.2 – Apr. 21,’10

Cat.No.A8000113 7 Ver.2 – Apr. 21,’10 
3. Enter the Depr per Period-Acc'ting Records sub-level form. 
4. In the From Date column, specify the date on which revaluation was performed. 
5. In the To Date column, specify the date on which this depreciation rate ceases to be 
in effect. 
6. In the Valuation column, specify the asset's current value. 
7. If the asset's depreciation rate has changed, indicate the new rate in the % Annual 
Deprec. or Depreciation column. 
8. Update the Residual Value, if necessary. 
9. Dual-currency users: The exchange rate to be used for the asset's new value is 
filled in automatically with the rate in effect on the revaluation date, but may be 
revised. 
10. Return to the upper-level form and select Calculate Depreciation from the list of 
Direct Activations, specifying the year in which revaluation was performed. 
11. To record journal entries for the revaluation, run the Record Asset Trans. in Journal 
program, specifying Revaluation Only. 
Results 
 
Journal entries are recorded as follows after revaluation of the asset: 
 The asset account is credited for the original value of the asset. 
 The accumulated depreciation account is debited for the total accumulated 
depreciation. 
 The asset account is debited for the new value of the asset. 
 If the asset has decreased in value, the revaluation impairment account is debited. 
 If the asset has increased in value, the revaluation reserve account is credited. 
Notes: 
 
After recording asset revaluation in the ledger for the first time, a decrease in asset 
value is deducted from the revaluation reserve account until the surplus for that asset 
is exhausted. Conversely, an increase in value is credited to retained profits to the 
extent that is recognized as an expense in respect of that same asset. 
 The asset's new value following the above procedure is determined based on the 
asset's fair value after the accumulated depreciation recorded for the asset is reset 
to zero. 
 Accounts can also be defined at the level of the asset group (in the Fixed Asset 
Groups form). After recording changes to an asset group, make sure to select the 
Update Accts for Assets in Group program from the list of Direct Activations. 
 If revaluation was performed in a previous system, make sure to load the amount 
accumulated in the revaluation reserve account for the asset in the Depreciation%-
Accounting Records form, a sub-level of Fixed Assets. In case of impairment of 
the asset following revaluation, the amount accumulated is recorded as a negative 
amount. Dual-currency users should also record the amount of reserve/impairment in 
the secondary currency in the appropriate column.
