# olsyncissues

- **Source:** `olsyncissues.docx`

This is a new case from my perspective.

It concerns the behaviour when “The Process Formerly Known As olsync” is not running, and the user attempts to use the RICH interface.

If this process is not running, the user sees a very confusing sequence, which has led them and me down lots of blind alleys

There are at least 4 errors/confusions:

1)    You get redirected to a screen entitled Priority 16 HTML5 – which made us wonder whether this problem was due to the upgrade to v17 having not worked correctly (red herring)

2)    Blind alley that the problem is due to the Priority Web Extension

a.    The message incorrectly draw you into thinking that the problem is that the Priority Web Extension isn’t installed.

b.    The link you follow in this branch takes you to a page in an non-english language, which I guess to be Hebrew, which only adds to the confusion

c.    Even if you battle through and re-install the Priority Web Extension , it doesn’t fix the problem

3)    Having realised that the problem is not to do with the Web extension, the user begins to follow the instructions related to olsync.  But

a.    On Windows 10 Task Manager, olsync is no longer called olsync, so the instructions don’t make sense.

b.    The installation has two different versions of olsync.exe, one in c:\ Program Files\Priority and one in c:\ Program Files\Priority\tabula.  This is another trap for the unwary, exacerbated by the fact that the instructions in the messages aren’t accurate.

4)    If the user manages to start olsync.exe and then checks on the Task Manager, the process olsync still doesn’t appear.  It seems that on Windows 10 it is called  Priority Application Execution (32bit)

Here’s what happens in detail:

1)  I open Chrome and attempt to go to Priority.  Firstly, the behaviour depends slightly on how I get there.

A)    If I type https://priority.coolled.com, I see the following.  Note the tab title: Priority 16 HTML5

2) The user knows that they have already installed Priority, so they attempt to follow the instructions in the second half of this screen.

Alternately, my shortcut to priority is not https://priority.coolled.com  it is https://priority.coolled.com/h5/priority.asp?_tabulaini=tabula.ini&_basiclang=3

If I follow this, I briefly see the loginscreen – which is want I expect, before being re-directed to https://priority.coolled.com/priority.htm?_fromicon=1

This is the equivalent of the second half of the previous screen, and the behaviour from here is the same whichever screen you arrived at.

So, given that the user is trying to use the web interface, it makes sense that the Priority Web Extension isn’t installed (even though this isn’t actually true, to they follow the “click here” link.  This takes them to:

This is clearly inappropriate.  If you do Google Translate on this page, it is inviting you to install the Priority Web extension, which you get to by clicking the blue hyperlink.  But re-installing the Priority Web Extension doesn’t cure the problem, (because that wasn’t the problem in the first place.)

So, eventually the user ends up back in the same place:

3) So now they are in the “still seeing this page after carrying out the instructions in section 1” camp.  So now they try section 2.  They open the Task Manager but olsync isn’t anywhere to be seen.  “Aha” they think, that must be my problem.

But the instructions: Open Start>All programs> Startup Menu, select Priority Outlook Sync  are not appropriate for Windows 10.

So eventually I found my way to the file on disk called olsync.exe.  Next problem, there are two different versions of olsync.  You would intuitively expect the correct version to be the one in c:\ Program Files\Priority  but it turns out that the correct one in c:\ Program Files\Priority\tabula

4)    So I start this program.  But still olsync doesn’t appear in the task manager:  It is actually the Process called Priority Application Execution (32bit)
