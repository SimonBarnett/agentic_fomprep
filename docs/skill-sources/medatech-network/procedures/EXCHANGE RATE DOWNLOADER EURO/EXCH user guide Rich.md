# EXCH user guide Rich

- **Source:** `EXCH user guide Rich.pdf`

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY  
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 1 of 5 
 
Exchange Rate Feed Downloader User Guide  
1. Description  
 
This module allows the automatic loading of exchange rate data into Priority. The executable 
downloads and reformats the XML feed data (to make it Priority friendly), and Priority loads this 
data using the procedures added by this module. This is well suited to automatic use.  
 
2. Currencies to Download  
 
When creating a new company ensure the currencies code for Lang. 2 is set: - 
Financials > Maintenance of Financials > Exchange Rates > Currencies 
 
 
 
3. Base Currencies Supported  
 
For the correct download to occur the base currency must have the code ‘GBP’ or ‘EUR’

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY  
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 1 of 5 
 
4. Automated Procedure  
 
The automated procedure will be the more commonly useful of the two available. This procedure 
runs without user interaction, downloads the XML data from the Bank of England, and finally loads 
it into Priority. This procedure is ideally suited for use on the Task Scheduler, to automate the 
process.  
 
This procedure is located here: 
 
 
 
 
Simply click to run the procedure to load the data.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY  
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 1 of 5 
 
5. Manual Procedure  
 
The manual procedure runs in a similar manner but allows the user to dictate a non-default location 
to download the xml file to. It works in a similar manner but takes a file path & name as an input.  
 
The procedure is located here:  
 
 
 
 
Running the procedure results in an input window:  
 
 
 
In this dialogue the path for the xml file can be defined. Include a filename, e.g. 
“exchangerates.xml” in the path. Note that the  icon can be used to browse to the intended 
location.

Tel :   + 44 (0) 845 230 6740 
E-mail: info@Medatechuk.com 
http://www. Medatechuk.com   
 
Registered Office: Anchor House, School Lane, Chandlers Ford, Hampshire, SO53 4DY  
Company No. 4311244 VAT Reg. No.: 781 9288 80 
 
Page 1 of 5 
 
As per the automated procedure, the data will now be downloaded and subsequently loaded into 
Priority.  
 
Note: that, due to the need for user input, this procedure is not suitable for use on the Task 
Scheduler. And you can only run this procedure within Priority Client version.
