# 15-Label Printing

- **Source:** `15-Label Printing.pdf`

Cat.No.LB120248 1 Ver.1 – Dec.04, ’12 
 
SOP: Printing Labels* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To print labels via barcode printers, or printers whose printing format is controlled by 
an external design program. 
Working Assumption 
 You have installed the Codesoft or BarTender label design program, by which you 
will set the label type, design the labels and print them out via Priority.  
Procedure 
This procedure involves the transfer of data from Priority to the label design program, 
through the following steps: 
1. Setting up the label design program. 
2. Defining label types and interface files. 
3. Loading label data to a work area. 
4. Printing the loaded data by running the design program. 
Stage I: Setting Up the Design Program and Label Types 
1. Run the program called the Choose Label Printing Program .  
2. Select the relevant label design program. (If the program you use does not appear in 
the input screen, consult your implementer.) 
Note: It is not necessary to run this program before each label printout, unless the 
design program has changed. 
3. Open the tabula.ini file (in the Windows directory) and add a line called [Labels]. In 
the following line, add the complete path to the design program, where it is installed 
in your computer. For example: 
 For Codesoft: Application=C:\cs4dmx\cs4dmx.exe 
 For BarTender: Application=C:\Program Files\BarTender\bartend.exe. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

4. Enter the Label Definitions form. For each type of label, record the following details: 
 Type of Label – The name of the label type, which will appear in records in the 
work area. 
 Description – A description of the label type. 
 Label File – The name and path of the label template file for this type in the design 
program. 
Note: The system contains three pre-defined lines for standard labels. You can change 
the file name as required by the design program. 
Stage II : Designing the Labels 
Aim: To design labels using data taken automatically from specified forms. 
1. Open the Label Generator form. 
2. Specify the Form Name, Type of Label, and Quantity of Labels. 
3. In the Label Parameters sub-level form, choose the form columns to transfer into 
the Print Labels program. 
Result: You have designed a label template. 
Stage III: Deleting Data from the Work Area 
Aim: To clear the work area, so that it will only contain the relevant label data. 
Note: You can skip this step and clear the work area when loading new data, as detailed 
in the next stage.  
 Run the Clear Labels from Work Area program. 
Result: The work area is clear and ready to receive new data. 
Stage IV: Loading Data into the Work Area 
Aim: To load the data to be printed on the labels into the work area. The work area is a 
table containing the information required by the design program to print labels. 
Note: While loading, you can set that all prior data be deleted from the work area 
(eliminating the need for Stage III) and that labels are to be printed immediately 
(eliminating the need for Stage V). 
1. Open the desired form, and retrieve the desired data (i.e., the sub-level form that 
contains item details to be printed). 
Example: To print labels for ordered parts, open the Sales Orders form, retrieve the 
desired order, and move to the Order Items sub-level form. 
2. From the Design menu, click Label Generator. 
3. In the Label Generator dialogue box that opens:  
 Choose the desired label. 
 To create labels for all of the lines retrieved in the current form (e.g., all of the 
lines in the order), flag All Displayed Records. 
 If the work area data was not previously deleted, flag the Clear Label 
Preparation Work Area option. 
Cat.No.LB120248 2 Ver.1 – Dec.04, ’12

Cat.No.LB120248 3 Ver.1 – Dec.04, ’12 
 If you wish to print the labels immediately without revising anything first, flag 
Print Labels. 
 Click OK. 
Result: If the Print Labels option was flagged, they will begin printing 
immediately.  
4. The labels are loaded to the work area, into appropriate columns ( Parameter 1 
through Parameter 20). To view the results of the program and to edit the labels, 
open the Label Preparation Work Area form and retrieve the data. 
Stage V: Printing the Labels 
 Run the Print Labels program. You will receive notification of the number of labels 
sent to the printer, according to the number of records loaded into the work area. 
Note: If you run this program again without clearing the work area, you will reprint those 
labels that were loaded previously.
