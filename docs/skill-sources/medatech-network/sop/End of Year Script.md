# End of Year Script

- **Source:** `End of Year Script.pdf`

End of Year Script 
Clip Link: http://www.eshbel.com/Movie_Search/End_of_Year_clip.htm 
Note: Yellow highlights 
indicate action instructions.  
Introduction (00:00-00:45) 
This clip illustrates the actions you must take to make a smooth year-end transition 
to a new fiscal year. We're going to divide these actions into three categories, based 
on the time of year at which they should be carried out: 
 actions that can be taken at any time, generally toward the end of the fiscal year, 
 actions that must be taken care of on t he last working day of the fiscal year,  
 and actions that must be performed on t he first working day of the new year, 
before users can work with the system.  
We'll begin with a demonstration of the actions that should be performed toward the 
end of the current fiscal year. It is important to ensure that they are all carried out by 
the end of December.  
Actions That Must Be Taken By the End of the Year (00:46-04:03) 
First, we need to define a new fiscal year. So we're going to navigate to the Fiscal 
Periods menu and open the Define Fiscal Years form. 
In this form we'll move to an empty line and define a new fiscal year; in this example, 
I'll enter '2013'. Record the Start Date and End Date of the new year. Upon exiting 
this record, a prefix is generated automatically for all journal entries recorded in the 
new fiscal year. The prefix can be changed at this point, if desired. 
In the sub-level form, Fiscal Periods, 12 fiscal periods have been defined 
automatically, one for each calendar month of the new fiscal year. These periods 
have not yet been opened and no entries can be recorded for them. 
The second thing you must take care of is to open new document numbers. 
Document numbers are defined in the system on a yearly basis, and include a prefix 
indicating the relevant fiscal year. So let's navigate to the Financials > Maintenance 
of Financials > Auxiliary Programs menu and run the Open Numeration 
Templates program for the upcoming fiscal year. 
If numeration templates for the current fiscal year were defined manually, you can 
flag the Base Prefix on Prev column to use the same document number prefixes 
during the upcoming year, while automatically switching the two digits that represent 
the year. For instance, if you had been using the prefix AB12 for a particular 
document type in 2012, the system would assign the prefix AB13 to documents 
opened in 2013. However, if the numeration template used in the current fiscal year 
was defined automatically, the Base Prefix on Prev column should not be flagged. 
Results can be viewed and revised as necessary in the Document Numeration 
Templates form. Let's retrieve all templates defined for the year 2013. As you can 
Cat.No. LB120289  Ver.1 – Dec. 2,’12 1

see, the Prefix assigned by default includes an alphabetic identifier for each 
document type as well as a numeric indicator of the year in question. Additional 
characters may also appear in the prefix, serving as a branch identifier. 
This formula can be revised, but we recommend that you leave it as it is. Should you 
choose to change the prefix, be careful not to assign a prefix that is too long, as that 
will limit the number of documents that can be generated. You must also make sure 
not to assign the same prefix for more than one type of document, and ensure that 
the Column Width defined for each document is neither too long nor too short. Note 
that once a given type of document is opened according to the new template, you 
will not be able to change its numeration template. 
Actions to be Taken on the Last Working Day  of the Year (04:04-06:27) 
There are some actions which need to be taken specifically on the last working day 
of the fiscal year. Note that if the year ends on a Saturday, your last day of business 
will be on a Friday and you should perform these actions on that Friday. 
First, make sure to finalize deposit slips for all deposits that you intend to make by 
end of business day. Then, enter the Cashiers form and close all cashiers, by 
recording today's date as the Closing Date. Next, run the Cashier Balance report, 
in order to obtain balances for all cashiers as of Dec. 31. 
At this stage, we'll return to the Cashiers form and check the Account Balance 
recorded for each cashier. We'll compare this balance to each of the following values: 
the cashier balance listed in the report and the actual physical contents of your 
cashiers. All three balances should match up -- if you spot any discrepancies, these 
should be investigated and corrected.  
We strongly recommend that you maintain a copy of the Cashier Balance report for 
year-end auditing purposes. To save a digital copy, we'll activate the report a second 
time, but this time we'll choose to save the report we ran earlier -- or rather, to block 
deletion of this report, so that it will always be available in the list of saved reports in 
the system. You may want to save a printed copy of the report as well. 
In addition to the Cashier Balance report, there are other important end-of-year 
reports that can only be run for the current date, and therefore should be run on the 
last working day of the year. These include the various Unbilled Shipment reports 
in the Unbilled Shipmt/S. Call Reports menu, as well as the Unbilled GRVs report. 
Additionally, dual-currency users should run the Postdated Checks Held in Bank 
report. 
Actions to be Taken on the First Working Day  of the New Year (06:28-08:46) 
Finally, let's review the actions that need to be taken on the first working day of any 
new year. First, we'll open the Default Accounts form and make sure that an 
account is linked to the line for Prior Retained Earnings. This is essential for 
transferring balances from one year to the next. 
Then we're going to run the Transfer Opening Balances program for the new fiscal 
year. This program updates opening balances for the new year based on the closing 
balances recorded for the previous year. The program does not record any journal 
entries, so there is no problem in running it before beginning to work in the system, 
even if balances for the previous year are not yet final.  
Cat.No. LB120289  Ver.1 – Dec. 2,’12 2

Cat.No. LB120289  Ver.1 – Dec. 2,’12 3
In order to record entries for the beginning of the year you will have to run the Open 
Fiscal Period program for any period in which you want entries to be recorded. You 
can open all periods now or, for better control, you can open them gradually over the 
course of a year. The latter option can help prevent users from accidentally recording 
entries for a future date. 
As this is a multi-year system, you can continue to work in the previous year (in our 
example, 2012) even after you're done working in the new one, as long as the fiscal 
period in question has not been closed. Whenever entries are added for the previous 
year, you can record them for the proper dates and then rerun the Transfer 
Opening Balances program for the new year. Once you finalize all closing balances, 
it is recommended that you prevent further entries for the previous year by running 
the Close Fiscal Period program. Subsequently, only authorized users can continue 
to record entries for the closed period. This authorization is defined in the Users 
Authorized for Closed Period form, a sub-level of the Fiscal Periods form. 
This concludes our demonstration of the transition to a new fiscal year. Eshbel 
wishes you a happy and successful New Year! 
Related Documentation 
 Year-End: Preparing for 2013 
 Set Up Financial Documents Wizard 
 Fiscal Periods Wizard 
 Working with Cashiers Wizard
