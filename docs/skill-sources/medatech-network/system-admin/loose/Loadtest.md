# Loadtest

- **Source:** `Loadtest.docx`

Shell Testing

Shell Num: 2611

Programmer: Yosi

Preceding shell/s: 2606

Scope

Create load form interface for unloading the Sales Opportunity data from the financial company. The interface will be used to copy the sales opportunity data from the financial company to a file.

Create load form interface for loading the data from the financial company to the logistics company. The interface will be used to put the sales opportunity data from the file created by the previous interface into the logistics company.

The original Sales Opportunity number from the financial company will be entered in a new field called Orig Sale Opp # which will be added on to the Sales Opportunity form.

Test Cases

Setup

In the financial company:

Create a customer group making sure to link the customer group to a company in the customer groups form.

Create a customer

Assign the customer group to the customer

Add a customer contact

Create a sales rep

Put the sales rep against the customer

Select a VAT/Tax ID Number against the customer. Add one if there is not one to choose.

Create a part in the part catalogue

Create a second customer (this will be your “end customer”). You can use the same customer group and sales rep as before to assign against it.

Create a contact for this customer

Enter the BPM flow chart for customers and create a new status which in the properties should have “end customer” flagged.

Assign this status to the end customer

Create a sales opportunity for the customer in the financial company using the first customer you set up in it as the customer.

-Use the sales rep which you set up as the rep

-Use the contact which you set up for your first customer as the contact

-Use the second customer (end customer) as the end customer number

-Use the contact from the second customer as the end customer contact

-Use the part which you set up as the part no. in the Parts in Sales Opportunity sub form

Make sure that the following fields are filled out:

- Sales opportunity form:

Sales Oppor. No.

Customer Number

Status

Contact

Sales Rep Number

Curr

Date Opened

Projected PO Date

Projected Ship Date

Details

End Cust-Number

End Cust-Contact

- Part in sales opportunity sub form

Part Number

Qty

Unit Price

Part Description

Projected Revenue

Discount %

-Remarks sub form

Please ensure that there is a discount amount filled in and that there is some text in the remarks sub form.

In the logistics company:

Create a customer group with the same code and name as the one created in the financial company and then link this in the customer groups form to the same company that you linked the financial company’s customer group to.

Create a customer which has the same customer number and name as the one you created in the financial company.

Assign the customer group to the customer on the customer form.

Add a customer contact to the customer making sure the customer contact has the same name and details as the one added to the customer in the financial company.

Create a sales rep with the same code and name as the one created in financial company.

Assign the sales rep against the customer

Select the same VAT/Tax ID Number against the customer as you did on the financial company customer. Add it if it is not there to choose.

Create a part which has the same part number as the one set up in the financial company.

Create a second customer (end customer) with the same number and name as the one set up in the financial company. Use the same sales rep and cust group as in the financial company.

Set up a new status exactly the same as the one set up in the financial company for end customers. Make sure it has the same name and same items flagged in the properties as the one set up in the financial company. Including “end customer” flagged.

Assign this status to the end customer.

Create a sales opportunity for the customer in the financial company using the first customer you set up in it as the customer.

-Use the sales rep which you set up as the rep

-Use the contact which you set up for your first customer as the contact

-Use the second customer (end customer) as the end customer number

-Use the contact from the second customer as the end customer contact

-Use the part which you set up as the part no. in the Parts in Sales Opportunity sub form

Make sure that the following fields are filled out:

- Sales opportunity form:

Sales Oppor. No.

Customer Number

Status

Contact

Sales Rep Number

Curr

Date Opened

Projected PO Date

Projected Ship Date

Details

End Cust-Number

End Cust-Contact

- Part in sales opportunity sub form

Part Number

Qty

Unit Price

Part Description

Projected Revenue

Discount %

-Remarks sub form

Please ensure that there is a discount amount filled in and that there is some text in the remarks sub form.

Setup 1

Testing

Financial Company: Inc. (dwi)

Logistic Company: Luxemburg (dwisarl)

In the financial company, enter "Form Load Designer" form and retrieve " SO Opp data migration - Download " interface

Screenshot of interface in form load designer

Run "Run Interface" DA

Choose "Download"

Choose ANSI

In the opened form query for the Sales op you just created and then leave the form.

Picture of form where you choose

Results

A message is received

Picture of x lines downloaded msg

A text file named " SO_Opp_Data_Migration.txt " is created under the financial company folder:  …\Priority\system\load\dwi

Pic of txt file name in form load

Pic of text file in explorer

Copy the file to the logistics company folder

Switch to a logistics company

Enter "Form Load Designer" form and retrieve " SO Opp data migration - Load " interface

Screenshot of interface in form load designer

Choose load

Results

A message is received

Pic of successful message

Check in Sales op form in logistics to see if data loaded. Compare the records loaded with the records which were downloaded from.

Check Sales Oppor. Number from financial company is now in the Orig sales opp # field in the logistics company.

Check customer number on the sales op matches in financial and logistics

Check status on the sales op matches in financial and logistics

Check contact on the sales op matches in financial and logistics

Check sales rep number on the sales op matches in financial and logistics

Check curr on the sales op matches in financial and logistics

Check date opened on the sales op matches in financial and logistics

Check projected PO date on the sales op matches in financial and logistics

Check projected ship date on the sales op matches in financial and logistics

Check details on the sales op matches in financial and logistics

Check end customer number on the sales op matches in financial and logistics

Check end customer contact on the sales op matches in financial and logistics

Check part number on the sales op parts matches in financial and logistics

Check qty on the sales op parts matches in financial and logistics

Check unit price on the sales op parts matches in financial and logistics

Check part description on the sales op parts matches in financial and logistics

Check projected revenue on the sales op parts matches in financial and logistics

Check discount on the sales op parts matches in financial and logistics

Check remarks on the sales op matches in financial and logistics

Ticket Num.: 114562 | Revision: | 1.0.0 | Date of issue: | 

Server | System | Company

Test 6 | Priority | Inc.- financial company Luxemburg- logistic company

Name of the Tester | Date | Results

Cherry Mallam | 18/06/15 |
