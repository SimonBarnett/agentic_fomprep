# Login timeout expired

- **Source:** `Login timeout expired.docx`

Windows interface: "Login Timeout Expired."

English |

All Databases |

All Versions |

Note: If the message was received in all workstations, after switching servers or on the server itself, skip to sections II-IV, respectively.

I. If the message was received when entering the system from a workstation:

Check the following and follow the respective instructions:

Ensure that the firewall on the workstation/server is not blocking communications between the server and workstation.

You entered the wrong username/password. Try entering the system as the tabula user.

The port is blocked. The client may be unable to communicate to SQL Server through port 1433. To check whether this is the case, open a DOS command window and run the following command: telnet servername port

where servename is the name that appears in the tabula.ini file under the Tabula host heading and port is the number of the port that the SQL server is listening on (the default port is 1433). If you receive a message indicating that the connection failed, meaning that the port in question is blocked, have your system administrator open the port in question.
Notes:
- To access the tabula.ini file, move to the C: drive in the server and open the Windows folder. 
- When working with SQL Server 2012, see also the explanation here.

Connectivity problems. Check that the connection with the SQL server is okay. You can test the connection by attempting to connect to the SQL server via ODBC:

Double-click the Administrative Tools icon in the Windows Control Panel and open Data Sources (ODBC).

Click Add.

Move to the SQL Native Client line.
Note: If the line does not appear in the list, the client was not properly installed. Reinstall the client by running the sqlncli.msi program from the system installation sub-directory of the client/misc folder on the server. You can also download the file from the Microsoft web site.

4. Enter any Name and Description, and select the Server precisely as it appears in the c:\windows\tabula.ini file under Tabula Host.

5. Click Next.

6. Flag the With SQL Server authentication and Connect to SQL Server lines.

7. Enter the tabula username and the corresponding password.

8. Click Next.

If at this stage you receive a connection error, there is a problem in the connection to the SQL server from the current workstation. Follow the instructions detailed in the error message or consult an SQL specialist.
Note: At this point, it is recommended that you uninstall SQL Native Client using Add or Remove Programs (in the Control Panel) and download the latest installation file from Microsoft's web site.

If no error message appears, the connection is successful. If you still can't connect to Priority, continue with item #4 below.

4. Priority was installed on a workstation with an old Windows operating system. Upgrade your operating system to a supported version of Windows and reinstall the client.

5. There is a problem with the tabula.ini file.

On Windows 7: Check whether the tabula.ini file appears in the C:\Users\username\AppData\Local\VirtualStore\ Windows folder. If so, this file must be deleted.

Open the tabula.ini file (in the Windows folder on the C: drive in the server). Check the value appearing in the Tabula host line, which represents the name of the server and SQL installation:

Compare that value to what appears in the srvpath file (located on the server, in the priority/system folder).

Make sure that the server name is defined with a backslash ( \ ) rather than a forward slash ( / ).
For example, XYZ\ESHBEL_PRIORITY is a valid server name while XYZ/ESHBEL_PRIORITY is an invalid name.

6. The workstation is not connected to the server. Perform a Ping test from the workstation.

II. If the message is received when entering the system from all workstations:

It is possible that the SQLServer Browser was not started successfully.

To ensure that the SQLServer Browser service has been started:

In the Control Panel, select Administrative Tools > Services to launch the Services manager.

Scroll down to the line for the SQLServer Browser and make sure it is listed as Started. If not, right-click the service and select Start.
Tip: If the Start option is greyed out, change the Startup type to Automatic to initialize the service.

III. If the message was received after switching servers:

In SQL Server, the Login and the User are two separate entities. The Login is the username on the server and is set for each SQL installation. The User is set separately for each database. Every user on Priority has a Login on SQL and a User on every database (with the same username). It is possible (for instance, due to an error when moving users to the new server) that there is a Login not linked to any User. In such a case, you need to switch the users again.

IV. If the message was received on the server:

It is possible that the Priority service was not started successfully.

To ensure that the Priority service has been started:

In the Control Panel, select Administrative Tools > Services to launch the Services manager.

Scroll down to the line that says SQLSERVER(ESHBEL_PRIORITY), and make sure it is listed as Started. If not, right-click the service and select Start.
