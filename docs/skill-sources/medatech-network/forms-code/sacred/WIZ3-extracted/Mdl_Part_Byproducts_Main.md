# Mdl_Part_Byproducts_Main

- **Source:** `Mdl_Part_Byproducts_Main.htm`

Modeling - Byproducts Overview.1 
 
 
- 
 
 
 
# Working With Byproducts

 

In Priority , reporting a successful manufacturing operation usually results in the addition of a single part into inventory. However, the system also provides a special predefined operation called Byprod , which occurs uniquely in a predefined routing of the same name and results in the creation of several different inventory parts, called byproducts , from a single raw material, which we will call the source part . 
 

A simple example of this process is the creation of an entire table from a single wooden board. The kit list for the final product consists of one tabletop, four legs and eight struts (in addition to glue, nails, varnish and whatever else is necessary to finish the product). All of the wooden parts are thus child parts of the table. 
 

When we expand the product's BOM an additional level, we see that each wooden part has its own child part, and that they are all the same: one wooden board, which is large enough to be cut up into a tabletop, four legs and eight struts. This board is the source part, and the table parts are its byproducts. 
 

In technical terms, the source part is assigned the Byprod routing, during which it is “joined” to its parents, the byproducts. These latter are then joined to the top-level parent part (i.e., the table) during further operations in its own routing.
