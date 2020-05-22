Custom Microsoft Compiler Toolkit Compilation
---------------------------------------------

Based on the VC from DDK 7.1.0 (cl 15.00.30729.207)

VS2008's cl is 15.00.21022.08, so this seems like the
same compiler generation.

### Directory layout:

     <Top Directory>
        +--bin
        |   +--1033
        |   +--x64
        |   +--x86
        +--include
        |   +--atl
        |   +--crt
        |   |   +--sys
        |   +--gl
        |   +--mfc
        +--lib
            +--x64
            +--x86

See `tools\README.txt` for dependencies and versions

### Invoking

Open command promt in project target and call

     c:> \<cmsc root>\setenv.bat /<cpu>

     Where <cpu> can be:
     /x86 | /i386 for Windows32
     /x64 | /amd64 for Windows64

This will set up required paths for binaries, include and
lib files.
It will also set `EXTRA_LIBS` environment variable
with the value `msvcrt_compat.lib msvcrt_compat.obj`

### Important

Make sure those two files are linked to every .dll
or .exe produced by this toolkit. The easiest is to add
`$(EXTRA_LIBS)` to link task in Makefile.

### Warning

Toolkit cannot be used for producing DEBUG builds
because there is no system msvcrtd.dll.
Trying to compile with the `/MDd` compiler option
will produce unusable builds, because of missing stubs.
For debugging purposes use the compiler that comes with Visual Studio.
