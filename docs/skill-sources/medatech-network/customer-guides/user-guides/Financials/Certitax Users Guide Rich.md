# Certitax Users Guide Rich

- **Source:** `Certitax Users Guide Rich.pdf`

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www.Medatechuk.com   
 
 
 
 
Registered Office: Anchor House, School Lane,, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 1 of 5 
Certitax Users Guide 
Contents 
1. Description ............................................................................................................................................................................. 2 
2. Assumptions .......................................................................................................................................................................... 2 
3. Process for working with Certitax file ................................................................................................................................... 2 
3.1. Download and Backup files .......................................................................................................................................... 2 
3.2. New Menu VAT Loading from Certitax ....................................................................................................................... 2 
3.2.1. Run the Clear VAT loading table procedure. ................................................................................................................ 2 
3.2.2. Run the Load VAT percents from file procedure .......................................................................................................... 2 
3.2.3. Check the VAT loading table form to make sure the data looks correct ....................................................................... 2 
3.2.4. Run the Load VAT percents interface procedure to create / update actual tax codes ................................................... 2 
4. Manually Creating Tax (VAT) Codes ................................................................................................................................... 3 
4.1. A New Tax Code is required for each US State & Zip code combination .................................................................... 3 
5. Customer Sites ....................................................................................................................................................................... 4 
6. Shipping Address ................................................................................................................................................................... 5

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www.Medatechuk.com   
 
 
 
 
Registered Office: Anchor House, School Lane,, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 2 of 5 
 
1. Description 
 
The Certitax module enables the system work with the multiple tax codes of the American sales tax system.  
 
2. Assumptions 
 
The customer has purchase the Certitax software. 
See details on http://tax.cchgroup.com/cszipsalesdb/default.htm  
 
3. Process for working with Certitax file 
3.1. Download and Backup files 
3.1.1. Go to the server or log on to it remotely in a console mode. 
3.1.2. Go to Start -> All programs -> CCH Zipproducts manager -> ZIPproduct manager 
3.1.3. Click on Zipsales database 
3.1.4. Click on Download Update 
3.1.5. Insert the password you received in the recent email from theme 
3.1.6. Choose to overwrite any existing files 
3.1.7. Save the file FLAT.txt as emg_taxes.txt under P:\ Priority\system\load. Overwrite if needed. (Substitute 
your particular system drive and directory value here)  
3.1.8. Rename the FLAT.txt to FLATDDMMYY.txt with DDMMYY being the current date for backup 
3.2. New Menu VAT Loading from Certitax 
Financials > Nominal Ledger > Financial Statements > Taxes > Sales Tax (U.S.) > VAT Loading from Certitax 
 
 
3.2.1. Run the Clear VAT loading table procedure. 
3.2.2. Run the Load VAT percents from file procedure 
3.2.3. Check the VAT loading table form to make sure the data looks correct  
3.2.4. Run the Load VAT percents interface procedure to create / update actual tax codes

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www.Medatechuk.com   
 
 
 
 
Registered Office: Anchor House, School Lane,, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 3 of 5 
 
4. Manually Creating Tax (VAT) Codes 
4.1. A New Tax Code is required for each US State & Zip code combination 
Financials > Maintenance of Financials > Basic Data > Financial Attributes > Value Added Tax  
 
Tax (VAT) Code is set for you when you enter a Zip Code and State Code.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www.Medatechuk.com   
 
 
 
 
Registered Office: Anchor House, School Lane,, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 4 of 5 
 
5. Customer Sites 
 
Tax (VAT) Code is set if a matching Tax code for the sites State/County & Zip (Post Code) is found

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www.Medatechuk.com   
 
 
 
 
Registered Office: Anchor House, School Lane,, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 5 of 5 
 
6. Shipping Address 
 
The parent Documents Tax (VAT) code is changed (if allowed) if a matching Tax code for the shipping State (County) & Zip 
(Post Code) is found. 
 
 E.G. On this Sales Order VAT Code is changed from 001 to AL35773 when Shipping Address is added.
