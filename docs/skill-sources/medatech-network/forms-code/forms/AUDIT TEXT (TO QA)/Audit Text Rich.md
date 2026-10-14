# Audit Text Rich

- **Source:** `Audit Text Rich.docx`

Audit Text

Summary

This development allows you to create an audit trail of comments on a document.

Comments are automatically time stamped with the user and time/date.

This development can be plugged into any form with an Auto-unique on the base table.

Example of use:

Enter a comment in the Add to Store subform

Comment stored in read only in the Text Store and auto time-stamped.

Additional comments made:

Displayed in the Text store:

Installation

Install the ZEMG_AUDITTEXT.sh and associated .rv files.

Run ZEMG_AUDITTEXT.q through windbi.

Decide which order the client wants the text to appear in, and update the ‘TestStoreOrd’ constant in Emerge System constsants accordingly.  E.g. text stored in chronological order top to bottom (like a document) or bottom to top chronological order (like an email conversation).

Plug the new forms ZEMG_TEXTEDIT and ZEMG_TEXTSTORE into chosen upper level forms.  Ensure that in the expression for the DOC column on both forms that they point to the upper level forms auto-unique from the base table. (E.g. :$$.DOC, :$$.PART etc).

Set the type column in both ZEMG_TEXTEDIT AND ZEMG_TEXTSTORE to match the type of the upper level document.  Note:  If there is no type column, or you wish to use these forms more than once, ensure that the TYPE is unique for each time the forms are used on the system.

(Optional) Rename these subforms within the document using the Design > Form Design option within the upper level form.

(Optional)  For any printed documents that require the text to appear in them.  Add in the ZEMG_TEXTSTORE Report to a copied version of the procedure using the companies ZXXX Prefix.  Add in the OX ASCII OUTPUT for the report in the Procedure Parameters.  Also pass to the report two variables:

Name	Type	Details

DOC	INT	Autounique of the basetable

TYP	CHAR	Type setup as per step 5)

Also remember to update the Input step with the report.  Create the HTML Page, and update any print formats that require the report accordingly.

Any questions, talk to Matt Barker.
