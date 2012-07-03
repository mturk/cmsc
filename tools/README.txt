Tools used in this distribution
===============================

wget.exe        1.11.4  http://users.ugent.be/~bpuype/wget/
                        http://xoomer.virgilio.it/hherold/
upx.exe         3.0.7   http://upx.sourceforge.net/
7za.exe         9.20    http://www.7-zip.org/

Files pulled coreutils-5.3.0
    cp.                 http://gnuwin32.sourceforge.net/
    ls.exe
    md5sum.exe
    rm.exe
    sha1sum.exe

awk.exe         3.1.6-1 http://gnuwin32.sourceforge.net/
diff.exe        2.8.7-1 http://gnuwin32.sourceforge.net/
patch.exe       2.5.9-7 http://gnuwin32.sourceforge.net/
sed.exe         4.2.1   http://gnuwin32.sourceforge.net/

Files pulled from sed-4.2.1-dep
    libiconv2.dll        http://gnuwin32.sourceforge.net/
    libintl3.dll
    regex2.dll



i386/nasm.exe       2.10.01 http://www.nasm.us/pub/nasm/releasebuilds/
     nasmw.exe              copy of nasm.exe
     depends.*      2.2.6   http://dependencywalker.com/
amd64/depends.*     2.2.6   http://dependencywalker.com/
ia64/depends.*      2.2.6   http://dependencywalker.com/

i386/nsinstall.exe  1.6     http://ftp.mozilla.org/pub/mozilla.org/mozilla/libraries/win32/
amd64/nsinstall.exe         MozillaBuildSetup-1.6.exe

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
  C:\Program Files\Microsoft SDKs\Windows\v7.0\
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

Cygwin
~~~~


 c:\> cms15_cygwin.bat

Will download Cygwin setup from http://cygwin.com
and download packages in <cmsc root>\tools\cygwin
Download mirror used is
http://ftp.heanet.ie/pub/cygwin/
Modify batch file is other mirror is desired.

Additional packages downloaded are
bison byacc cpio curl flex git make p7zip patch
python subversion unzip wget w3m and zip

Creating distribution archive
-----------------------------

Open Command promt and change directory to
<cmsc root>\tools and then invoke

 c:\> cmsc_makedist.bat

This will create cmsc-<version>-windows32-i386.zip archive
as well as md5 and sha1 digest.


Intalling Tollkit on target computer
------------------------------------

Create a directory inside drive root that contains no
spaces and unzip the archive file in that directory.

Open Command promt and change directory to
that directory and then ivoke

 <cmsc root>\> postinstall.bat

This will relocate perl hard-coded paths to that new location
and install cygwin subset if present.

All in one
----------

Here is listed how a typical distribution is made:

 c:\> cd cmsc15\tools
 c:\> cmsc_compile.bat
 c:\> cmsc_perl5.bat
 c:\> cmsc_cygwin.bat [optional]
 c:\> cmsc_makedist.bat
