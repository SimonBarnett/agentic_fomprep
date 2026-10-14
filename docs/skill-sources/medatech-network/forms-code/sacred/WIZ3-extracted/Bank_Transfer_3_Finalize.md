# Bank_Transfer_3_Finalize

- **Source:** `Bank_Transfer_3_Finalize.htm`

Bank Transfers - Finalizing Batch Documents 
 
 
- 
 
 
 
# Finalizing the Payment Documents

 

When you finalize a bank transfer document, the following occurs: 
 

 ·        A unique internal document number is generated, which replaces the temporary number that appeared when the bank transfer was opened. 
 

 ·        A journal entry is recorded for the bank transfer. 
 

 ·        The status of the payment document is set to Final . 
 
## To finalize the payment documents:

 

 ·        Run the Finalize Bank Transfers program. 
 
## Notes:

 

 ·        The program will not finalize bank transfers to vendors for which payments are blocked (i.e., whose status in the Financial Parameters for Vendors form does not allow for payment), or whose No Payment After date (in the same form) has expired. 
 

 ·        You must be authorized to change the status of bank transfer documents to Final . Moreover, you will only be able to finalize documents whose current status allows for finalization (e.g., are assigned the Approved status). 
 

 ·        If you did not flag the Post Journ. Entries column for bank transfers (in the Financial Documents form), the journal entry created is only pending. That is, it needs to be checked and posted. 
 

 ·        Click to print notifications to the vendor and your bank. 
 

 ·        Click to return to the main screen.
