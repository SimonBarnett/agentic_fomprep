# ZEMG_CHANGEDOCSTATUS

- **Source:** `ZEMG_CHANGEDOCSTATUS.txt`

~~~
/******************************************************************/
/* func/ZEMG_CHANGEDOCSTATUS (Requires func/ZEMG_ERRMSGLOG)       */
/* Changes the status of any DOCUMENTS table based form.          */
/* DOCUMENTS_A through DOCUMENTS_Z (inc. H & Q !) plus e, m & p   */
/* Returns number of any errors that occurred.                    */
/*                                                                */
/* INPUT: :i_DOC (INT) = ID of DOCUMENTS record to change status  */
/*        :i_STATDES (CHAR) = Full Status Description required OR */
/* single character for flagged statuses, Draft, Cancel, Final    */
/* 'D' for INITSTATFLAG, 'C' for CANCELFLAG, 'F' for FINALFLAG    */
/*                                                                */
/* OUTPUT: :o_LOGGEDMSGS = Number of error logged NB. <= 0 is OK  */
/******************************************************************/
~~~
