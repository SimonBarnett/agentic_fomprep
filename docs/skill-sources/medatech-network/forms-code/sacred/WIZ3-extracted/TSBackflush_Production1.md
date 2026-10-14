# TSBackflush_Production1

- **Source:** `TSBackflush_Production1.htm`

Troubleshooting Backflush Wizard - Missing Issues Following Production Reporting: Overview 
 
 
- 
 
 
 
# Missing Issues Following Production Reporting: Overview

 

The kit components of a given work order (appearing in the Kit List sub-level of the Work Orders form) are backflushed when you run the Backflush program, based on production reports for the operation in which they are integrated into the parent part for the work order . 
 

Components which are used during non-reported operations are backflushed when you report the next reported operation. 
 

Any items issued during a non-reported operation which is the last in the work order routing are backflushed only if the following conditions are met: 
 

 ·        the work order in question appears in the kit list of another work order, and 
 

 ·        the operation in which they are integrated into the parent part is reported. 
 

If the program cannot locate inventory for these items in the floor warehouses, missing issues are generated.
