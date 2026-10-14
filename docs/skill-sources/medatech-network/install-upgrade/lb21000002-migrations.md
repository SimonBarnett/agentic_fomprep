# lb21000002-migrations

- **Source:** `lb21000002-migrations.docx`

Priority Migrations Manual

Description

Migrations are a mixture of a Restore plus a manual refresh.

The steps are:

Follow the restore guide to create a copy of the live server on the new server. Note that if on Ridgeon servers you will need an SSL. If the user has a test SSL this can be borrowed. If they are the customers own servers then a manual SSL can be created. The customer will need to make DNS changes for access. Note that if the customer is migrating to a database server and Application server, the application server will be installed on the relevant server.

Copy over any other folders that are deemed appropriate.

Customer to test to determine if all working correctly. Important to understand if any software missing i.e. Bartender etc. The purpose is to create a replica of the live system.

Carry out a manual refresh at live migration time.

The manual refresh does not need tts or search server re-installed. However, the application server will need to be re-installed to use the correct URL.

Manual Refresh

Note: “Live server” refers to current live and “New Live” refers to server we are migrating to.

At migration the customer needs to change the DNS mappings so that the test URL no longer maps to the New Live server and the live URL does map to the New Live server. This has to be done once users have stopped using the system.

Make sure nobody is logged in on the Live server.

Stop services on the Live server (App, Redis, Search, TTS). Set to manual so they cannot start again.

Stop services on the New Live server. Set to manual so they cannot start again.

Detach DB’s on New Live server in SSMS. These are going to be replaced by the databases from the Live server.

Right click on database and select “Detach”:

Select the check boxes and click ok.

Delete DB’s on the New Live server in file manager.

On the Live server, start SSMS and detach the DB’s are described previously.

Copy the database files *.mdf and *.ldf from Live to New Live into the MS SQL folder you deleted the databases from previously. Only copy the Priority database file i.e. not master etc.

On the New Live server, in SSMS, right click on Databases and select Attach.

Click Add and select database copied from Live to New Live.

Repeat for all copied databases.

Copy system\mail and system\reports folders from Live to New Live.

Check for any other folders on Live that need to be copied across. Most should have been done and identified with initial restore and customer testing.

Check the file permissions as described in install guide.

Depending on when the restore was done originally on the New Live server, the users defined in New Live may not match those defined in Live. Do a manual comparison and add any missing users. You need to check Security>Users. Each data has its own set of users but these will be fine as the databases were copied. If the Users do no exist in the SQL instance then they will not be able to log in. Refer to section “Logins recovery and restore” in the refresh manual for more information.

Delete the Priority Backup folder.

On the Live server export the SSL certificate and copy it to New Live.

On the New Live server import the certificate into IIS.

Change the bindings in IIS to use the new certificate on New Live server.

On New Live server start the dedicated client and check forms, reports and procedures work.

On New Live Server, re-install the app server using the live URL. Note, if separate application server, start dedicated client on application server and install. There is no need to re-install the dedicated client.

Start the Redis and Application services. Note they were set to manual previously.

Check that access through the web browser works and test forms, reports and procedures.

Run a Priority backup through the dedicated client.

Check the tts tasks and ensure that the backup tasks are mapped to correct drive, in case New Live server has different drives.

Start the tts and review logs to make sure it is running ok.

Start the search service.

Rebuild the search index.

Customer will need to setup server email as it will have been disabled as part of the original restore.

Things to consider when planning a Migration

Is the SQL version changing.

Are they upgrading as well
