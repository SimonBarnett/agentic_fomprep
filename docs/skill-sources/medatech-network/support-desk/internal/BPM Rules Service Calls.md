# BPM Rules Service Calls

- **Source:** `BPM Rules Service Calls.pdf`

Medatech UK - SQL
Medatech UK, Cherry Mallam
18/11/25 16:13
BPM Flow Chart Service Call, Active Rules Only? Y
Rules
Service Calls
Path between Helpdesk and Open
286984
Allow status change to CherryM
Status Active
287026
After 1 minutes Change status to Helpdesk
Status Answered
286966
If "the previous value of Call Status" differs
from Update
then After 1 minutes Send e-mail to Contact:
<> <> has been
answered
We have answered your call about
<
Details
286967
After 2 weeks Change status to Closed
Status Call Updated
286993
If "Assigned to" differs from anybody.
then After 1 minutes Send e-mail to Assigned to:
Service call <> for
<> has been updated
Service Call <> about
<
Details
Status Cancelled
287003
If "the previous value of Call Status" differs
from New
then Send e-mail to Contact: Your service call
<> was cancelled
Hi <>
We cancelled your service call
<>. This is probably because
it was opened in error, or has been merged with
another call.
The call contents are attached.
Thanks
Medatech Support
Status Client Act
286975:Send email to Customer
After 1 minutes Send e-mail to Contact: <  Call Number>> <> <
Details
286976
After 1 minutes Send e-mail to
support@medatechuk.com: <>
<> <
Details
286977
After 4 weeks Change status to Helpdesk
286978
If "Assigned to" is equal to TimS
then After 4 weeks Send e-mail to
timscott@medatechuk.com: Call <> is
back from client action!
Hi Tim
Please review <> for customer
<>.
It is back in your action after remaining in
client act status for 4 weeks.
Thanks
Status Client Monit
287123
After 1 minutes Send e-mail to Contact: <  Call Number>> <> <
Details
287125
Rule

Medatech UK - SQL
Medatech UK, Cherry Mallam
18/11/25 16:13
BPM Flow Chart Service Call, Active Rules Only? Y
Rules
Rule
After 1 weeks Change status to Helpdesk
Status Esc to Exter
287133
After 4 weeks Change status to Helpdesk
Status Esc to PM
287039
If "Second Technician" is not blank
then Send e-mail to Second Technician: <  Number>> for <> is in your action
<> is escalated to you.
Please see attached for details.
287104
After 1 weeks Change status to Helpdesk
Status Esc to Prio
287091
After 3 months Change status to Helpdesk
Status Exter w/ upd
287073
After 5 minutes Change status to Esc to Exter
287074
After 1 minutes Send e-mail to Contact: <  Call Number>> <> has been updated
We have updated the attached service call
<
Details
Status Helpdesk
286971:William SSL
If "Assigned to" is equal to WilliamB and "Call
Type" is equal to SSL
then After 10 minutes Change status to Monitoring
286972:Critical alert
If "Severity Code" is equal to 1 and "Assigned
to" is equal to Support
then After 20 minutes Send e-mail to
support@medatechuk.com: Reminder call < Number>> is critical!
This critical call is still assigned to support
and is still in helpdesk status after 20
minutes! It needs to be allocated and looked
into ASAP!
Call: <>
Customer: <>
Details: <
Details
286974
If "Severity Code" is equal to 1 and "Assigned
to" is equal to Support
then After 20 minutes Send e-mail to
UKsupport@medatechuk.com: Reminder call < Number>> is critical!
This critical call is still assigned to support
and is still in helpdesk status after 20
minutes! It needs to be allocated and looked
into ASAP!
Call: <>
Customer: <>
Details: <
Details
Status Monitoring
286994
After 1 weeks Send e-mail to Assigned to: Is it
still being monitored?
Call <> has been in
monitoring status for 1 week and will no longer
close automatically. Can you please review it.
286995
After 2 weeks Send e-mail to Assigned to: Is it
still being monitored?
Call <> has been in
monitoring status for 2 weeks and will no longer
close automatically. Can you please review it.
286996
After 3 weeks Send e-mail to Assigned to: Is it
still being monitored?

Medatech UK - SQL
Medatech UK, Cherry Mallam
18/11/25 16:13
BPM Flow Chart Service Call, Active Rules Only? Y
Rules
Rule
Call <> has been in
monitoring status for 3 weeks and will no longer
close automatically. Can you please review it.
286997
After 3 months Change status to Helpdesk
Status New
286985:Assigned to reminder email 1h
After 1 hours Send e-mail to Assigned to: <  Number>> 1h in NEW status
<> has been in 'New' status
for 1 hour.
Please assign to Helpdesk so the customer
recieves
an email that somebody is looking at this.
286986:New SC raised
If "Call Source Number" is equal to W
then After 1 minutes Send e-mail to
support@medatechuk.com: <>
<> has been raised by< Name>>
<> has raised a new call on the
website Ref: <>.
286988
If "Severity Code" is equal to 1
then After 1 hours Send e-mail to SDCRITICAL:
CRITICAL Service Call needs attention
Service Call <> with severity
<> has remained in this
status for more than 1h.
286989
If "Severity Code" is equal to 1
then After 2 hours Send e-mail to SDCRITICAL:
CRITICAL SERVICE CALL 2H
Service Call <> with severity
<> has remained in this
status for more than 2h.
286990
If "Severity Code" is equal to 1
then After 8 hours Send e-mail to SDCRITICAL:
CRITICAL 8h unattended!!!
Service Call <> with severity
<> has remained in this
status for more than 8h.
286991
If "Assigned to" is equal to APIUser
then After 1 minutes Assign it to Support
286992
If "Assigned to" is equal to APIUser
then After 1 minutes Change status to Open
Status Open
286979
After 1 minutes Send e-mail to Contact: New
service call raised: <> RE:
<
Details
286980
After 2 minutes Change status to Helpdesk
286981
After 1 minutes Send e-mail to Third Technician:
We have logged <> RE: <
Details
Status PM w/ update
287046
After 1 minutes Send e-mail to Contact: <  Call Number>> <> has been updated.
We have updated the attached service call
<
Details
287047
After 5 minutes Change status to Esc to PM
Status Prio w/ upd.
287041
After 1 minutes Send e-mail to Contact: <  Call Number>> <> has been updated

Medatech UK - SQL
Medatech UK, Cherry Mallam
18/11/25 16:13
BPM Flow Chart Service Call, Active Rules Only? Y
Rules
Rule
We have updated the attached service call
<
Details
287042
After 5 minutes Change status to Esc to Prio
Status Quote Reqd
286999
If "the previous value of Call Status" differs
from Update or "the previous value of Call
Status" differs from Quote Req'd or "the
previous value of Call Status" differs from
Q-Auth-Reqd
then After 1 minutes Send e-mail to Contact:
Quote required for <>
We are working on preparing a quote for service
call <>.
287090
After 1 minutes Send e-mail to Assigned to:
Quote required for <> for < Number>>
Please create a quote for call number
<>
Status Re-ClientAct
287062
After 1 minutes Change status to Client Act
Status ReClientMont
287124
After 1 minutes Change status to Client Monit
Status Sched w/ upd
287067
After 1 minutes Send e-mail to Contact: <  Call Number>> <> has been updated.
We have updated the attached service call
<
Details
287068
After 5 minutes Change status to Scheduled
Status Update
287000
After 1 minutes Send e-mail to Contact: <  Call Number>> <> has been updated.
We have updated the attached service call
<
Details
287001
After 5 minutes Change status to Helpdesk
Status Web Update
287028
After 1 minutes Change status to Call Updated
Status With Client
287143
After 4 weeks Change status to Helpdesk
