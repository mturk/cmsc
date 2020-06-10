Tools used in this distribution
===============================

wget.exe        1.19.4  https://eternallybored.org/misc/wget/
7za.exe         19.00   http://www.7-zip.org/
patch.exe       2.5.9   http://gnuwin32.sourceforge.net
nsinstall.exe   from    https://ftp.mozilla.org/pub/mozilla/libraries/win32
                        MozillaBuildSetup-3.3.exe

posix2wx.exe    2.0.1   https://github.com/mturk/posix2wx/releases/download/2.0.1/posix2wx.exe

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

  c:> cmsc15_compile.bat

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


 c:> cmsc15_perl5.bat

Will download Strawbery Perl from
http://strawberryperl.com/releases.html
and uncompress in <cmsc root>\perl

Nasm
~~~~


 c:> cmsc15_nasm.bat

Will download Netwide assembler from
https://www.nasm.us/pub/nasm/releasebuilds
and uncompress in <cmsc root>\tools


Cmake
~~~~~


 c:> cmsc15_c,ake.bat

Will download cmake from
 https://github.com/Kitware/CMake/releases
and uncompress in <cmsc root>\cmake

Creating distribution archive
-----------------------------

Open Command promt and change directory to
<cmsc root>\tools and then invoke

 c:\> cmsc15_makedist.bat

This will create cmsc-<version>-windows-x86_x64.zip archive
as well as sha-512 digest.


Intalling Tollkit on target computer
------------------------------------

The safest way is to unzip the archive file directy
on system drive.

You can create a directory inside drive root that contains no
spaces and unzip the archive file in that directory.




All in one
----------

Typical distribution:

 c:\> git clone ...
 c:\> cd cmsc\tools
 c:\> cmsc15_compile.bat
 c:\> cmsc15_cmake.bat
 c:\> cmsc15_perl5.bat
 c:\> cmsc15_nasm.bat
 c:\> cmsc15_makedist.bat
