# 12-17-Setting Up Customer Service

- **Source:** `12-17-Setting Up Customer Service.pdf`

www.priority -software.com   
1/5 ‏Feb 05, '15 Ver.02 Cat.No. A8000100 
 
 SOP: Setting Up Customer Service 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To set up the Customer Service module. 
Procedure 
Stage I: Defining Work Hours and Travel Time 
Defining a work hour part 
1. Enter the Part Catalogue form. 
2. Record a Part Number and Description. 
3. Click the Details tab. 
4. In the Family column, select the pre-defined part family for work hours. 
Note: To define additional work hour part families, use the Part Families form. Make sure to flag 
the Work Hours column. 
5. Click the Additional Details tab. 
6. Select R in the Type column. 
7. Remove the check mark from the Inv. Control column. 
8. Select the value "ea" in the Buy/Sell Unit and Factory Unit columns. 
9. Click the Prices & Costs tab. 
10. In the List Price column, record the price and currency of a single work hour. 
Note: To define different work hour prices for different customers, leave this column empty, and 
define the price in the various customer price lists. 
Assigning a work hour to an employee 
1. Enter the Personnel File form and retrieve the desired employee. 
2. Enter the Company-Specific Information sub-level form. 
3. Click the Details tab. 
4. Specify the defined Work Hr. Part.  
Result: The assigned work hour part will serve as the default in any customer bills for labor 
performed by this employee (e.g., service calls). 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/5 ‏Feb 05, '15 Ver.02 Cat.No. A8000100 
 
Defining the cost of travel time 
1. Enter the Part Catalogue form and retrieve the part "Miles to Charge." 
Note: In the dual-currency package, the part is called "Kilometers to Charge." 
2. Click the Prices & Costs tab. 
3. In the List Price column, record the price for traveling a single mile (or kilometer). 
Defining default travel costs per customer 
1. Enter the Financial Parameters for Customers form and retrieve the desired customer. 
2. Click the Charges tab. 
3. Fill in the Miles to Charge (dual-currency: Kms to Charge) and Travel Time to Charge 
columns. 
Note: For customers with multiple sites, you can define different values for each site in the 
Customer Sites sub-level of the Customers form. 
Result: Assuming you have reached an agreement with the customer as to the number of miles (or 
kilometers) and work hours the customer will be charged for each service call, Priority will use the 
details defined above whenever travel expenses are not covered by a part warranty or service 
contract. 
Stage II: Service Terms and Warranties 
Service terms 
Priority provides two pre-defined service terms: Full Payment and Project. 
To define additional service terms: 
1. Enter the Service Terms form.  
2. On a new line, record a Code and Description of Terms. 
3. To link a part to the current service terms, specify the part in the Part No. for Invoice column.  
Result: The defined part will appear in invoices opened automatically for service contracts 
assigned these service terms. 
To link part families to service terms: 
1. In the Service Terms form, move to the desired code.  
2. Enter the Conditions of Service Terms sub-level form and select each Family to which the 
current service terms apply.  
3. If the family is to be billed, flag the Billable column. Otherwise, select the appropriate Billing 
Exempt Type (see below). 
To define warranty types: 
1. Enter the Warranty Codes form. 
2. Record a Warranty Code and Description. 
3. Specify the duration of the first warranty period in the First Period (Mos.) column, and the 
relevant Service Terms (Code). If necessary, define these values for a second warranty period.

www.priority -software.com   
3/5 ‏Feb 05, '15 Ver.02 Cat.No. A8000100 
 
Billing exemptions 
When recording a service call, you can specify a billing exemption type that explains why a 
particular replacement part or work hour is not being billed. The system provides two pre-defined 
exemption types: Manufact'r Warranty and Servicing Paymt. 
To define billing exemptions: 
1. Enter the Types of Billing Exemptions form. 
2. On a new line, record the description of each Billing Exempt Type.  
Stage III: Initializing Parts for Service 
1. Enter the Service Parameters for Part form and retrieve the desired part. 
2. If the part is serialized, flag the Maintain Serial Nos column.  
3. In the Warranty Code column, specify the type of warranty usually given for this part. 
4. In the Maximum Repair Price column, specify the maximum price the customer can be charged 
without explicit authorization. This value will serve as the default in all new service calls opened 
for this part. 
5. In order to base the price of a service contract on a percentage of the part's unit price, specify 
the percentage in the Prorate Charge (%) column. 
6. If the part serves as a replacement part (e.g., a part covered by a manufacturer warranty or a 
very valuable part) and you are interested in monitoring its return to the company during the 
servicing process, flag the Replacement Part column. 
7. In the Mandatory Resp. Time column, specify the maximum permissible time lapse between 
the start time agreed in the service call and the actual start time. 
Stage IV: Service Contracts 
Defining the InvContPart constant 
This constant determines which part appears in invoices opened automatically for service contracts. 
1. Enter the Financial Constants form and move to the InvContPart constant. 
2. Do one of the following: 
 Leave the pre-set value of 0 to use the standard "Contract Paymnt" part. 
 Change the value to 1 to use the part number in the first line item of the service contract. 
 Change the constant to 2 to use the part number defined for the service terms assigned to the 
contract. 
Defining the default payment frequency for service contracts 
 Enter the Payment Frequency Options form and flag the Default Option column for the desired 
option. 
Result: The system will automatically calculate service contract payments according to the defined 
option. 
Defining the payment date option 
1. Enter the Logistic Constants form and move to the CContPayPrd constant. 
2. Change the value to 0.

www.priority -software.com   
4/5 ‏Feb 05, '15 Ver.02 Cat.No. A8000100 
 
Note: You can change the option for each specific contract in the Service Contracts form, by 
flagging the Set Pay Date column. 
Defining set text for service contracts 
 Enter the Set Text for Service Contracts form and record the desired text in the Set Text for 
Service Contracts sub-level form. 
Stage V: Defining Technicians 
Defining an employee as a technician 
1. Enter the Personnel File form and retrieve the desired employee. 
2. Click the Definitions tab and flag the Service Provider column. 
3. Enter the Company-Specific Information sub-level form and specify the relevant Skill. 
Note: You can define additional skills in the Skills form. 
4. If necessary, fill in the following details: 
 the type of work hour in the Work Hr. Part column 
 the default warehouse for replacement parts used by this employee in the Warehouse 
column. 
Defining technician groups 
1. Enter the Groups form and record a Group Name and Description of Group. 
2. Enter the Users in Group sub-level form and list the technicians in the group. 
Defining service zones 
1. Enter the Shipping Zones form. For each zone, record a Zone Code and Zone Description. 
2. Enter the Customers form and assign a Shipping Zone to each customer (in the Shipments 
tab). 
Result: The system will use this information to schedule service calls. 
Assigning technicians to service calls per part family 
1. Enter the Personnel File form and retrieve the desired employee. 
2. Enter the Company-Specific Information sub-level form. 
3. To restrict the technician to the repair of parts in specific part families, flag the Service for Fams 
Only column. 
4. Enter the Families Serviced by Technician sub-level and specify the part families for which the 
technician is responsible. 
Assigning technicians to service calls per customer 
1. Enter the Customers form and retrieve the desired customer. 
2. Enter the Additional Customer Data sub-level form. 
3. Select the technician in the Technician in Charge column. 
Assigning technicians to service calls per zone 
 Enter the Shipping Zones form. For each zone, specify the Technician in Charge.

www.priority -software.com   
5/5 ‏Feb 05, '15 Ver.02 Cat.No. A8000100 
 
Stage VI: Service Call Definitions 
Defining service call types 
 Enter the Types of Service Calls form and record a description for each Call Type. 
Defining malfunction types 
1. Enter the Malfunction Codes form. For each malfunction type, record a Malfunction Code and 
Malf. Description. 
2. Enter the Families With This Malfunct Type sub-level form and specify the part families for 
which the type is relevant. 
Defining problem types 
A problem differs from a malfunction in that a malfunction is defined by a technician and a problem 
is defined by the customer. 
 Enter the Problem Codes form. Record a Code for each problem type, and describe it in the 
Problem column. 
Defining resolution types 
 Enter the Resolution Codes form. Record a Resolution Code for each resolution type, and 
describe it in the Resolution column. 
Assist time vs. repair time 
By default, service calls that require less than an hour are called "assists," whereas longer calls are 
called "repairs." This cut-off time determines whether a service call will appear in the Mean Time to 
Repair (MTTR) report or in the Mean Time to Assist (MTTA) report. 
To change the cut-off time between assists and repairs: 
 Enter the Logistic Constants form and change the value of the CAssistTime constant.
