# Service_Quality_Send_Survey_Link

- **Source:** `Service_Quality_Send_Survey_Link.htm`

Customer Surveys – Setup: Sending Surveys 
 
 
- 
 
 
 
# Sending Customer Surveys: Preliminary Steps

 

 Priority allows you to send mail to designated customer contacts, requesting that they fill out a customer survey that has been posted on your web site. Such messages consist of set text that explains how to access and complete a customer survey and a link to the web page with the survey. Before sending requests for survey completion to customers, you need to define the set text that appears in these messages. This text appears in all such requests, regardless of the survey to which the customer contacts are referred. 
 

If, in your current installation of Priority , MarketGate is used with more than one language or more than one company, you also need to define the correct tabula.ini file for the link that is sent to customers before sending requests for survey completion for the first time, in order to ensure that customer contacts can access your web site using this link. 
 
## To define set text that is sent with requests for survey completion:

 

 1 .  Enter the Set Text for Sending Cust Survey form. 
 

 2 .  Move to the Set Text for Sending Survey sub-level form and record the set text. This text will automatically appear in the mail sent to customer contacts with a request to fill out a survey, together with a link to the survey to be completed.
 Note: In a multi-language system, record remarks in English in this form and remarks in the local language in the parallel Set Text-Sending Survey (Lang2) sub-level form. The set text that is included in the mail message depends on the language interface with which the user is working when running the program that sends the survey request. 
 
## To define the tabula.ini file for multiple languages/companies:

 

 1 .  In the IIS server, define the appropriate .ini file (with a slightly different name) for each company and language. Thus, for example, if you work with two companies and two languages, you must define four such files. Example. 
 

 2 .  In each company, run the Set tabula.ini File Definitions program to set the link that is sent to customers, indicating the appropriate language and filename. If you work with multiple languages in a given company, run the program once for each language (e.g., once for Spanish and once for English).
