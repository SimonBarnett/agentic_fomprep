# 13-17-Withheld Tax Report

- **Source:** `13-17-Withheld Tax Report.pdf`

www.priority -software.com   
1/2 Feb. 25,'15 Ver. 02 Cat.No. LB10000152 
 
 SOP: Preparing the Withheld Taxes Report  
(dual-currency package) 
Customer:   Company Inc. 
Assigned to:  Dept./Position 
Aim 
Companies that are required to use double-entry bookkeeping are also required by the tax 
authorities to withhold tax from vendors when performing a payment. 
The procedures described below will assist you in tracking withheld taxes and running withholding 
tax reports for vendors and tax authorities. They will also assist your financial officers in the routine 
tracking of the required authorizations and the withheld sums, in various cross-sections. 
Setups 
 In the Company Data form, record the company's withholding tax file number in the File 
Number (Tax) column. 
 Define a GL account for withholding taxes in the Chart of Accounts form. Select 9 in the VAT 
Report Item column. 
Note: If the Account Initialization-Intl program was run, the account is already defined in the 
system. 
 In the Financial Parameters for Vendors form, flag each vendor for which taxes must be withheld 
in the Must Rep. Income column, and define all necessary withholding tax parameters. 
Note: You can run the Missing Data for Withhd Tax Rep. report to make sure all the necessary 
details have been defined. 
 Define the maximum percentage of tax to withhold in the Withholding Tax Definitions form. In the 
Account No. column, select the account defined for withholding tax. 
 Make sure that the journal entry types included in tax withholding reports (e.g., check payments, 
bank transfers) are flagged in the In Withhd Tax Rep't column in the Journal Entry Types form. 
 To report consolidated withholding taxes in a multi-company environment, include each 
company by flagging it in the Multi-company column in the Companies form. 
Procedure 
Stage I: Automatically Recording a Payment with Withholding Tax 
When you record a payment to a vendor by check (in the Check Payments form) or bank transfer (in 
the Payments by Bank Transfer form), tax is withheld automatically from each vendor required to do 
so, according to the parameters defined in the Financial Parameters for Vendors form. 
If part of the payment is not subject to withholding tax, enter the Payment Details sub-level of the 
Check Payments or Payments by Bank Transfer form and flag the relevant payment line in the 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 Feb. 25,'15 Ver. 02 Cat.No. LB10000152 
 
Vendor's Cust Debt column. This occurs automatically when the vendor is also defined as a 
customer and the owed sums are canceled out by the sums you owe the vendor. In such a case, 
taxes are withheld from all sums in vendor invoices, without reference to the sum owed by the 
vendor as a customer. 
Stage II: Manually Recording a Payment with Withholding Tax 
 When you manually record a vendor payment in the entry journal, make sure that the Entry 
Code appearing in the Transaction column is defined for inclusion in withholding tax reports. 
Stage III: Monthly Reporting of Withheld Tax 
You can run a monthly report for a single company, or a consolidated report for all companies in a 
multi-company environment. 
 Run the Withheld Taxes report, choosing the summary or detailed format. 
 To check data originating in payment documents (as opposed to manual journal entries), run the 
Withheld Tax Versus Payments report. 
 In a multi-company environment, run the Consolidated Withholding Tax report.   
Stage IV: Auxiliary Reports for Reporting Annual Withholding Tax 
 Run the Annual Withheld Taxes report to view the total payments and taxes withheld each 
month, within the designated time period. 
 To check data originating in payment documents (as opposed to manual journal entries), run the 
Annual Withhd Tax Versus Paymts report. 
Stage V: Authorizing the Sums Withheld from Vendors 
You can issue an authorization to a vendor for the sums withheld each month, within a specified 
time period. 
 Run the Withheld Taxes – Vendor's Copy report. 
Stage VI: Checking the Validity of Withholding Tax Exemptions 
You can check to see which withholding tax exemptions are due to expire prior to a designated 
date. 
 Run the Expiration of Reduced Withhd Tax report. 
 To change the expiration date for all vendors whose withholding tax exemptions are due to 
expire on the same date, run the Extend Authorizations program.
