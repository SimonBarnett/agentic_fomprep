# SFDC-PDA create load Rich

- **Source:** `SFDC-PDA create load Rich.docx`

SFDC\PDA auto create loading

Target:

Create loading procedure, loading table, and a form load in an easy and errorless way.

How to use:

The form for defining the loading can be found on:

System Management > Database Interface > Loading procedure for PDA/SFDC

Steps:

Define the loading procedure and loading table name (default to same)

Define the forms that you’d like to load and their hierarchy (i.e. record type).

Define the form columns that you’d like to load by flagging the ‘From Device’ flag, and define the fields loading order in the form.

In order to create the loading table, and the definitions required for the SFDC2 and PDA development, run the direct activation ‘Create loading table’. This will create the loading table and a file with the SFDC\PDA data.

The table will have all fields required for being a loading table + a bubble id field, and all the fields you flagged in step 3. The fields will be named as the original field name + their record type (ORD1, ORDNAME1, PARTNAME2, etc.)

File created for PDA/SFDC development:

In order to create the form load and the loading procedure, run the direct activation ‘Create loading procedure’.

This will create the form load, as defined in the form, and a loading procedure with 2 steps:

The form load (named as the procedure name

SQLI step with the required code for recording all loading error in the emerge load error log (System Management > Database Interface > Error Message Logs > Error Messages Log).

You can, of course, add more code or steps if needed.
