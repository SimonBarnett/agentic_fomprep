# PART MIGRATION INC REMARKS

- **Source:** `PART MIGRATION INC REMARKS.docx`

Part Migration including Remarks

System Management > Database Interface > Data Migration > Inventory Data Migration > Part Data Migration > Load from InterimTbl to DB (Emg)

Select the fields you want to import (actually tick the ones you want to ignore) using

System Management > Database Interface > Data Migration > Inventory Data Migration > Part Data Migration > Load File Definitions-Parts

Import your Tab delineated file into the interim table using

System Management > Database Interface > Data Migration > Inventory Data Migration > Part Data Migration > Load File into Interim Table

View the data using

System Management > Database Interface > Data Migration > Inventory Data Migration > Part Data Migration > Load File into Interim Table

Optionally remove any the double quotes imported if not required using

System Management > Database Interface > Data Migration > Inventory Data Migration > Part Data Migration > Auxiliary Programs > Remove Quotes from Part Desc.

Run new version of loading

System Management > Database Interface > Data Migration > Inventory Data Migration > Part Data Migration > Load from InterimTbl to DB (Emg)

Includes changing the fields TEXT25 on GENERALLOAD_T to width 68 to meet text requirements.
