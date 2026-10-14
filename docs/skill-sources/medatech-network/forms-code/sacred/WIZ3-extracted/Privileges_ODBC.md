# Privileges_ODBC

- **Source:** `Privileges_ODBC.htm`

Privilege Explorer - Assigning Privileges to Run ODBC 
 
 
- 
 
 
 
# Assigning Privileges to Access Priority Data via External Programs

 

You can authorize users to access Priority data via external programs (e.g., MS-Query, MS-Access). 
 
## Note:

 

If your system is based on Oracle, you can set a constant that limits the privileges of such users to those assigned to them in Priority . 
 
## To authorize a user to import data:

 

 1 .  Enter the User Permissions form and retrieve the desired user. 
 

 2 .  Click on the Permissions tab and flag the Authorized for ODBC column. 
 
## To apply Priority privileges to external programs (for Oracle):

 

 1 .  Enter the System Constants form. 
 

 2 .  Move to the DBSTRICTPRIV constant and select 1 .
