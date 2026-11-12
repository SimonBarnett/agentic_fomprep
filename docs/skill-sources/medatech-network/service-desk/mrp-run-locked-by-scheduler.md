# A manual MRP run got stuck while the scheduler was running MRP

Issue type: a user starts MRP and it gets stuck at the same stage, and the scheduler also runs MRP.

Known: on 2026-09-03 a user reported their MRP run got stuck at the same point twice; a colleague had to stop the process the first time. Support saw that MRP had run successfully overnight. On 2026-09-08 support found the user had been running MRP at the same time as the Tabula Task Scheduler was running MRP, so the procedure was locked, and pointed to the error messages in Purchasing > MRP for Manufacturers > History of MRP Runs. On 2026-09-10 the user said they had not had the issue since. User names are not stored.

This is not a data error in the MRP input. Do not keep restarting MRP while another run is going.

## Steps

1. Open History of MRP Runs and check for lock or error messages at the time of the stuck run.
2. Check the TTS tasks for a scheduled MRP run, and when it runs.
3. Ask the user to wait until the scheduled run has finished, or run MRP at a time that does not overlap.
4. Run MRP again and check it completes.

## Verification

Proven: after support explained the overlap, the user had no further issue (SC262717, customer-verified).

Not proven: how long the scheduled run takes, and whether a stuck process had to be cleared by an admin.

## Stop

Stop if no other MRP run overlapped. Then escalate with the time and the History of MRP Runs entries.
