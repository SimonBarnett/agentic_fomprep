# SOP Creating BOM Revisions

- **Source:** `SOP Creating BOM Revisions.pdf`

Cat.No.LB09000169 1 Ver.1 – Apr.22,’09 
 
SOP: Creating BOM Revisions* 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 Itemization of raw materials, components and sub-assemblies required for the 
production of a processed part (Type P), together with their required quantities. 
Working Assumptions 
 The parent parts have been defined in the Part Catalogue as Type P parts. 
 The child parts have been defined in the Part Catalogue as Type R parts. 
Procedure 
1. Enter the Parts form and retrieve the desired parent part. 
2. Click the Additional Details tab and flag the BOM Revisions column. 
3. Enter the BOM Revisions sub-level form and open a current revision. Indicate a 
BOM Revision Number and a Description. 
4. Specify the date on which the revision goes into effect in the Effect Date column. The 
End Date will be filled in automatically when you leave the line. 
Note: The end date of the previous revision (if there is one) is automatically updated 
to the effect date defined for the new revsion. 
5. Enter the next sub-level form, Child Parts, and itemize the child parts. 
6. For each child part, indicate the required quantity for production of a single unit of the 
parent part in the Qty(Child) column. 
7. Indicate the percentage of scrap. 
8. Return to the BOM Revisions form. 
9. To authorize the revision, flag it as Authorized. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No.LB09000169 2 Ver.1 – Apr.22,’09 
Notes: 
 When a child part is a sub-assembly, it should be treated as a parent part and its child 
parts should be defined in the same fashion. 
 In the Parent Parts sub-level form, the part's parents can be viewed. 
 To record a related part, define it as a child part of a Type R part (raw material). The 
Info Only column will be flagged automatically. 
 You can define an authorizer list for BOM revisions in the Revision Authorizers form. 
Consequently, the username of the next person to authorize (based on the defined 
sequence) appears in the Next Signature column of the BOM Revisions form. That 
user can then enter the sub-level form, Revision Authorization, and flag the 
Approve column on the line for his/her name. The revision is not fully authorized until 
all authorizers have approved it. 
Results 
 A BOM revision is created, detailing the components required for the processed part 
(Type P) and their required quantities. The components are the child parts; the 
processed part is the parent part. 
 The BOM of one or more more specific parts can be viewed by running the Part 
Explorer program. 
 BOM data can be viewed in a variety of cross-sections. See the reports in the Bill of 
Materials Reports menu.
