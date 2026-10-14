# Application Server

- **Source:** `Application Server.docx`

Application Server

Intro

Web server: Internet Service that works from the web browser.

Priority’s application server must use the default https protocol therefore port 443 must connect to the Priority site on the IIS

Priority is designed only to work with port 443, which is so Priority Support can assist

IIS Service: Windows optional components

It is mandatory for Priority application server

Select Web Server (IIS), then click next

Add all Web Server services

Under Application Development, choose one of the following options, then click next:

.Net Extensibility 4.6 or higher

AS

ASP .Net 4.6 or higher

ISAPI Extensions

ISAPI Filters

SSL Certificate

Self-Signed Certificate:

For internal use only

Accessed from app server itself

Others on the same network will get security warnings

Cannot be reached from outside organisation’s network

Organisation CA SSL:

Can connect on network without any security warnings

Authorised SSL:

Recommended

Accessible from the global internet

Required for API and Priority mobile

Bind Certificate to Default Website

Certificate must be a .pfx file with a known password and the windows user must be a local admin on the IIS server

IIS > Server Certificates > Create Self Signed Certificate

“issued to” should be the URL

Right-click “Default Website” > click “Edit Bindings…”

Add https protocol: Click “Add” > select https > make sure it’s 443 > host name empty > SSL Certificate: select certificate > Click ‘OK’

Import from inside the IIS: Server Certificates > Import… > … > Select certificate > insert pw for certificate > Click ‘OK’

Bind in the same way

reinstall the application server

This will install priority app and priority Redis services

FAQS

How Can I find the Priority Web application server?

System Management > System Maintenance > Internet Definitions > Application Server Maintenance > Application Server Attributes

In the “Application Server” column, you will see the name of the Application Server

What needs to be configured when running Priority without Internet?

When working offline with Windows interface, cancel the search for revocation of publisher certificates in Internet:

Enter Internet Explorer browser

Click the settings icon

In the settings menu, move to Advanced. Scroll to Security and remove the checkmark beside the “Check for publisher’s certificate revocation” column.

Click Apply

Click OK

User or Password are incorrect on priority web, although on local Priority thhe credentials work

In case and after fresh installation of Priority WEB the issue occurred:

Validate the Priority app service parameters as shown

Change the path of tabula.ini on Priority shortcut without prefix (without -t > would be redirected to tabula.ini on c:\windows)

Dete Priority App Service and Priority Redis Service [from cmd SC DELET “SERVICE_NAME”]

Reinstall Priority Web server

Error 500

Open a service call with Priority Software

Make sure you are working on the latest bin.95

Note if there are specific forms that cause the error

Check for messages in the server.log

Check for any DUMP files in the Priority/tmp folder

Are there any errors in the Windows Event Viewer?

See if you can find an issue on the website using Developer tools > Network tab. If you do, create a HAR file.

From browser - click refresh and try to recreate the issue – do you get a red line?

How to create a HAR file

From the browser – open developer tools from your Browser top menu

Go to the Network tab and refresh the Priority web page

Click on “Save Har file”

Errors will appear as a red line. You might be able to get more info from the error by double tapping it.
