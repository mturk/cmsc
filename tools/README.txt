Tools used in this distribution
===============================

wget.exe        1.19.4  https://eternallybored.org/misc/wget/
7za.exe         19.00   http://www.7-zip.org/

Files pulled coreutils-5.3.0 
    http://gnuwin32.sourceforge.net/
    rm.exe
    sha1sum.exe
    diff.exe        2.8.7-1
    patch.exe       2.5.9-7
    libiconv2.dll
    libintl3.dll



nasm.exe       	2.14.02 	http://www.nasm.us/pub/nasm/releasebuilds/

Files pulled from https://ftp.mozilla.org/pub/mozilla/libraries/win32
                  MozillaBuildSetup-3.3.exe
    nsinstall.exe


Creating CMSC distribution
--------------------------

Prerequisites:

The following prerequisites has to be installed in
machine used for building CMSC toolkit.
Except Visual Studio .NET 2003 all are freely
downloadable from Microsoft MSDN site.

* Windows Server 2003 R2 Platform SDK
  Make complete install inside default directory
  C:\Program Files\Microsoft Platform SDK for Windows Server 2003 R2

* Windows Software Development Kit for Windows 7
  Make complete install inside default directory.
  C:\Program Files\Microsoft SDKs\Windows\v7.1\
  It will also install a subset of Visual Studio 2008 (9.0) at
  C:\Program Files\Microsoft Visual Studio 9.0

* Windows Driver Kit version 7.1.0
  This is a DDK version for Windows 7 and Windows Server 2008r2
  There are two versions of those at MSDN, so make sure
  to download version 7.1.0 or later. It installs in:
  c:\WinDDK\7600.16385.1

Compiling distribution
----------------------

Open Command promt and change directory to
<cmsc root>\tools and then invoke

  c:> cmsc_compile.bat

This will create required directories and copy files
from prerequisites to a new layout.
It will also create msvcrt_compat.lib and copy
msvcrt_win2003.obj to msvcrt_compat.obj. Those two
files are set in EXTRA_LIBS envvar within setenv.bat.

By default compile will use Windows 2003 libraries
from DDK. Using wxp command line option will result in
using Windows XP libraries for i386 target.

Additional components
---------------------

Perl
~~~~


 c:> cms15_perl5.bat

Will download Strawbery Perl from
http://strawberryperl.com/releases.html
and uncompress in <cmsc root>\perl

Creating distribution archive
-----------------------------

Open Command promt and change directory to
<cmsc root>\tools and then invoke

 c:\> cmsc_makedist.bat

This will create cmsc-<version>-windows-x86_x64zip archive
as well as md5 and sha1 digest.


Intalling Tollkit on target computer
------------------------------------

The safest way is to unzip the archive file directy
on system drive.

You can create a directory inside drive root that contains no
spaces and unzip the archive file in that directory.




All in one
----------

Here is listed how a typical distribution is made:

 c:\> cd cmsc15\tools
 c:\> cmsc_compile.bat
 c:\> cmsc_perl5.bat
 c:\> cmsc_makedist.bat
