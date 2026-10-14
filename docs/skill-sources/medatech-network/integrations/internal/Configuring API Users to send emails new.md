# Configuring API Users to send emails new

- **Source:** `Configuring API Users to send emails new.docx`

Configuring API Users to send emails

Log on to the IIS server

Log onto into Priority Web as the API user

Go to Office Management > Mail > Mail Options for Other Servers > Mail Options for Other Servers

In “Mail Server” enter YOUR MAIL SERVER

This is defined here: Office Management > Mail > Mail Options for Other Servers > Mail Servers

In “User Name” enter MAIL SERVER LOGIN

In “Password” enter MAIL SERVER PASSWORD

In “E-mail address” enter MAIL SERVER EMAIL ADDRESS

Leave “Use Outlook?” box unchecked

Click on “Approve”

This message will be displayed:

A test message will be sent to the server email address.

The API user should now be able to initiate email notifications via the business rules feature.

In version 20 and above:

System Management > System Maintenance > Constant Forms > System Constants

If you change the SENDMAILBY constant to 1 or 2 (for at least the API users), you can follow the steps above, but for tabula.
