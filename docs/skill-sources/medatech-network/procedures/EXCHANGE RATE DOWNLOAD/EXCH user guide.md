# EXCH user guide

- **Source:** `EXCH user guide.docx`

Exchange Rate Feed Downloader User Guide

Description

This module allows the automatic loading of exchange rate data into Priority. The executable downloads and reformats the XML feed data (to make it Priority friendly), and Priority loads this data using the procedures added by this module. This is well suited to automatic use.

Currencies to Download

When creating a new company ensure the currecies code for Lang. 2 is set:-

Base Currencies Supported

For the correct download to occur the base currency must have the code ‘GBP’ or ‘EUR’

Automated Procedure

The automated procedure will be the more commonly useful of the two available. This procedure runs without user interaction, downloads the XML data from the Bank of England, and finally loads it into Priority. This procedure is ideally suited for use on the Task Scheduler, to automate the process.

This procedure is located here:

Simply click to run the procedure to load the data.

Manual Procedure

The manual procedure runs in a similar manner but allows the user to dictate a non-default location to download the xml file to. It works in a similar manner but takes a file path & name as an input.

The procedure is located here:

Running the procedure results in an input window:

In this dialogue the path for the xml file can be defined. Include a filename, eg “exchangerates.xml” in the path. Note that the  icon can be used to browse to the intended location.

As per the automated procedure, the data will now be downloaded and subsequently loaded into Priority. Note that, due to the need for user input, this procedure is not suitable for use on the Task Scheduler.
