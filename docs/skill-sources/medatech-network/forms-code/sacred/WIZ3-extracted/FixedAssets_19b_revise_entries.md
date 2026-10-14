# FixedAssets_19b_revise_entries

- **Source:** `FixedAssets_19b_revise_entries.htm`

Fixed Assets - Recording Depreciation in the Ledger.3 
 
 
- 
 
 
 
# Revising Depreciation Data in Final Journal Entries

 

If you need to revise depreciation data for which a journal entry has already been posted, you can use one of the following methods, depending on whether the fiscal period in question is still open. 
 
## Note:

 

This procedure should only be performed under the guidance of an Eshbel implementor. 
 
## If the fiscal period is still open:

 

 1 .  Enter the Entry Journal form and retrieve the desired journal entry. 
 

 2 .  Select Reverse Entry (Original Entry) from the list of Direct Activation s to cancel the entry. 
 

 3 .  Retrieve the asset in question in the Fixed Assets form and make the necessary revisions. 
 

 4 .  Select Calculate Depreciation from the list of Direct Activation s . 
 

 5 .  Run the Record Asset Trans. in Journal program to create a new entry for the asset. 
 
## If the fiscal period is closed:

 

 1 .  Run the Cost and Depreciation report for the asset in question, choosing the Accounting Purposes option. Save your report results. 
 

 2 .  Run the Adjust Depr. Calcs (Prep. Stage) program for the asset and dates in question. This unlinks the journal entry from the asset. 
 

 3 .  Retrieve the asset in the Fixed Assets form and make the necessary revisions. 
 

 4 .  Select Calculate Depreciation from the list of Direct Activation s . 
 

 5 .  Rerun the Cost and Depreciation report for the asset in question, choosing the Accounting Purposes option. 
 

 6 .  Enter the Entry Journal form and record a manual journal entry for the difference between the first Cost and Depreciation report you ran and the current report.
 Note: Do not run the Record Asset Trans. in Journal program for past dates, as this will result in double entries. 
 
## Note:

 

Click to return to the main screen .
