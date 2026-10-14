# OpenUser_Use_Windows_Logins_2

- **Source:** `OpenUser_Use_Windows_Logins_2.htm`

Opening a User - Using Windows Logins: Converting 
 
 
- 
 
 
 
# Converting the System to Windows Logins

 

If you have already opened user records in Priority , there are several steps you must take before switching to user logins based on Windows Active Directory settings. 
 
## Before you begin

 

 1 .  Enter the User Permissions form, retrieve all users and fill in their Windows Login . 
 

 2 .  Enter the Groups in Active Directory form and assign each Priority privilege group leader to the appropriate Active Directory privilege group. In particular, assign the superuser to the highest Active Directory group (e.g., “Administrator”).
 Notes: 
 

 ·      Only virtual group leaders (i.e., fictitious users with no personnel file) can be assigned to the Active Directory. Click to define fictitious group leaders . 
 

 ·      Additional group leaders can be defined and linked to the Active Directory at any time, provided that they are fictitious users. 
 
## To convert to using Windows logins:

 

 ·        Run the Activate Use of Active Directory program. Provided that the A D A UTO O PEN system constant is set to 1 , each user will be logged into the system according to the name appearing in the Windows Login column of the User Permissions form the next time he/she enters the system. When a new user enters the system, a personnel file and username are opened automatically according to the user's identification settings in Windows. 
 
## Notes:

 

 ·        Once a user's Windows login appears in the User Permissions form, it can only be revised by selecting Update Windows Login from the list of Direct Activations . 
 

 ·        Click to change the conditions under which personnel files and user names are opened automatically. 
 

 ·        Click to return to the main screen.
