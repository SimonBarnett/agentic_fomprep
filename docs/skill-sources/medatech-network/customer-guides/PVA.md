# PVA

- **Source:** `PVA.pdf`

Medatech UK Ltd 
Anchor House, School Lane, 
Chandlers Ford 
Hampshire 
SO53 4DY 
Tel.: +44 2380 460 400 
Fax: +44 2380 261 078  
 
                                                                    
 URL: http://www.medatechuk.com   
                                                                             E-mail: info@medatechuk.com  
 
 
  
 
. 
 
 
 
 
Postponed VAT Accounting 
Entry Code Definitions 
Financials > Maintenance of Financials > Basic Data > Journal Entry Codes > Journal Entry Codes 
 
Check there are entry codes for reverse charge. To do this, query for lines ticked as “Reverse Charge?”. If they do not 
exist, create two entry codes – one for Reverse Charge, one for Reverse Charge Credit. Tick both as “Reverse Charge?”. 
 
Give the entry codes the following account patterns:

Medatech UK Ltd 
Anchor House, School Lane, 
Chandlers Ford 
Hampshire 
SO53 4DY 
Tel.: +44 2380 460 400 
Fax: +44 2380 261 078  
 
                                                                    
 URL: http://www.medatechuk.com   
                                                                             E-mail: info@medatechuk.com  
 
 
  
 
. 
 
 
 
 
VAT Code Definitions 
Financials > Maintenance of Financials > Basic Data > Financial Attributes > Value Added Tax 
 
Add the VAT Code for Domestic purchases to the Reverse Charge Tax field for the EU purchases and Worldwide 
purchases VAT Codes: 
 
 
 
Vendor Definitions 
Financials > Maintenance of Financials > Basic Data > Default Values > Financial Parameters for Vendors 
 
Give all EU and Worldwide vendors a VAT Record Type 6, Entry Code-Invoice REVC (the code for reverse charge), and 
Entry Code-Credit REVCC (the code for reverse charge credit). Give EU vendors the VAT Code for EU Purchases and 
Worldwide vendors the VAT Code for Worldwide purchases:

Medatech UK Ltd 
Anchor House, School Lane, 
Chandlers Ford 
Hampshire 
SO53 4DY 
Tel.: +44 2380 460 400 
Fax: +44 2380 261 078  
 
                                                                    
 URL: http://www.medatechuk.com   
                                                                             E-mail: info@medatechuk.com  
 
 
  
 
. 
 
 
 
 
Box Definitions 
Financials > Nominal Ledger > Financial Statements > Taxes > VAT Reports > VAT Report Box Definitions 
 
In Box 1, add definitions for the REVC and REVCC entry codes. In the definitions, include the VAT Code (EU purchases or 
Worldwide purchases) and the VAT Record Type (6). Tick the REVCC entries as “Reverse Sign?”: 
 
 
 
In boxes 4 and 7 create definitions for the REVCC Entry Code. Include the VAT Code (EU purchases or Worldwide 
purchases) and the VAT Record Type (6) and tick as “Reverse Sign?”: 
 
 
 
 
Note: Always check the VAT Report before submitting: Financials > Nominal Ledger > Financial Statements > Taxes > VAT 
Reports > VAT Report (by Boxes) 
 
Note: As VAT rules change, each business using Priority Software has a responsibility to make their own necessary checks 
and amendments to the definitions to comply with the latest HMRC regulations.
