# PriceDiscounts_12_sources_pricelists

- **Source:** `PriceDiscounts_12_sources_pricelists.htm`

Prices and Discounts - Setting up Price Sources for Price Lists 
 
 
- 
 
 
 
# Setting up Price Sources for Individual Price Lists

 

Price sources can be assigned to individual price lists either manually or automatically, depending on how the SPLAutoPrSrc constant is set. These price sources will appear throughout the system when prices are taken from the price list to which they are assigned. If no price source is assigned to a given price list, the price source will simply appear as "Price List". 
 

You can set up the SPLAutoPrSrc constant to automatically assign new customer price lists a price source whose title is identical to the price list description. If no such price source has been defined, one will be opened automatically and assigned to this price list. Alternatively, you can define price sources manually in the Price/Cost Sources form and then assign them to the desired price lists. 
 
## To determine whether a price source is assigned automatically to newly opened customer price lists:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Move to the SPLAutoPrSrc constant and select the appropriate value. 
 
## To define price sources manually:

 

 1 .  Enter the Price/Cost Sources form and move to a line that is flagged in the Updatable Title column. 
 

 2 .  In the Price/Cost Source column, record the desired title for the current price source. This will appear in the Choose list when assigning a price source to a given list in the Price Lists form.
