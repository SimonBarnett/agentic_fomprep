# EDI PO to SO data transfer

- **Source:** `EDI PO to SO data transfer.docx`

EDI PO to SO data transfer:

Set up 2 Companies (on same installation or different servers)

Company A – sending data (open Purchase Orders to open Sales Orders)

Company B – receiving data (open Sales Orders based on Purchase Orders open in company A)

Define email address in Company Data form for each company

Company A – companya@mail.com

Company B – companyb@mail.com

In Company B:

Create a Customer with email address of the company which will send information through

Customer B - companya@mail.com

Create a Vendor with email address of the company which will send information through

Vendor B - companya@mail.com

In Company A:

Create a Vendor with email address of the company to which data will be sent

Vendor A –  companyb@mail.com

Create a Customer with email address of the company to which data will be sent

Customer A - companyb@mail.com
