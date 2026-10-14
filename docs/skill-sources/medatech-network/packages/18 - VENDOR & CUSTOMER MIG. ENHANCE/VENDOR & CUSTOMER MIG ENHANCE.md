# VENDOR & CUSTOMER MIG ENHANCE

- **Source:** `VENDOR & CUSTOMER MIG ENHANCE.docx`

Vendor and Customer Migration Enhancements

Also allows for separate City and State/County names and Customer Tax Code

System Management > Database Interface > Data Migration > Purchasing Data Migration > Vendor Data Migration > Load File Definitions-Vendors

Includes changing the fields TEXT5, 8 and 9 on GENERALLOAD_T to width 80 to meet address requirements.

Plus, extra fields ZEMG_CITY and ZEMG_COUNTY on HSLOADACCOUNTS for separate City and State/County import. The state/county is validated by System Management > Database Interface > Data Migration > Purchasing Data Migration > Vendor Data Migration > Check for Errors in Interim Tbl procedure.

Same change have been made to Customer Migration with the addition of Tax Code.
