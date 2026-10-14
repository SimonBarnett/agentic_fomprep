# SOP Executive Reports

- **Source:** `SOP Executive Reports.pdf`

SOP: Executive Reports 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 The Executive Reports module provides a broad view of company activities. 
 The module contains BI reports that allow you to compare data from different years, 
periods and companies. 
 A variety of dashboards display data in interactive mini-windows called web parts, 
which allow users instant access to the data they need the most. 
 Once calculated for a given period, y ou can view the data from a variety of 
perspectives (e.g., per part, per customer), and you can obtain varied levels of detail. 
 The module also contains monthly summaries in a variety of cross-sections. 
Setups 
Hiding Orders With a Given Status 
You can exclude sales and purchase orders with a given status from BI reports, 
customized reports and monthly summaries. 
1. Run the appropriate program: BPM Flow Chart-Sales Orders or BPM Flow Chart-
Purchase Orders. 
2. Right-click each status that you want to exclude from reports, select Properties and 
flag the Omit from Reports property. 
Defining the BI Constant  
This constant determines the date from which BI data will be calculated, when you run 
the Prepare All for Analysis (BI) program. 
3. Enter the Logistic Constants form. 
4. Move to the EDaysBI constant, and in the Value column, record the number of days 
back for which to calculate report data when the Prepare All for Analysis (BI) 
program is run. 
Defining Scales for Control Lamps and Gauges 
Priority includes a list of scales which determine how various BI reports (e.g., Invoice 
Analysis (BI) and Order Analysis (BI)) and dashboards are displayed. You can define 
Cat.No. LB110537 1 Ver.1 – Aug. 22, ’11

ranges of values for control lamps and gauge scales, indicated by different colors 
(Red/Yellow/Green/White). 
Note: The list itself is predefined and cannot be revised. 
1. Enter the Definition of Gauge Scales form. 
2. For each scale in the list, define the Base Value, End of Green Area, End of 
Yellow Area, End of Red Area, and End of White Area. 
Defining External Web Sites for Display in Dashboards 
1. Enter the Define Web Sites form. 
2. Record the Site Name, as it will appear in dashboard Choose lists. 
3. Specify the URL of the website. 
Defining the Graphic Display Constant 
This constant determines how graphs and BI charts will be displayed in Priority. If you 
want to enable display of graphs and charts in three-dimensional, interactive format, 
make sure your system administrator sets the CHARTTYPE system constant 
accordingly. 
1. Enter the System Constants form. 
2. Move to the CHARTTYPE constant, and in the Value column, specify the desired 
display format. 
Procedure 
Stage I: Creating BI Reports 
Preparing data for BI reports 
 To prepare data for multiple reports, run the Prepare All for Analysis (BI) program. 
Make sure that the categories for which you want to calculate data are flagged in the 
input screen. The program updates the existing BI data for the selected categories, 
for the defined period (according to the value of the EDaysBI constant), and adds 
any data that were recorded in the system since the last preparation. Existing data 
from beyond the defined period are not affected. 
Tip: You can set the Tabula Task Scheduler to automatically run the program at the 
end of every work day. 
 You can also run the relevant preparation program for a specific topic. For example, 
you can run the Prepare for Order Analysis-BI program from the Sales Order 
Analysis menu and  the Prepare for Inv. Analysis-BI program from the Customer 
Invoice Analysis menu. 
Running BI reports 
 
Run the desired report from the relevant menu. For example, you can run both the 
Order Analysis (BI) and the Invoice Analysis (BI) reports from the Marketing and 
Sales menu. 
Cat.No. LB110537 2 Ver.1 – Aug. 22, ’11

Making Minor Adjustments and Analyzing the Report 
Defining the cross-sections by which data is displayed 
The report first displays data for the entire population. You can drill down to the desired 
level of detail, by selecting the relevant cross-sections and sub-categories: 
1. To drill down one level of detail, click All. The menu that appears displays the cross-
sections by which you can display the data. Select the desired cross-section. 
2. To drill down to the next level of detail, click one of the values appearing in the right-
hand column, and select the desired sub-category. You can continue drilling down in 
this manner until you reach the desired level of detail. 
3. To return to the previous level of detail, click the return arrow in the Tool Bar, or 
select Back from the Go menu. 
4. To return to the All screen, click the 
  icon at the top of the report (below the Tool 
Bar). 
Tips: 
 The input screen that appears when drilling down to a more detailed report contains 
the option to Filter data or display an additional row with a Total for the defined 
cross-section. If you select Filter, specify the desired pattern in the Use Pattern 
column, which allows you to restrict the data displayed according to a given criterion. 
For example, you can record the value "5*" in order to restrict a report on parts to 
parts whose numbers begin with 5. Similarly, you can select Filter Except for and 
record the value "5*" in order to view a report on all parts whose numbers do not 
begin with 5. 
 Clicking a monetary sum at any level opens a report that details its component sums. 
 Clicking any linked value opens the Priority form and record from which the value 
was taken. 
Defining cross-sections by periods or companies 
1. Click 
the 
  or 
  icon in the upper left-hand corner to define the periods and/or 
companies for which you want to compare data. Select any option to define report 
periods, as needed. 
2. After defining the desired parameters, you can save them in a template by clicking 
one of the numbered buttons appearing next to Save Template.  
3. The parameters currently displayed in the table will serve as the default the next time 
you run the report. To change them, click the appropriate icon and revise them 
manually, or load one of the saved templates by clicking the appropriate numbered 
buttons next to Get Template. 
Adding or hiding report columns 
 
When the report is first opened, the data are displayed in the pre-defined manner, 
usually according to quantity and sum. Click the 
 icon to add or hide columns, by 
flagging or clearing the available options. 
Cat.No. LB110537 3 Ver.1 – Aug. 22, ’11

Note: The options you define will serve as defaults the next time you run the 
program. 
 In reports that display data in percentages for key performance areas (e.g., 
profitability or budget usage), it is recommended that you choose to display the 
control lamp. The color of the control lamp indicates target compliance for the 
percentage displayed in the current report, based on the value ranges defined in the 
Setups section. 
Tip: Clickin
g the control lamp displays a gauge with the full range of values defined 
for the report in the Setups section. 
Defining the display format for the table values 
1. Click 
the 
 icon to select the appropriate display format for the table values. You 
can choose: 
 a rounding option 
 the method of comparing data from different periods 
 the type of percentage to display for table data. 
2. The Graph icons 
  and 
  are activated when you select a cross-section by which 
to display the report data. Click the desired icon to display the chart. 
Notes: 
 The options you define will serve as defaults the next time you run the program. 
 You can only display charts if you are running MS-Office 2000 or higher. 
Displaying a detailed report 
 Click 
the 
  icon at any stage in order to view the component data on the most 
basic level. This is the level of greatest detail. 
Printing the report 
 
When you have reached the desired manner of displaying the report data, you can 
export the data to MS-Word, MS-Excel or MS-Outlook (using the 
 , 
  and 
  
icons), print the report or save it as an HTML document. 
Stage II: Dashboards 
Dashboards display pertinent data in various cross-sections, including reports, tables, 
graphs, gauges and pies, and even allow access to relevant BI reports. The system 
contains dashboards suited to specific topics or for employees with specific positions: 
 Executive Dashboard: Sales analysis, cash flow, profit and loss, aging, budgets, 
profit and cost centers, sales opportunities, sales orders, purchase orders, service 
calls, inventory value analysis. 
 Projects Dashboard: Profitability analysis, human resource management, milestone 
tracking, details of a specific project.  
 Calendar: Appointments and assigned tasks on defined dates (can also revise 
tasks/appointments and add new ones)  
Cat.No. LB110537 4 Ver.1 – Aug. 22, ’11

 CFO Dashboard: Budgets, profit and cost centers, cash flow, profit and loss, aging, 
sales and purchases.  
 HR Dashboard: Job openings, total vs. filled positions, employee and candidate 
profiles  
 Service Manager Dashboard: Active service calls, service call analysis, technician 
scheduling, customer service data.  
 Customer Dashboard: All aspects of working with a given customer.  
 Vendor Dashboard: All aspects of working with a given vendor.  
 Parts Dashboard: Part sales, current inventory, sales and purchase orders, work 
orders, costs.  
 Production Manager Dashboard: Production reports, production data for parts, 
production costs analysis, work load analysis, inventory value analysis. 
 Inventory Manager Dashboard: Current inventory, inventory value analysis, inventory 
data for parts and for base products. 
 Customer Relations Mgr Dashboard: Sales opportunities, sales forecasts, order 
targets, sales targets. 
 Sales Manager Dashboard: Sales orders, customer invoices, commission sales. 
 Purchasing Manager Dashboard: Purchase requisitions, purchase orders, purchase 
invoices.  
 My Dashboard: Main menu, Favorites menu, To Do List, calendar, customer and 
contact search.  
All dashboards include a user-friendly design tool for determining which web parts to 
display, and in what order. Within each web part users can drill down to the lowest level 
of data and activate Priority forms. External web sites can also be displayed in any 
dashboard, and other selected web parts can be added to each user’s personalized My 
Dashboard. 
Preparing data for dashboards 
To prepare data for dashboards, ru
n the Prepare All for Analysis (BI) program on a 
regular basis (see Preparing data for BI reports).  
Designing dashboards 
1. Click 
the 
  icon that appears in the upper-right corner of any web part. This will 
open the Dashboard Design window, which displays the arrangement of web parts 
appearing in the dashboard alongside a list of hidden web parts. 
2. To include additional web parts displaying selected web sites, open the Additional 
Sites Choose list and select a site. This list displays all sites that have been 
recorded in the Define Web Sites form (see Setups). The title of the selected web 
site will app
ear in the table of displayed windows in the top part of the screen. 
3. To include additional web parts in your personalized My Dashboard (in accordance 
with user privileges), select the desired web part from the Additional Web Parts 
Choose list. This list displays all available web parts for which you have the 
necessary privileges. The selected web part will appear in the top part of the screen. 
Cat.No. LB110537 5 Ver.1 – Aug. 22, ’11

4. To remove any web part from the dashboard, drag its title to the list of hidden web 
parts on the left. 
5. To apply the changes you've made to the dashboard design, click GO. 
6. To enlarge one of the windows, click the 
  icon in the upper right corner. 
7. To determine the date range for which reports are run, click the 
  icon. 
8. To change the type of graph displayed, click the 
  icon. 
Note: In order to use the Graph Type icon, the CHARTTYPE system constant must 
be set to 5 (see Setups). 
Stage III: Preparing and Viewing Monthly Summaries 
Priority provides monthly summary reports for goods shipped to customers, customer 
invoices, sales orders, purchase orders and purchase invoices. 
1. To calculate monthly summaries, run one of the following programs: 
 For goods shipped to customers, run the Calculate Monthly Sales program. 
 For customer invoices, run the Calculate Monthly Invoices  program. 
 For sales orders, run the Calculate Monthly Sales Orders  program. 
 For purchase orders, run the Calc. Monthly Purchases (Orders) program. 
 For purchase invoices, run the Calc. Monthly Purchases (Invs.) program. 
2. Specify the desired date range in the input screen. 
3. To view the monthly summaries: 
 For goods shipped to customers, enter the Monthly Sales form. The data in this 
form are based on lines in customer shipment documents that are flagged as 
billed, sales invoices and over-the-counter invoices.   
 For customer invoices, enter the Monthly Customer Invoices form. The data in this 
form are based on multi-shipment invoices, sales invoices and over-the-counter 
invoices. 
 For sales orders, enter the Monthly Sales Orders  form. This form displays sales 
orders divided into two categories: all orders (open and closed) and their profit, 
and open sales orders and their profit. 
Note: The lines in the upper-level form are displayed in the sub-level forms in the 
following cross-sections: per sales rep, per branch, per customer and per part. 
 For purchase orders, enter the Monthly Purchase Orders form. 
 For purchase invoices, enter the Monthly Purchasing Invoices  form. 
Note: The lines in the upper-level form are displayed in the sub-level forms in the 
following cross-sections: per vendor and per part. 
Cat.No. LB110537 6 Ver.1 – Aug. 22, ’11
