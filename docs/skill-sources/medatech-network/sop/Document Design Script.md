# Document Design Script

- **Source:** `Document Design Script.pdf`

Document Design Script 
Clip Link: http://www.eshbel.com/Movie_Search/Document_Design_clip.htm  
Note: Yellow highlights 
indicate action instructions.  
Introduction (00:00-00:41) 
In this presentation we will demonstrate several tools that are used to design 
HTML documents and reports generated in Priority, such as changing colors to 
adjust the look and feel of documents, changing the color and look of fonts, 
changing or hiding column names, and changing the date format that appears in 
the document. 
Only users with the appropriate permissions have access to design options; if you 
lack such permissions, consult your system manager.  
We'll start by defining the company logo that will appear on all system documents, 
as well as a personalized signatu
re that will appear on any documents that you 
generate. 
Add a Logo to System Documents (00:42-01:53) 
We recommend that you use a .JPG or .GIF file format for your company logo, 
and that you import this file into Priority, where it can be accessed by all system 
users. 
If you work with multiple companies, affiliates and/or branches in Priority, you can 
import a separate logo for each, in the relevant form. Let's enter the Company 
Data form and define a logo for any documents produced for the current company 
environment, International Demo Company. Move the cursor to the HTML Logo 
column, right-click on the paperclip icon and select Import. In the dialog box that 
opens, locate your logo file and click Open. 
You can switch to a different company environment and repeat this process to 
add a logo for a different company. You can also add separate logo files for 
specific affiliates or branches in the Affiliates or Branches forms, respectively. 
These alternate logos will then appear on any documents that are linked to the 
branch or affiliate in question. 
Add a User Signature for Document Printouts (01:45-02:39)  
Next, we're going to customize the user signature that appears in any documents 
you generate. From the upper File menu, select the User Signature command. In 
the parameter input screen that opens, we'll choose to define the signature that 
will appear in Documents.  
A second parameter input screen appears, in which you can compose a personal 
greeting and indicate which elements you want to display in your signature. Most 
of the elements in this screen correspond to a parallel column in your personnel 
file (e.g., your name and job title). 
Cat.No. LB120104  Ver.2 – July 22,’12 1

Next, we'll look at a few general definitions that apply to all reports and 
documents, system-wide, and then we'll set up some custom definitions for an 
individual document. 
Report Design Tool (02:40-07:00) 
We will no
w demonstrate the design functionality in a specific document. In this 
example, we'll design the Order Confirmation document, but the same principles 
apply to various reports and documents throughout the system. The report 
customizations we are about to make will affect all users in all companies in the 
system. 
Let's go to the Sales menu, Orders, Sales Order Reports, Order Confirmations 
and locate the program used to print an Order Confirmation. Right-click this print 
program and select Design Report. You can see a list of all print formats that 
have been defined for the document, such as the predefined Standard Format. 
Each of the predefined print formats comprises a different set of document 
components. Now, rather than modify an existing format, we're going to duplicate 
the Standard Format and make our changes in the duplicate format. This is a 
good practice to adopt, as it may prevent you from having to reconstruct the 
original design, if it is needed at some later date. So, let's right-click the format 
title, select Duplicate, and then assign the desired format title. 
Next, we'll open the new print format to view a list of document sections. While 
some reports consist of a single section composed of the relevant columns, most 
documents, such as this one, contain a number of sections. 
Some sections are pre-designed in a fixed style, and you cannot rearrange their 
columns. Those sections without a fixed style appear as tables, and their columns 
can be rearranged. 
Click the arrow next to any section title to view its component columns. We'll open 
one without a fixed style, and use the up and down arrows on the right to 
rearrange the columns. You can also right-click any column in order to hide or 
rename it. Hidden columns are indicated by a red X. To display a hidden column, 
right-click the column and select Show.  
In addition, you can revise the appearance of document fields and their titles. 
Right-click the desired field and select Field Attributes to open a dialog box in 
which you can change the field’s font, font style, font size, color, background color 
or alignment in the space assigned to the field.  
Different types of fields may also present other options. For instance, in fields that 
contain a number, such as Packing Crates (No.), you can also set the number of 
decimal places to display or choose to color negative values. In a date field, such 
as Due Date, you can choose the desired Date Format. In text fields in an 
itemized document, such as Part Description, you can also determine whether 
text for a given item will be broken automatically into more than one line if it 
exceeds the column width. This is the default setting, but can be changed by 
flagging the Prevent Line Break attribute. 
Right-click the desired field and select Title Attributes to open a dialog box in 
which you can change the column title's font, font style, font color, background 
color or text justification. 
Cat.No. LB120104  Ver.2 – July 22,’12 2

To undo all changes to the report’s appearance, right-click the format title and 
select Restore Defaults.  
Change the Color Scheme of Printouts (07:01-10:19) 
When you first begin producing documents and reports in Priority, you'll notic
e 
that they appear on a cream and brown background and that the default font color 
is black. However, you may want to change the standard color scheme of all 
printouts in your organization; for instance, to match your company's logo.  
To change the background color, go to the System Management > System 
Maintenance > Advanced Design menu and open the Color Definitions form. 
In this form, you can change the RGB definitions used in any section of the 
printout, either for the background or for the font itself. For instance, let's revise 
the background color of sections that are currently set to appear with a cream-
colored background, so that they appear with a white background, instead. And 
next we'll define sections that currently have a darker cream background so that 
they appear with a grey background instead.  
Finally, let's change the font color used for the report title to dark blue. 
You can also set color definitions to be used solely within a specific company. For 
instance, if you want to use a green font for the report title only when working in 
the Demo Company, which is our current company environment, use the 
Company-Specific Color Definitn sub-level form to set the RGB definitions used 
in this company. 
When you finish defining the desired color scheme, run the Create HTML Pages 
for Documents program in order to implement your changes in all document 
templates (e.g., price quotations, sales orders). 
Change the Font Used for Printouts (10:20-11:46) 
You can also change the font face and size, if desired. By default, all system 
documents and reports are defined with the Font Arial and the Size 2 (other than 
the "Report Title" section, which should hav
e a Size of 3). 
To change the font definitions for the body of all system reports or documents, 
enter the Font and Color Defaults form and move to the row for Line. Place the 
cursor in the Font Name column and press F6 twice to enter the Font Definitions 
form and make the desired changes to the font face and size. 
You can also set special font definitions for a specific company in the Company-
Specific Font Definition sub-level form. For instance, let's use the Verdana 
font for any reports and documents generated for the International Demo 
Company, which is our current company environment. 
Press Esc to return to the Font Definitions form, and then press Esc again to 
return to the Font and Color Defaults form. And now we'll move to the line for 
Line2 and repeat the procedure for this report element as well. 
This concludes our explanation of report and document design in Priority. 
Related Documentation 
 User Interface Guide 
Cat.No. LB120104  Ver.2 – July 22,’12 3

Cat.No. LB120104  Ver.2 – July 22,’12 4
 Printing Wizard
