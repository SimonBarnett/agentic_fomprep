# SOX Documentastion Procedure (7)

- **Source:** `SOX Documentastion Procedure (7).docx`

SOX Documentation Procedure

Purpose: To test new programming on test servers before installation on Production server, and preparing a SOX document that will document the testing procedure and the results.

Remark: In this document, instructions starting with "(MedaTech)" are relevant to MedaTech employees only.

Connecting to DW's servers:

(MedaTech) All connection details can be found in the Cust under customer 24832.

Connect to the VPN address:

https://ott-vpn01-p.dragonwaveinc.com/medatech

Enter your Username and Password:

In the opened list of servers, choose the server you want to connect to.

Enter the same Username and Password as in step 2.

Testing

Step I: Testing on Test Server 05

Enter Priority on Test05 development server.

Username: tabula

Password: test1

Test the programming according to the design received, applicatively (and from the point of view of the end user).

Document the testing procedure in the SOX document (will be explained below in a different section).

Whenever a problem is discovered in the programming, or a doubt is raised during testing, email the programmer, Hana (hana_s@medatech.com) and DragonWave_Team (DragonWave_Team@medatech.com).

After the programming is fixed and a new shell is created, test the relevant part/s again.

Step II: Installing & Testing on Test Server 06

Once testing on Test05 is done, copy the shell (the name of the file is the shell number) from D:\Priority\system\upgrades folder to \\EAGLES\backup2\upgrades\In Testing folder.

Enter Priority using the "Run as administrator" option:

Username: tabula

Password: test2

Run "Install Upgrade" procedure and choose the shell to be installed from "In Testing" folder.

After approving, you'll be asked to re-enter the password for tabula user.

When the system finishes to install the shell, a message will be presented;

If it indicates that errors were encountered during the installation, run the "Install Upgrades-Errors" report from "Revisions" menu and send a screen shot of the report to the programmer.

After the programmer finishes fixing the errors, make sure the shell was re-prepared and reinstall it on Test06 server as instructed on steps 2-4 above.

Follow the testing instructions you wrote for Test05 server, to test the shell on Test06 server.

Again, whenever a problem is discovered in the programming, or a doubt is raised during testing, email the programmer, Hana and DragonWave_Team and continue the testing after the programming is fixed.

When testing is complete, send an email to Hana and DragonWave_Team.

SOX documentation

Create a new SOX document using the template: P:\dragonWave\SOX\ SOX documentation-TEMPLATE-new.docx.

The document will include instructions on how to perform the testing for the specific shell along with the description and screen shots of the results received.

All of the possible scenarios should be tested and documented.

(MedaTech) Files Update

When the programming is ready for testing, the programmer marks the installed on test5 (programming done) columns.

When the SOX doc is completed and the upgrade is ready to be released, the tester should update the following fields in the Upgrades file in MedaTech network (path: P:\dragonWave\SOX\Upgrades-New-Apr.xlsx): installed on test06 and SOX.
