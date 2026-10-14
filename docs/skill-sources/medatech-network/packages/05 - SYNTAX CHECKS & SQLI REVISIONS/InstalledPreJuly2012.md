# InstalledPreJuly2012

- **Source:** `InstalledPreJuly2012.txt`

~~~
If shell installed pre-July 2012 it is recommended you change procedure
MED_SAVESQLIREV step 30 line 33 to read:-

AND ORIG.ENAME IN ('SQLI', 'INPUT') /* INPUT can have SQL code */

as this enables the storing of SQL query code for INPUT type steps.
~~~
