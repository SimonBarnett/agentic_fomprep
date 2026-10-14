# Budgets_Tree_2

- **Source:** `Budgets_Tree_2.htm`

Budgets - Building a Budget Tree.2 
 
 
- 
 
 
 
# To define values for main categories:

 

 1 .  Enter the Define Budget - Level 1 form. 
 

 2 .  Record a Budget Code (up to eight characters) and Budget Description for each possible value.
 Note s: 
 

 ·      This code serves as a component in budget item codes. It is advisable to take this into consideration now, as the number of characters used for budget items is limited to the width of the Budget Item column in the Budget Items form. 
 

 ·      D ual-currency users: If you are working in a language other than English, and want to produce budget reports in English, record an English description in the Budget Desc ( Lang 2) column. 
 

 3 .  By default, the system allows you the option either of creating sub-categories beneath each main category, or of assigning budget items to a main category directly (when building the budget tree). It also allows you to define rules that restrict the use of any given value to one of these options. To define such a rule, do one of the following: 
 

 ·      To prevent the assignment of budget items to the current main category, remove the check mark from the Allow Suffix column. Consequently, only sub-categories can be assigned to that main category value. 
 

 ·      To prevent the creation of intervening sub-categories between the current main category and its assigned budget items, leave the check mark in the Allow Suffix column and remove it from the Allow Another Level column. Consequently, only budget items can be assigned to that main category value. 
 

 Note: When you build the actual budget tree, the system posts error messages to enforce these rules, provided that the BudValid constant (in the Financial Constants form) retains its default value of 1 .
