# 15-17-Exchange Rate Adjustments

- **Source:** `15-17-Exchange Rate Adjustments.pdf`

www.priority -software.com   
1/4 Feb. 19, '15 Ver. 2 Cat.No. LB120260 
 
SOP: Exchange Rate Adjustments1 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
Every account is handled in the account currency and the local currency. In the Priority dual-
currency package, it is also handled in the second currency.  
If changes occur in the exchange rates between these currencies, discrepancies will arise in the 
local-currency (and second-currency) balances, relative to the account currency. Exchange rate 
adjustment programs are provided to correct these discrepancies in the appropriate currency. 
Setups 
Defining a default contra account 
A default contra account is necessary in order to record adjustment entries for accounts for which 
no specific contra account is defined. 
1. Enter the Default Accounts form and move to the "Exchange Rate Adjustments" line. 
2. In the Account No. column, specify the default exchange rate adjustments account. 
Procedure 
Stage I: Defining Accounts for Exchange Rate Adjustments 
Before running the exchange rate adjustment programs, you need to flag the accounts in the system 
that are affected by such adjustments, and specify the contra accounts against which they will be 
made. 
1. To define accounts for exchange rate adjustments, enter the Exch. Rate Adjustment Definition 
form. 
2. Retrieve the accounts for which you want to perform adjustments. 
3. In each account, flag the Make Exch Adjstments column. 
4. If no specific contra account is defined for the account, the journal entry will be recorded against 
the general contra account. To define a specific contra account, specify the appropriate account 
in the Adjustment Account column. 
Stage II: Dual-currency Users Only: Performing Exchange Rate Adjustments in 
Local-Currency Accounts 
Journal entries for exchange rate adjustments in local-currency accounts cause adjustments in the 
account's second-currency balance, according to the designated exchange rate. 
 
                                                 
1 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/4 Feb. 19, '15 Ver. 2 Cat.No. LB120260 
 
1. Run the Adjustments to Local-Curr Accts report. 
 The report allows you to preview the exchange rate adjustments that will be recorded in the 
system. 
 Specify the exchange rate between the local and second currencies, by which the 
adjustments will be calculated. This rate must be in effect on the date for which you want to 
create the adjustment entry. 
Note: You can leave the column blank in order to use the exchange rate that was in effect at 
the end of the previous fiscal period. 
 If you encounter an error or problem when checking the report, perform the required revisions 
in the existing journal entries before running the adjustment program. 
2. Run the Record Adjmts for LocalCur Accts program. 
 Define the fiscal period for which you want to record exchange rate adjustments: the previous 
or the current period. Adjustment entries will be assigned a transaction date and exchange 
rate according to the designated period.  
 Use the Post Entry column to determine whether the entries should be left pending or posted 
immediately. 
Recommendation: The first few times you run this program it is recommended to leave the 
entries pending and check them before they are posted. 
3. Open the Entry Journal form and retrieve the entries recorded by the program: 
 Retrieve by the entry code "EXC" (in the Transaction column) 
 Retrieve by the date the program was run in the Time Stamp column (in the Signature tab).  
 If the program was defined to leave the entries pending, use the entry number pattern "T*" as 
well. 
 Check the pending entries that were opened, and make any necessary revisions. 
 If the entries are pending, post them, either individually by Direct Activation from the Entry 
Journal form, or in batch via the Post Journal Entries program. 
Result:  
Journal entries of type EXC have been recorded to adjust second-currency balances according to 
the local-currency balance, for the designated period and for the accounts that are flagged for 
exchange rate adjustments. 
Note: If any entries remain pending, do not rerun the exchange rate adjustment program before 
posting or canceling them. 
Stage III: Performing Exchange Rate Adjustments in Foreign-Currency 
Accounts 
Journal entries for exchange rate adjustments in foreign-currency accounts cause adjustments in 
the account's local-currency (and second-currency) balance, according to the designated exchange 
rate. The report only displays the local-currency adjustments, but in the dual-currency package, the 
program also calculates and adjusts the second-currency balance. 
1. Run the Adjustments to Foreign Accounts report for the relevant currency 
 The report allows you to preview the exchange rate adjustments that will be recorded in the 
system.

www.priority -software.com   
3/4 Feb. 19, '15 Ver. 2 Cat.No. LB120260 
 
 Specify the exchange rate between the local currency and the account currency, by which the 
adjustments will be calculated. This rate must be in effect on the date for which you want to 
create the adjustment entry. 
Note: You can leave the column blank in order to use the exchange rate that was in effect at 
the end of the previous fiscal period. 
 If you encounter an error or problem when checking the report, perform the required revisions 
in the existing journal entries before running the adjustment program. 
2. Run the Record Adjs for Foreign Curr Acc program. 
 Define the fiscal period for which you want to record exchange rate adjustments: the previous 
or the current period. Adjustment entries will be assigned a transaction date and exchange 
rate according to the designated period.  
 Use the Post Entry column to determine whether the entries should be left pending or posted 
immediately. 
Recommendation: The first few times you run this program it is recommended to leave the 
entries pending and check them before they are posted. 
3. Open the Entry Journal form and retrieve the entries recorded by the program: 
 Retrieve by the entry code "EXC" (in the Transaction column) 
 Retrieve by the date the program was run in the Time Stamp column (in the Signature tab).  
 If the program was defined to leave the entries pending, use the entry number pattern "T*" as 
well. 
 Check the pending entries that were opened, and make any necessary revisions. 
 If the entries are pending, post them, either individually by Direct Activation from the Entry 
Journal form, or in batch via the Post Journal Entries program. 
Result:  
Journal entries of type EXC have been recorded to adjust local-currency (and second-currency) 
balances according to the foreign-currency balance, for the designated period and for the accounts 
that are flagged for exchange rate adjustments. 
Note: If any entries remain pending, do not rerun the exchange rate adjustment program before 
posting or canceling them. 
Stage IV: Dual-Currency Users Only: Performing Exchange Rate Adjustments 
in Multi-Currency Accounts 
Journal entries for exchange rate adjustments in foreign-currency accounts cause adjustments in 
the account's local-currency and second-currency balance, according to the designated exchange 
rate. The report only displays the local-currency adjustments, but the program also calculates and 
adjusts the second-currency balance. 
1. Run the Adjustments to Multi-Curr Accts report for the relevant currency. 
 The report allows you to preview the exchange rate adjustments that will be recorded in the 
system. 
 If you encounter an error or problem when checking the report, perform the required revisions 
in the existing journal entries before running the adjustment program. 
2. Run the Record Adjs for Multi-Curr Accts program.

www.priority -software.com   
4/4 Feb. 19, '15 Ver. 2 Cat.No. LB120260 
 
 Define the fiscal period for which you want to record exchange rate adjustments: the previous 
or the current period. Adjustment entries will be assigned a transaction date and exchange 
rate according to the designated period.  
 Use the Post Entry column to determine whether the entries should be left pending or posted 
immediately. 
Recommendation: The first few times you run this program it is recommended to leave the 
entries pending and check them before they are posted. 
3. Open the Entry Journal form and retrieve the entries recorded by the program: 
 Retrieve by the entry code "EXC" (in the Transaction column) 
 Retrieve by the date the program was run in the Time Stamp column (in the Signature tab).  
 If the program was defined to leave the entries pending, use the entry number pattern "T*" as 
well. 
 Check the pending entries that were opened, and make any necessary revisions. 
 If the entries are pending, post them, either individually by Direct Activation from the Entry 
Journal form, or in batch via the Post Journal Entries program. 
Results:  
 Journal entries of type EXC have been recorded to adjust local-currency and second-currency 
balances according to the foreign-currency balance, for the designated period and for the 
accounts that are flagged for exchange rate adjustments. 
 For balance sheet accounts, a single exchange rate adjustment entry is created for all 
unreconciled entries in any account flagged for Multiple Currencies. 
 For each P&L account, an exchange rate adjustment entry is created based on the account 
balance. 
Note: If any entries remain pending, do not rerun the exchange rate adjustment program before 
posting or canceling them.
