# Overnight MRP ran without Purchase Planning, so no purchase demands

Issue type: a nightly scheduled MRP raises work orders but no purchase demands, and the user believes the parameters are the same as a company where it works.

Known: support first asked which company was affected: one company was raising purchase demands and the other was running MRP without Purchase Planning. On 2026-10-12 15:44 BST support said the overnight MRP had not run with Purchase Planning, and to run MRP with Purchase Planning, update the user input, then run Refresh Task Input by User. On 2026-10-13 09:32 BST the customer said they had done that. On 2026-10-20 09:26 BST the customer said all resolved. Company names and part numbers are not stored.

This is not an MRP calculation defect or a missing supplier. Check which company the scheduled task runs in before comparing parameters.

## Steps

1. Ask which company the missing purchase demands are in. Compare the scheduled MRP run in that company, not a similar company.
2. Check whether the scheduled run used MRP with Purchase Planning or plain MRP.
3. In the affected company, run MRP with Purchase Planning once interactively with the agreed parameters, so the user input is saved.
4. Run Refresh Task Input by User so the scheduled task picks up that saved input.
5. After the next overnight run, confirm purchase demands are raised as expected.

## Verification

Proven: after the run and input refresh, the customer reported all resolved a week later (SC263116).

Not proven: the exact scheduled task name, and whether other users scheduled tasks needed the same refresh.

## Stop

Stop if the run already uses Purchase Planning, or if demands are still missing after the refresh. Then compare part planning data, not the schedule.
