# vat report generator setup

- **Source:** `vat report generator setup.pdf`

VAT REPORT GENERATOR  
ADDON  
VERSION CHECK  
The addon is required for the following versions: 
19.1 
20.0 
20.1 
The VAT Report by Boxes feature is fully available in versions 21.0+, so the addon is not 
required. 
Any Priority version 19.0 and below will need to be upgraded because the VAT Report 
Generator is not available. 
INSTALLING THE ADDON  
The addon can be found on the downloads page of the Xpert site 
It is called “HMRC Tax Boxes” and is under the Localizations section 
This should be run on the server when users are out of the system 
It takes about 30 minutes to complete 
The addon must be installed before attempting the set-up, because some of the 
definitions/forms will not be available without it 
BIN.95  
Please also do a bin update for anyone below these bin versions: 
19.1.0.89 
20.0.0.90 
20.1.0.76 
21.0.44 
21.1.09 
There was a bug to do with Export Credit Notes that was fixed in these bin versions.  
More details about the issue can be found below. 
 
SETUP

BOXES  
1. Open Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports  > VAT 
Report Boxes and hide the “Box Type” column in the form design 
2. Open the Vat Report Boxes template from LB21000012 and delete the “Box Type” column 
3. Paste the data from the spreadsheet into the form 
4. Restore the default form design 
BOX TOTALS  
1. In the VAT Report Boxes form, select box 3 and enter the “Totals for Boxes” sub-level 
2. Add a line for box 1 and a line for box 2 
3. Go back to the upper-level form and move to box 5 
4. Enter the “Totals for Boxes” sub-level and add a line for box 1, box 2 and box 4 
5. On the lines for boxes 1 and 2, tick “reverse sign” 
BOX DEFINITIONS  
1. Open the VAT Report Definitions spreadsheet from LB21000012 
2. Check the VAT codes defined in the spreadsheet match the ones defined in Priority 
e.g., in Financials > Maintenance of Financials > Basic Data > Financial Attributes >  Value 
Added Tax, find their VAT code for UK sales and replace 001 in the spreadsheet  with this 
value, then do the same for UK purchases etc. 
3. Check they have a VAT group code for services 
4. Change the code in the spreadsheet if necessary 
5. Check they have a reverse charge entry code 
6. Revise the code in the spreadsheet if necessary 
7. Open the form Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports > 
VAT Report Box Definitions 
8. In the form design, hide the following columns: 
Box Title 
VAT Description 
VAT Group 
Transaction Description 
9. If there is a column for “Country”, move this to the end of the form layout  
10. In the VAT Report Definitions spreadsheet, delete the following columns:  
VAT Description

VAT Group 
Transaction Description 
11. Copy the data from the spreadsheet into the form 
12. Restore the default form design 
EXTRA DEFINITIONS  AND CHECKS  
EXPORT INVOICES  
You will notice in the VAT Report Definitions that in box 6, there are definitions for CEX 
transactions. 
CEX is the journal entry code for Credit Export Invoices. 
Priority’s default set-up for UK does not include these definitions.  
The “bug” mentioned earlier in the document, that was fixed in those bin updates, meant 
that even when there was a definition for CEX transactions, they weren’t pulling through to 
the VAT Report (by Boxes). 
If there are transactions for CEX that don’t appear on the report because they were created 
before the bin was updated, raise a call with Priority so they can amend the transactions.  
Otherwise, advise that they need to repost the invoices so that the “VAT Calculation Details” 
fills out correctly. 
MANUAL JOURNALS  
Any manual journals that don’t appear on the VAT Report (by Boxes) need to be reposted  
and details should be added to the VAT Calculation Details sub-level (manually). 
Going forward, when creating manual entries, will also need to fill out the VAT Calculation 
Details. See below (TAXDETAILS CONSTANT). 
PVA ADJUSTMENTS  
When posting PVA entries, the amount of VAT may not necessarily be 20% of the invoice 
value. HMRC say to account for an approximate figure, and to post a variance when the 
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
To see what will be posted on the VAT Report (by Boxes), look in the VAT Calculation Details 
sub-level in the Entry Journal form. 
As part of the set-up, we should turn on the TAXDETAILS constant. However, I advise that this is 
done after any manual journals have been reversed/reposted (so that the system allows you 
to reverse journals that don’t have tax details!). 
System Management > System Maintenance > Constant Forms > Financial Constants 
Once on, you won’t be able to post manual entries for tax accounts without filling out the 
VAT Calculation Details sub-level form. This will ensure manual entries appear on the VAT 
Report (by Boxes). 
Note: The constant is only available from version 20.0. Therefore on 19.1, users will have to 
manually check there are details in the VAT Calculation Details form. 
OTHER PROBLEMS/FAQS  
CANNOT SUBMIT MID -MONTH  
If you need the ability to submit partway through a month, download this fix:  
FQ21000085 21_0_32905es.zip 
CANNOT SEE THE VAT BOXES FORMS AFTER INSTALLING THE ADDON  
Check the licence to see if they have module 2,000 for Europe. 
If not, forward details to Keith/Elli so Priority can add this to the customer’s licence.

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
