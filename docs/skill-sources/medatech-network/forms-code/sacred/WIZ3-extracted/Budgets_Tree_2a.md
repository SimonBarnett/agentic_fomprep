# Budgets_Tree_2a

- **Source:** `Budgets_Tree_2a.htm`

Budgets - Building a Budget Tree.3 
 
 
- 
 
 
 
# To define values for sub-categories:

 

 1 .  Enter each of the following forms in turn, as needed: 
 

 ·      Define Budget - Level 2 
 

 ·      Define Budget - Level 3 
 

 2 .  In each form, record a Budget Code (up to three characters) and Budget Description for each possible value.
 Notes: 
 

 ·      This code serves as a component in budget item codes. It is advisable to take this into consideration now, as the number of characters used for budget items is limited to the width of the Budget Item column in the Budget Items form. 
 

 ·      D ual-currency users: If you are working in a language other than English, and want to produce budget reports in English, record an English description in the Budget Desc ( Lang 2) column. 
 

 3 .  By default, the system allows you the option either of creating additional sub-categories beneath a given sub-category, or of assigning budget items to that sub-category directly (when building the budget tree). It also allows you to define rules that restrict the use of any given value to one of these options. To define such a rule, do one of the following: 
 

 ·      To prevent the assignment of budget items to the current sub-category, remove the check mark from the Allow Suffix column. Consequently, only additional sub-categories can be assigned to that value. 
 

 ·      To prevent the creation of intervening sub-categories between the current sub-category and the budget items themselves, leave the check mark in the Allow Suffix column and remove it from the Allow Another Level column. Consequently, only budget items can be assigned to that sub-category. 
 

 Note: When you build the actual budget tree, the system posts error messages to enforce these rules, provided that the BudValid constant (in the Financial Constants form) retains its default value of 1 . 
 

 4 .  To define sub-categories at Level 4, enter the Define Budget - Level 4 form. As this is the last possible level of sub-categories before the actual budget items, it is only necessary to fill in the code and description.
