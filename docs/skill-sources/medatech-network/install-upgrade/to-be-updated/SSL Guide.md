# SSL Guide

- **Source:** `SSL Guide.docx`

Ordering SSL Certificates

SSL24 Portal

For ordering SSL certificates we use SSL24, https://myssl.ssl247.co.uk

The login details can be found in Vendor Remarks in Priroity.

When you log in to the portal you will see the following home screen:

Renewing Certificates

Process:

Determine which certificates need to renewed. Section “Reviewing Expiring Certificates”.

Determine whether a quote needs to be created for the customer. Section “Is a Quote Required to be Created?”

Carry out either section “Raise Service Call for Customer” or “Raise Quote for Customer”.

Carry out section “Renewing a Certificate”.

Carry out section “Installing the SSL Certificate” once certificate provided by SSL247.

Creating a new Certificate

Determine whether a quote needs to be created for the customer. Section “Is a Quote Required to be Created?”

Carry out section “Determine URL and Email”

Carry out section “Ordering a New Certificate”

Carry out section “Installing the SSL Certificate” once certificate provided by SSL247.

Is a Quote Required to be created?

Existing Customers

If the customer has silver or gold maintenance, then one SSL certificate is included (for live normally).

If the customer has standard maintenance, navigate to Service > Service Contracts. Select the sub form Payment Instalments

Select the most recent maintenance invoice and drop down to items covered by Instalment. Look for an SSL entry like below.

If there is a record then no quote is needed for the customer. If there is not a record, then go to section “Raise Quote for Customer”. Otherwise go to section “Raise Service Call for Customer”.

Notes: Some customers have more that one contract. Remember to check both.

Note: If the SSL is for a test server, this will normally be a second SSL. Check the payment Installments as above and look for a second record. If there is not one, then a quote will be required.

New Customers

For new customers, no quote or service call is required. A Sales Order will already exist. Raise a Purchase Order and specify the Sales Order on it. If a warning message is displayed that the order is already linked to another purchase order, click ok to continue. Specify the Customer for license field.

Click on the order items and all the Sales Order lines will be copied to the purchase order.

Delete all lines except the SSL line.

If the SSL line is not for product “SSL Cert (Ext)1”, delete this line and add a new line for product “SSL Cert (Ext)1”.

Change the “Auth.List Code” to “00” and change status to “Begin Auth.”

Wait for the purchase order to be authorised.

Return to process steps

Raise Service Call for Customer

Open a support Service Call to manage the renewal. See SC220547 as example.

Raise a Purchase Order to SSL247 and in the references tab, enter the service call number.

In order item remarks please include the information about sub-domain and authoriser email. Please see example below.

Change the “Auth.List Code” to “00” and change status to “Begin Auth.”

Set status on PO to “Begin Auth”.

Wait for the purchase order to be authorised.

Return to process steps

Raise Quote for Customer

Raise a Customer Price Quotation. The quote needs to include line for the SSL certificate and a line for installation time. Please see the example below except put the URL in the description of the SSL line.

When the quote is authorised please send it to the customer and ask for a PO in return if they accept the quote.

When the PO is received from the customer, convert the Price Quotation to Sales Order and attach the PO.

Raise a Purchase Order to SSL247 and in the references tab, enter the sales order number.

This will copy the sales order lines. Remove the installaton line as this is not needed on the PO to SSL247.

In the order item remarks please include the information about sub-domain and authoriser email. Please see example below.

Change the “Auth.List Code” to “00” and change status to “Begin Auth.”

Wait for the purchase order to be authorised.

Return to process steps.

Reviewing Expiring Certificates

In the SSL247 portal, click My SSL Certificates on the left hand side panel. Then click on “Expiring”.

The list of certificates that will expire over the coming months will be displayed. Click on the “Expires” heading to order the list to see the ones due to expire soonest.

Click the green eye icon to display details about a certificate.

In the details you can see the relevant information. For the certificate you are planning to renew, note down the “Approver email” as well as the CN, O, OU, L, S, and C fields in the Decoded CSR, as these will be needed to renew a certificate.

Renewing a Certificate

Before renewing a certificate in SSL247, carry out the steps in “Create CSR on IIS Server”.

To renew a certificate shown in the Expiring Certificates list, click the Green button with a white circle and dot, next to the green eye icon.

The following screen is displayed:

Change the product to Sectigo DV SSL

Click “Renew by paying online”. The following will be displayed:

Enter the Purchase Order number created in either section “Raise Service Call for Customer” or “Raise Quote for Customer” in the reference field and click “Complete Order”.

This takes you too a new screen offering you the option to pay online.

Go into to My SSL Certificates and take the Stock option.

The certificates that have been ordered are shown in here.

Click the green Icon.

In the “Your order refence” field, enter the PO number again.

Change the “DV Authorisation Method” to be “Approver Email”. The screen will change to show a drop down where you can select an email.

Select the email that matches what you recorded in the section “Reviewing Expiring Certificates”.

Open the CSR file you created in “Create CSR on IIS Server” using notepad. The file will either be on your local pc or on the customers server.

Copy the text from the CSR file and paste it int the CSR window shown previously. An example fo the text is as follows:

-----BEGIN NEW CERTIFICATE REQUEST-----

MIIEkzCCA3sCAQAwgZYxCzAJBgNVBAYTAkdCMRYwFAYDVQQIDA1IZXJ0Zm9yZHNo

aXJlMQ8wDQYDVQQHDAZCdXNoZXkxHzAdBgNVBAoMFkFlcm9zcGFjZSBSZWxpYW5j

ZSBMdGQxFDASBgNVBAsMC0hlYWQgT2ZmaWNlMScwJQYDVQQDDB5wcmlvcml0eS5h

ZXJvc3BhY2VyZWxpYW5jZS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK

AoIBAQC/ngR0Hwqd006jqvyAO2oB1bAlNOVP1kOtVzkQco947u2/9zAZoIM9qRXy

4d9Vbpq0Ua1vlvYhKAkJX47akdMtH0ToZtv5KHRTVdc6eP8mJs1Kvrh2E7wj27+7

Av9QqAykEhf0KI/+qPk08sRnlu9Rl7LQwZk+NEdJ6oxd/Q0/2iIGE5JWXuCvf5r9

eIQdK3z1Mn8nIb7XvqiQxEYLnyywIOyfjSQMj2N0yjDP8Wub8/Jxo6Q9/t5NqZyW

DJNgSYakKDt89+iI/uVEh25ANV0fwk2KFdd1yWa/0s1hBeBCxuOpYNmRXkOAbOcG

yphRZ+pdIvZT0bF7oaPJG7ASJ+OJAgMBAAGgggG1MBwGCisGAQQBgjcNAgMxDhYM

MTAuMC4xNzc2My4yME8GCSsGAQQBgjcVFDFCMEACAQUMGkVNLUNWUy0wMDYuc2hv

Y2t3YXZlLmxvY2FsDBJFTS1DVlMtMDA2XFN1cHBvcnQMC0luZXRNZ3IuZXhlMHIG

CisGAQQBgjcNAgIxZDBiAgEBHloATQBpAGMAcgBvAHMAbwBmAHQAIABSAFMAQQAg

AFMAQwBoAGEAbgBuAGUAbAAgAEMAcgB5AHAAdABvAGcAcgBhAHAAaABpAGMAIABQ

AHIAbwB2AGkAZABlAHIDAQAwgc8GCSqGSIb3DQEJDjGBwTCBvjAOBgNVHQ8BAf8E

BAMCBPAwEwYDVR0lBAwwCgYIKwYBBQUHAwEweAYJKoZIhvcNAQkPBGswaTAOBggq

hkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgCAMAsGCWCGSAFlAwQBKjALBglghkgB

ZQMEAS0wCwYJYIZIAWUDBAECMAsGCWCGSAFlAwQBBTAHBgUrDgMCBzAKBggqhkiG

9w0DBzAdBgNVHQ4EFgQU3s8ifXjj0J7D3dq0bb/1llsPh4EwDQYJKoZIhvcNAQEF

BQADggEBAKCGiJlGWEWaSbuGBBdIesLy2SneuBf1bU65DWzOZvxB/uK0DWiCPfrb

VhKy/fJTbiqBKtDS031h5Y1qlzauZp7WdyKCAL1tydIZ07L2c0mlev4yJQknGSff

sywnFAyw69U6Gfrnemz1ZCfpUxeALryclsSAOL/BFWvjZfyE8l2tgqc0I9XVj/4r

nIDPf50zXuE85uMagjlZXM1pjZqkBAdKOa2wdt93kOzhMXINR1ukj4abe4L4pGmm

CP4WsOrgsp2rRmlH4ebHwYX4zP6K5azUo/RMHv1R0Ubj8PnIVOp134jPUGm8xqPm

BEKFpSI287UxvMUf7NxF4TZ3cE97hBY=

-----END NEW CERTIFICATE REQUEST-----

Then click Check CSR. This will decode the CSR so you can check the details again with what you recorded in section “Reviewing Expiring Certificates”.

If you click Update fields with CSR Information it will overwrite any information from the fields such as Common name.

On Admin and Technical tabs please select the Technician and Admin for the organisation from the list. These should be populated by default with Wiki and Tim.

Finally, when you are happy all is complete, click Submit Certificate for issuance.

Email support to get the certificate changed

support.validation@sectigo.com

Certificate Issuer

“In reference to Case Number: 03700729, please update the issuer of the certificate to Sectigo RSA Domain Validation Secure Server CA instead of Sectigo Public Server Authentication CA DV R36 for the following order(s):

Certificate Authority Order Reference       2485878306”

Raise a support ticket to get the issuer changed

https://www.sectigo.com/support-ticket

Order number is the Certificate Authority Order Reference

“Hi, please could the issuer for the new certificate for priority.abc.xyz (Certificate Authority Order Reference 2598011XYZ) be changed to Sectigo RSA Domain Validation Secure Server CA

Thank you”

Finally, send an email to the customer advising them that a SSL Certificate verification email will be sent to the email address specified from section “Reviewing Expiring Certificates”.

Create CSR on IIS Server

Connect to the customer server, using the connection details that are in Priority.

Customers > Customer Connection Data

Once on the server that is running IIS, start the Internet Information Services (IIS) Manager program.

Double click “Server Certificates”

In the right hand side panel, click Create Certificate Request.

Fill in the details in the form using the details recorded in the section “Reviewing Expiring Certificates”.

Example

Click Next.

Change the Bit Length from 1024 to 2048

Save CSR on the Local Disc.

Create a folder “Cert” on the C: drive if it does not exist and save the CSR there.

The filename should contain customer name and year of certificate. Example of the file name shown below:

Copy the file from the customer server to your local machine.

Installing the SSL Certificate

The certifcate should be emailed to the technical contact and admin contact when the customer verifies the email.

Connect to the customer server, using the connection details that are in Priority.

Customers > Customer Connection Data

Copy the SSL Certificate to the folder Certs in the C: Drive on the customers IIS server. Change the file type from .TXT to .CER

Start the Internet Information Services (IIS) Manager program.

Double click “Server Certificates”

In Server Certificates, on the right hand side panel click Complete Certificate Request.

Select SSL Certificate file from Certs folder and add a Friendly name. E.g Certificate for 2021 should be called Priority 2021 or Priority21. Leave Certificate Store as Personal

When you click OK the window should close and new SSL should be showing on the list

In IIS, on the left hand side panel navigate to Default Web Site and then go to Bindings on the right hand side panel.

In Bindings select HTTPS and Edit. If there is only HTTP, please create a new Binding for HTTPS.

Change the SSL Certificate to the newest one and click OK

In browser, go to the URL that is expecting the certificate and click on the padlock icon, and then click on Certificate to view it and to check if it is correct.

Determine URL and Email

Contact the customer to agree the url and email to be used. The advice in general is to use priority or prioritytest with the customers domain name. For example:

priority.bscdiecasting.co.uk

prioritytest.bscdiecasting.co.uk

When requesting the email, the customer needs to advise which email they have setup for the admin of the domain. It has to be one of the following:

Administrator@yourdomain.co.uk

admin@yourdomain.co.uk

hostmaster@yourdomain.co.uk

postmaster@yourdomain.co.uk

webmaster@yourdomain.co.uk

with yourdomain.co.uk replaced appropriately. For example bsc use administator@bscdiecasting.co.uk

Ordering new Certificate

Goto the MySSL Portal

Select “Order a new Certificate”

The following is shown:

Click on “See certificates”. From the list displayed, select the “Sectigo – Sectigo DV SSL” and enter the domain name.

Press Check. Once the field is green, click “Add to Basket”

The following is displayed. Click “Add to Basket”.

The following is displayed:

Click “Add to Basket”.

Add in the Purchase order number and click “Complete order”

The following is then displayed:

In the left-hand side panel go to My SSL certificates and then Stock. You will see the stock record created:

Carry out the steps in section “Create CSR on IIS Server”.

Click the green button. The following is displayed:

Change the “DV Authorisation Method” to be “Approver Email”. The screen will change to show a drop down where you can select an email.

Select the email that the customer will use.

Open the CSR file you created in “Create CSR on IIS Server” using notepad. The file will either be on your local pc or on the customers server.

Copy the text from the CSR file and paste it int the CSR window shown previously. An example fo the text is as follows:

-----BEGIN NEW CERTIFICATE REQUEST-----

MIIEkzCCA3sCAQAwgZYxCzAJBgNVBAYTAkdCMRYwFAYDVQQIDA1IZXJ0Zm9yZHNo

aXJlMQ8wDQYDVQQHDAZCdXNoZXkxHzAdBgNVBAoMFkFlcm9zcGFjZSBSZWxpYW5j

ZSBMdGQxFDASBgNVBAsMC0hlYWQgT2ZmaWNlMScwJQYDVQQDDB5wcmlvcml0eS5h

ZXJvc3BhY2VyZWxpYW5jZS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK

AoIBAQC/ngR0Hwqd006jqvyAO2oB1bAlNOVP1kOtVzkQco947u2/9zAZoIM9qRXy

4d9Vbpq0Ua1vlvYhKAkJX47akdMtH0ToZtv5KHRTVdc6eP8mJs1Kvrh2E7wj27+7

Av9QqAykEhf0KI/+qPk08sRnlu9Rl7LQwZk+NEdJ6oxd/Q0/2iIGE5JWXuCvf5r9

eIQdK3z1Mn8nIb7XvqiQxEYLnyywIOyfjSQMj2N0yjDP8Wub8/Jxo6Q9/t5NqZyW

DJNgSYakKDt89+iI/uVEh25ANV0fwk2KFdd1yWa/0s1hBeBCxuOpYNmRXkOAbOcG

yphRZ+pdIvZT0bF7oaPJG7ASJ+OJAgMBAAGgggG1MBwGCisGAQQBgjcNAgMxDhYM

MTAuMC4xNzc2My4yME8GCSsGAQQBgjcVFDFCMEACAQUMGkVNLUNWUy0wMDYuc2hv

Y2t3YXZlLmxvY2FsDBJFTS1DVlMtMDA2XFN1cHBvcnQMC0luZXRNZ3IuZXhlMHIG

CisGAQQBgjcNAgIxZDBiAgEBHloATQBpAGMAcgBvAHMAbwBmAHQAIABSAFMAQQAg

AFMAQwBoAGEAbgBuAGUAbAAgAEMAcgB5AHAAdABvAGcAcgBhAHAAaABpAGMAIABQ

AHIAbwB2AGkAZABlAHIDAQAwgc8GCSqGSIb3DQEJDjGBwTCBvjAOBgNVHQ8BAf8E

BAMCBPAwEwYDVR0lBAwwCgYIKwYBBQUHAwEweAYJKoZIhvcNAQkPBGswaTAOBggq

hkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgCAMAsGCWCGSAFlAwQBKjALBglghkgB

ZQMEAS0wCwYJYIZIAWUDBAECMAsGCWCGSAFlAwQBBTAHBgUrDgMCBzAKBggqhkiG

9w0DBzAdBgNVHQ4EFgQU3s8ifXjj0J7D3dq0bb/1llsPh4EwDQYJKoZIhvcNAQEF

BQADggEBAKCGiJlGWEWaSbuGBBdIesLy2SneuBf1bU65DWzOZvxB/uK0DWiCPfrb

VhKy/fJTbiqBKtDS031h5Y1qlzauZp7WdyKCAL1tydIZ07L2c0mlev4yJQknGSff

sywnFAyw69U6Gfrnemz1ZCfpUxeALryclsSAOL/BFWvjZfyE8l2tgqc0I9XVj/4r

nIDPf50zXuE85uMagjlZXM1pjZqkBAdKOa2wdt93kOzhMXINR1ukj4abe4L4pGmm

CP4WsOrgsp2rRmlH4ebHwYX4zP6K5azUo/RMHv1R0Ubj8PnIVOp134jPUGm8xqPm

BEKFpSI287UxvMUf7NxF4TZ3cE97hBY=

-----END NEW CERTIFICATE REQUEST-----

Then click Check CSR. This will decode the CSR so you can check the details.

If you click Update fields with CSR Information it will overwrite any information from the fields such as Common name.

On Admin and Technical tabs please select the Technician and Admin for the organisation from the list. These should be populated by default with Wiki and Tim.

Finally, when you are happy all is complete, click Submit Certificate for issuance.

Finally, send an email to the customer advising them that a SSL Certificate verification email will be sent to the email address specified.

SSL Intermediate Certificates

View Cert to check if root is correct

To view a certificate open IIS on the web server, go to site, then bindings

Click edit - Then click view

Click on certification path tab – it should look like this (4 levels)

If it has 4 levels, then you still just need to install the intermediate cert

If it looks like this (3 levels) it is not right

Fix root if root is wrong

To fix it - Go to run

Open mmc

Type mmc

This opens Microsoft Management Studio

Add certificate snap in

Go to file> add/remove snap in

Click on certificates then add

Computer account

Local computer then finish

This will then show up

View intermediate certs

Expand on the left to see Intermediate Certification Authorities>certificates

You should be able to see the new Sectigo issued cert “Issued to Sectigo Public Server Authentication CA DV R36” here.

As well as one called Sectigo Public Server Authentication Root R46

You can see the same R46 one in the Trusted Root Certification Authorities section:

Delete the Root R46 one, then restart the web server

Then once the server is back up go to next steps to install the intermediate certs.

Install intermediate certs (regardless of if root is correct)

Open MMC (follow this bit to open and then import certificate snap in to see the screen below)

Right click on intermediate certification authorities > all tasks> import

Import both certs found below in the same way
sectigo public server auth.crt
dv rsa intermediate secure.crt

Then restart IIS

Then go back to the start of the doc and just check the root is still correct
