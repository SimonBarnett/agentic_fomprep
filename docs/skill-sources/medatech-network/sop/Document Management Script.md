# Document Management Script

- **Source:** `Document Management Script.pdf`

Cat.No. LB120115  Ver.4 – Feb. 04,’14 1 
 
Document Management Script 
Clip Link: http://www.eshbel.com/Movie_Search/Document_Management_clip.htm 
Note: Yellow highlights indicate action instructions.  
Introduction (00:00-01:20) 
Priority provides organizations with several options for maintaining and organizing 
work-related documents or other files directly in the cloud, with no need to ever save 
a local copy. These options enable multiple users to share and collaborate on 
individual files, such that: 
 Each user can access their documents and files from any device, including 
smartphones, tablets and PCs.  
 Files that are currently in use are locked for editing by other users. This 
enables you to maintain a single, up-to-date copy of each file, rather than 
multiple copies, each containing a different set of revisions. 
 Permissions enable you to grant each user the desired level of access to a 
given file or folder. 
 Priority's Enterprise Search tool scans the contents of each file for your 
search terms and any matching files show up in the search results. 
Priority files can be managed using Priority's File Explorer, or you can simply 
attach a file to any of a variety of Priority records, including customer or part 
records, financial documents, sales and shipping documents, etc. The process of 
importing and working with these files is fairly similar for both options. Let's begin by 
demonstrating how to attach files to a Priority record. 
Attaching a File to a Form Record (01:21-03:10) 
Any file that you attach to a Priority record is stored on the Priority server, and a 
link to the file is added to the form record in question. Consider the following 
example: suppose one of your customers requires all vendors with which they do 
business to sign a supply contract and confidentiality agreement. Signed copies of 
each document can be attached to the relevant customer record for future reference. 
First, open the Customers form and retrieve the customer in question. Next, enter 
the Customer Documents sub-level form and move the cursor to the File Path 
column. Now click the icon that appears, in order to locate and select any files you'd 
like to import from your local hard drive. Note that you can attach several files 
simultaneously by holding down the Ctrl key and clicking on each item you want to 
attach.  
The system automatically records the date each file is created, the name of the user 
it was last Modified by and the date it was last modified. The File Path column is 
also filled in automatically for each of the imported files, along with the original File 
Name. You can revise the File Name that appears in this form if desired, but keep in 
mind that this has no effect on the file itself.You can continue to attach additional

Cat.No. LB120115  Ver.4 – Feb. 04,’14 2 
files to the same customer record as needed; for instance, by right-clicking the file 
icon and selecting Import. 
Note that the icon that appears in the File Path column now reflects the relevant file 
type: in this case, a Word document. Any user with access to this form can click this 
icon to open the attachment.  
Working with Files (03:11-03:26) 
You can work with the file as usual and then save any changes, without changing the 
file name or path. The file is backed up in a temporary directory on your local 
machine while open, and then synchronized with the system automatically when it is 
closed. 
File Status (03:27-04:48) 
Upon opening the file, the File Status is updated automatically to indicate that the 
file is currently in use and only a read-only copy can be opened at this time. This 
mechanism prevents other users from revising the original file while you are working 
with it, and thus ensures that multiple collaborators do not inadvertently create 
multiple copies of the file, each containing a different set of revisions. The Locked 
by column shows us which user is currently using the file. Once we close the file, it is 
updated on the server and released for other users. Refresh the record to see the 
updated File Status, now indicating that the file is free. 
Note that your system manager can set an upper limit on the amount of time that 
files remain locked for editing by a given user. Once the maximum time is exceeded, 
other users who attempt to open the file will be notified that they can unlock it for 
writing, if necessary. This option should be used sparingly, however, as the original 
user may still be in the midst of editing the file and there may be significant changes 
to the file that have not yet been updated in the system. If the original user continues 
to edit a file that has since been released and modified by another user, the file 
containing his or her changes is saved in the temporary directory, but will not be 
synchronized automatically. It can, however, be imported manually if necessary. 
Attaching a File to Multiple Form Records (04:49-06:19) 
As we mentioned earlier, the files we attached to this record are now stored on the 
Priority server, and the attachments we see in this form are essentially shortcuts 
pointing to the original item on the server. These shortcuts can be copied to any 
other record in the system, as needed. For instance, we can link the supply contract 
signed by the customer to a sales invoice opened for the same customer. First, we'll 
move to the File Path column and copy the entire path to the clipboard - for 
instance, by pressing Ctrl+C. Next, we'll open the Sales Invoices form and retrieve 
the desired invoice. Moving to the Attachments sub-level form, we'll place the 
cursor in the File Path column and paste in the file path - for instance, by pressing 
Ctrl+V.  
Note that whatever file status is assigned in one location is automatically applied to 
any other locations from which the file can be accessed. Let's demonstrate this using 
the file we just linked to this invoice. We're going to use the File Status column to 
manually define the attachment as "Read Only", and then look back at the 
Customer Documents sub-level of the Customers form. Press Ctrl+M to refresh 
the records in this form. As you can see, the File Status has been updated here as

Cat.No. LB120115  Ver.4 – Feb. 04,’14 3 
well, indicating that the file is currently in use. In other words, once the file has been 
locked for editing in any location, it will open in read-only mode no matter where you 
access it from.  
Attaching Files Using Paste & Import (06:20-07:06) 
You can also copy a file and paste it into the Attachments form, at the same time 
importing it onto the Priority server. For instance, you can copy one or more MS-
Outlook attachments, or copy any file from the Windows Explorer, and then use the 
Paste & Import command to paste it directly into Priority. 
You can also use the Paste & Import command to attach a screen capture. Simply 
press the Print Screen key on your keyboard and then use the Paste and Import 
command to import the capture to any attachment form. 
Both the Import and the Paste & Import commands are also available in the File 
Explorer, as we'll demonstrate later, and offer the same functionality.  
Copying Vs. Duplicating (07:07-08:00) 
When you copy a Priority file from one location to another - for instance, by pressing 
Ctrl+C - this creates a shortcut pointing to the original item, which can then be 
pasted into another Priority record or into the File Explorer (e.g., by pressing 
Ctrl+V). In some cases, however, you may prefer to duplicate the file instead, 
thereby creating a new copy of the file on the Priority server. To duplicate a file, 
right-click the file in question and select the Duplicate command. You can then 
rename the file, revise it as needed and save your changes. In this way, you can 
create as many documents or other files as you need directly in the cloud, with no 
need to ever save a local copy. Note that both the Copy and Duplicate commands 
can also be used to copy or duplicate files within the File Explorer. 
Copying a Document Link (08:01-09:43) 
You can export any files that have been attached to a form record from within the 
attachments form, using the Save as command. However, you may prefer to simply 
include a link to the file in a Priority text form or an external document, such as an 
Outlook message or Word document. To copy a document link, press Ctrl+Y. A link 
to this file has now been copied into the Windows clipboard and can be pasted 
where desired. Let's paste this document link into a new e-mail message in Outlook. 
And now we'll simply paste the document link into the message by pressing Ctrl+V. 
Note that the same keyboard shortcut can also be used to copy a document link 
within the File Explorer. 
Upon receiving an e-mailthat contains a document link, recipients can press Ctrl and 
click the link to open a read-only copy of the attached file. If you want to edit the file, 
however, you'll need to open it from the attachment form itself, where there are 
status management capabilities in place to ensure that other users aren't working on 
it simultaneously. Thus, if you anticipate that other users may need to edit the 
document in question, it is preferable to simply provide a link to the relevant form 
record (e.g., the sales invoice). This method also enables you to limit access to 
users who are authorized to view the record in question. So, let's move to the upper-
level Sales Invoices form and press Ctrl+S to create an e-mail message containing 
a link to the record, which we can then edit as desired. Authorized users can use this

Cat.No. LB120115  Ver.4 – Feb. 04,’14 4 
link to access the sales invoice, and then enter the Attachments sub-level form to 
work with the attached file. 
Removing Attached Files (09:44-10:34) 
Should you wish to remove an attachment from a form record, you can do so at any 
time by selecting the file in question and pressing Ctrl+Del. Similarly, you can press 
Delete within the File Explorer attachment form to remove the file from its current 
location in the Explorer. Note, however, that so long as the file is still linked to other 
system locations, such as other form records or folders in the File Explorer, it will 
not be deleted from the Priority server, and will still be accessible from these 
locations. The file will only be deleted from the server once it has been removed from 
all system locations. To view a list of any system locations to which a particular file 
has been linked, simply enter the Links to File sub-level form. One of the lines in 
this form always displays the current record; in this case, a sales invoice. 
Attachment Columns in a Root Form (10:35-11:19) 
While attachments are usually added to Priority records via a sub-level form, as in 
the examples we've seen so far, several root forms (e.g., the Part Catalogue form) 
also include a folder icon for attaching a file. This particular field is meant to be used 
to attach an image – for example, a picture or sketch of the part in question. The 
procedure for attaching an image to the part record is the same as the procedure 
used to attach files to any form record. The attached image now appears instead of 
the folder icon. You can click the image to open the file, as you would with any other 
attached file, or you can simply position the mouse over the magnifying glass icon to 
view an enlarged image within the current window.  
The File Explorer (11:20-12:37) 
Users can work with the File Explorer to organize files and folders that are stored on 
the Priority server, in much the same way as you use Windows Explorer to organize 
the files and folders on your computer. Access to each folder is governed by the 
same privilege mechanism in use throughout Priority. For instance, all of your sales 
and marketing materials can be maintained in a single folder in the File Explorer 
and individual files can also be linked to related Priority records, such as customer 
or part records, customer tasks and sales opportunities, for easy access. In such a 
case, a single copy of each file is stored on the server and a shortcut is used to 
access that file, whether you choose to do so from the File Explorer or via a specific 
record in Priority.  
To run the File Explorer, we'll select the File Explorer command from the File 
menu. You can click on any folder in the left pane to view its contents (in a 
hierarchical structure). Individual files and sub-folders appear in the right pane. 
Various commands for working with this tool appear in the upper File and Edit 
menus, and can also be accessed when you right-click on a file or folder in either 
pane or right-click an empty space in the right pane. 
Working with the File Explorer: Creating a Folder (12:38-13:14) 
Next, we'll demonstrate how to create a new folder in the File Explorer and define 
permissions for the folder. Folder permissions are defined per privilege group -- the 
same privilege groups that are used to assign privileges for Priority forms and other

Cat.No. LB120115  Ver.4 – Feb. 04,’14 5 
entities, generally representing the various departments in your organization. Let's 
start by creating a new folder in which to work. To do so, I'm going to right-click the 
main folder and select New Folder from the drop-down menu. Next, let's click on the 
folder and change its name to, say, "Marketing". 
Defining Folder Permissions (13:15-16:39) 
Upon creating the "Marketing" folder, I have automatically been granted full 
administrator permissions for this folder. I can now define permissions for other 
users, thereby determining who else can view and modify the folder and its contents. 
To do so, I'm going to right-click the folder and select Permissions. 
A window opens in which we can see the types of permissions that are assigned to 
different privilege groups for this folder. Each level of permission is represented by a 
different letter. 'R' stands for read, indicating that users with this level of permission 
can view the folder's contents but not modify them. 'W' stands for write, indicating 
that users with this level of permission can modify the folder's contents 'A' stands for 
administrator, indicating that users with this level of permission can view and modify 
the folder's contents, and assign folder permissions to other privilege groups. '!' 
stands for navigation, indicating that users with this level of permission can navigate 
within this folder and its sub-folders, but cannot view or modify the folder's contents. 
Lastly, 'X' indicates that the user has no permissions for the folder. The current 
permissions were inherited automatically from the main folder, and can be changed 
manually for any folder that you create.  
In this example, we're going to concentrate all of our marketing collateral in the new 
"Marketing" folder we just created, which will be accessible to all sales staff. We'll 
then divide the materials in this folder into sub-menus, in order to differentiate 
between domestic and international sales staff. Let's start by making sure that all 
sales managers have full administrator permissions for the "Marketing" folder and its 
contents. So, we're going to right-click the Sales Manager privilege group and, in the 
pop-up menu that opens, we'll select "Administrator Permission". We'll also assign 
Navigation permissions to both domestic and international sales teams. This permits 
them to navigate within the folder and to open any sub-folders for which they've been 
granted permissions. Finally, we'll click OK and the permissions we defined are now 
in effect. 
Let's create a new folder within the Marketing folder, in which we'll maintain copies of 
the company's brochures. This folder automatically inherits the same permissions 
we've just assigned to the "Marketing" folder, meaning that all sales managers have 
full administrator permissions and that all sales teams have navigation permission 
only. Let’s grant read-only permissions for this folder to both domestic and 
international sales teams., so that users in either privilege group can view the folder's 
contents, but neither group will be able to modify these contents. Click OK to save 
these definitions. 
Now we'll create a second folder within the Marketing folder, in which we'll maintain 
materials that are only used for domestic sales. This folder also inherits the 
permissions we assigned to the "Marketing" folder. Let’s grant read and write 
permissions for this folder to the domestic sales privilege group and revoke all 
permissions for the international sales privilege, meaning that users in this group will 
not be able to access the folder or its contents. Click OK to save these definitions. 
Later on we can repeat this process to create a folder for international sales

Cat.No. LB120115  Ver.4 – Feb. 04,’14 6 
materials, thereby creating a hierarchical file system, with multiple branches for 
various folders and sub-folders. 
Adding Items to the File Explorer (16:40-17:03) 
Now that permissions have been defined for the folders we created, we're going to 
start adding files to these folders, starting with the company's brochures. To do so, 
we're going to right-click the "Brochures" folder and select Import Files from the 
drop-down menu. In the dialog box that opens, we'll locate and double-click the 
desired file to import it onto the server. 
Using Paste & Import (17:04-18:28) 
As we demonstrated earlier when working with attachment forms, you can also copy 
a file or folder and paste it into the File Explorer, at the same time importing it onto 
the Priority server, using the Paste & Import command. For instance, you can copy 
one or more MS-Outlook attachments, or even copy an entire folder from the 
Windows Explorer and paste it, together with all of its contents, directly into Priority's 
File Explorer. 
You can also copy items from the File Explorer and paste them into an attachment 
form, or vice versa. For instance, say you want to attach a couple of these brochures 
to a sales order. Simply select the desired files and press Ctrl+C to copy them to the 
clipboard. Next, we're going to open the Sales Orders form and retrieve a sample 
sales order with the "Draft" Status, and then move to the Attachments sub-level 
form. Finally, place the cursor in the desired line and press Ctrl+V to paste the files, 
or rather, shortcuts to their location on the server, into this form. If you expand the 
column to its full width, you'll see that the File Paths in this form are identical to the 
File Paths that appear in the File Explorer; that is, no duplicate file was created. 
File/Folder Permissions & File Status (18:29-20:10) 
Let's return to the File Explorer. Looking over to the side of the File Explorer 
screen for a moment, you can see what permissions you've been assigned for the 
selected file or folder. 
Keep in mind, however, that these permissions only apply to the file's current 
location within the File Explorer. If the same file has been linked to one or more 
form records in Priority, all users with access to the form record can also open the 
attached file, regardless of the permissions they are assigned in the File Explorer. 
To view a list of any Priority records - or additional File Explorer folders - to which a 
particular file has been linked, simply right-click the desired file and select Links to 
File. It's also possible to copy a shortcut to the file into another location within the 
File Explorer. Here, too, users who cannot access the file from its current location 
may be able to do so from the second location, if they have been granted the 
necessary permissions. 
On the other hand, a file that is locked for editing in any system location will only 
open in read-only mode, regardless of where you access it from. All system files are 
locked for editing by other users while they are open -- whether opened from an 
attachment form or from the File Explorer -- and then synchronized with the system 
automatically when closed. The file's status appears in the Status column. If the file 
is in use, you can check the Locked by column to see who is currently working with

Cat.No. LB120115  Ver.4 – Feb. 04,’14 7 
it. If the file in question is listed in your name, you can free it for use by right-clicking 
the file and selecting Change Status.  
Exporting Items from the File Explorer (20:11-20:37) 
You may also wish to export a file or folder from the File Explorer and save it to your 
hard disk or network drive. To do so, simply copy it into the Windows Explorer, for 
instance, using Ctrl+C and Ctrl+V. Alternatively, you can right-click the relevant item 
and select Save from the drop-down menu. In the dialog box that opens, locate the 
desired folder, and then click OK. 
Organizing Folders & Creating Favorite Links (20:38-21:30) 
Once you've added a number of files and folders to the File Explorer, you may want 
to organize things a bit better. You can move items around within the File Explorer 
using basic copy and paste commands, which are available in the upper Edit menu 
or by right-clicking within the File Explorer. You can also use the standard keyboard 
shortcuts: Ctrl+C and Ctrl+V. Even simpler, you can click and drag any file or folder 
within the File Explorer and then drop it into the desired location. You can also use 
any of these methods to organize folders within the list at the left of the screen. 
You can also add a direct link to any frequently-used folders to your list of Favorite 
Links. To rearrange or edit this list, simply right-click any folder and choose from the 
available options. 
Designing the File Explorer (21:31-22:10) 
You may also want to change the appearance of the File Explorer, for maximum 
efficiency. For instance, you can drag any column to a different location, click on any 
column title to sort the displayed items by the values in that column, or change the 
width of any column by placing the cursor on the edge of the column title and 
dragging it to the desired width.  
In addition, you can use the Arrange Columns dialog box, accessed via the upper 
Design menu, to hide or rearrange columns to your specifications and to restore 
columns that were previously hidden.  
Exiting the File Explorer (22:11-22:30) 
To exit the explorer, select the Exit command from the File menu. All of your design 
definitions will be maintained the next time you open the File Explorer. 
This concludes our explanation of Priority's document management tools. 
Related Documentation 
 User Interface Guide 
 Collaboration clip
