# Euro Exchange rate uploader

- **Source:** `Euro Exchange rate uploader.docx`

Euro Exchange rate uploader

This procedure downloads the Exchange rate from

http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml

To work in one company you need.

The Standard bank Currency codes from the XML feed recorded either in code with second lang code blank or the same Or in the second lang. eg. One of the lines below

Code	Second Lang

USD

USD	USD

$	USD

To work with the Multi Co Exchange rate mechanism.

The Multi co Exchange rate mechanism within priority works when the following match

If a currency is common to base and second currency in any company then the standard code MUST be recorded in the second language in all instances in all companies. Eg

Base 		USD

Second currency $

Then Second lang must be USD for both.

All Base currencies from every company must be recorded as a currency in all companies that the procedure may be run from.

The procedure displays a warning message showing currencies in the XML feed that are not recorded in the Currencies form. You may wish to run a quick check to make sure these currencies do not exist in any other company that you are updating through the Multi Co Exchange rate mechanism.

Tabula Task Scheduler

To run in the Task scheduler, comment out the WRNMSG 30 in the last line of step 30.

Installation.

Install shell file,

Run ?? to check ECODE not duplicated

Run ?? to check All Base currencies from every company recorded as a currency in all other companies.

Run ?? to Check all currency codes from XML exist in currencies table.

check if base and second currency the same in any companies and set ECODE if so.

Upload company | Multi company | Works?

Code | Code | YES

Second Lang Code | Second Lang Code | YES

Second Lang Code | Code | YES

Code | Second Lang Code | NO
