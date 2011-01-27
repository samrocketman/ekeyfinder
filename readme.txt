                        Enchanted Keyfinder v0.1 Beta
README                                                      January 17th, 2011

                  http://sourceforge.net/projects/keyfinder/
--------------------------------------------------------------------------------

Product Overview
----------------
The Enchanted Keyfinder is a free and open source utility that retrieves
your Product Key used to install windows from your registry or from an
unbootable Windows installation.
It works on Windows 95, 98, ME, NT, 2000, XP, Vista and Windows 7.
It has options to save the keys to a text file, or print them out.


Features
--------
Open Source - This means that it can be trusted. The Keyfinder does not contain trojans or "phone home" messages. No spam, spyware, viruses, 
or trojans.
Office 2010, Office 2007, & Windows 7 support!
An optional config file - this functionality lets you pull a key stored in the registry for any software. A sample config file is included 
in the zip and can be seen here: keyfinder.cfg
Command line options - /save <location> /savecsv <location> /close /hive <location> /file <filename>
Load Hive option - allows you to load the registry hive of another Windows installation. To use, put the hard drive in a working machine 
(must also be Windows 2000,XP, Vista or 7) or use Windows PE (not tested, should work) and click Load Hive. Then point it to the dead Windows 
install. If you're using Windows Vista or Windows 7, Administrator rights are required for this feature. You may have to right click on the Keyfinder and 
run as Administrator.
Improved Save & Print! - save & print options will now include all keys. Save is also available in text or CSV.

How To Extract
--------------
Download the ZIP package and extract to a folder of your choice.
Launch the program by double-clicking on keyfinder.exe.


Known Issues
------------
 - Build 2.08: If the /hive command line is used, and the hive file listed is 
   damaged or missing, the program will loop endlessly trying to open the hive.
 - If you bought your new PC preinstalled with Windows, you may find
   the CD Key that appears in keyfinder is different from the CD Key on
   your Windows Certificate of Authenticity. This issue can happen with
   the branded PC's mostly (Dell, HP, IBM, Acer etc.). COA samples are
   at http://www.microsoft.com/resources/howtotell/windows/
 - If you have no physical XP media or only restore media, the retrieval software will have limited use. 
 - Do not pay for a key retrievable utility for any reason, reinstalled, upgraded or clean installed XP since purchasing or building the computer. 
   No paid key retrieval tool will retrieve a valid key from a OEM installation that used a generic key. 
 - In older versions of Office (Office 2000 and below), the
   'Product Key' value is not available.


Command Line Parameters
-----------------------

Syntax:
-------
keyfinder.exe [/close] [/file <filename>] [/hive <path>]
or
keyfinder.exe [/close] [/hive <path>] [/savecsv <path>]


Parameters:
-----------
/close                No GUI displayed.
/hive <path>          Load product key information from another operating
                      system on the same computer. The <path> would be the 
                      location of the Windows folder. (e.g H:\windows)
                      This feature is only supported on Windows 2000 and XP.
/file <file.ext>      With /save or /savecsv, use filename.ext as the
                      filename for the saved file.


You can also combine the above command-line options with the following
save options in order to save product key information to a file:

/delim <character>    Many countries use a “,” and not a “.” as decimal separator.
                      This means they can't use “,” as field separator, and they
                      use another character instead.
/savecsv <Filename>   Save the list of product keys into a comma-delimited
                      text file.


Examples
--------

Interactive Usage
-----------------

To display the product keys:

    keyfinder

To display keys and save them to text file .\LICENSES.TXT:

    keyfinder /save /file LICENSES.TXT

To retrieve keys from "dead" Windows XP install on hard disk letter F:

    keyfinder /hive F:\WINDOWS


Automated/Scripted Usage
------------------------

To save keys from machine WIN-XP in text file R:\LICENSES\WIN-XP.TXT
without showing the GUI:

   keyfinder /close /save R:\LICENSES\

To save keys in CSV file "Y:\ANOTHER PATH\SYSTEM LICENSES.CSV" without
showing the GUI:

   keyfinder /close /savecsv "Y:\ANOTHER PATH\" /file "SYSTEM LICENSES.CSV"


System Requirements
-------------------
keyfinder works on all 32-bit versions of Windows.
However, some features, like viewing the product keys of another
operating system instance, are only supported on Windows 2000 and XP.

How to update the CFG file
-------------------------- 
keyfinder.cfg is an ANSI text file which can be modified in Notepad.
Each line is formatted as follows.

ApplicationDisplayName|Description=FullyQualifiedRegistryLocation=KeyName|Description2=FullyQualifiedRegistryLocation2=KeyName2 

You can have as many description fields as necessary. Just separate each with the pipe symbol. 
Comment lines can be added by putting a semicolon ';' symbol at the begining of a line.
The first line in the file holds the version of keyfinder it's compatable with and the date it was last updated.


Reporting Bugs
--------------
If you experience something you believe is a bug, please fill out the
online form at:

http://sourceforge.net/tracker/?group_id=369948

Do not assume someone else will report it.

Please describe the problem in as much detail as possible.
Include the following information:

  - Version of keyfinder (as shown in the About dialog)
  - Operating system and version

