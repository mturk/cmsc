# Tools used for building this distribution


```
curl.exe        7.81.0    https://curl.se/windows/dl-7.81.0_1/curl-7.81.0_1-win64-mingw.zip
7za.exe         21.07     https://www.7-zip.org/a/7z2107-extra.7z
patch.exe       2.5.9     http://gnuwin32.sourceforge.net
```

## Creating CMSC distribution

Prerequisites:

The following prerequisites has to be installed in
machine used for building CMSC toolkit.
Except Visual Studio .NET 2003 all are freely
downloadable from Microsoft MSDN site.

* Windows Software Development Kit for Windows 7
  Make complete install inside default directory.
  `C:\Program Files\Microsoft SDKs\Windows\v7.1\`
  It will also install a subset of Visual Studio 2008 (9.0) at
  `C:\Program Files\Microsoft Visual Studio 9.0`

* Windows Driver Kit version 7.1.0
  This is a DDK version for Windows 7 and Windows Server 2008r2
  There are two versions of those at MSDN, so make sure
  to download version 7.1.0 or later. It installs in:
  `c:\WinDDK\7600.16385.1`

* [optional] Windows Server 2003 R2 Platform SDK
  Make complete install inside default directory
  C:\Program Files\Microsoft Platform SDK for Windows Server 2003 R2
  Used for ATL

## Compiling distribution

Open Command promt and change directory to
<cmsc root>\tools and then invoke

```
  c:> cmsc15_compile.bat
```

This will create required directories and copy files
from prerequisites to a new layout.
It will also create msvcrt_compat.lib and copy
msvcrt_win2003.obj to msvcrt_compat.obj. Those two
files are set in EXTRA_LIBS envvar within setenv.bat.

By default compile will use Windows 7 libraries
from DDK. This can be define inside versions.bat file

## Perl

Strawbery Perl is required component for `CMSC`.
It allows important packages to be compiled like `OpenSSL` and
others. It also contains a set of tools that can be used for
downloading and signing files etc.

```
 c:> cmsc15_perl5.bat
```

Will download [Strawbery Perl release](http://strawberryperl.com/releases.html)
and uncompress in `<cmsc root>\perl`


## Additional components

Following additional components can be added

### Nasm


```
 c:> cmsc15_nasm.bat
```

Will download [Netwide assembler](https://www.nasm.us/pub/nasm/releasebuilds)
and uncompress in `<cmsc root>\nasm`


### Tcl


```
 c:> cmsc15_tclsh.bat
```

The script will download and compile tcl source
adding basic `tclsh.exe` binary to the distribution,
so that packages like SQLite and others can be compiled
which require Tcl toolkit at build time.


## Creating distribution archive

Open Command prompt and change directory to
`<cmsc root>\tools` and then invoke

```
 c:\> cmsc15_makedist.bat
```

This will create `cmsc-<version>-win7-x86_x64.zip` archive
as well as sha-512 digest.


## All in one

Typical distribution build will look like

```
 c:\> git clone ...
 c:\> cd cmsc\tools
 c:\> cmsc15_compile.bat
 c:\> cmsc15_perl5.bat
 c:\> cmsc15_nasm.bat
 c:\> cmsc15_cygwrun.bat
 c:\> cmsc15_tclsh.bat
 c:\> cmsc15_makedist.bat
```

Alternatively `cmsc15_allinone.bat` scrip can be used instead.

```
 c:\> git clone ...
 c:\> cd cmsc\tools
 c:\> cmsc15_allinone.bat
```

