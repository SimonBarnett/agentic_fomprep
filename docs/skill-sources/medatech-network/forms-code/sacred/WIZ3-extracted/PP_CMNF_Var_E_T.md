# PP_CMNF_Var_E_T

- **Source:** `PP_CMNF_Var_E_T.htm`

PP_CMNF_Var_E/T 
 
 
- 
 
 
 

Machine time for the Sawing operation depends on the board's thickness (the sawing of 1 cm. of board takes 2 minutes). You would thus define the machine time variable for the sawing operation as follows: 
 

 ·        Variable: Board width 
 

 ·        Operand: Multiply ( M ) 
 

 ·        Coefficient: 2 (1 cm. /2 min.) 
 

Parts 610 and 620 are defined as 10 and 20 centimeter-thick wooden boards, respectively. In the Part Processing Parameters sub-level of the Parts form, the Value of the "Board width" Variable is defined as "10" for part 610, and "20" for part 620. 
 

The costing program will use these parameters to calculate the operation's machine time: 
 

Part 610: 10 (Value) ´ (Operand) 2 (Coefficient) = 20 min. (T) 
 

Part 620: 20 (Value) ´ (Operand) 2 (Coefficient) = 40 min. (T)
