# Support desk manual

- **Source:** `Support desk manual.docx`

Support desk manual

Introduction

Support Desk role is to ensure that customer’s queries/problems are captured and answered as soon as possible. This service is delivered in a simple and effective manner to our customers. System users can raise service calls in a number of different ways such as phone calls, e-mails to the support team or through MedatechUK website.

The Support desk team will record the query into priority via the service call form. Service Calls from customers are prioritised according to the severity classification, each of which has a service level commitment and escalation procedure.

This document provides the support technicians with instructions to follow on how to manage and respond to service calls in compliance with the Service Level Agreements (SLAs) between MedatechUK and the customer.

If the response times identified in the SLA are exceeded the technician must immediately inform the Operations Manager. At this point the Operations Manager will call the Customer to discuss the situation and propose a solution or assign it to a Project Manager.

Opening a Service Call:

NB: All service or assistance provided to a customer should be recorded in the system, including the issue, the provided solution and the amount of time spent to resolve the Issue/Query.

Please make sure you have the following details in hand before you proceed with opening a service call:

Customer

Customer contact name

Details of the problem

Call Type

Manual Service Call Entry:

Manual service call entry is used to record service calls raised via phone calls; the following process describes how to open a service call:

Open the Service Call form in Priority, Path: Service >Service Calls > Service Calls

Choose a customer number from the list of customers

Select the relevant Project

Select the relevant call severity

Select the appropriate call source and fill in the call details.

Call status will default to ‘New’; you need to change this to Helpdesk when you start investigation or any other appropriate status based on the service actual status. (This will email the customer to tell them the Call who the call has been assigned to).

Select the appropriate malfunction code. If you are unsure about this, select Not Identified.

Assign the call to yourself or an available technician.

Go to the sub-level form ‘External Call Dialogue’ and start typing the issue/query raised by the customer.

Raising a service call via Outlook Sync:

All Incoming Queries/Issues through E-mail to support@MedatechUK.com are synchronized into Priority. Also E-mails received regarding open service calls are loaded into the system using the same method. The other way to update Service Call is to copy the E-mail text into the ‘External Call Dialogue’ of the appropriate Service Call and change its status to Helpdesk in order for a technician to start investigating.

Follow the below steps to sync Support Email:

From the list of E-mail in the Support Inbox, right click on the E-mail you want to Open/Update a service call for at the very bottom of the list select Sync with Priority.

(This is not needed when someone machine is set up to sync every 15 min ) to load sync mail into priority do the following:

MedatechUK priority systems go to the toggle on the menu bar: Mail > Mail Option> Outlook> Synchronize with outlook then a box will display click sync now.

Web service call:

On the company website www.MedatechUK.com customers can raise and update service calls. Service calls raised over the web are automatically recorded in the system when Priority Sync is run; this is a program which is set to run automatically every 15 minutes. The service call will be opened for the customer with the details provided and various default values such as Customer name, Project number, Date opened, Service call number, Contact, Phone, Details and Call Taker. The initial status of the call will be ‘New’. After filling in the malfunction code, severity and other mandatory details assign the call to a technician and change the call status to ‘Helpdesk’.

Dealing with active service calls:

Retrieve list of calls that need to be looked at:

Open the Active Service Calls form to view all service calls that are still being processed. You can use Query Generator to quickly display specific SC from the list of active call.

Press F6 on the SC number to drill down into the form in order to edit it or F4 to change from multiple view to single record view, which will also enable editing.

Calls in Client Action status do not require any further action until the customer updates the call.

To start working on an active service call, do the following:

You should click the “Take Service Call” Direct Activation button on the right hand side of the SC form, this will record that you have started working at the given time and will display a warning message to anyone wanting to work on the same service call.

Go to the Internal Call Dialogue and start recording investigations made or record a brief comment about what the issues were and its solution.

When you have completed working on it (at this point). The last things to do are:

Record final text to be shown to the customer in the External Call Dialogue. This may be an update asking them for information, or an update to advise what the next steps will be on our side.

Optional: Internal call dialogue for only internal use.

Change the status from Helpdesk to the appropriate status.

Record the time you have now spent on it.

Untick the “In progress” checkbox.

Move onto the next call.

Escalation of Issue:

The support desk will provide an initial assessment of all the incidents and try to resolve them. The type of issues include general queries, training and assistance on all the standard functionality of the system. More complex issues such as implementation, functionality change, Bug, unavailable function and amendments to a report should be discussed with a project manager to see if it’s necessary to escalate the issue. Any problems requiring 3rd Tier support/resolution from Priority Software must be approved by one of the Operations Managers before escalating.

As soon as the issue is escalated to a project manager, it is their responsibility to ensure its successful resolution, changes of status and communication with the customer. In this situation, the Service Desk need to monitor progress of the service call until PM has resolved the problem. The PM should be chased regarding service calls assigned to him and ask if he requires any assistance for testing a solution.

Issues escalated to Priority software need to be chased for updates depending on the severity of the issue. The Priority Software Service Call Number needs to be recorded against the MedatechUK Service Call. To open a service call to Priority you need to go to the following website http://www.priority-software.com/ and do the following:

Go to the Customer Zone

Select Either Open New/ View and Update a Service Call

Use these details to login: eshbel@emerge-it.co.uk Password: zxc

Select customer you want to open a service call for.

In the Search Keywords text box type the issue you are looking for

Review the FAQ to check that it is not an existing issue before you raise it.

Then you can start writing your service call and add any attachment or screenshot of the issue

Closing and Cancelling Service Call:

Closing:

When a customer is satisfied with the support and proposed solution the next step is to close the Service Call.

Before assigning a Closed status to a service call, there is a call status of ‘Closed Review’ if you are at this stage make sure that hours reported are correct, the correct malfunction code is defined, in the Internal Call Dialogue you have written a good description of the issue and the proposed solution. You can now change the status to ‘Closed’.

See if the call has an issue which may be a useful FAQ and if so then raise an FAQ using the associated sub-level form.

Cancelling:

NB: You cannot delete a service calls, but you can cancel it.

If you open a new service call by mistake or you have created a duplicate service call. What you want to do in this situation is to cancel the call.

Enter the Service Calls form and retrieve the desired service call.

Check if there is time recorded against this service call In the Service Report-Labour sub-level form. If there is time recorded then deletes all entries.

Return to the upper-level form and change the Status of the Call to Cancelled.

Description of each status and Severity Code

Call Status:

Each status describes current action on the service call, it is defined along with attributes, rules and condition in the BPM flow chart-service calls program. Below is the meaning of each status with the message send to customer:

New: is an initial and default status assign to new service call raised that have not been look at yet.

Message sent:  Thank you for contacting the MedatechUK Support Desk. Your Service Call reference "<<Details>>" has been logged and is awaiting allocation to a member of the service desk team for further investigation…

Helpdesk: call will be in this status when it is assigned to a technician for investigation.

Message sent: To Contact” Your Service Call reference "<<Details>>" has now been assigned to <<Assigned to>> for further investigation….”

Clientact: Notify customer that there is an update on a SC and requires his action.

Message sent: To customer “Please contact the Service Desk to update or close this call…”

Cust Updated: This status is assigned to a call when the contact updates the call.

Message sent: To technician “Contact>> from <<Customer Name>> has updated <<Call Number>>. Please look at their update and respond.”

Update: This status is used to send an update to customer without requiring any action from them the status will change to helpdesk after a minute.

Message Sent: To customer “Your service call <<Call Number>> has been updated. Technician <<Assigned to>> is still investigating the issue and will keep you informed of any progress.”

Quote req’d: on this status mean customer accept to receive a quote, this should be change to close after creating a quote. No message sent.

Monitoring: Use when we can’t replicate an issue or an issue has been solved but we are waiting to see if it will replicate again.

Message sent: To customer “Please contact the support desk or your project manager if the issue persists or occurs again. Please note that this service call will automatically close after 1 week if there are no changes”.

Closed review: this is assigned to a service call when the customer agrees with the proposed solution and technician needs to record hours and record details against the call,

Message sent: To customer “Your service call <<Call Number>> has been closed. Please see the attached document for the resolution details.”

For billable service call Email will be send to technician: “You have closed a billable service call. Please review it and ensure it should be billable.”

Severity Code:

It is important that the severity of each query is determined accurately and those which are assigned “Critical” or “Major” must be given the highest priority and monitored closely. Severity is assigned to service call based on these criteria.

Critical: Server is offline or nobody can access the system to complete their work

Major: An issue stopping a few employees from doing their job but the majority of the company can still continue to work.

Normal: Issue with the system but this is not preventing anybody from doing their daily duty. Most service calls will have this severity

Minor: Issue which has very little impact on the business and does not need to be immediately resolved

Enquiry: Enquiry from customer about adding extra functionality to priority, normally calls of this severity result in a price quotation.

Process map: Draft
