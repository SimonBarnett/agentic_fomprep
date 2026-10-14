# 13-17-Interfacing with WorldShip

- **Source:** `13-17-Interfacing with WorldShip.pdf`

www.priority -software.com   
1/10 Feb. 09,'15 Ver. 03 Cat.No. A8000569 
 
 SOP: Interfacing with WorldShip 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
The interface between Priority and WorldShip enables the automatic transmission of data related to 
customer shipments via UPS. Files are generated based on data from shipping documents and/or 
sales invoices in Priority, and transferred automatically to the shipping company via the WorldShip 
software you have installed. The interface also enables you to receive the shipment’s tracking 
number and shipping price from UPS and integrate these data directly into the shipping 
document/sales invoice in Priority. 
This document describes the setups required to work with the interface, as well as the operations 
performed in order to transfer data. 
Setups 
 Ensure that you have received and installed the license for Priority’s EDI for Shippers module. 
 Ensure that your company is registered as a customer of UPS and you have a UPS shipping 
account number. 
 Install WorldShip version 10 to C:\ups on the workstation you will use to run this interface. 
Procedure 
Stage I: Creating a Data Source (ODBC) 
1. Create the following directory: C:\ups\wstd\impexp\priority. 
2. Navigate to Start > Settings > Control Panel > Administrative Tools > Data Sources 
(ODBC). 
3. In the System DSN tab, click Add… and select Microsoft Text Driver (*.txt, *.csv). Click 
Finish. 
4. In the Data Source Name field, enter PriMap, and in the Description field, enter a brief 
description. 
5. Remove the check mark from the Use Current Directory column. 
Click Select Directory… and select the following directory: C:\ups\wstd\impexp\priority. 
Stage II: Copying Map Files to the Directory 
1. Navigate to the ..\..\priority\bin.95 directory. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/10 Feb. 09,'15 Ver. 03 Cat.No. A8000569 
 
2. Copy the PriImport.dat and PriExport.dat files to C:\ups\wstd\impexp\shipment, and copy the 
schema.ini file to C:\ups\wstd\impexp\priority. 
Note: To create map files yourself, see Appendix A. 
Stage III: Recording Data Definitions and Parameters 
Aim: To record preliminary definitions in Priority and WorldShip, which must be set before running 
the outgoing interface from Priority to WorldShip. 
1. Enter the Drivers/Shippers form. Define a record for UPS, in which the value in the 
Shipper/Driver No. column is “UPS”. 
2. In the Packing Crate Codes form, define packing crates, including Weight, Length, Width, and 
Height. These data will be transferred to WorldShip when the interface is run, and serve as a 
basis for shipping prices. 
3. If there are customers whose UPS account should be billed for delivery costs, record the 
customer account data in the Accounts at Shippers form (a sub-level of Customers) under the 
record for UPS. 
4. In the Customers form, and the Customer Sites sub-level, record a Street Address for the 
customer/customer sites. This data will be transmitted automatically via the outgoing interface. 
Missing data will need to be recorded manually in WorldShip. 
5. If you would like a file containing the shipment’s tracking number and cost to be created 
automatically after data is imported into WorldShip, define the following parameters in 
WorldShip: 
 From the Import/Export Data menu, select Automatic export after processing shipment. 
 Select the PriExport map. 
Stage IV: Running an Outgoing Interface from Priority to WorldShip 
Aim: To create a data file from a shipping document/sales invoice for importing to WorldShip. 
1. In the shipping document/sales invoice, select “UPS” in the Shipper/Driver No. column. 
2. When you finish recording the shipping document/sales invoice, change the document’s status 
to one that is flagged for Shipping. 
3. Select Create Shipping Order from the list of Direct Activations, and define the following 
parameters in the program’s input screen: 
 Path for Files – enter C:\ups\wstd\impexp\priority 
 Type of Service 
 Type of Package 
Result: 
 Two files are created: shipment.csv and package.csv . 
Note: For an explanation of transmitted fields, see Appendix B. For sample files, see Appendix C. 
Stage V: Importing Data into WorldShip and Assigning a Tracking Number 
Aim: To import shipping data from the files created in the previous stage into WorldShip, and 
receive a UPS tracking number. 
1. In WorldShip, click the Import/Export Data menu, and select Batch Import… using the 
PriImport map.

www.priority -software.com   
3/10 Feb. 09,'15 Ver. 03 Cat.No. A8000569 
 
2. Click Next twice. A message appears, displaying the number of records imported. 
3. Click Save. The records are saved to History, in the Imported Shipments folder. 
4. Click Edit to enter the imported record. Revise the data as necessary. 
To assign a tracking number, click Process Shipment (F10). 
Stage VI: Importing the Tracking Number and Shipping Price from WorldShip 
to Priority 
Aim: To update the shipping document/sales invoice with the tracking number and shipping price 
generated in WorldShip. 
Note: If the customer’s account was charged by WorldShip, the shipping price will not be imported. 
1. Locate the data file with the tracking number and shipping price: 
 If you chose Automatic export after processing shipment when recording preliminary 
definitions in WorldShip, this file was generated when you clicked Process Shipment (F10) 
in the previous stage.  
 If you did not choose automatic export, you need to generate the file manually in WorldShip. 
From the Import/Export Data menu, select Batch Export… and choose the PriExport 
map. 
The file in question is named ups_csv_export.csv and is located in the 
C:\ups\wstd\impexp\priority directory. 
2. In Priority, retrieve the relevant shipping document/sales invoice and select Update Tracking 
Number from the list of Direct Activations. In the input stage, browse for the File 
C:\ups\wstd\impexp\priority\ups_csv_export.csv. 
If you would like to automatically add a line to the itemized shipping document/sales invoice with 
the shipping price, flag the Upd Shipping Price column. 
Note: If the shipping document is based on packing crates, the shipping price will be added to 
the shipping document but the tracking numbers will be recorded in the packing slips. 
Result: 
 The Tracking Number column is updated, and a line is added to the itemized shipping 
document/sales invoice with the predefined “Shipping” part number, the quantity “1”, and the 
imported shipping price. 
Note: For an explanation of transmitted fields, see Appendix B. For sample files, see Appendix C. 
Result 
 The shipping document/sales invoice is updated with the tracking number assigned by the 
shipping company. This number will be displayed on printouts of the document, thereby 
facilitating tracking of your shipment with UPS.

www.priority -software.com   
4/10 Feb. 09,'15 Ver. 03 Cat.No. A8000569 
 
Appendix A: Mapping Information 
This appendix may be used to define import/export maps yourself. 
PriExport: 
UPS WorldShip - Import/Export Data Report 
Map Name: PriExport 
Data Source Information: 
 DSN Name: 
  UPS WorldShip CSV Export 
 DSN Description: 
   
 ODBC Driver Name: 
  Microsoft Text Driver (*.txt; *.csv) 
 ODBC Driver: 
  C:\WINDOWS\system32\odbcjt32.dll 
 Database Name: 
   
 Database Path: 
  C:\ups\wstd\impexp 
 Database Server: 
Map Information: 
 Map Type: 
  Shipment 
 Map Version: 
  1013 
 Primary Table: 
   
 Primary Key: 
   
 Package Name: 
   
 Prompt for Table Name: 
  No 
Field Mappings: 
 WorldShip Field (Container::Field) 
  ODBC Data Source Field (Table::Field) 
 Shipment Information::Total Shipment and Handling Charges

www.priority -software.com   
5/10 Feb. 09,'15 Ver. 03 Cat.No. A8000569 
 
 upsxport.csv::ShipmentInformationTotalShipmentandHandlingReferenceCharges 
 Package::Tracking Number 
  upsxport.csv::PackageTrackingNumber 
 Package::Reference 5 
  upsxport.csv::PackageReference5 
 Shipment Information::Bill Transportation To 
  upsxport.csv::ShipmentInformationBillTransportationTo 
 
PriImport: 
UPS WorldShip - Import/Export Data Report 
Map Name: PriImport 
Data Source Information: 
 DSN Name: 
  PriMap 
 DSN Description: 
  PriMap 
 ODBC Driver Name: 
  Microsoft Text Driver (*.txt; *.csv) 
 ODBC Driver: 
  C:\WINDOWS\system32\odbcjt32.dll 
 Database Name: 
   
 Database Path: 
  C:\ups\wstd\impexp\priority 
 Database Server: 
   
Map Information: 
 Map Type: 
  Shipment 
 Map Version: 
  1013 
 Primary Table: 
  shipment.csv 
 Primary Key: 
  KEY1 
 Package Name:

www.priority -software.com   
6/10 Feb. 09,'15 Ver. 03 Cat.No. A8000569 
 
   
 Prompt for Table Name: 
  No 
Field Mappings: 
 ODBC Data Source Field (Table::Field) 
  WorldShip Field (Container::Field) 
 package.csv::PACKAGE_REFERENCE5 
  Package::Reference 5 
 package.csv::PACKAGE_WIDTH 
  Package::Width 
 shipment.csv::SHIPTO_ZIPCODE 
  Ship To::Postal Code 
 shipment.csv::SHIPTO_STATE 
  Ship To::State/Province/County 
 shipment.csv::SHIPTO_RECEIVERSUPSACCOUNTNUMBER 
  Ship To::Receiver UPS Account Number 
 shipment.csv::SHIPTO_COMPANYORNAME 
  Ship To::Company or Name 
 shipment.csv::SHIPTO_ATTENTION 
  Ship To::Attention 
 shipment.csv::SHIPTO_ADDRESS1 
  Ship To::Address 1 
 shipment.csv::SHIPMENTINFORMATION_DESCRIPTIONOFGOODS 
  Shipment Information::Description of Goods 
 shipment.csv::SHIPMENTINFORMATION_SERVICETYPE 
  Shipment Information::Service Type 
 shipment.csv::SHIPTO_ADDRESS2 
  Ship To::Address 2 
 shipment.csv::SHIPTO_TELEPHONE 
  Ship To::Telephone 
 shipment.csv::SHIPTO_EMAIL 
  Ship To::Email Address 
 package.csv::PACKAGE_PACKAGETYPE 
  Package::Package Type 
 shipment.csv::SHIPMENTINFORMATION_BILLTRANSPORTATIONTO 
  Shipment Information::Bill Transportation To 
 shipment.csv::SHIPTO_CITY

www.priority -software.com   
7/10 Feb. 09,'15 Ver. 03 Cat.No. A8000569 
 
  Ship To::City or Town 
 shipment.csv::SHIPTO_COUNTRY 
  Ship To::Country/Territory 
 shipment.csv::SHIPTO_FAX 
  Ship To::Fax Number 
 package.csv::PACKAGE_HEIGHT 
  Package::Height 
 shipment.csv::SHIPMENTINFORMATION_BILLINGOPTION 
  Shipment Information::Billing Option 
 package.csv::PACKAGE_LENGTH 
  Package::Length 
 package.csv::PACKAGE_WEIGHT 
  Package::Weight 
 package.csv::PACKAGE_REFERENCE1 
  Package::Reference 2

www.priority -software.com   
8/10 Feb. 09,'15 Ver. 03 Cat.No. A8000569 
 
Appendix B: Fields Transmitted via the Priority-WorldShip Interface 
Fields Transmitted from the Outgoing Interface 
 ShipmentInformation_ServiceType 
 ShipmentInformation_BillTransportationTo – If a UPS account is defined for the customer in 
the Accounts at Shippers sub-level of the Customers form, this account will be charged for 
shipment. Otherwise, the shipper will be charged. 
 ShipmentInformation_DescriptionOfGoods  – The field to which data from the Details field in 
the upper-level form of the shipping document/sales invoice are transferred. 
 ShipTo_CompanyOrName 
 ShipTo_Attention 
 ShipTo_Address1 
 ShipTo_Address2 
 ShipTo_City 
 ShipTo_State 
 ShipTo_Country 
 ShipTo_ZipCode 
 ShipTo_Telephone 
 ShipTo_Fax 
 ShipTo_Email 
 ShipTo_ReceiversUPSAccountNumber 
 Package_PackageType 
 Package_Weight 
 Package_Reference2  – The customer’s purchase order number. 
 Package_Reference5  – For internal use (enables you to later identify the document in Priority 
in order to update data). 
 Package_Height 
 Package_Width 
 Package_Length 
Note: If the shipping document is based on packing crates, crate data (fields beginning Package_) 
will be taken from the crates. Otherwise, these data will be taken from the shipping document/sales 
invoice.

www.priority -software.com   
9/10 Feb. 09,'15 Ver. 03 Cat.No. A8000569 
 
Fields Transmitted to the Incoming Interface 
 Total shipping price – A line is added to the itemized shipping document/sales invoice with the 
Part Number “Shipping” and the shipping price. 
This data is taken from the 
ShipmentInformationTotalShipmentandHandlingReferenceCharges field in WorldShip. 
Note: If the customer’s account was charged by WorldShip, the price will not be imported into 
the shipping document/sales invoice, even if Upd Shipping Price was flagged during input. 
 Tracking Number – If the shipping document/sales invoice are based on packing crates, the 
tracking number of each crate will be updated. Otherwise, this data will be updated in the 
shipping document/sales invoice.

www.priority -software.com   
10/10 Feb. 09,'15 Ver. 03 Cat.No. A8000569 
 
Appendix C: Sample Files 
shipment.csv 
Key1,ShipmentInformation_ServiceType,ShipmentInformation_BillingOption,ShipmentInformation_B
illTransportationTo,ShipTo_CompanyOrName,ShipTo_Attention,ShipTo_Address1,ShipTo_Address
2,ShipTo_City,ShipTo_State,ShipTo_Country,ShipTo_ZipCode,ShipTo_Telephone,ShipTo_Fax,Shi
pTo_Email,ShipTo_ReceiversUPSAccountNumber 
I13510,Ground,PP,Shipper, ORT,,Hameyasdim 2,,Los Angeles,CA,United States,90001,(323) 111-
2222,(323) 111-2333,avia@eshbel.com, 
package.csv 
Key1,Package_PackageType,Package_Weight,Package_Reference1,Package_Reference5,Packa
ge_Height,Package_Width,Package_Length 
I13510,Package,0.00,,I13510,0.00,0.00,0.00 
ups_csv_export.csv 
"21.02","0 Z9WX4860376556559","P11717","Shipper" 
"21.02","0 Z9WX4860375745365","P11718","Shipper"
