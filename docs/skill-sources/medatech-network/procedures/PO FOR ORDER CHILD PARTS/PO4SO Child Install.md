# PO4SO Child Install

- **Source:** `PO4SO Child Install.docx`

How to Install Open Purchase Order for Sales Order Child Parts

System must have the ‘ERROR MESSAGE LOGGING’ add-on already installed

Install the ZEMG_POFORSOCHILD shell file.

Modify Standard Trigger PORDERS/BUF7 NB. Log details in Emerge system for the customer.

/* Insert from ORDERITEMS */

GOTO 71 WHERE :$.CORD = :$1.CORD ;

/* EMERGE CREATE PO FOR CHILD PARTS */

GOTO 71 WHERE :FORM_INTERFACE_NAME = 'ZEMG_LOADCORDPARTS';

/* End EMERGE CREATE PO FOR CHILD PARTS */

/* OR :$.CORD = 0 - Avia 10/01/06 */

/* Grisha 22/08/04 - OR :$.DEAL <> 0 */

GOTO 71 WHERE :$.ORD <> 0 AND EXISTS (SELECT 'X' FROM PORDERITEMS

WHERE ORD = :$.ORD);

:PORD = :$1.CORD; /**/

#INCLUDE PORDERS/BUF23 /* Delete Matrix */

GOTO 71 WHERE :$.CORD = 0;

:CORD = :$.CORD;

:PPROF = :$.PROF;

#INCLUDE PORDERS/BUF22 /* Insert Lines and copy Matrix */

LABEL 71;
