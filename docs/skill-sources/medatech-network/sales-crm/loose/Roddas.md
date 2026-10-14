# Roddas

- **Source:** `Roddas.docx`

Hi,

Our customer has both their RndBackflush constant and their RoundBalance constant set to round quantities.

They run the “Prepare issue to floor stock” procedure. This then pulls information about the bulk items which are required on the floor to a form called “Issues to Floor Stock” where they can be reviewed and approved. Parts with a factory unit of ea should only be issued in whole numbers, so any decimal should be rounded up. This does not seem to be happening. Please advise.

Question 2

The IFloorInv constant is set to 2 to prepare issues to floor stock based on open, released work orders. When actual production is reported as higher than the expected quantity, why when Prepare Issues to Floor Stock is run does it not take into account these differences and issue any required extra parts? (e.g boxes hold 6 tubs of cream, 7 tubs are made on a WO instead of the planned 6 and therefore another box and label needs to be issued ). Backflush will flag these issues up but surely this procedure should to. Please advise.
