# woocommerce doc

- **Source:** `woocommerce doc.docx`

Troubleshooting web order issues

To see web orders go to Sales > Orders > WooCommerce > WooCommerce Setup > WooCommerce Loading Table and open the form

Search for everything in the Status field

The most recent orders will be at the bottom of the form, and any failures will have blank ‘Order’ fields

Only orders in a status of ‘Processing’ should be processed by Priority (we have added a search which will keep looking for any status updates to orders!)

Find the failed order

Use the web orders load errors to check what errors exist

In this case its because the products weren’t mapped. And in this particular scenario all products were 200g loose tea which aren’t products on priority.

If the products are on Priority then you should map them using this formula

In the woocommerce order items sub form, if ‘coffee size code’ exists, that is the number to map, if it is blank or 0, then look for the variation id, if that is blank or zero then use the product ID.

Once you have found the correct code, map it here, against the relevant part in part catalog.

Once you have mapped the products, pop a 1 in the customer notes field, come off the line and close the form

When you come back, the order should have been created or a new error message left.

Other errors- other reasons for failure are usually to do with the sattus being wrong, these don’t seem to happen now.
