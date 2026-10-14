# ZEMG_DOCPAT Rich

- **Source:** `ZEMG_DOCPAT Rich.docx`

Medatech Document Number Templates

Template Definition

Only tabula user may create new templates in this form or change the year option.

Setting year to 0000 means only one template record ever created, 2 or 4 digit means new record created for each year when required.

NB. No need to open template procedure appropriate year record created whenever becomes required.

Using Template Function

Example code to retrieve the next document number.

/*

** Make Next Document Number for current Year

*/

:i_PATNAME = 'HOLREQUESTS';

:i_PATDATE = SQL.DATE8;

#INCLUDE func/ZEMG_NEXTPATTERN

:$.HOLREQUESTNO = :o_DOCNO;

NB. If pattern year 0000 then value of :i_PATDATE is irrelevant.

NB2. The document number has been incremented, if value is not used (user does Control-Z) it is not returned or reused.
