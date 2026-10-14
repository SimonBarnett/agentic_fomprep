# backing up a table with Windbi

- **Source:** `backing up a table with Windbi.docx`

Open windbi

SELECT COUNT(*) FROM table FORMAT;

This will give a count of records on the file

Counts to be recorded.

SELECT * FROM table DATA

STRCAT(‘..\..\table’,SQL.ENV,‘1.bak’) ;

(Creates a backup of table for each environment)

Note NEED TO EDIT SINGLE QUOTES

Run Count Again, commenting out the SELECT statement, record second count again.
