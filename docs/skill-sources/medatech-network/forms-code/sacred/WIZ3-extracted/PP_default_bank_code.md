# PP_default_bank_code

- **Source:** `PP_default_bank_code.htm`

PP_default_bank_code 
 
 
- 
 
 
 
# Reconciliation Code Example

 

This example describes a sequence of steps that might be used in a bank reconciliation code. 
 

 1 . First, the system reconciles items meeting all of the following criteria: 
 

 ·              Their amounts match. 
 

 ·              The reference number in the bank statement matches the second reference number in the journal entry ( Ref. 1 vs Ref. 2 ). For example, the entries match because they refer to the same check. AND 
 

 ·              They have the same date. 
 

 This method is used first because it reconciles a large percentage of the items. 
 

 2 .  A second step is applied to the items remaining unreconciled from the first method. The reconciliation method is the same as the first except that one criterion is looser: entries are reconciled whose dates fall within a range of 2 days. 
 

 3 .  The third step reconciles all remaining items with matching amounts (i.e., the Permitted Variance is zero). 
 

 4 .  The fourth step is the same as the third, except that amounts may differ by up to 5 cents from each other. 
 

 5 .  The fifth step reconciles items with the same Details and the same date. 
 

 6 .  The sixth step reconciles items with the same Details , with a date range of one day.
