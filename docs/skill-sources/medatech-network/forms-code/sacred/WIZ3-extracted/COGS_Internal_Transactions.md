# COGS_Internal_Transactions

- **Source:** `COGS_Internal_Transactions.htm`

COGS - (Perpetual) Warehouse Inventory Transactions 
 
 
- 
 
 
 
# How Warehouse Inventory Transactions Affect COGS Entries

 
 
 
 

 Transaction 
 
 

 Entry Code 
 
 

 Debit 
 Account 
 
 

 Credit Account 
 
 

 Remarks 
 
 
 

 Packing for customer 
 
 

 No entry is recorded, as debit and credit accounts are identical. To view the entry that would have been recorded , run the Details of COGS Transactions report. 
 
 
 

 Receipt from bonded warehouse 
 
 

 IT 
 
 

 Purchases / Inventory 
 
 

 inventory account of the bonded warehouse 
 
 

 Dual-currency package only 
 
 
 

 Receipt from subcontractor 
 
 

 IT 
 
 

 inventory accoun t of subcontractor warehouse 
 
 

 inventory account of finished goods warehouse 
 
 

  
 
 
 

 Warehouse transfer 
 
 

 IT 
 
 

 inventory account of sending warehouse 
 
 

 inventory account of receiving warehouse 
 
 

  
 
 
 

 Inventory count 
 
 

 CNT 
 
 

 Purchases/ Inventory 
 
 

 Inventory Count Variance 
 
 

 For positive variance, entry sum is positive; for negative variance, entry sum is negative . 
 
 
 

 Conversions 
 
 

 CNV 
 
 

 Purchases/ Inventory 
 
 

 Conversion Variance 
 
 

 Entry sum: cost of new part less cost of original part. 
 
 
 

 Assembly 
 
 

 ASM 
 
 

 Purchases/ Inventory 
 
 

 Assembly Variance 
 
 

 Entry sum: cost of assembled part less cost of issued components. 
 
 
 

 Issue to kit / issue to floor stock 
 
 

 IT 
 
 

 inventory account of materials warehouse 
 
 

 inventory account of floor warehouse 
 
 

  
 
 
 

 Issue of supplies 
 
 

 ISS 
 
 

 Production Costs 
 
 

 Purchases/ Inventory 
 
 

  
 
 
 

 Inventory disposal 
 
 

 DSP 
 
 

 Inventory Disposal 
 
 

 Purchases/ Inventory 
 
 

  
 
 
 

 Sampling 
 
 

 SMP 
 
 

 Part Sampling 
 
 

 Purchases/ Inventory 
 
 

  
 
 
 

 Reported production 
 
 

 LH 
 
 

 Inventory-Labor (plant floor) 
 
 

 Labor Offset 
 
 

 Summary entries are recorded to cover all reports in the period, for the day of the past balance. 
 
 

  
 
 

 FB 
 
 

 Inventory-Burden (plant floor) 
 
 

 Burden Offset 
 

  
 
 
 

 P roduction completed 
 
 

 IT 
 
 

 inventory account of floor warehouse 
 
 

 inventory account of finished goods warehouse 
 
 

 The entry is recorded for the date of the production report. 
 
 
 

 Backflush 
 
 

 No entry is recorded. 
 
 

  
 

 How the program works: 
 

 ·        All entries are recorded when the Post Cost of Goods Sold program is run (except when COGS online is used; see below). They are assigned a transaction date that matches the date of the inventory transaction. Transactions of the same type and for the same date are combined into a single entry. 
 

 ·        When transactions involve parts not subject to inventory control, entries are not recorded. 
 

 ·        Entries debit/credit the inventory account assigned to the warehouse in which the inventory transaction is recorded. 
 

 ·        Entries for inventory transactions of manufactured parts are recorded in three separate inventory accounts: Purchases /Inventory , Inven tory – Labor and Inventory – Burden . 
 

 ·        The entry sum is determined by the standard cost of the part, as can be viewed in the Material Costing and Product Costing forms. 
 

 ·        When the COGSPeriod constant is set to 2 and inventory counts or warehouse transfers are flagged in the Record COGS Online column of the Inv. Transaction Documents form, then COGS entries are recorded when the documents are finalized. Additional entries are recorded when the Post Cost of Goods Sold program is run.
