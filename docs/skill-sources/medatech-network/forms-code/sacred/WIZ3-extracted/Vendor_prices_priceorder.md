# Vendor_prices_priceorder

- **Source:** `Vendor_prices_priceorder.htm`

Vendor Parts/Prices - Price Hierarchy 
 
 
- 
 
 
 
# Price Hierarchy

 

When recording a purchasing document, an item price appears automatically from one of a variety of sources, in the following order: 
 

 1 .   Part prices from the document on which the current document is based. 
 

 2 .  The unit price in the vendor price list or the list price in the Part Catalogue, depending on the value assigned to the PPriceByList constant. 
 

 3 .  The price appearing in the last purchase order for this part, regardless of vendor. The number of days back to search for such an order is determined by the PPriceDays constant. 
 
## Notes:

 

 ·        A price recorded manually always overrides all other price sources. 
 

 ·        In an invoice, the price source is determined by the PurchDocPrice constant.
