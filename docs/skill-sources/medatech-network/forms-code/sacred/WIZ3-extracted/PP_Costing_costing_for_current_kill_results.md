# PP_Costing_costing_for_current_kill_results

- **Source:** `PP_Costing_costing_for_current_kill_results.htm`

PP_Costing_costing_for_current_kill_results 
 
 
- 
 
 
 

It's easy to understand why the results of Costing for the Current Date are overridden by the results of a later run of the same program. But why are they overridden by the results of Costing for a Past Balance Date ? 
 

The answer is that when costing calculates costs and inventory values for a date in the past, these costs affect part costs in any inventory transaction recorded after that date. Therefore, costing calculations for the current date, which were based on data from before the costing run, are not accurate and should be deleted.
