# BPM Flow chart rules 31.07.26

- **Source:** `BPM Flow chart rules 31.07.26.pdf`

Medatech UK - SQL
Medatech UK, Cherry Mallam
31/07/26 10:57
BPM Flow Chart Service Call, Active Rules Only? Y
Rules
Service Calls
Path between Helpdesk and Open
309086
Allow status change to CherryM
309260
Allow status change to GemmaL
Status Active
309128:Auto change status to Helpdesk
After 1 minutes Change status to Helpdesk
Status Answered
309071:Auto set to closed
After 2 weeks Change status to Closed
309249:Answered Status email
After 1 minutes Send e-mail to Contact:
309263:COPY to Support
After 1 minutes Send e-mail to
support@medatechuk.com:
Status Call Updatd
309095:email to technician
If "Assigned to" differs from anybody.
then After 1 minutes Send e-mail to Assigned to:
Service call <> for
<> has been updated
Service Call <> about
<
Details
Status Cancelled
309250:Cancelled Status email
If "the previous value of Call Status" differs
from New
then Send e-mail to Contact:
309271:COPY to Support
If "the previous value of Call Status" differs
from New
then Send e-mail to support@medatechuk.com:
Status Client Act
309079:bounce back to helpdesk
After 4 weeks Change status to Helpdesk
309080:Tim Email
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
309251:Client Action Status email
After 1 minutes Send e-mail to Contact:
309264:COPY to Support
After 1 minutes Send e-mail to
support@medatechuk.com:
Status Client Monit
309227:bounce back to helpdesk
After 1 weeks Change status to Helpdesk
309257:Client Action Status email
After 1 minutes Send e-mail to Contact:
309265:COPY to Support
After 1 minutes Send e-mail to
support@medatechuk.com:
Status Esc to Exter
309235:bounce back to helpdesk
After 4 weeks Change status to Helpdesk
Status Esc to PM
Rule

Medatech UK - SQL
Medatech UK, Cherry Mallam
31/07/26 10:57
BPM Flow Chart Service Call, Active Rules Only? Y
Rules
Rule
309141:Email Esced to
If "Second Technician" is not blank
then Send e-mail to Second Technician: <  Number>> for <> is in your action
<> is escalated to you.
Please see attached for details.
309206:Auto bounce back to helpdsek
After 1 weeks Change status to Helpdesk
Status Esc to Prio
309193:bounce back to helpdesk
After 3 months Change status to Helpdesk
Status Exter w/ upd
309175:back to esc to external
After 5 minutes Change status to Esc to Exter
309256:Update Status email
After 1 minutes Send e-mail to Contact:
309269:COPY to Support
After 1 minutes Send e-mail to
support@medatechuk.com:
Status Helpdesk
309074:William SSL
If "Assigned to" is equal to WilliamB and "Call
Type" is equal to SSL
then After 10 minutes Change status to Monitoring
309075:Critical alert
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
Status Monitoring
309099:bounce back to helpdesk
After 3 months Change status to Helpdesk
Status New
309087:Assigned to reminder email 1h
After 1 hours Send e-mail to Assigned to: <  Number>> 1h in NEW status
<> has been in 'New' status
for 1 hour.
Please assign to Helpdesk so the customer
recieves
an email that somebody is looking at this.
309088:New web SC raised
If "Call Source Number" is equal to W
then After 1 minutes Send e-mail to
support@medatechuk.com: <>
<> has been raised by< Name>>
<> has raised a new call on the
website Ref: <>.
309090:Critical Email to Internal
If "Severity Code" is equal to 1
then After 1 hours Send e-mail to SDCRITICAL:
CRITICAL Service Call needs attention
Service Call <> with severity
<> has remained in this
status for more than 1h.
309091:Critical Email to Internal
If "Severity Code" is equal to 1
then After 2 hours Send e-mail to SDCRITICAL:
CRITICAL SERVICE CALL 2H
Service Call <> with severity
<> has remained in this
status for more than 2h.
309092:Critical Email to Internal
If "Severity Code" is equal to 1
then After 8 hours Send e-mail to SDCRITICAL:

Medatech UK - SQL
Medatech UK, Cherry Mallam
31/07/26 10:57
BPM Flow Chart Service Call, Active Rules Only? Y
Rules
Rule
CRITICAL 8h unattended!!!
Service Call <> with severity
<> has remained in this
status for more than 8h.
309093:Auto assign web calls to support
If "Assigned to" is equal to APIUser
then After 1 minutes Assign it to Support
309094:Auto assign web calls to open
If "Assigned to" is equal to APIUser
then After 1 minutes Change status to Open
Status Open
309082:Auto Change to HelpDesk
After 2 minutes Change status to Helpdesk
309083:Email Raised by
After 1 minutes Send e-mail to Third Technician:
We have logged <> RE: <
Details
309248:Open Status email
After 1 minutes Send e-mail to Contact:
309261:COPY to Support
After 1 minutes Send e-mail to
support@medatechuk.com:
Status PM w/ updte
309149:bounce status back to esc to pm
After 5 minutes Change status to Esc to PM
309253:Update Status email
After 1 minutes Send e-mail to Contact:
309266:COPY to Support
After 1 minutes Send e-mail to
support@medatechuk.com:
Status Prio w/ upd.
309144:back to esc to prio
After 5 minutes Change status to Esc to Prio
309255:Update Status email
After 1 minutes Send e-mail to Contact:
309268:COPY to Support
After 1 minutes Send e-mail to
support@medatechuk.com:
Status Quote Reqd
309192:email technician
After 1 minutes Send e-mail to Assigned to:
Quote required for <> for < Number>>
Please create a quote for call number
<>
309254:Quote Reqd Status email
After 1 minutes Send e-mail to Contact:
309262:COPY to Support
After 1 minutes Send e-mail to
support@medatechuk.com:
Status Re-ClientAct
309164:back to client action
After 1 minutes Change status to Client Act
Status ReClientMont
309226:back to client monit
After 1 minutes Change status to Client Monit
Status Sched w/ upd
309170:move back to scheduled status
After 5 minutes Change status to Scheduled
309252:Update Status email
After 1 minutes Send e-mail to Contact:
309270:COPY to Support
After 1 minutes Send e-mail to
support@medatechuk.com:
Status Updte
309103:Auto bounce back to helpdesk

Medatech UK - SQL
Medatech UK, Cherry Mallam
31/07/26 10:57
BPM Flow Chart Service Call, Active Rules Only? Y
Rules
Rule
After 5 minutes Change status to Helpdesk
309258:Update Status email
After 1 minutes Send e-mail to Contact:
309267:COPY to Support
After 1 minutes Send e-mail to
support@medatechuk.com:
Status Web Updte
309130:Auto move to call updted
After 1 minutes Change status to Call Updatd
Status With Client
309245:bounce back to helpdesk
After 4 weeks Change status to Helpdesk
