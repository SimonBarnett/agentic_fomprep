# vat report generator customer guide

- **Source:** `vat report generator customer guide.pdf`

VAT REPORT GENERATOR  
REQUIREMENTS  
VERSION CHECK  
An additional addon is required for the following Priority versions: 
19.1 
20.0 
20.1 
If you are on a version requiring the addon, please raise a service call so that the support 
team can organise to install this. 
The addon must be installed before attempting the set-up, because some of the 
definitions/forms will not be available without it 
The VAT Report by Boxes feature is fully available in versions 21.0+, so the addon is not 
required. 
Any Priority version 19.0 and below will need to be upgraded before the VAT Report 
Generator is available. 
BIN.95  VERSION  
Enter the Help>About Priority screen from the main menu. 
Please ensure your BIN version is equal to or higher than the versions specifi ed below. If your 
bin is below this, please contact support to arrange a bin update with you.  
19.1.0.89 
20.0.0.90 
20.1.0.76 
21.0.44 
21.1.09 
SETUP  
BOXES  
1. Open Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports  > VAT 
Report Boxes and hide the “Box Type” column in the form design. (Right 
click>Design>Organize fields) 
2. Open the Vat Report Boxes template 
3. Delete the “Box Type” column

4. Paste the data from the spreadsheet into the form 
5. Restore the default form design (Right click>Design>Organize fields) 
BOX TOTALS  
1. In the VAT Report Boxes form, select box 3 and enter the “Totals for Boxes” sub-level 
2. Add a line for box 1 and a line for box 2 
3. Go back to the upper-level form and move to box 5 
4. Enter the “Totals for Boxes” sub-level and add a line for box 1, box 2 and box 4 
5. On the lines for boxes 1 and 2, tick “reverse sign”. 
BOX DEFINITIONS  
1. Open the VAT Report Definitions spreadsheet.  
2. Check the VAT codes defined in the spreadsheet match the ones defined in Priority . 
 
Go to Financials > Maintenance of Financials > Basic Data > Financial Attributes > Value 
Added Tax, find the VAT code for UK sales and replace 001 in the spreadsheet  with this value 
if it has been assigned a different code, then do the same for UK purchases etc. 
3. Check there is a VAT group code defined for services. 
Financials > Maintenance of Financials > Basic Data > Financial Attributes > List of Tax Groups  
There is a tickbox in the above form to indicate a VAT group is defined for services. 
If you do not work with services, remove the lines in the spreadsheet relating to the service 
VAT group. 
4. Change the code in the spreadsheet if necessary if yours is defined differently. 
5. Check to see if you have a reverse charge entry code 
6. Revise the code in the spreadsheet if necessary if yours is defined differently. 
7. Open the form Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports >  
VAT Report Box Definitions 
8. In the design form screen(Right click>Design>Organize fields), hide the following columns: 
Box Title 
VAT Description 
VAT Group 
Transaction Description 
9. If there is a column for “Country”, move this to the end of the form layout . 
10. In the VAT Report Definitions spreadsheet, delete the following columns:  
VAT Description

VAT Group 
Transaction Description 
11. Copy the data from the spreadsheet into the form 
12. Restore the default form design (Right click>Design>Organize fields) 
EXTRA DEFINITIONS  AND CHECKS  
MANUAL JOURNALS  
Any manual journals falling in the next submission period that don’t already appear on the 
VAT Report (by Boxes) need to be reposted, and details should be added to the VAT 
Calculation Details sub-level (manually). 
Going forward, when creating manual entries, will also need to fill out the VAT Calculation 
Details. See below (TAXDETAILS CONSTANT). 
PVA ADJUSTMENTS  
When posting PVA entries, the amount of VAT may not necessarily be 20% of the invoice 
value. HMRC say to account for an approximate figure, and to post a variance when  the 
final figure is known. 
This will need to be done with a journal entry. 
This adjustment journal will look like the VAT element on a PVA invoice, however, there is 
some set-up needed so that this appears on the VAT Report by Boxes. 
1. Create a new entry code called PVA 
Financials > Maintenance of Financials > Basic Data > Journal Entry Codes >  Journal Entry 
Codes 
2. Create an Entry Pattern that matches the Entry Pattern for Manual entries  
3. In the VAT Report Box Definitions form, add a line for box 1 and 4: 
Box Code VAT Code VAT Description VAT Group Code VAT Group Entry Code 
1 004 VAT on EU Purchases 000 Standard PVA 
4 004 VAT on EU Purchases 000 Standard PVA 
4. Make a journal by selecting PVA as the transaction code, and selecting your Input 
and Output VAT accounts as the debit and credit e.g. 
Account Description Debit Credit 
EU Input VAT 100 0 
Output VAT 0 100 
5. Then fill out the VAT Calculation Details e.g. 
VAT Code VAT Group Code VAT (%) Taxable Amount Tax-Exempt Sum VAT Amount Total Including VAT 
004 000 0 0 0 100 100

6. Once posted, this example will increase boxes 1 and 4 by 100. 
TAXDETAILS CONSTANT  
To see what will be posted on the VAT Report (by Boxes) on any given journal, look in the VAT 
Calculation Details sub-level in the Entry Journal form. 
As part of this set-up, you should turn on the TAXDETAILS constant. However, it is advised that 
this is done after any manual journals have been reversed/reposted (so that the system 
allows reversal of journals that don’t have tax details!). 
System Management > System Maintenance > Constant Forms > Financial Constants 
Once turned on, it is not possible to post manual entries for tax accounts without filling out 
the VAT Calculation Details sub-level form. This will ensure manual entries appear on the VAT 
Report (by Boxes). 
Note: The constant is only available from version 20.0. Therefore on 19.1, users will have to 
manually check there are details in the VAT Calculation Details form. 
FAQS  
CANNOT SUBMIT MID -MONTH  
If you need the ability to submit partway through a month, please contact support so they 
can install a fix file to enable you to do this. 
EXPORT INVOICES  
Even when there is a definition for CEX transactions, they aren’t pulling through to the VAT 
Report (by Boxes). 
Check your bin version matches those defined at the beginning of the document. There was 
a known issue in earlier bins that caused this problem. Please raise the issue with support.  
PRIORITY’S VAT GENERATOR GUIDES  
Brexit guide: 
https://www.eshbelsaas.co.il/eshbel/primail/library/Updates%20for%20Brexit_21_1_E.pdf  
Set-up guide: 
https://www.eshbelsaas.co.il/eshbel/primail/library/SOP-
Setting%20Up%20the%20VAT%20Report%20Generator_21_0_E.pdf 
Running the Report: 
https://www.eshbelsaas.co.il/eshbel/primail/library/Running%20the%20VAT%20Report%E2%80
%93EU%20(VAT%20Report%20Generator)_20_0_E.pdf

WHERE DO I FIND THE NEW VAT REPORT?  
Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports > VAT Report (by 
Boxes) 
HOW DO I SUBMIT USING THE NEW VAT REPORT?  
Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports > Online VAT (UK) >  
Submit VAT Return 
Then select ‘Transmit by’ ‘VAT Report by Boxes’ 
HOW DO I EXCLUDE A JOURNAL FROM APPEARING IN THE VAT REPORT?  
This is the same for the old VAT Report. Find the journal (Financials > Nominal Ledger > Entry 
Journal > Entry Journal) and add a dash in the VAT Record Type field. E.g. –
