# customer_portal_setup_guide

- **Source:** `customer_portal_setup_guide.docx`

Setting Up a User on the Portal

Project Form Checks:

Project > Projects

Check that the Customer has a project ticked as portal default in the Misc. tab of the Projects form.

If there is no Project marked as “Portal Default?” then an existing one must be ticked, or a new Project created.

Service Contract Form Checks:

Service > Service Contracts > Service Contracts

Check that the Customer has a service contract ticked as portal default in the Misc. tab of the Projects form.

If there is no Service Contract marked as “Portal Default?” then an existing one must be ticked, or a new Contract created.

Customer Contact Subform Checks:

CRM > Customers > Customers

Customer must have a contact ticked as “Approved Service Call Contact” in the  customer contacts subform.

All contacts who have this tickbox marked will then be selectable in the contact field on the customer portal for any service calls raised for this particular customer.

Customer Portal Users form setup:

CRM > Customer Portal > Customer Portal Users

Create a new entry on the Customer Portals Users form.

Select the Customer Number from the drop down.

Create a User Name in the User Name field, the username should be the email address we have on record for the contact who will make use of the customer portal account being created.

Link to a Contact in the Contact field by using the drop-down
NOTE: If you receive “Specified Item not in database” error when linking the contact, F6 into the contacts form and ensure the “Company” field is filled out with exactly the same as the “Associated with customer” name.

Tick Generate Password.

A password will be generated. This is to be provided to the user to allow them to log in for the first time.

Tick as Active.

Provide the user with their credentials and direct them to go to: https://priority.medatecherp.co.uk/customer_portal/#/login

After they user logs in to the customer portal for the first time, they will be prompted to change their password.

Example email:

Hi [ENTER NAME],

You have been granted access to use the Medatech Customer Portal.  You can retrieve the login credentials for the account that has been set up for you on the below link, which will expire after one use:

[ENTER OTP LINK]

Please go to: https://priority.medatecherp.co.uk/customer_portal/#/login and use the credentials provided to login for the first time, after which you will be prompted to change your password.

The attached help doc provides details on how to raise and manage service calls on the Medatech Customer Portal.

Alternative Setup Method:

Customers can manually create their accounts by selecting the “Sign Up” option on the Customer Portal. To complete the process, they will need to provide their Customer Number and Customer Code to verify their company. These details will be provided by Medatech.

CRM > Customers > Customers

The recommended code format is as follows:

The initials of the customer’s company name, followed by the non-zero digits of their customer number:

e.g. 
Customer Name: Advanced Construction Mechanical Engineering Inc
Customer Number: C00012

Becomes Company Code: ACME12
