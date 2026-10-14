# Bartender Labels Users Rich Guide

- **Source:** `Bartender Labels Users Rich Guide.docx`

Using BarTender with Priority

Medatech UK

Create a Labels directory under System Folder on Priority

Create a Tab delimited txt file to be used as the database format

Save this file in System directory on Priority

In Priority

Inventory > Label Printing > Choose Label Printing Program

Run the “Choose Label Printing Program” to set the label printing program to be used as BarTender.

Design a label using external variables as per “In BarTender” below. Priority details will appear in variables 1 – 20.

NOTE: In bartender, define the 21st variable as the quantity of labels variable and the file format as Tab delimited as above.

Save the label in a file and record its name in the Label Definitions form.

Inventory > Label Printing > Label Definitions

Always create a new label definition, with the appropriate BarTender file associated with it.

Run one of the programs that loads the work area, In the Label Preparation Work Area form, check that the labels are loaded correctly.

In a Windows (client-server) environment: at the end of the tabula.ini file (located in the Windows Directory), add the following:

[Labels]

Application=c:\Program Files\BarTender\Bartend.exe

The application path above (in red) may need to be modified to point to the location of your local BarTender installation.

Inventory > Label Printing > Label Generator

Within the “Label Generator” form, you will then need to specify the form name and type of label to be printed as defined within the “Label Definitions” form above.

The sublevel of this form is used to match the form column to the variable. In the example above, the ‘Received Items’ sub-form of the ‘Goods Receiving Voucher’ has been specified. This is set to print a label per receipted line and display the GRV number on the label.

In Bartender

Create a Label Format

Select Printer

This will provide a label format

Setup Database connection

Select Text File

Select Text file created earlier

Design Label

Link Quantity of labels to print to Priority database

Select Printer Icon, click “Identical Copies of Label” Options Box

Select “Set by Data Source” – Data Source Tab becomes enabled

Change Source to Database Field

Select Field that contains the data

OK then Close

Design Label by drag and drop of fields, adding text where necessary
