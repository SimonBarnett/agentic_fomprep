# St-Cross Onsite training 08

- **Source:** `St-Cross Onsite training 08.docx`

Onsite training 08/12/14

PC Issues

There are a number of PC issues on site. A number of users do not have the correct privileges assigned. This prevents user data/settings being saved. To set up Mail Synchronisation you have to set the Language and exit/re-enter priority. As this setting cannot be saved this is not possible. Other preferences such as the last user signed on, search preferences etc. cannot be saved either.

There is also speed issues present on a number of PCs causing users to have to wait for screens to open and frozen screens when switching between screens. This may be PC issues or Network issues that could be looked into by your IT provider.

A number of PCs do not open links properly, either just failing or in Lydia’s case opening Excel. This is due to incorrect file association or file privileges on the PC. On these PC’s try each of the following until Priority works correctly.

Give the user the correct PC file/directory privileges. As defined in the documentation provided (I sent a copy to Dax in a recent email).

Log in as the local Administrator (not a user with admin rights) un-install Priority and re-install priority and check the users PC file privileges as above.

Re-install the PC operating system.

Costing

A number of parts did not produce a Standard Costing Analysis report – No Values in Report. This we discovered was due to all the BOM being flagged as Info only and worked fine once the Info Only was removed.

Development – List File name and Issue number of attachments.

Adrian would like a quotation to add 2 columns to the Shipping Document and Sales order confirmation document to list the "Document Number" and "Version of Doc" of files attached to the part.

I recommend adding a trigger that adds the "Document Number" and "Version of Doc" of all the attachments as order item remarks. This will ensure the details are correct and reflect the documents in effect at the time of order and don’t change as new documents are added or changed during the period between order and shipment. These details will then be copied to the Shipment. St-Cross can then use the normal reports using the “W/Extended Desc” format.

St Cross will have to ensure they use the “In Use” and “Don’t Send” flags correctly so no internal or obsolete documents are sent. Changes to these “Document Number” and “Version of Doc” if required will have to be manually recorded.

Costing for Current Date run overnight.

Adrian would like Costing for Current date run overnight in the Task Scheduler. I will quote to modify the program to suit and add to the scheduler.

Purchase Demands

A number of problems were highlighted with the way the business is running MRP and pushing demands through to the purchasing department and also the safety stocks held against parts.

Problems highlighted are.

MRP is being run multiple times a day. This has been causing Karen to lose the work she has done and having to start again assigning vendors to demands. It would be easier to try and run MRP once per day. If MRP needs to be run again, I have advised Karen to take the time to finish the particular Vendor she is working on and process this through and raise the order before letting MRP be run again. This will lead at times to multiple purchase orders being raised on the same vendor in one day if more demand for parts are raised.

Certain customers such as Sail Craft have blanket orders on your system and randomly call these orders off. Purchasing will have no visibility of the demand for these parts until the order is raised. Julia is currently raising sales orders for some of these parts with a due date of today and re-running MRP to give Karen visibility but without communicating to Karen that this is what she has done and that actually there is no demand. This causes Karen to suddenly receive demands for parts that are overdue on Vendors with long lead times. Karen is then having to pay over the odds either in increased shipping charges or using more expensive suppliers with stock to satisfy these urgent orders.

We discussed a number of options to help with blanket orders. Firstly it would be sensible you all to look at implementing safety stocks for some of the of these longer lead time parts. Secondly you could look at adding forecasts for the call off of these blanket orders. This will drive demand for the components but when actual demand is created in the form of an actual sales order thess will be consumed from the forecast rather than added to it. These forecasts should be entered into the future to give purchasing the visibility to order at the correct time at the correct price. Lastly there are high value parts that you do not wish to stock until you have an actual order. You should look at the lead times of these parts and inform your customers and staff that even with a Blanket order the shortest lead time they can have their product is this lead time plus the manufacturing time.

There are also certain crimp parts that have large stock figures on the system but actually no or small physical stock. These items are suddenly inventory counted to zero giving purchasing no lead time to source these products at normal prices. This was apparently due to not knowing how much stock is on a part used reel when Priority was implemented. These items should be checked and accurate estimates entered onto the system via an inventory count.

Most parts are kitted to works orders by James at the start of the works order but wire and crimps are kitted later. Crimp contacts are issued after they have been used so that the actual amount used can be issued. Cable is issued later so part reels stocked in various locations can be issued from the correct location. There seems to be debate as to whether these items are kitted as soon as they are issued or later after the works order has been completed. I noticed that there are a number of works orders with Crimps in their BOM that have been issued a month ago for normal parts but Wire and crimps have not been issued and the works orders have not been completed. These should be investigated and the appropriate action taken to ensure correct stock is recorded. Look to see if

These are kits are sat on the shop floor waiting for assembly or complete works orders that have not been booked through.

If kits do they physically have Wire and crimps in the kit or are they still waiting for these items.

Split buying for UK and Oversea

Having 2 buyers has caused a couple of issues with 2 people processing the same purchase demand. I have assigned Karen as the Buyer on all R parts that didn’t have a buyer assigned. All parts that will be bought by Lydia will need their buyer code changed.

Karen and Lydia have been trained in the following procedures.

Default queries have been set up for each so they only see their parts.

The copy down macro is used to flag all lines for “Do not open order”.

The lines can then be processed with Vendor assigned and quantities and due dates etc. changed. When they are happy –

Retrieve all part with their buyer code and a Vendor for PR and use the macro to Un Flag “Do Not Order”

Run the direct activation “open Purchase Orders for Doc” making sure they select only for their buyer and do not flag the Blank Buyer column.

They need to communicate with each other when they need to change the status to allow them to open the purchase orders. They also have queries to see each others items and also blank buyer parts. People adding parts must make sure they assign a buyer now. This could be enforced by a Business rule or making the Buyer field Mandatory in the Privilege explorer.
