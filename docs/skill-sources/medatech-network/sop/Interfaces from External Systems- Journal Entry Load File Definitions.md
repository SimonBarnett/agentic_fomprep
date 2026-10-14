# Interfaces from External Systems- Journal Entry Load File Definitions

- **Source:** `Interfaces from External Systems- Journal Entry Load File Definitions.pdf`

Interfaces from External Systems – Journal Entry Load 
File Definitions 
The following document presents the structure of the ASCII file that can be 
loaded into Priority via an interface from external systems.  
In order to load the file, place it in the following directory: Home\system\load 
(where “Home” represents the drive in the server in which Priority is installed), 
and run the Load HS Accts into Interim Table program. 
Notes: 
 Fields of REAL type will have a decimal point; leading zeros are not 
needed. 
 Date fields will be in the format DD/MM/YY. 
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
Cat.No. LB09000364 1 Ver.02, Nov. 20,'11

Currency 180 178 3 CHAR 18 
Debit/Credit 181 181 1 ‘C’ or ‘D’  19 
Source 189 182 8 CHAR 20 
Remark 221 190 32 CHAR 21 
Cash Flow Code 229 222 8 CHAR 22 
Entry Item Group 237 230 8 CHAR 23 
Ref.1 – Entry Item 245 238 8 CHAR 24 
Ref.2 – Entry Item 253 246 8 CHAR 25 
Details 277 254 24 CHAR 26 
Profit/Cost Ctr 2 293 278 16 CHAR 27 
Profit/Cost Ctr 3 309 294 16 CHAR 28 
Profit/Cost Ctr 4 325 310 16 CHAR 29 
Profit/Cost Ctr 5 341 326 16 CHAR 30 
Quantity 354 342 13 REAL 10.2 31 
Adjusted Sum 367 355 13 REAL 10.2 32 
Sum (Trans Curr) 380 368 13 REAL 10.2 33 
Exch Rate-Trans Curr 390 381 10 REAL 5.4 34 
Trans. Curr. 393 391 3 CHAR 35 
Project Number 413 394 20 CHAR 36 
WBS Code 437 414 24 CHAR 37 
Customer Number 453 438 16 CHAR 38 
Branch Code 459 454 6 CHAR 39 
 
Notes: 
1. The pair of fields Journal Entry Number and Ln (fields 1 and 2) has to be 
unique in every line in the file. That is, no two rows in the file can have the 
same entry number and line number. 
2. Amounts in the local currency and in the second currency have to be 
balanced for every journal entry. 
Cat.No. LB09000364 2 Ver.02, Nov. 20,'11

Cat.No. LB09000364 3 Ver.02, Nov. 20,'11 
3. In the Source field, write a fixed code, which denotes the source of the 
entries. 
4. The  fields Reference 1 and 2 in the header (fields 4 and 5) are shared by 
all the lines of the same journal entry, whereas the fields Reference 1 and 
2 in the line (fields 24 and 25) are for each separate line. 
5. The load file should be defined ei ther as a fixed-width file called loadfnc 
(no file extension) or as a tab-delimited file called loadfnc.txt. 
6. When using a tab-delimited file, there are no limitations on column width. 
Among other things, this enables you to define a line number that is more 
than 3 integers in length (i.e., greater than 999). 
7. Lines with identical entry number s must have the same transaction and 
reference dates.
