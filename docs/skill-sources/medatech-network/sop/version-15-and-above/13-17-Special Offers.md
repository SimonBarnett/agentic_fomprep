# 13-17-Special Offers

- **Source:** `13-17-Special Offers.pdf`

www.priority -software.com   
1/3 ‏05/02/15 Ver.02 Cat.No. A8000102 
 
 SOP: Special Offers 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To define special offers for a limited time period, in which the customer is rewarded according to 
the purchases made during that period. 
Procedure 
Stage I: Defining the Special Offer 
1. Enter the Special Offers form. 
2. Record an Offer Description. The Offer Code appears automatically. 
3. Specify the offer's Priority. This value determines the special offer to which an invoice will be 
linked, when more than one offer is in effect for the same part or part family. That is, any given 
invoice can only be considered for one offer. The lower the number, the higher the priority. 
Example: 
 Part X belongs to part family Y. 
 Two offers are in effect: 
o Offer 1, which rewards customers for the purchase at least 1000 units of Part X, and is 
assigned a priority of 1. 
o Offer 2, which rewards customers for the purchase of at least 1000 units of any part in 
Family Y, and is assigned a priority of 2. 
 Both offers are linked to the same customer.  
 If that customer purchases more than 1000 units of Part X, he will receive the rewards defined 
for Offer 1, which has the higher priority.  
4. In the Target Details tab, define the Start Date and End Date of the special offer period. 
5. Do one of the following: 
 Specify a Target Quantity. This is the number of units the customer must purchase in order to 
qualify for the special offer. 
 Specify a Target Sum. This is the monetary amount the customer must spend on the target 
item in order to qualify for the special offer. 
6. Specify the Target Currency for the special offer. 
7. Click the Offer Details tab. If the customer is rewarded in goods: 
 Select the part the customer will receive in the Credit/Part Offered column. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 ‏05/02/15 Ver.02 Cat.No. A8000102 
 
 Specify the quantity of parts the customer will receive in the Offer Quantity column. 
 If the customer receives the parts at a reduced price, specify the price in the Unit Price 
column. 
8. If the customer is credited with a percentage of the price of the goods purchased during the offer 
period, specify that percentage in the Credit (%) column. "Credit" will appear automatically in 
the Credit/Part Offered column. 
9. If the customer is credited with a fixed sum, specify that sum in the Credit Sum column. "Credit" 
will appear automatically in the Credit/Part Offered column. 
Result 
 A special offer is defined that determines a customer reward of bonus goods, a credited 
percentage or a credited sum for purchases of a defined quantity or monetary value.  
Stage II: Defining the Target Part or Part Family 
1. Enter the Offer Items sub-level of the Special Offers form. 
2. To define an offer for a part family, select it in the Family column. 
3. To define an offer for an individual part, select it in the Part Number column. 
4. For any additional families/parts, open new lines. 
Result 
 The designated parts/families will be the goods whose purchase entitles customers to the 
special offer defined in Stage 1. 
Stage III: Linking the Special Offer to Customers 
1. To link the offer to one or more customers automatically: 
 Run the Link Offer to Customers program (or select it from the list of Direct Activations of the 
Special Offers form). 
 If run from the menu, select the desired Offer Code.  
 Specify the Customer Number or press F6 twice from the Customer Number column to 
enter the Customers form and retrieve multiple customers. Exit the form to return to the 
program. 
2. To link the offer to customers manually: 
 Enter the Customers Participating in Offer sub-level of the Special Offers form and record 
a line for each customer you want to include in the current offer. 
Notes: 
o You can also link a customer to an offer in the Special Offers for Cust sub-level of the 
Customers form. 
o You can assign a given offer a different priority for different customers. 
3. To remove a customer from a special offer, run the Remove Customers from Offer program (or 
select it from the list of Direct Activations of the Special Offers form).  Or delete the relevant line 
in either of the sub-level forms mentioned in step 2. 
4. Change the status of the special offer to the one flagged as In Effect.

www.priority -software.com   
3/3 ‏05/02/15 Ver.02 Cat.No. A8000102 
 
Result 
 The customer is linked to the special offer. Any purchase of those target goods defined for the 
offer will add to the quantity/sum needed to become eligible for the defined reward. 
Stage IV: Checking the Progress of the Special Offer 
1. To check the progress of a given offer, use the following sub-levels of the Special Offers form: 
 The Invoice Items Linked to Offer form displays the invoice items recorded for the target 
parts during the offer period. 
 The Credit Memos and Special Offer Orders forms are discussed below (see Stage VI). 
2. To view all offers in which a specific customer participates, retrieve that customer in the 
Customers form and enter the Special Offers for Cust sub-level form. For each offer, you can 
view its target quantity/sum, status and priority, as well as the actual quantity/sum accumulated 
by the customer.  
3. Two reports are also useful: 
 Run the Special Offer Details report for the desired offers. 
 Run the Offer Profitability report (see Stage VI below). 
Stage V: Closing the Special Offer 
1. Run the Close Special Offers program (or select it from the list of Direct Activations of the 
Special Offers form). 
2. If run from the menu, select those offers you wish to close.  
Tip: Leave the asterisk (*) to close all special offers still in effect whose end dates have passed. 
Result 
 The selected offers are closed and further purchases of the target parts will not be taken into 
account. 
Stage VI: Rewarding the Eligible Customers 
1. Run the Prepare Credit/Order for Offer program for the desired offers (or select it from the list of 
Direct Activations of the Special Offers form). 
2. To view the credit memos and sales orders opened for customers by this program, enter the 
Credit Memos and Special Offer Orders sub-levels of the Special Offers form, respectively. 
To view them per customer, use the Special Offers for Cust sub-level of the Customers form. 
3. To view the net profit generated by the special offer, run the Offer Profitability report for the 
desired offers. 
Result 
 A credit memo or sales order is opened for those sums/goods the customer is entitled to, in 
keeping with the definition of the special offer and the amount of purchases made during the 
offer period.
