# PurchOrd_Setup_Remarks

- **Source:** `PurchOrd_Setup_Remarks.htm`

Purchase Orders - Setup: Order Remarks 
 
 
- 
 
 
 
# Setting Up Constants That Affect Order Remarks

 

There are two constants that affect text that is copied automatically into purchase orders. The PCopyTxtToPO constant affects remarks in the entire purchase order, as well as remarks for order items. The PCopyPartTxt constant only affects remarks for line items within the purchase order. 
 

The PCopyTxtToPO constant determines whether remarks recorded in vendor quotes, purchase demand documents or sales orders are copied automatically into purchase orders based on those documents. 
 

By default, the constant is set at 1 , which means that all document and line item remarks are copied automatically, instead of the order's set text. 
 
## To define whether remarks are copied into purchase orders:

 

 ·        Enter the Logistic Constants form, move to the PCopyTxtToPO constant, and record the value of your choice. 
 

The PCopyPartTxt constant determines whether remarks recorded for items in the Parts - Remarks form are copied automatically to purchase order items. 
 

By default, the constant is set at 0 , which means that line item remarks are not copied automatically. 
 
## To enable automatic copying of remarks into purchase order line items:

 

 ·        In the Logistic Constants form, move to the PCopyPartTxt constant, and change the value to 1 . 
 
## Note:

 

If the value of both constants is set at 1, and there are remarks for line items in the document that the order is based on, part remarks are copied from the original document and not from the part catalogue.
