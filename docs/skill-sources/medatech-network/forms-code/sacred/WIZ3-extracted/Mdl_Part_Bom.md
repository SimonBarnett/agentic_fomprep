# Mdl_Part_Bom

- **Source:** `Mdl_Part_Bom.htm`

Modeling - BOM Intro 
 
 
- 
 
 
 
# Defining a Bill of Materials

 

A bill of materials (BOM) lists the raw materials and/or sub-assemblies required to manufacture a processed part. The processed part is called the parent part, and its components are called child parts. Child parts are either raw materials (type R ) or sub-assemblies (type P ) that require their own BOMs. 
 

The BOM contains the required ratio of child parts to parent parts, which may be fixed or variable, as well as the operation at which each child is joined to its parent. 
 

Sometimes it is expedient to record an imaginary part, called a phantom , in order to link together a group of child parts that appears in several different BOMs. Phantom parts are defined as type P and assigned the special Phanto routing; the parts it represents are recorded as its child parts. One of the advantages of a phantom is that you can make a small change to its BOM, and the kit lists of all its parent parts are updated automatically. Example.
