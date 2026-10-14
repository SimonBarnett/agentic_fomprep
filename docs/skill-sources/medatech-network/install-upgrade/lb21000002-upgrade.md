# lb21000002-upgrade

- **Source:** `lb21000002-upgrade.docx`

Priority Upgrade

Test Upgrade

Upgrade of Test server to newer (not necessarily the newest) Priority version/BIN version.

Run Daily Backup on the Test server

System Management > System Maintenance > Periodic Maintenance > Run Daily Backup.

Run Form preparation

System Management > Generators > Forms > Form Preparation > Form Preparation , and select Reprepare all forms.

Run Report & Procedure preparation

System Management > Generators > Reports > Prepare Reports & Procedures. and select Reprepare all.

Run View License

System Management > System Maintenance > Software Licenses > View License Details.

Run Renew License

System Management > System Maintenance > Renew License.

Tabula user must have email  support@medatechuk.com

Once run review the license is valid into the future.

Upgrade Priority

Open Priority dedicated client and run Help/Upgrade System.

Save file to local Upgrade folder.

Close Priority and run downloaded file as Administrator.

Save Installation Errors (if any) to Upgrade folder.
Then repeat steps until desired version reached.

Check table changes recorded in Std Trigger Chgs

For customer review all records in Standard Trigger Changes which are of type “T”. This indicates a table change. Review the comment and check that the table definition in Priority still matches. For example, a column may have been increased in length from 6 to 15. The check would be to ensure the column is still 15.

This will reveal if any table copies will be needed for the live upgrade.

To create table backups, run the following command in windbi, replacing table name as appropriate.

SELECT 'BEFORE', SQL.ENV, COUNT(*) FROM [TABLE_NAME] FORMAT ADDTO STRCAT('../../system/upgrades/[TABLE_NAME]- ',SQL.ENV, ' -COUNT.TXT');
 SELECT * FROM [TABLE_NAME]  DATA STRCAT('../../system/upgrades/[TABLE_NAME] -', SQL.ENV,'.BAK');

This has to be done for each company. Note that the company name is part of the filenames.

Live Upgrade

Upgrade of Live server to newer (not necessarily the newest) Priority version/BIN version.

Run Daily Backup on the Live server

System Management > System Maintenance > Periodic Maintenance > Run Daily Backup.

Run Form preparation

System Management > Generators > Forms > Form Preparation > Form Preparation.

Run Report preparation

System Management > Generators > Reports > Report Generator.

Run View License

System Management > System Maintenance > Software Licenses > View License Details.

Renew Priority License

Tabula user must have email  support@medatechuk.com

Run Renew License System Management > Revisions > Renew License

Upgrade Priority

Run installation file from Upgrade folder as Administrator

Save Installation Errors (if any) to Upgrade folder.

Repeat steps until all upgrade files run.

Check Log File for Database Errors

Review the server.log file for any references to database update errors.

Install Add-ons and Fixes

Install files from PM (*.sh, *.rv).

If there is no Emerge or Medatech upgrade option, use Install Upgrade.

Check revision files applied by reviewing System Management > Revisions > Version Revisions.

Apply Table Changes

Check that all table changes that existed before the upgrade are still in place. If not, PM needs to be contacted.

Is Form Alerts Fix Needed to be Applied to Upgrade?

The decision is not so much based on what version the customer is going TO, but actually what version they are coming FROM.

The way to check is in the form prep errors. Errors referring to ZEMG_COPYFORMALERTS or ZEMG_LOADFORMALERTS indicate that the fix is needed.

The following is an example from Fairey upgrade.

Stop Test Server from Sending Emails

In the desktop client, go to mail options:

In the resulting screen, enter rubbish in the user name, password and e-mail address fields.

Tick the send test email box and click approve, A message will be displayed saying the send failed.

Unassigned Privileges

Refer to process on Xpert site via this link:

https://support.priority-software.com/#/kb/FQ110124_E/English

How to identify and handle unassigned privileges
