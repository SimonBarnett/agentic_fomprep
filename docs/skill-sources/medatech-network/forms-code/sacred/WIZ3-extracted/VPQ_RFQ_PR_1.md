# VPQ_RFQ_PR_1

- **Source:** `VPQ_RFQ_PR_1.htm`

Vendor Price Quotes - Creating RFQs Automatically From Purchase Requisitions.1 
 
 
- 
 
 
 
# Creating RFQs Automatically From Purchase Requisitions

 

 Priority provides a program that automatically prepares RFQs based on PRs that have not yet been linked to purchase orders, and that fall within a designated date range. The program retrieves all PRs for the parts you specify, and opens one RFQ from each indicated vendor (i.e., the preferred vendor, all vendors up to a certain rank, one or more designated vendors), for the total demand of the part they supply. Example. You can also open RFQs for PRs that have not yet been authorized. 
 

In order to be taken into account, PRs must fulfill the following conditions: 
 

 ·        The demand document to which they belong must have a status that allows it to be linked to an RFQ.
 Tip: To create a new status for unauthorized PRs, run the BPM Flow Chart-Purchase Demands program. 
 

 ·        The requisitioned parts must be included in the vendor's part list. 
 

 ·        If you specify a specific vendor, the same vendor must appear in the Vendor for PR column. 
 Note: If a purchase requisition has a designated Vendor for PR , it will generate an RFQ for that vendor only, regardless of the designated ranking. 
 
## To create RFQs from PRs:

 

 ·        Run the Prepare RFQs from PRs program. 
 

 Note: You can view any warning messages that were received when running the program in the Prepare RFQs - Warnings report.
