# Process Run Logging Rich

- **Source:** `Process Run Logging Rich.docx`

Process Run Logging

Installs new table ZEMG_PROCRUNLOG, trigger func/ZEMG_PROCRUNLOC and new menu.

Used for logging any User processing you may wish to log was done. E.G. The use of a direct activation, the running of a procedure or even just entry into a particular form.

System Management > Process Run Log with options: -

func/ZEMG_PROCRUNLOG

/*****************************************************************/

/* ZEMG_PROCRUNLOG - Creates a Log entry that a process been run */

/*                                                               */

/* INPUT: :i_ENAME = Name of Process                             */

/*            E.G. :i_ENAME = '$';                               */

/*        :i_ETYPE = Type of Process                             */

/*            E.G. 'P' for procedure, 'F' for Form               */

/*        Optional values:-                                      */

/*        :i_DOCNO = Number of Document being processed          */

/*            E.G. DOCNO or ORDNAME or IVNUM etc.                */

/*        :i_DOCTYPE = Type of Document being processed          */

/*            E.G. 'D' for shipment, 'I' for invoice             */

/*        :i_EXTTYPE = Form running procedure Type               */

/*            E.G. 'D' for shipment, 'O' for Orders, 'C' for     */

/*                 Multi-Shipment Invoices                       */

/*                                                               */

/* OUTPUT: :o_PROCRUNID = Auto Unique of Procedure Run Log Entry */

/*****************************************************************/

E.G. For a Procedure SQLI step.  NB.  You can use the ‘$’ shortcut for procedure name.

NB. Does not work if in code that is #INCLUDE in a procedure step.

:i_ENAME = ‘$’;

:i_ETYPE = ‘P’;

#INCLUDE func/ZEMG_PROCRUNLOG

To include in the log details of the Sales Order the procedure is working on.

SELECT ORDNAME, TYPE, 'O' INTO :i_DOCNO, :i_DOCTYPE, :i_EXTTYPE

FROM ORDERS WHERE ……

:i_ENAME = ‘$’;

:i_ETYPE = ‘P’;

#INCLUDE func/ZEMG_PROCRUNLOG

E.G. For a Form PRE-FORM in this case ORDERS you cannot use the ‘$’ shortcut that works in procedure steps.

:i_ENAME = ‘ORDERS’;

:i_ETYPE = ‘F’;

#INCLUDE func/ZEMG_PROCRUNLOG

View logged processes in form

Or on Report

Delete procedure to remove old logs
