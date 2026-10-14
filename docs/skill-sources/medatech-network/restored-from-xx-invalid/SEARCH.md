# SEARCH

- **Source:** `SEARCH.docx`

Search

Priority Search is not working

1. Do you get any results when you search?

i.e., if you start typing SO21... do you get any suggestions?

YES (Problem with the Index)

NO (Problem with the service)

Run “Build Search Index”

System Management > System Maintenance > Search > Build Search Index

Untick “rebuild” if this is ticked

1. Do you get any results when you search?

i.e., if you start typing SO21... do you get any suggestions?

YES
NO

3. Is Build Search Index running on the scheduler?

The command is "WINACTIV -P SEARCHINDEX" and the task should be active in each company you intend to search.

YES
NO

Add the task to the task scheduler/make it active in your company

Go to next question

4.After Build Search Index runs on the TTS, does this update the index?

i.e., are you able to search for records created just before the index was run?

YES (Resolved!)
NO (Problem building the index)

2.Is the Priority Search Service running on the web server?

Open Services on the server that holds the IIS, and check that "Priority Search Service" is running.

YES
NO

Start the service

Go to next question

Restart the service

Go to next question

1. Do you get any results when you search?

i.e., if you start typing SO21... do you get any suggestions?

YES (Resolved!)
NO

5. Are there any search definitions?

System Management > System Maintenance > Search > Search Definitions > Document Types in Search
Are there any ticks in "Include in Search"?

YES
NO

Run "Initialise Search Definitions"

System Management > System Maintenance > Search > Search Definitions > Initialise Search Definitions and select "Default"

Go to next action

Run “Build Search Index” with “rebuild”

System Management > System Maintenance > Search > Build Search Index with “rebuild” ticked

Go to next question

1. Do you get any results when you search?

i.e., if you start typing SO21... do you get any suggestions?

YES (Rebuild OK)
NO (Rebuild does not work)

Reinstall the Priority Search service

Run

Go to next action

Activate the Search service

Run

Go to next action

Initialise search definitions

Run "Build Search Index" and tick "Rebuild"

Go to next question

1. DO YOU GET ANY RESULTS WHEN YOU SEARCH?

i.e., if you start typing SO21..., do you get any suggestions?

YES
NO

Edit tabula.ini on both servers

Under [PriSearch] in the tabula.ini file, add host=WEBSERVER where WEBSERVER is the name of the web server
