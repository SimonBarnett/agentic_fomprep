# Error Message Logging Rich

- **Source:** `Error Message Logging Rich.docx`

Error Message Logging

R:\INSTALLED AS STANDARD\07 - ERROR MESSAGE LOGGING\ZEMG_ERRMSGLOG.sh

Installs new table ZEMG_ERRMSGLOG, trigger func/ZEMG_ERRMSGLOG and new menu

System Management > Database Interface > Error Message Logs with options: -

func/ZEMG_ERRMSGLOG

/****************************************************************/

/*                                                              */

/* ZEMG_ERRMSGLOG - Logs values from ERRMSGS table for current  */

/*                  user into log table with supplied process   */

/*                  name for use by matching form/report.       */

/*                                                              */

/* INPUT: :i_LOGGEDBY = String (upto 24 chars) to indicate      */

/*                      process which is logging the error      */

/*                      messages.                               */

/*                                                              */

/*        :i_MSGTYPE = Type of messages to log.                 */

/*        E.G. 'i' (default) for Form Interface Errors          */

/*                                                              */

/* OUTPUT: :o_LOGGEDMSGS = Number of messages logged.           */

/*                                                              */

/****************************************************************/

E.G.

EXECUTE INTERFACE 'ZTRX_ORDERWARSHASSM', SQL.TMPFILE, '-L', :$.GNL;

:i_LOGGEDBY = 'ZTRX_ORDERWARSHASSM';

:i_MSGTYPE = 'i';

#INCLUDE func/ZEMG_ERRMSGLOG

ERRMSG 800 WHERE :o_LOGGEDMSGS > 0;

Or to skip if no errors

GOTO <nnn> WHERE :o_LOGGEDMSGS <= 0;

NB.  If the function below does not exist on site then use ZEMG_ERRMSGLOGSP1.sh

func/ZEMG_ERRLOGINS

/****************************************************************/

/*                                                              */

/* ZEMG_ERRMSGLOG_INS - Logs supplied message for current user  */

/*                   into log table with supplied process       */

/*                   name for use by matching form/report.      */

/*                   This will only update if there is a value  */

/*                   in the :i_MSG string - check :o_LOGGEDMSGS */

/*                   to see if a record has been inserted       */

/*                                                              */

/* INPUT: :i_LOGGEDBY = String (upto 24 chars) to indicate      */

/*                      process which is logging the error      */

/*                      messages.                               */

/*                                                              */

/*        :i_LOGGEDDATE = date logged. This is an input so you  */

/*                        can ensure a consistant date/time     */

/*                        when calling many times in a procedure*/

/*                        Use :i_LOGGEDDATE = SQL.DATE; at the  */

/*                        start of your procedure               */

/*                                                              */

/*        :i_MSGTYPE = Type of messages to log.                 */

/*        E.G. 'i' (default) for Form Interface Errors          */

/*                                                              */

/*        :i_MESSAGE = message you want displayed up to         */

/*                     150 characters                           */

/*                                                              */

/* OUTPUT: :o_LOGGEDMSGS = Number of messages logged.           */

/*                                                              */

/****************************************************************/

E.G.

:i_LOGGEDBY = 'ZTRX_ORDERWARSHASSM';

:i_LOGGEDDATE = SQL.DATE;

:i_MSGTYPE = 'i';

:i_MESSAGE = 'Invalid status for Warehouse Assembly';

#INCLUDE func/ZEMG_ERRMSGLOG_INS

ERRMSG 800 WHERE :o_LOGGEDMSGS > 0;

Or to skip if no errors

GOTO <nnn> WHERE :o_LOGGEDMSGS <= 0;

View logged messages in form.

Or on Report

Delete procedure to remove old messages.
