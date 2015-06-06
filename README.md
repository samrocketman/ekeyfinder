# Enchanted Keyfinder

* Project Status: Abandoned in 2012 migrated from [SourceForge][ekeyfinder]
* License: [GNU GPL v3](license.txt)

This is a migration of the enchanted keyfinder source code base from
SourceForge.  This is purely meant as an archive of my sourceforge project.
Enchanted Keyfinder was born out of the will to keep an open source project open
for anybody to study.  What follows is original excerpts from the ekeyfinder
website.  There was a small effort to port the Pascal code base to
[Lazarus][lazarus], an open source Free Pascal IDE, however that effort was
ultimately abandoned.

# About from the website

Enchanted Keyfinder is a Magical Jelly Bean Keyfinder (MJB KF) fork from the
open source version of MJB KF. It is a utility that retrieves the product key
used to install Windows from your registry or from an unbootable Windows
installation. It works on Windows 9X, ME, NT/2K/XP, and Vista/Win7 and for other
software.

Enchanted Keyfinder is written in Pascal and compiles in: Delphi 7, Borland
Developer Studio 2006, DS Turbo Delphi 2006, Delphi 2007. It may compile in
other versions of Delphi.

# Features

This is a summary of the features and goals currently outlined in the project.
This is something to keep the EK team on track but also so that you, as a user,
understand where we wish to take this project. The first stable release, v0.2,
will be released soon. You can read below and see what is currently missing from
the stable version. The changes listed below the General Feature List are
changes which have been made since Magical Jelly Bean Keyfinder 2.0.8.

### General Feature List

* Office 2010, Office 2007, Vista, & Windows 7 support.
* MS Office 2010 key recovery is experimental.
* Change Windows Registration information and Product Key.
* Portable, settings saved in an INI file.
* An optional config file for software serial lookups.
* Export found keys to csv, html, ini, or txt.
* Load a registry hive backup.
* Can check for program and config file updates.
* Command line options.
* No software installation.

### What is currently stable in the EK v0.1 Betas? (v0.1)

* Retrieve product key for MS Office 2010.
* Change the Windows XP Product Key of a Windows Installation.
* All settings are now saved and loaded from an INI file. I had PortableApps.com
  in mind when I did this because I enjoy their releases.
* Saving and loading of Font Settings are now done correctly.
* The `File > Refresh` menu entry which reloads the keyfinder.cfg file and then
  displays the newly detected keys.
* Graphics and logos of the program (using the [Tango Icon Library][tango]).
* The list of detected keys (no more blank entries). Also the program doesn't
  fail in Wine on Linux from invalid data types when reading the registry. Add
  config setting for displaying blank keys.
* Software updates. They are implemented for both unstable and stable versions
  of EK. To check for updates you click `Help > Check for Updates` in the menu.
  This is the only time the program will connect to the internet.
* User defined keyfinder.cfg file.
* Path to config file setting has been implemented. Check out the documentation
  in keyfinder.ini.
* Documentation - This has been finished for the stable release. The wiki
  documentation has been written and I can export it to the mediawiki xml
  schema. I wrote a python script which parses the mediawiki xml schema and
  generates html files as output. Then I can compile the generated html files
  into a chm format all automated. It took me 5 or 6 hours to create but from
  now on generating documentation will take seconds for me across all of my
  projects.

The logs settings are "stable" that is to say they don't do anything (they
didn't in MJBKF 2.0.8) and they won't for the first stable release of EK v0.2.

### What is unstable but will be finished for EK v0.2 Stable? (v0.2)

* keyfinder.cfg needs to be reorganized into a standard format.
* Once keyfinder.cfg is standardized then we need to update exporting keys to
  match it. This way when keys are exported the found serials are all uniform.

### What are my current plans for the next unstable release? (v0.3)

* Remote registry connection. This is something which has already been in the
  works since MJBKF 2.0.8. The dialogs are somewhat there but the implementation
  isn't. I want to start to get this working because it could be a useful
  feature for a sys-admin. After that I probably won't do too much more because
  I want ekeyfinder to remain a small and simple program. I want it to do one
  thing, and do it well... look up keys in the registry.
* Implement logging.
* Exporting to other formats?
* More serials!
* Possibly recovering wifi keys from connected networks?
* Any request that a user may have which would better enable the program to do
  its original intent of functionality. Go ahead and submit a request if you
  have an idea (even if the idea is incomplete).

### Beyond?

I want to abstract the underlying code away from the UI. The previous developers
did not do this very well. Right now it is very integrated. Once I have the code
abstracted away then I can begin work on a Linux edition of Enchanted Keyfinder
which is native to the Linux OS (and possibly a Mac native). I was thinking of
doing it in Kylix but apparently it's difficult to get a hold of so I will check
out other Pascal IDEs such as [Lazarus][lazarus].

# History

### Magical Jellybean Keyfinder 1.51

MJB KF 1.51 was closed source. It was basically a self extracting RAR file. It
extracted to the Windows `%TEMP%` folder four files:

1. `findkey.exe` - A Delphi/Pascal GUI front end which displayed text files from
   output of other programs.
2. `chgxp.vbs` - VBScript which changed the Windows XP product key.
3. `xpkey.exe` - A cli executable which found/decoded Windows XP and below key
   to plain txt file.
4. `officekey.exe` - same as xpkey.exe but for Office 2003 and below.

### Magical Jellybean Keyfinder 2.0

MJB KF became open source in MJB KF 2.0 under the GNU GPLv3 license. It remained
open source until last year (2010). The last open source version is 2.0.8.
Recover Keys bought the project and closed the source which shut the community
project down. The current MJB KF is the "less feature rich" product compared to
their flagship product. They took out many of the keyfinder.cfg entries with the
intention to make it view fewer software keys. Entries in the keyfinder.cfg
which were built by community members of MJB KF when it was open source. EK v0.1
was born from the original open source MJB KF 2.0.8.

### Enchanted Keyfinder vs. Magical Jellybean Keyfinder open source

Here are some features which EK does better than MJB KF open source.

* It works for Office 2010
* Load Hive is more reliable
* Documentation is actually existent
* Live updates of the software and not just a web link
* Able to change the Windows XP product key similar to MJB KF 1.51
* Several other minor bug fixes

Also the EK keyfinder.cfg is built from the original community versions of MJB
KF keyfinder.cfg. Some entries have been added to that and eventually the whole
file will be reformatted to match a standard. There are even more plans for more
features which will aide it with recovering software keys. There's more that it
can do from the svn repository but that's what the current unstable releases can
do (EK v0.1). The Enchanted Keyfinder project isn't attempting to copy the
original MJB KF, we're trying to evolve it into something more with our own set
of features and goals in mind.

[ekeyfinder]: https://sourceforge.net/projects/ekeyfinder/
[lazarus]: http://www.lazarus-ide.org/
[tango]: http://tango.freedesktop.org/Tango_Icon_Library
