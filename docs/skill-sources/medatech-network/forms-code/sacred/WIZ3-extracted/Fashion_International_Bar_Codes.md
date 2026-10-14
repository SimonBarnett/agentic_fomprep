# Fashion_International_Bar_Codes

- **Source:** `Fashion_International_Bar_Codes.htm`

Fashion - Assigning International Bar Codes 
 
 
- 
 
 
 
# Assigning International Bar Codes

 

When parts are first opened by the system, they are assigned bar codes that are identical to their part numbers. If you have purchased a series of Global Trade Item Numbers (GTIN), you can assign such bar codes automatically. 
 
## Before You Begin

 

 1 .  Enter the International Bar Codes form and list all GTIN series. Flag the series that should currently be used as Active . 
 

 2 .  The system is initially set up to always create 14-digit bar codes, by adding leading zeroes (when needed) to the series number. To disable this mechanism, enter the Logistic Constants form and change the value of the IZ eroPadBar c constant to 0 . 
 
## To assign international bar codes to parts:

 

 1 .  Enter the Part Catalogue form and retrieve the fashion style in question. 
 

 2 .  Select Assign International Bar Code from the list of Direct Activations . 
 
## Notes:

 

 ·        Bar codes are not assigned to the style itself, but rather to all linked parts. There is one exception to this rule: if the base product does not have a defined size chart, then it is assigned a bar code as well. 
 

 ·        If the active series ends before the process is complete, return to the International Bar Codes form and activate the next GTIN series. Then return to the Part Catalogue form and rerun the program. 
 

 ·        If you delete any assigned bar codes, they will automatically be recorded in the Reactivated Bar Codes form and will be reused the next time the Assign International Bar Code program is run.
