# SOTI Training

- **Source:** `SOTI Training.docx`

SOTI/SFDC

Main aim is to deal with Customer questions revolving around interface issues.

PRIPROC

Has handlers that process data that is sent to a valid web address

EmergeWeb is on a server at Ridgeon

This server is where the data shown to the clients on SOTI is stored/ maintained

Emergeweb.ridgeonnet.com

Handles creation of Rules and deployment of Packages

The directory structure you see on SOTI is held in this server’s directory structure

Under C:\inetpub\wwwroot\soti

The image below shows 2 different views

The left is the directory structure on the server which can be changed

The right what is visible to download from the web address

Here is where files are stored to maintain the devices software.

Some details no certain files

100.sh/rv – Installation file to add a tick box in Priority forms (to include menu on a device)

Logo.bmp - The logo you see on the device

Provision.xml - Where all the customers users/passwords are stored

Sfdc3_1.cab - The Program for Priority on the handheld

SFDC3combined.sql – Code that is needed at install to be executed in SQL server per envirinment

Static_provision.xml – Extra users and passwords for test environments

In each companies directory (Client directory) there is a file structure specific to them

i.e. ATP

NET..Messages are messages displayed on the device

NET.arm is an operating system update for older devices

Medatech Priority

Customers have a feed address

They also have mobile users

This will create a record in the provisioning file within 30 mins

The WIKI

An important learning tool for SFDC/PDA covering many topics

http://dev.emerge-it.co.uk/

Our Test Environment

Erpdemo.emerge-it.co.uk

Quite a few transaction loaded. Is used to develop/test

Priproc console on the machine shows transaction history when active.

Some functionality will be done differently by different Companies, so Picking in ATP is different than Rodda and different than Trutex.

General Forms may be modified to work differently, so a warehouse transfer form may be different and is specific to a way the company works to minimise the scans needed.

SQL Server

Some forms cannot be handled in Priority SDK so the functionality has been written into SQL server functionality that when the device runs the code it is translated (ie Picking)

Services - The Queue

In Version 5, when a bubble of data is processed it will be saved in the queue under the environment performed against. A good data bubble goes thru the LOG structure, a bad data bubble will go thru the Badmail structure.

If the loading service is not running (or stalled) the bubble will be held at the queue waiting to be processed

Bubble data can be viewed, wordpad is best.

The last lines will give reasons what the problem may have been.

Mobicontrol

I use Firefox

Username is Administrator password is …………

https://soti.emerge-it.co.uk/mobicontrol/

You can view devices, blue means they are connected, grey not.

The above message may appear to view a device.

Click on Priority Icon

Either scan provision code or re-provision (new code)

An error message if a session is already open.

Will tell you who you are

Services

Use windows Services to control

You can stop/start these
