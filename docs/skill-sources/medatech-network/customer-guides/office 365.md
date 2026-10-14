# office 365

- **Source:** `office 365.docx`

Setup Priority to work with office 365

Define a mail server

Path: Office > Mail > Mail Options for Other Servers > Mail Servers

Choose a mail server name

Set Mail Server Address as smtp.office365.com; SMTP Port as 587 and tick TLS

Set Mail Without outlook

Path: Office > Mail > Mail Options for Other Servers > Mail Options for Other Servers

Select the mail server (choose your mail server name)

Enter the username and password of the hosted mailbox

Enter the email address used to send emails (usually this is the same as the username)

Un-tick the use outlook box

Tick send test message

additional requirements

Allow ports 587 and 993 through the firewall

Restart your tabula task scheduler service (stop and then start)
