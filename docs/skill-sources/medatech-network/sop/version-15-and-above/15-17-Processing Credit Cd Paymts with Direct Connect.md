# 15-17-Processing Credit Cd Paymts with Direct Connect

- **Source:** `15-17-Processing Credit Cd Paymts with Direct Connect.pdf`

www.priority -software.com   
1/3 ‏Mar. 12,'15 Ver. 03 Cat.No. LB130094 
 
 SOP: Processing Customers' Credit Card Payments with 
Direct Connect 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
The use of Direct Connect as a payment gateway to Priority enables the automatic transmission of 
credit card data and approval of credit card payments received from customers. You can also use 
Direct Connect to create a standing order of credit card payments for a given document (e.g., order, 
invoice). This is done by getting a token from Direct Connect, which is then used to fill in credit card 
details automatically when payment is received.  
This document describes the setups required to work with Direct Connect, as well as the operations 
performed in order to record credit card payments. 
Initial Setups 
 If you work in the Windows version of Priority, install the Priority Lite application server. For 
details, see Installing the Application Server. 
 Fill out the Eshbel referral page to Direct Connect. Under "I have a customer interested in," select 
Credit/Debit Card Processing. Add your contact details and submit. Direct Connect will then 
supply you with the following information: 
 The URL of the Direct Connect server (e.g., 
https://gateway.1directconnect.com/paygate/home.aspx). 
 Your user name and password to enter the Direct Connect server. 
 Your user name and password to enter the web service. 
 Your merchant key. 
Procedure 
Stage I: Setting Up the Direct Connect Hosted Page 
1. Access the Direct Connect web site via the URL you received, using your user name and 
password to enter the Direct Connect server (see Initial Setups above). 
2. In the web page that opens, select Tools. 
Tip: Consult the User Documentation offered in this menu. 
3. Select Hosted Page. This allows you to define the page on which you will record credit card 
details in Direct Connect.  
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 ‏Mar. 12,'15 Ver. 03 Cat.No. LB130094 
 
4. In the Options tab, flag "Page is active" and make any other desired definitions. 
5. In the Fields tab, do the following: 
 In the Submit button URL and Error URL fields, record the URL of the Priority page to 
which Direct Connect will send a response. In Windows installations, use the URL of the 
Priority Lite application server (see Initial Setups above); in Priority Rich installations, use 
the URL of Priority Rich. Add to the URL the name of the page: directconnect.htm. 
Example: https://www.eshbelsaas.co.il/eshbel/priority/directconnect.htm. 
 Under Field Visibility, click the + sign next to Order Information and select Total Amount. 
Select any other fields you wish to display on the hosted page (optional). 
6. Use the Appearance, Button and Panels tabs to design the page as desired. 
7. In the Security tab, click Generate. This will create a user name and password with which to 
enter the hosted page. Record these details, as you will need to store them in Priority (see 
below). 
Note: You can also click Generate (again) to change your password to the hosted page. If you 
do so, be sure to revise the settings in Priority. 
Stage II: Recording Direct Connect Settings in Priority 
1. Enter the Direct Connect Settings form.  
2. Define a code and description for the installation and flag the Default column. 
3. Record the Server Domain. This is part of the URL received from Direct Connect (see Initial 
Setups above). For instance, if the URL is 
https://gateway.1directconnect.com/paygate/home.aspx, the domain would be 
gateway.1directconnect.com 
4. Record the Merchant Key received from Direct Connect. 
5. Record your user name and password for the hosted page, as created in Stage I (step ‎7). 
6. Record your user name and password for the web service, as received from Direct Connect. 
Stage III: Recording Receipt of a One-Time Payment 
Aim: To record a credit card payment for a customer receipt or over-the-counter invoice, using 
Direct Connect.  
1. Open a receipt/invoice in the Receipts or Over-the-Counter Invoices form and enter the Other 
Forms of Payment (Details) or Payment by Credit Card/Coupon sub-level form, respectively. 
2. Select the desired credit card in the Payment Means column. 
Tip: Use the Payment Means form to add a new credit card to the Choose list. 
3. Designate the Payment Amount. 
4. Select Send to Direct Connect from the list of Direct Activations. 
5. A web page will open in Direct Connect (this is the hosted page; see Stage I). Use it to record 
credit card details and then submit the page. You will receive a message indicating that the 
transaction has been completed. 
Result: In Priority, in the line for the current transaction, the Approved column is flagged, a 
Confirmation Number is recorded and the transaction ID appears in the Credit Card Slip 
column. 
6. Finish recording the receipt/invoice and finalize it.

www.priority -software.com   
3/3 ‏Mar. 12,'15 Ver. 03 Cat.No. LB130094 
 
Stage IV: Creating a Standing Order for Credit Card Payments 
Aim: To receive a token from Direct Connect, in order to create a standing order for credit card 
payment for a given transaction (e.g., order, invoice) and to use that token to process future 
payments. 
1. Enter the document in question (e.g., Sales Orders). 
2. Enter the Credit Card to Charge sub-level form. 
3. Select the desired credit card in the Payment Means column.  
Tip: Use the Payment Means form to add a new credit card to the Choose list. 
4. Select Get Token from Direct Connect from the list of Direct Activations. 
5. A web page will open in Direct Connect (this is the hosted page; see Stage I). Use it to record 
credit card details and then submit the page. You will receive a message indicating that the 
transaction has been completed. 
Result: In Priority, credit card details (including the token) are recorded in the Credit Card to 
Charge sub-level form and the Approved column is flagged. 
6. When payment is received, open a receipt/invoice in the Receipts or Over-the-Counter Invoices 
form. 
7. Enter the Other Forms of Payment (Details) or Payment by Credit Card/Coupon sub-level 
form, respectively. Credit card details are recorded there automatically. 
8. Select Send to Direct Connect from the list of Direct Activations. You will receive a message 
when the transaction has been completed. 
Result: In Priority, in the line for the current transaction, the Approved column is flagged, a 
Confirmation Number is recorded and the transaction ID appears in the Credit Card Slip 
column. 
9. Finish recording the receipt/invoice and finalize it.
