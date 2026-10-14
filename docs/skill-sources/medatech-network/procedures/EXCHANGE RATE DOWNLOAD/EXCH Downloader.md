# EXCH Downloader

- **Source:** `EXCH Downloader.docx`

Bank of England Exchange Rate Feed Downloader

This document outlines the functionality of the ZEMG_EXC executable.

Preface

The Bank of England offers regularly updated data from their Interactive Statistical Database. Details of this can be found here:

http://www.bankofengland.co.uk/boeapps/iadb/help.asp

In short, the database offers various customisable feeds as XML or CSV files. These are updated daily in most cases.

This executable is designed to automate the retrieval of updates to the Bank of England’s spot exchange rate XML feed, and re-format the data to make it Priority friendly.

Functions

Main()

The main function handles command line arguments, so that a location can be defined (within priority) for the XML feed to download to. When run in the Priority procedure, this path is passed to the executable.

In the Automatic version, this is “../../system/load”, in the manual procedure it is user specified.

If no argument is passed to the executable, it will download the file to C:\load.xml. This is useful for debugging in isolation from Priority. In either case, the variable “arg” holds this path.

The main function calls urlBuilder() to instantiate a string variable, “url”.

The main function also calls urlCheck(url) and xmlParse(url, arg). urlCheck() returns a Boolean value, on which the calling of xmlParse() is dependant.

urlBuilder()

urlBuilder() constructs the URL that is used to obtain the XML feed. The date range must be defined, so this is changed daily. In addition to this, this section handles possible no-update conditions (eg. Attempts to download prior to 0930 when the feed is updated).

Note that the Select Case statement handles Mondays, and weekends. On Mondays, the feed must retrieve Friday’s update. In addition this function contains the hardcoded key value pairs for specifying the data series to be retrieved (&SeriesCodes), and the verbosity of the information (&Omit)

urlCheck(url)

urlCheck() ensures that the feed is available. It will return false (causing the program to exit gracefully) if your machine, or the feed, is offline at runtime. Otherwise, this will return true. Note that this will return false if the URL (which is hardcoded) is invalid.

xmlParse(url, arg)

If urlCheck() returns true, this subroutine loads the XML feed as specified by “url”, and subsequently re-writes it in a Priority friendly format, to the path specified in “arg”.

The dictionary “dctCode” contains a hardcoded list of the BoE’s currency codes, and Priority’s currency codes (Currency, language 2).

“writeload” is the output XML writer, and is iteratively written to with values obtained by calling getXmlData(Element), for each element present in the xml document.

getXmlData() returns an array of values, which are extracted and written to the new XML document.

For the first instance of successful data retrieval, the date is written to a parent tag. Subsequently, children are written for each currency.

Outside of the loop, the end tags are written, and the writer object is closed.

getXmlData(element)

This function is called iteratively by xmlParse, for each element in the source XML document. It simply checks the current element for the appropriate child nodes & attributes, then retrieves the pertinent data, and returns it in an array, “Values”.
