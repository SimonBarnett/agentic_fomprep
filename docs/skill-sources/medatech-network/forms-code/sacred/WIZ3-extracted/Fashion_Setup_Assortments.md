# Fashion_Setup_Assortments

- **Source:** `Fashion_Setup_Assortments.htm`

Fashion - Setting Up Default Fashion Assortments 
 
 
- 
 
 
 
# Defining Default Fashion Assortments

 

Default assortments save you time when itemizing fashion transactions, by displaying a specific assortment template for each combination of product type and distribution type. Each default represents the proportional distribution of the items in an assortment, not the actual transaction quantity. For example, if a certain type of store always requires twice as many Medium items as Large items, and twice as many Small items as Medium items, the values in the assortment matrix should be: S=4, M=2, L=1. This expresses the ratio between the three sizes in the lowest possible denomination. Later, when you are recording an actual inventory transaction, you can determine how many of each set are needed. 
 
## To define default fashion assortments:

 

 1 .  Enter the Product/DistribType Combinations form. 
 

 2 .  Select a Product Type and Distribution Type . 
 

 3 .  Enter the Assortment sub-level form and fill in the color/size matrix with the appropriate quantities. The Total Quantity of each color is calculated automatically.
 Tips: 
 

 ·              If the same assortment of sizes applies to several different colors, open one line for the default color code 00 and fill in the quantities in question, and they will apply to any color for which an assortment is not specifically defined in this form. 
 

 ·              To copy the distribution values from one color to all other colors in the assortment, place the cursor on the line for that color and select Copy Distribution from the list of Direct Activations . 
 

 4 .  Return to the upper-level form and open a new line for each possible combination of product and distribution types. 
 
## Notes:

 

 ·        When an assortment is defined for the combination of a given product type with distribution type 00 , that assortment appears in the Assortment sub-level of the Part Catalogue form as the default assortment for all new styles with that product type. 
 

 ·        Assortments that have been manually revised for specific parts can be reset to the default defined for the part's product type by retrieving the part in the Part Catalogue form and selecting Update Distribution by Prod Type from the list of Direct Activations . 
 

 ·        Each horizontal row, or set , in a style assortment represents the defined range of sizes for a single color in that style. Click to define separate part numbers or bar codes for specific sets .
