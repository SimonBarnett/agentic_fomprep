# Employee Holidays Users Guide - Rich

- **Source:** `Employee Holidays Users Guide - Rich.pdf`

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 1 of 26 
Employee Holiday Module Users Guide 
Contents 
1. Description ................................................................................................................................................................................... 2 
2. How to set up ............................................................................................................................................................................... 2 
2.1. Company dependant constants should be set for module operation. ................................................................................... 2 
2.2. Define Bradford Scale Absent Codes .................................................................................................................................. 4 
2.3. Define Employee Extra Holiday Reasons (Recommended) ................................................................................................ 5 
2.4. Define Absent Codes as Holiday and optionally Extra Holiday ......................................................................................... 5 
2.5. Employee Working Days/Hours ......................................................................................................................................... 6 
2.6. Holiday Groups ................................................................................................................................................................... 7 
2.6.1. Holiday Group Warning Level ............................................................................................................................................ 7 
2.6.2. Holiday Group Leader ......................................................................................................................................................... 8 
2.6.2.1. Holiday Group leader email include Holiday Requests .................................................................................................. 8 
2.7. Employee Holiday Groups ................................................................................................................................................ 10 
2.8. Employee Holiday Authoriser User .................................................................................................................................. 10 
2.9. Employee Ignore Closed Days .......................................................................................................................................... 11 
2.10. Holiday Requests BPM Rules ........................................................................................................................................... 11 
2.11. Employee Initial Holiday Entitlement ............................................................................................................................... 12 
3. How to Record Holiday ............................................................................................................................................................. 14 
4. How to Record Extra Holiday .................................................................................................................................................... 15 
4.1. Using Extra Holiday Reasons (Recommended) ................................................................................................................ 15 
4.1.1. One-Off Extra Entitlement ................................................................................................................................................ 16 
4.2. Using Extra Holiday Absence (Optional) ......................................................................................................................... 17 
4.3. Employee Holiday History reflects above entries: ............................................................................................................ 17 
5. Holiday Requests ....................................................................................................................................................................... 18 
5.1. Adding a Holiday Request ................................................................................................................................................ 18 
5.2. Authorizing a Holiday Request ......................................................................................................................................... 19 
5.3. Holiday Request Comments .............................................................................................................................................. 20 
5.4. Holiday Group Warnings .................................................................................................................................................. 20 
5.5. Holiday Group Leader Email ............................................................................................................................................ 20 
6. Calendar of Employee Absences Report ................................................................................................................................... 21 
7. Employees on Holiday Report ................................................................................................................................................... 21 
8. Employee Holiday Requests Report .......................................................................................................................................... 22 
9. Holiday Forward Entitlement .................................................................................................................................................... 22 
10. Holiday History Recalculation .............................................................................................................................................. 23 
11. Compulsory Holidays ............................................................................................................................................................ 24 
12. Bradford Scale ....................................................................................................................................................................... 25 
12.1. Showing Scale for individual Employee ........................................................................................................................... 25 
12.2. Reporting Scale for Employees ......................................................................................................................................... 26

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 2 of 26 
 
1. Description 
 
The employee holiday module enables maintenance of employee holiday entitlement, enhances the existing 
Employee Absences functionality to specially record holidays and to see remaining days for any given 
employee and calendar year. It also enables the recording of employee holiday requests and their 
authorisation by selected other employees auto populating Employee Absences as appropriate. Holiday 
requests are supported by BPM statuses thus allowing rules to be added to email requests upon change of 
status. 
 
2. How to set up 
 
2.1. Company dependent constants should be set for module operation. 
 
Company Constants must be set up in the form: 
System Management > System Maintenance > Constant Forms > Medatech Company Constants 
 
The default number of days holiday entitlement for new employees. NB. Used whenever the module needs to create holiday 
entitlement details for an employee and no previous details exist or are applicable.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 3 of 26 
Minimum amount of holiday entitlement the module will manipulate. E.G. If set to the default 0.5 day booking holiday for 1 ho ur will 
round up to 0.5 days. 
 
 
Maximum amount of holiday entitlement that can be carried forward to the next calendar year if the holiday forwarding procedure or 
holiday requests are used.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 4 of 26 
If Group Leader emails (see later on) are set to be sent, then add a warning to the email if the holiday exceeds this number of days. 
 
 
2.2. Define Bradford Scale Absent Codes 
Absent Codes to be included in the Bradford scale calculations must be set up in the standard absent codes form: 
Human Resources > HR Definitions > General Definitions > Reasons for Absence

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 5 of 26 
2.3. Define Employee Extra Holiday Reasons (Recommended) 
 
Extra Holiday Reason Codes must be set up in the new form: 
Human Resources > Employee Holidays > Extra Holiday Reasons 
 
 
2.4. Define Absent Codes as Holiday and optionally Extra Holiday  
Absent Codes must be set up in the standard absent codes form: 
Human Resources > HR Definitions > General Definitions > Reasons for Absence  
 
If the absence code should deduct from holiday entitlement taken then flag the holiday 'Tick Box' against the absence code 
If the absence code should add to the holiday (i.e. give extra holiday entitlement awarded) then flag the Extra holiday 'Tick Box' 
against the absence code. This absence code can be marked so entries will not be posted into the calendar.  
NB: Extra holiday entitlement is carried forward to subsequent years being added to current entitlement for the next year 
NB2: This Extra holiday is an alternate method to using Extra Holiday Reasons, we recommend using the latter.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 6 of 26 
2.5. Employee Working Days/Hours 
 
Globally this can be set up in the standard Office Hours form: 
Office Management > Appointments & Office Hours > Office Hours 
 
NB. There is an extra column to record the length of a single break in the day. E.G. 08:30 to 17:30 with 1:00 break means 8 h ours per 
day. 
 
 
This can be varied for an individual employee using the standard employee Office Hours form: 
Office Management > Appointments & Office Hours > Office Hours per Employee  
 
NB. There is an extra column to record the length of a single break in the day. E.G. 09:00 to 17:30 with 1:00 break means 7.5 hours 
per day.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 7 of 26 
2.6. Holiday Groups 
Holiday groups are optional. They are used to give warnings in the Holiday Request form when employees within the same holida y 
group or groups as each employee can be linked to up to three different groups request holiday with overlapping dates. A limit on the 
number of employees on holiday at same time before any warning is given may be set. Also a Holiday group leader may be defined, 
this user is sent an email when someone within the holiday has a holiday request approved by the defined authoriser (see further on in 
document) and optionally when that employee request holiday. 
 
These can be set up using the new holiday group form on the new menu: 
Human Resources > Employee Holidays > User Holiday Groups 
 
 
2.6.1. Holiday Group Warning Level

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 8 of 26 
2.6.2. Holiday Group Leader 
 
2.6.2.1. Holiday Group leader email include Holiday Requests

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 9 of 26 
 
A sub-level of the User Holiday Groups form will show a list of the employees linked to each holiday group

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 10 of 26 
2.7. Employee Holiday Groups 
Employees can be linked to up to three holiday groups using the sub-level form: 
Human Resources > Personnel File > Company-Specific Information 
 
 
 
 
 
2.8. Employee Holiday Authorizer User 
In the same form Employees can be set as having the authority to view other employees’ holiday requests and change their status to 
Approved or Rejected (see 2.7). For an employee to use holiday requests they must have an authorizer set-up for them. It is valid to 
set an employee as having authority to authorize his/her own holiday requests.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 11 of 26 
 
2.9. Employee Ignore Closed Days 
Tick this box if this employee does not get office closed days [Office Management > Appointments & Office Hours > Holidays 
(Office Closed)] and would need to book holiday for those days. 
 
Employees without this tick cannot book holiday for these days. 
 
2.10. Holiday Requests BPM Rules 
Holiday request statuses are set as follows, add any rules you wish to trigger emails etc. 
Human Resources > Employee Holidays > Holiday Request Status

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 12 of 26 
 
2.11. Employee Initial Holiday Entitlement 
2.11.1.  Create manually by entering details in new 
Human Resources > Personnel File > Employment Holiday History form: 
2.11.2.  
 
2.11.2.1. Enter the holiday year number i.e. 2011 
2.11.2.2. Enter the year’s holiday entitlement in days. 
2.11.3.  Create Automatically by using the Forward Holiday Entitlements direct activation on the Human 
Resources > Personnel File form:

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 13 of 26 
2.11.3.1. Enter holiday year i.e. 2011, the procedure will then create records for all active employees and 
create details in Employment Holiday History using the default number of holiday entitlement 
days from the company constant set earlier.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 14 of 26 
3. How to Record Holiday 
If not using holiday requests or to record extra holiday entitlement. 
 
3.1. Go to Human Resources > Personnel File form: 
3.2. Find the user in the normal way.  
3.3. Go to the sub-level form ‘Calendar of Employee Absences’ 
3.4. Enter the Start Date for the holiday, this will populate the users’ standard start and end time for this day of 
the week. 
3.5. If the holiday is for more than one day, then specify the end date of the holiday. 
3.6. Select the absence code. 
 
The quantity of holiday entitlement used is based on the employee’s hours for each day and the times entered for each day rounded up 
to the nearest minimum holiday quantity as set in the company constant earlier. 
 
 
Examples 
Employee Hours are 08:30 – 17:30 Monday to Friday with 01:00 hour lunch break 
 
Start Date Start Time End Date End Time Days Entitlement Used 
Two Weeks holiday from 3rd Jan 11 to 14th Jan 11 
03/01/11 08:30 14/01/11 17:30 10.000 
Three Days Holiday  
17/01/11 08:30 19/01/11 17:30 3.000 
Monday Morning Off   
24/01/11 08:30 24/01/11 12:30 0.500 
 
Employee Hours are 09:00 – 17:00 Monday to Friday with 01:00 hour lunch break 
 
Start Date Start Time End Date End Time Days Entitlement Used 
Two Weeks holiday from 3rd Jan 11 to 14th Jan 11 
03/01/11 09:00 14/01/11 17:00 10.000 
Three Days Holiday 
17/01/11 09:00 19/01/11 17:00 3.000 
Monday Morning Off

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 15 of 26 
24/01/11 09:00 24/01/11 12:30 0.500 
But if Monday Morning Off entered as over ½ the day in terms of working hours then rounds up! 
24/01/11 09:00 24/01/11 13:00 1.000 
 
4. How to Record Extra Holiday 
 
4.1. Using Extra Holiday Reasons (Recommended)

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 16 of 26 
4.1.1.  One-Off Extra Entitlement

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 17 of 26 
4.2. Using Extra Holiday Absence (Optional) 
Same as for holiday but select the extra holiday absence code. 
 
 
 
4.3. Employee Holiday History reflects above entries: 
NB. Extra Days are recorded separately for the year in which they are added but are added to  Holiday entitlement when calculating 
holiday taken forward to next year.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 18 of 26 
5. Holiday Requests 
 
These can be maintained using the new holiday request form on the new menu:  
Human Resources > Employee Holidays > Holiday Requests 
 
If an employee is not a Holiday Authorizer for any other employees, then he/she can only see and create/amend his/her own holiday 
requests.  
 
 
5.1. Adding a Holiday Request 
 
 
 
5.1.1. User Name select or enter the user required, if you are not a holiday authorizer then only your name 
will be valid. 
5.1.2. Enter holiday date/times and leave status as Draft 
5.1.2.1. The form shows the number of day’s holiday this would deduct from entitlement and the 
entitlement left if this holiday request has been set to requested status. Once approved this will 
show the new balance. 
 
 
5.1.3. When required employee can change the status to Requested, a BPM rule could be added to email the 
details to an appropriate person. 
5.1.4. The Employee Holiday History will reflect the requested quantity. 
 
 
5.1.5. Once Request is at Requested status it cannot be amended but the employee can change status to 
Cancelled.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 19 of 26 
5.2. Authorizing a Holiday Request 
 
5.2.1.  Any Employee marked as being an Authoriser for another employee may find any existing holiday 
requests for him /herself plus those of employees for whom he/she is an authorizer and change its 
status to Approved or Rejected. 
5.2.2. . The Employee Holiday History will reflect the approved quantity. 
 
 
 
5.2.3.  An entry in Calendar of Employee Absences will have automatically been made.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 20 of 26 
 
5.3. Holiday Request Comments 
5.3.1. Comments can be added to a Holiday request at draft status or at any status by a holiday authoriser. 
 
 
 
 
5.4. Holiday Group Warnings 
5.4.1. Whenever any employee enters or amends a holiday request for an employee and other employees in 
either of that employee’s holiday groups have holiday requests entered with overlapping dates a 
warning if given showing the number of other employees whose holiday dates clash BUT only if the 
number of employees exceeds the warning level set for any of the employee’s holiday groups. 
5.4.2. But the request can still be processed in any way required. 
5.4.3.  
 
5.5. Holiday Group Leader Email 
5.5.1. An email will be sent to the holiday group leader for each of the employee’s holiday groups if a group 
leader has been defined and the holiday request is being approved or if holiday group is set-up such 
also when request is requested.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 21 of 26 
 
6. Calendar of Employee Absences Report 
 
This can be accessed using the new menu: 
Human Resources > Employee Holidays > Calendar of Employee Absences  
 
 
 
7. Employees on Holiday Report 
 
This can be accessed using the new menu: 
Human Resources > Employee Holidays > Employees on Holiday Report  
 
 
This report shows all employees who have holiday, either created by approved holiday requests or entered directly into Calendar of 
Employee Absences form, which overlap the entered date range:

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 22 of 26 
8. Employee Holiday Requests Report 
 
This can be access using the new menu: 
Human Resources > Employee Holidays > Employee Holiday Requests Report  
 
 
This report shows all employees who have holiday requests at Draft, Requested or Approved statuses which overlap the entered date 
range: 
 
 
 
9. Holiday Forward Entitlement 
 
When you want to setup the annual holiday entitlement for the next calendar year you can use the Holiday Forward Entitlement direct 
activation on the form: 
Human Resources > Personnel File

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 23 of 26 
 
9.1. Enter the New Year number. 
 
9.2. The procedure will then create records for all active employees’ details in Employment Holiday History 
adding any extra holiday entitlement into the current year’s entitlement and carrying forward any unused 
holiday up to the limit set in the constant. 
9.3.  
 
9.4. Holiday entries could still be made into the previous year and the procedure run again to update the new 
year values. 
9.5. The Brought Forward (B/Fwd) value for the new year can be adjusted if required. 
 
10. Holiday History Recalculation 
 
If at any time you wish to recalculate the holiday history for any given year based on th e calendar of absences, then you can use the 
direct activation on the form: 
Human Resources > Personnel File

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 24 of 26 
 
11. Compulsory Holidays 
 
If you wish to allocate compulsory holidays to all employees (E.G. Factory Shutdown) then use the procedure:  
Human Resources > Employee Holidays > Compulsory Employee Holidays 
 
 
 
Select any Employees required or * for all active employees, from and to dates then approve. A report showing the success or failure 
for each employee will display.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 25 of 26 
 
12. Bradford Scale 
 
12.1. Showing Scale for individual Employee 
User direct action on the form: Human Resources > Personnel File 
 
 
 
 
Override defaulted date range of previous year if required: 
 
 
 
Bradford scale is displayed:

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY 
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 26 of 26 
12.2. Reporting Scale for Employees 
Run report: Human Resources > HR Reports > Employees Bradford Scale Report 
 
 
 
 
Select employees and defined date range and report shows values: -
