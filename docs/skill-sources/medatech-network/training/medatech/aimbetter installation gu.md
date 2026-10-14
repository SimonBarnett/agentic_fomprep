# aimbetter installation gu

- **Source:** `aimbetter installation gu.docx`

AimBetter

SaaS Monitoring and Management Tool

___

Installation Guide

Estimated time: 15 minutes.

Requirements:

Processor > 1 GHz Pentium® 4 CPU Memory > 1 GB RAM

Hard disk space > 200 MB (This free disk space should exist on a local hard drive) Operating system Microsoft Windows Server 2019 (64-bit)

Microsoft Windows Server 2016 (64-bit)

Microsoft Windows Server® 2012 R2 (64-bit) Microsoft Windows Server 2012 (64-bit) Microsoft Windows Server 2008 R2 (64-bit)

Microsoft Windows Server 2008 (32-bit and 64-bit)

Microsoft® Windows® 10 (32-bit and 64-bit)Microsoft Windows 8.1 (32-bit and 64-bit) Microsoft Windows 8 (32-bit and 64-bit)

Microsoft Windows 7 (32-bit and 64-bit)

NET: It is recommended to have the latest .NET version installed, (Minimum NET 4.5). Internet Access: Allow outbound traffic to Aimbetter on port 443.

Before starting, use the following link to access System Requirements, prepare your environment and check our Q&A.

Step 1: Sign Up

This level is only for new customers. If you're an existing customer, please proceed to step 2.

Create an account by following this link: https://app.aimbetter.com/signup/

Fill out your details and click “SUBMIT”:

Notes for registration::

Please avoid using signs like (* & ^%') if unnecessary.

If you have already signed up using your email and are having issues logging in, please contact the AimBetter team (attach your email or phone number)

You will receive an “AimBetter Account Confirmation” email to your specified email; click the verify box.

Then, you will receive the following message with your Identifier and a License Key. (The Identifier and License Key are unique for each client; save them in order to complete the installation).

.

!

Step 2: Download the Agent File

This step is only necessary if you install AimBetter Agent on a new Agent Server. If not, please proceed to step number 4.

Connect to the Server where you want to install AimBetter.

Notes:

The installation can be done either on the local Server itself or the Remote Server (usually specified application server).

Download the setup file from the following link (use Internet Explorer) -

http://update.aimbetter.com/

Open the Installation file

Click Run

Click Next

Tap on I accept, then Next

Click on Install

Finally, you will get the following screen:

By clicking finish, you will be prompted to configure your servers.

Step 3: Account Activation

This level is only necessary if you open Aimbetter Agent on a new Agent Server. In case you're just adding a new monitored server, please proceed to step 4.

Click on “Activate the account”

Complete the 'License Key & Identifier' that you received via email, then click on ‘Next’ :

Notes for setting keys:

In case you lost the License Key & Identifier, try searching through your mailbox again or contact AimBetter support at: support@aimbetter.com.

Wait until you see the message shown below, and then click “Next”.

If you haven't verified your account, check out your License Key & Identifier and make sure that Port 433 is open.

Step 5: Service Settings

Choose one of the following: 'This account' or 'Local system account'.

This account – in order to monitor from a Remote Server. Once you complete the installation, enter the domain user or local admin user on AimBetter Agent Service.

Local system account – if you install the agent on the server you want to monitor. [Take this option]

Notes for Service Settings:

We recommend choosing the local account option for both types of installations - on the local Server or via Remote Server. You can change this option later via Service login.

Verify that any choice you select has admin privileges in both Windows and SQL Server.

Avoid signing up with signs like (* & ^%') because it causes problems in our database.

You should receive this message and then click on 'Next.' :

15. Last step for account activation

Step 6: Adding Servers

Click "Add Server" to add the Windows server that AimBetter Agent will monitor

In "Add host," choose "Windows" and continue - if you want to monitor another hosting type, and then click on the following link (for Amazon or Azure installations).

If you see the following message: "You have reached the maximum number of hosts," please contact the support team.

Fill in the Remote Server details:

Name: General display name (UI)

IP/Name: Server name or IP.

It is recommended to enter the Server name.

To identify the name of the computer, go to “Server Management” then “Local Server.”

Note:

If you edit the Server's IP/Name after entering another IP already in Aimbetter's dashboard, it will define it as the same Server (and won't create a new server on the UI).

If everything was done correctly, you should see the green lights, as shown below.

Server status: red light means - no ping was established. WMI: red light means - you don't have permissions.

An example:

Note: If there is a green light and no data is being received correctly, ensure that WMI service is up.

Click on 'Add New DB' and add the relevant instance of the SQL Server.

Name General Name (UI). [Anything you want]

Server: Name of the correct Instance. [The sql instance name you would connect to in SSMS]

Note:

We can add several instances under the same host.

Choose the Server's access method: Windows/SQL Server Authentication

Note:

If the customer wants to configure the login as Windows Authentication, the user should have administrator permissions.

If the connection still doesn't work, check how many instances there are and if you are connected to the right one.

For SQL Server Authentication- please make sure that the user is a sysadmin user OR enter requirements (attach link) to create minimal permission SQL server user.

[TP] Used SQL Server Authentication here. Windows gave error. Aimbetter said to use SQLServer. sa password is generally same as tabula.

tabula is accepted when sa password is not available!

Reload Reloading Data:

Click on 'Restart Agent to ensure that all servers are in an operational state.

Note:

Make sure that all data is received correctly.

Internal Note:
At this point, add a task under the Aimbetter vendor in Priority to show it is currently installed. Task code: Ai, status: InProgress. You can also update the upgrades Trello.

[The following is no longer applicable]

To also monitor IIS, first ensure Aimbetter is installed on the IIS machine where the web server is on a different box. There is a big button at the bottom of above screen which says add IIS. If this is active, click it. If not, you need to change the server name to “.” as it states. Click the edit button in top of form which cause the window from step 18 to be displayed. Replace the server name entered in the field “IP / Name” with a dot. This should make the button active. Simply click it.

AimBetter System Connections TAB:

If you want to monitor the status of any type of connection – IP, URL, Folder, DB, Files, or a Query – this is what the connection feature is made for.

We have 6 types of connections. To activate it you should enter Aimbetter Configuration and click on the connection tab:

IP connection (Ping TAB in the UI)

Display name: The name you choose for the chosen IP in Aimbetter's UI. Value- the IP (numeric)

Advantage and ability – sends pings to the chosen IP or Server and shows if it's activated, and tests its connection.

URL connection:

URL of any website that you want to check the connection for.

Display name: The name that you choose for the chosen URL in Aimbetter's UI. Value – the website itself.

We enter it in the format of HTTP:\\

Advantage and ability- tests the connection of the website, if available, and how long it takes to enter it.

Folder

Any folder in a chosen drive that tests its connection to files and folders inside it. Display name: The name that you choose for the chosen folder in Aimbetter's UI. Value – the folder itself.

How do we set it up? Enter the chosen folder and copy its path:

\\SERVERDISPLAYNAME\d$\...\MSSQL13.

Advantage and ability - folder connection monitors several files and folders inside it, shows the changing values and their history in a graph, and tests the folder's connection speed.

DB Connection:

This tab enables connection to a chosen SQL server's Instance and brings data about availability and the connection's speed.

It doesn't show data about queries, databases, etc.

Display name – The name that you choose for the chosen instance in Aimbetter's UI. Value – the instance itself.

How do we set it up?

We click on EDIT CONNECTION STRING and define the SQL server instance as the usual way to define it when adding an instance to the monitor system.

To choose the right user for SQL server authentication, we must enter sysadmin user details.

Drive connection:

Connection of drives in the storage. Monitoring drive connections must be on a local installation.

File connection:

A connection to a specific file in the drive.

Display name: The name that you choose for the chosen file in Aimbetter's UI. Value – the file itself.

How do we set it up?

Enter the chosen file and copy its path, including the file name and the file type. Advantages and ability – tests the connection to the chosen file and monitors its size.

SQL Query connection:

A connection to a specific query.

Display name: The name that you choose for the chosen query in Aimbetter's UI. Value - the instance and the query itself.

Advantage and ability - this connection tests the duration of the execution of the chosen query. It has the ability to send an alert about the query's result by measuring the result over a specific value.

Step 7- Almost there! Last check

Open the following link: https://app.aimbetter.com

Type username and password. If this is your first time logging in, click on "Forgot Password" and create a new password.

Check that all tabs are compliant with data requirements. If you experience any issues, please contact AimBetter support at support@aimbetter.com.

Congrats!

We wish for your learning process to be quick and effective. Hope you will ﬁnd what you are looking for.

At your service, AimBetter team
