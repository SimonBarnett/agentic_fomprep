# bank payment users guide

- **Source:** `bank payment users guide.pdf`

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
 
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 1 of 11 
Bank Payment Module Users Guide 
Contents 
1. DESCRIPTION................................................................................................................................................................................................................................................................................. 2 
2. CREATING A BANK TRANSFER PAYMENT .............................................................................................................................................................................................................................................. 3 
3. FLAG BANK TRANSFERS FOR ITP ....................................................................................................................................................................................................................................................... 8 
4. EXPORT BANK PAYMENT TO A FILE ................................................................................................................................................................................................................................................... 10

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
 
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 2 of 11 
1. Description 
The Bank transfer module enables to send the bank an order for paying various payees by loading a single file for outstanding payments. This file is 
prepared in Priority using the step-by-step instructions in this document. Before you can generate the file, payments must be generated for invoices in 
Priority. This document covers the process of creating payments as well as creating the payment file. 
 
Before start using the module: 
1. Ensure the Vendor Bank Account is set (bank name, branch number and account number). 
 Financials > Maintenance of Financials > Basic Data > Default Values > Financial Parameters for Vendors in the sub level “Bank account details”. 
 
 
2. Set up a paying bank account in Financials > Cash Management > Bank Accounts

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
 
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 3 of 11 
2. Creating bank transfer payments for a single vendor 
 
If you need to prepare payments for multiple vendors as a time, move on to section 3.  
Financials > Accounts Payable > Payments > Bank Transfers > Payments by Bank Transfer  
Choose the vendor, and the bank to pay the money from on the upper level form.  
Flag the invoices to pay on the ‘Flag Invoices for Payment’ sub level form, and change the record status to ‘Final’.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
 
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 4 of 11 
3. Creating bank transfer payments for multiple vendors at a time 
 
Run the procedure to automatically flag invoices for payment based on criteria: 
Financials > Accounts Payable > Payments > Prepare Payments > Flag Invoices for Paym ent 
 
 
 
You can choose specific accounts, a singular account, or all accounts. 
You can also define which invoices to flag based on payment or invoice date.  
This will flag all unpaid invoices that meet the set criteria, as long as the invoices are not flagg ed as “checking”. 
 
Once you have ran the procedure, enter the flag invoices form payment form:  
Financials > Accounts Payable > Payments > Prepare Payments > Flag Invoices for Payment  
 
Search for everything that has the “prepare payment” ticked:

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
 
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 5 of 11 
Here you can exclude invoices from the payment run by unticking the “prepare payment” box. You can also flag invoices as “checking” he re, meaning that they will not have a 
payment prepared until the checking box is unticked. 
 
 
Once you are happy with the invoices flagged for “prepare payments” in the “flag invoices for payment” form, run the following procedure to generate the payments in Priority: 
Financials > Accounts Payable > Payments > Prepare Payments > Prepare Payments  
 
The procedure gives you several options:

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
 
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 6 of 11 
First choose the bank account you are making payment from. 
Then you will need to choose the payment date so that the bank knows which date to process the transaction on.  This date will apply to all payments being generated. 
 
Tick “Postdated payments” if you would like to prepare post dated payments based on the payment dates on the invoices instead of the payment date you  specified. 
 
Tick “1 payment per project” if you want to prepare a separate payment per project. This will look at which project th e invoice is linked to, and if a vendor has invoices linked to 
different projects, a payment will be generated for each project. 
 
You can choose to either prepare, or prepare and finalise. If you choose prepare only, you will have to review and finalise t he payments before you can generate the payment file. If you 
choose to prepare and finalise, the system will automatically finalise the payments.  
 
Next you need to define the payment means: 
 
 
In the case of using the bank payment module, you will need to choose to prepare bank transfers. 
Alternatively you can choose to create cheque payments, or you can choose to go by vendor definition, which means if the vend or has the “pay by bank transfer” flag ticked on the 
financial parameters for vendor form, a bank transfer will be raised, otherwise a cheque payment will be raised.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
 
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 7 of 11 
Lastly, you can choose which currency is used: 
 
Either the invoice currency, vendor currency or the currency of your paying bank account.  
 
Hit OK and the system will prepare the payments. 
In the case that you prepared payments without finalizing, you need to review and finalise them.  
 
You can finalise all temporary payments at once by running this procedure and querying for all payments starting with T:  
Financials > Accounts Payable > Payments > Bank Transfers > Finalize Bank Transfers 
 
 
Once payments are prepared and finalized, you will be able to move on to the next step.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
 
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 8 of 11 
4. Flag Bank Transfers for ITP 
Go to the following form: 
Financials > Accounts Payable > Payments > Bank Transfers > Interbank Transaction Processing > Flag Bank Transfers for ITP  
 
Query for everything that has no date file recorded (date file recorded = blank).  
 
 
All payments will have automatically been flagged to be included in the payment file. 
Any payment that has already been included in a file will have a “date file recorded” and therefore will not be included again un less this date is removed. You can query for these 
payments if you wish to review what has already uploaded, or if you wish to remo ve the recorded date in order to include it in the next file.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
 
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 9 of 11 
Check through the list and unflag “upload” on anything you do not wish to be included in the file.  
 
 
 
Once you are happy with the payments flagged for upload, move on to section 5.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
 
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 10 of 11 
5. Export bank payment to a file 
Financials > Accounts Payable > Payments > Bank Transfers > Interbank Transaction Processing > Run Interbank Payment  
Run the relevant procedure from the above menu according to the paying bank.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
 
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 11 of 11 
Choose the bank and the range of payment dates you wish to cover in the file. 
 
 
The system will then prompt you to save the file. Once saved, you can then manually upload it to your bank.
