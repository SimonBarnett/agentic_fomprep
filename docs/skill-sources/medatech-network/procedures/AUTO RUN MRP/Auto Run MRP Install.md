# Auto Run MRP Install

- **Source:** `Auto Run MRP Install.docx`

How to Install Auto Run MRP Procedure

Install the ZEMG_AUTORUNMRP.sh shell file.

Start Priority and open WINDBI

Open file ZEMG_AUTORUNMRP.q

Select Execute -> In All Companies

Adding new MRP parameters. (Optional)

In Form Generator, find and open ZEMG_MRPSETTINGSSETU, this will enable new records and possible values to be added.

Adjust procedure ZEMG_MRP_NOPROMPTS to read new values from table ZEMG_MRPSETTINGS for any of the compiled program in the MRP procedure.
