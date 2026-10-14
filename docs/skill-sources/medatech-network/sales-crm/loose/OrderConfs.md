# OrderConfs

- **Source:** `OrderConfs.docx`

In your standalone Priority:

First make a part and import an image to the part image (not the document for part sub form)

Then create an order for this part

Create the test procedure

Procedure below explanation:

The procedure will create a file (defined as a parameter in the above screenshot), link orders table to populate the file with the selected order(s). This file is then used to tell which orders to execute the standard priority WWWSHOWORDER (print order confirmation)  procedure on. The result is output to the TEST.pdf file which is then attached to an email and sent. There are two lines to indicate sending the message. The first (commented out) is for external mail and the second is for internal (to a user not an email address). We are only interested in the external mail line in this case.

The print format selected is the one to include images.

The email address should be changed to an external one (gmail etc not our medatech email addresses) for this test.

:FIL = 'C:\tmp\TEST.pdf';

LINK ORDERS TO :$.MAL;

GOTO 99 WHERE :RETVAL <= 0;

INSERT INTO ORDERS

SELECT * FROM ORDERS ORIG

WHERE ORDNAME = 'SO16000001'; /*whatever order you’d like to print*/

/**/

:EXEC = 0;

SELECT EXEC INTO :EXEC FROM EXEC

WHERE TYPE = 'P' AND ENAME = 'WWWSHOWORDER';

UPDATE PRINTFORMAT SET VALUE = -3

WHERE EXEC = :EXEC AND USER = SQL.USER;

EXECUTE WINHTML '-d', 'WWWSHOWORDER', 'ORDERS' ,:$.MAL, '-pdf',

:FIL ;

SLEEP 2;

/*

MAILMSG 1 TO  EMAIL 'cherrymallam@medatechuk.com' DATA :FIL ;

*/uncomment the above line and comment out the below when you run this when external mail has been set up

MAILMSG 1 TO  USER 1 DATA :FIL ;

UNLINK AND REMOVE ORDERS;

LABEL 99;

Schedule the procedure

The procedure is then added to the scheduler.

The test is to see if sending the .pdf order confirmation via the scheduler to an external email address will result in being able to see images or not within the .pdf

Please try to get an answer and when you have one please update the Priority call S1602029 to let them know. You can include this document to show what steps were taken in the test.

There should be all this detail and more in the service call and Christine is knowledgeable about this if you are stuck and she is available…

thanks
