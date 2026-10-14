# Priority Web-SDK Node Setup

- **Source:** `Priority Web-SDK Node Setup.docx`

Priority Web-SDK

Node & IIS Server

Setup

File Structure

Priority WebSDK has no special requirements when setting up file structure however we would like to keep the file structure consistent between clients.

We will need to create a folder for our project we will do this In Documents > Medatech > Node create a folder for your project here if any of the folders do not exist then you will need to create them.

IIS Settings

Open IIS Manager and right click the default website and click “Add

Application”.

We must now set the alias and the physical path, if we have called our project file “NodeProject” then we would put “NodeProject” as the alias and select the location of your project files this should be something like C:\Users\Medatech\Node\*NodeProject*

We can then click ok and proceed to setup our node project.

We will need to install the URL Rewrite module in IIS to allow us to access the server that priority is hosted on this is a requirement even if the server and node are on the same system.

You can download the module from https://www.iis.net/downloads/microsoft/url-rewrite once installed we will be required to restart IIS.

Open the project in IIS and select the project you have created double click to view the features window and you should be able to see the following features window.

Double click the URL Rewrite and in the top right corner you should see an option called “Add Rule(s)” click this then click “Reverse Proxy” and enter the link “localhost:3000” into the Inbound Rules section if you are running node on a different port than the standard 3000 then you will be required to make the relevant changes.

You should now see a new inbound rule in the top window of the URL Rewrite module like so.

After you have confirmed this restart IIS.

Install Node.js

If you haven’t got node installed you can download and install it from https://www.npmjs.com/get-npm once complete and you have verified the correct version is installed and any other required modules are downloaded for example if you would like to use express for your template then you will be required to install it using npm in the cmd prompt. Once installed you may create the project using the relevant code for your setup.

In the cmd prompt npm init to create a project if you are using express it may be an advantage to install the express-generator with npm install express-generator -g this will then install express.

Create Node Project

then run express *MyAppName* to create an application. Express or Pug(Jade) is the preferred method although any can be used.

Once you have created your app using the cmd prompt we can go the install directory and install all dependencies using the command npm install.

Test the Project

To run our project we must open the cmd prompt and type npm start You should be given a link like http://localhost:3000 if you can see the default page then node is setup.

To check node is setup for URL Rewrites we would need to go to our local priority page and type the alias from the IIS Settings page step this link would be something like http://*Priority-Server-URL*/*Alias* the result should be the same as http://localhost:3000.

Once this is setup we can then move on to developing for Priority using the WebSDK
