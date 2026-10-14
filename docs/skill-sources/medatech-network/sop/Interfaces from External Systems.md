# Interfaces from External Systems

- **Source:** `Interfaces from External Systems.pdf`

Interfaces from External Systems 
The following document presents the structure of ASCII files that can be loaded into 
Priority via an interface from external systems. At the top of every table appears the 
name of the load file, as well as the appropriate loading procedure. To load the file, use 
the items in the Interfaces from External Systems menu (path: Financials Æ 
Maintenance of Financials Æ Interfaces Æ Interfaces with External Systems), unless 
you are instructed otherwise below. 
In order to load a given file, place it in the following directory: D:\priority\system\load 
(where “D” represents the drive in the server in which Priority is installed), and run the 
appropriate procedure. 
(See separate instructions for journal entry interface, below). 
Notes: 
• Fields of REAL type will have a decimal point; leading zeros are not needed. 
• Date fields will be in the format DD/MM/YY. 
General Ledger 
File Name: Accounts.doc 
Procedure Name: Load HS Accts into Interim Table 
Title To char From char Length Type 
Account No. 8 1 8 CHAR 
Account Description 39 10 30 CHAR 
Trial Bal Item 43 41 3 CHAR 
Bal Sheet/P&L Item 74 45 30 CHAR 
Details 125 76 50 CHAR 
 
Accounts Payable Subledger 
File Name: Suppliers.doc  
Procedure Name: Load A/P into Interim Table (HS) 
Title To char From char Length Type 
Account No. 8 1 8 CHAR 
Account Description 39 10 30 CHAR 
Trial Bal Item 43 41 3 CHAR 
Bal Sheet/P&L Item 74 45 30 CHAR 
Cat.No. A8000444 1 Ver.02, 08/01/07

Details 125 76 50 CHAR 
Phone Number 142 127 16 CHAR 
Street Address 177 148 30 CHAR 
City/State 193 179 15 CHAR 
Zip Code 199 195 5 CHAR 
Tax Exempt? (Y/N) 201 201 1 CHAR 
% Withholding Tax 207 203 5 REAL 
Expir. Date 216 209 8 DD/MM/YY 
Co. Registration No. 226 218 9 CHAR 
Bank Code 232 231 2 CHAR 
Branch Number 236 234 3 CHAR 
Bank Account 246 238 9 CHAR 
 
Accounts Receivable Subledger 
File Name: Customers.doc  
Procedure Name: Load A/R into Interim Table (HS) 
Title To char From Char Length Type 
Account No. 8 1 8 CHAR 
Account Description 39 10 30 CHAR 
Trial Bal Item 43 41 3 CHAR 
Bal Sheet/P&L Item 74 45 30 CHAR 
Details 125 76 50 CHAR 
Phone Number 142 127 16 CHAR 
Street Address 187 158 30 CHAR 
City/State 203 189 15 CHAR 
Zip Code 209 205 5 CHAR 
Tax Exempt? (Y/N) 211 211 1 CHAR 
Billing Cust. Number 220 213 8 CHAR 
Sales Rep. Number 225 222 4 CHAR 
Bank Code 228 227 2 CHAR 
Branch Number 232 230 3 CHAR 
Bank Account 242 234 9 CHAR 
Parts 
Cat.No. A8000444 2 Ver.02, 08/01/07

File Name: Part.doc  
Procedure Name: Load Parts into Interim Table. 
Title To char From char Length Type 
Part Number 15 1 15 CHAR 
Price 1 26 17 10 REAL 
Currency 1 29 28 2 CHAR 
Price 2 40 31 10 REAL 
Currency 2 43 42 2 CHAR 
Price 3  54 45 10 REAL 
Currency 3  57 56 2 CHAR 
Price 4  68 59 10 REAL 
Currency 4 71 70 2 CHAR 
Price 5  82 73 10 REAL 
Currency 5 85 84 2 CHAR 
Price 6 96 87 10 REAL 
Currency 6 99 98 2 CHAR 
Price 7 110 101 10 REAL 
Currency 7 113 112 2 CHAR 
Price 8 124 115 10 REAL 
Currency 8 127 126 2 CHAR 
Keep open (space) 136 128 9 CHAR 
Last Price Currency 138 137 2 CHAR 
Last Price 153 140 14 REAL 
Date 162 155 8 DD/MM/YY 
Purchase Lead Time 178 164 15 REAL 
Sea Cost % 184 180 5 REAL 
Safety Stock 199 186 14 REAL 
Minimum Reorder Qty. 214 201 14 REAL 
Factory Unit 218 216 3 CHAR 
Taxable? 220 220 1 CHAR 
Volume 234 222 13 REAL 
Weight 248 236 13 REAL 
Factory Unit 252 250 3 CHAR 
Cat.No. A8000444 3 Ver.02, 08/01/07

Part Descrip.Lang2 285 254 32 CHAR 
Family 289 287 3 CHAR 
Part Description 322 291 32 CHAR 
Preferred Vendor 338 324 15 CHAR 
VPN 354 340 15 CHAR 
 
Bill Of Materials 
File Name: Parttree.doc  
Procedure Name: Load BOM into Interim Table. 
Title To char From char Length Type 
Parent Part Number 15 1 15 CHAR 
Qty(Parent) 25 17 9 REAL 
Child Part Number 41 27 15 CHAR 
Qty(Child) 51 43 9 REAL 
 
Sales Orders 
File Name: Orders.doc  
Procedure Name: Load S. Orders to Interim Table (path: Marketing and Sales > 
Orders > Sales Order Interface). 
Notes/Record TypeTitle To char From char Length Type 
1 Date 8 1 8 DD/MM/
YY 
1 Customer No. 24 9 16 CHAR 
2 Part No. 31 17 15 CHAR 
2 Quantity 44 32 13 REAL 
2 Unit Price 54 45 10 REAL 
1 Currency 57 55 3 CHAR 
1 Original Order No. 65 58 8 CHAR 
1 Sales Rep 69 66 4 CHAR 
1 Cust’s Purchase Order 77 70 8 CHAR 
1 Overall Discount (%) 85 78 8 REAL 
1 Branch Code 91 86 6 CHAR 
Cat.No. A8000444 4 Ver.02, 08/01/07

1 Shipping Destination 95 92 4 CHAR 
1 Payment Terms Code 97 96 2 CHAR 
1 Shipment Code 99 98 2 CHAR 
2 Variable Part Desc. 131 100 32 CHAR 
1 Variable Cust. Name 163 132 32 CHAR 
2 Due Date 171 164 8 DD/MM/
YY 
1 Discount (%) 179 172 8 REAL 
2 Unit 182 180 3 CHAR 
2 Shipping Destination 
(line) 
186 183 4 CHAR 
2 Budget Item 202 187 16 CHAR 
2 Profit/Cost Center 210 203 8 CHAR 
2 Tax/VAT? 211 211 1 CHAR 
2 Line Currency 213 212 2 CHAR 
2 Exchange Rate 223 214 10 REAL 
“1” – Title 
“2” – Item 
“3” – Text 
Record Type 227 224 4 CHAR 
2 Line No. 232 228 5 INT 
3 Order Line Text 316 249 68 CHAR 
 
Note: The file should be built in such a way that the title record appears at the head of 
the file (with the value “1” in the Record Type column), followed by the item records 
(Record Type “2”) and finally one or more text records (Record Type “3”). Afterwards 
you can itemize additional orders in the same manner. 
Credit Data 
File Name: Obligo.doc  
Procedure Name: Input Credit Data. 
Title To char From char Length Type 
Customer No. 8 1 8 CHAR 
Liability 23 10 14 REAL 
Currency 26 25 2 CHAR 
Credit 41 28 14 REAL 
Cat.No. A8000444 5 Ver.02, 08/01/07

Currency 44 43 2 CHAR 
Avg. Late Payments 49 46 4 INT 
 
Product Families  
File Name: Family.doc  
Procedure Name: Load Families.  
Title To char From char Length Type 
Family Description 65 34 32 CHAR 
Family 79 72 8 CHAR 
 
Special Customer Prices 
File Name: cprice.doc  
Procedure Name: Input Sp ecial Customer Prices. 
Title To char From char Length Type 
Currency 5 1 5 CHAR 
Price 23 13 11 REAL 
Customer 67 60 8 CHAR 
Part Number 125 114 12 REAL 
 
Alternate Nos. (Cust/Vendor) 
File Name: suppart.doc 
Procedure Name: Input A ltern. Nos (Cust / Vendor) 
Title To char From Char Length Type 
Altern. Num. 27 13 15 CHAR 
Cust/Vendor Num. 50 43 8 CHAR 
Part Number 70 59 12 CHAR 
 
Cat.No. A8000444 6 Ver.02, 08/01/07

Load Journal Entries 
Title To char From char Length Type Field 
Journal Entry No. 8 1 8 CHAR 1 
Ln 11 9 3 INT 2 
Entry Code  14 12 3 CHAR 3 
Reference 22 15 8 CHAR 4 
Refer. 2 30 23 8 CHAR 5 
Transact Date 38 31 8 DD/MM/YY 6 
Reference Date 46 39 8 DD/MM/YY 7 
Due Date 54 47 8 DD/MM/YY 8 
Account No. 70 55 16 CHAR 9 
Contra Account 86 71 16 CHAR 10 
Budget 102 87 16 CHAR 11 
Profit/Cost Center 118 103 16 CHAR 12 
Sum 131 119 13 REAL 10.2 13 
Sum (C2) 144 132 13 REAL 10.2 14 
Exch. Rate (C2) 154 145 10 REAL 5.4 15 
Sum (Trans. Curr) 167 155 13 REAL 10.2 16 
Exchange Rate 177 168 10 REAL 5.4 17 
Currency 180 178 3 CHAR 18 
Debit/Credit 181 181 1 ‘C’ or ‘D’  19 
Source 189 182 8 CHAR 20 
Remark 221 190 32 CHAR 21 
Cash Flow Code 229 222 8 CHAR 22 
Entry Item Group 237 230 8 CHAR 23 
Ref.1 – Entry Item 245 238 8 CHAR 24 
Ref.2 – Entry Item 253 246 8 CHAR 25 
Details 277 254 24 CHAR 26 
 
Notes for the Journal Entry Interface: 
1. The pair of fields Journal Entry Number and Ln (fields 1 and 2) has to be 
unique in every line in the file. That is, no two rows in the file can have the same 
entry number and line number. 
Cat.No. A8000444 7 Ver.02, 08/01/07

2. Amounts in the local currency and in the second currency have to be balanced for 
every journal entry. 
3. In the Source field, write a fixed code, which denotes the source of the entries. 
4. Transaction dates and reference dates in each entry item have to be identical. 
5. The fields Reference 1 and 2 in the header (fields 4 and 5) are shared by all the 
lines of the same journal entry, whereas the fields Reference 1 and 2 in the line 
(fields 24 and 25) are for each separate line. 
6. The name of the load file must be “loadfnc” (without a suffix). 
 
Inventory Count Interface 
Title To char From 
char 
Length Type Comments 
Date 8 1 8 DD/MM/YY  
Warehouse 12 9 4 CHAR  
Bin 15 13 3 CHAR In case of no bin use 0 or 
leave empty 
Part Number 30 16 15 CHAR  
Quantity 43 31 13 REAL Up to 3 digits after decimal 
point 
Record Type 45 44 2 INT Explanation follows
Ln Number 50 46 5 INT  
Cost 60 51 10 REAL Up to 2 digits after decimal 
point 
Cost(C2) 70 61 10 REAL Up to 2 digits after decimal 
point 
The first line is the Heading of the Inventory Count. 
The following data should be entered:  
Field Content  Comments 
Date Count date Mandatory 
Warehouse The Warehouse in which the 
count took place. 
Mandatory 
Bin   
Part Number Empty In case of a value the system will ignore.  
Quantity Empty  In case of a value the system will ignore.  
Record Type 1 (constant) Mandatory 
Cat.No. A8000444 8 Ver.02, 08/01/07

Cat.No. A8000444 9 Ver.02, 08/01/07 
Ln Number The beginning of the file line 
Num. 1 
If there are inventory counts for multiple 
warehouses in one file, there should be a 
header for each warehouse. The Ln 
Number should appear only once in a file. 
No duplicates. 
 
The following lines are the Inventory counted data. 
The lines must include the following: 
Field Content  Comments 
Date  Does not influence the Inventory Count* 
Warehouse  Does not influence the Inventory Count* 
Bin   
Part Number Part Number Mandatory 
Quantity Quantity   
Record Type 2 (constant) Mandatory 
Ln Number Serial number begin from 2  Mandatory 
Cost   
Cost(C2)   
* The data will be obtained from the header.
