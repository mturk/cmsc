Custom Microsoft Compiler Toolkit Compilation
=============================================

Based on the VC from DDK 7.1.0 (cl 15.00.30729.207)
It offers only command line build tools and produces
binaries that are dependent only on the system `msvcrt.dll`
It does not require compiler installation, since its
completely portable and does not write anything to system registry.
See more in Installing section

## Invoking

Open command prompt in project target and call

```
     c:> \<cmsc root>\setenv.bat <cpu>

     Where <cpu> can be:
     x64 or amd64 for 64-bit Windows
     x86 or i386  for 32-bit Windows
```

This will set up required paths for binaries, include
and lib files.
It will also set `EXTRA_LIBS` environment variable
with the value `msvcrt_compat.lib msvcrt_compat.obj`
If no argument is provided default target is `x64`


## Important

Make sure those two files are linked to every .dll
or .exe produced by this toolkit. The easiest is to add
`$(EXTRA_LIBS)` to link task in Makefile.


## Warning

Toolkit cannot be used for producing DEBUG builds
because there is no system msvcrtd.dll.
Trying to compile with the `/MDd` compiler option
will produce unusable builds, because of missing stubs.
For debugging purposes use the compiler that comes with Visual Studio.


## Installing Toolkit on target computer

The safest way is to unzip the archive file directly
in the root of system drive (eg, C:)
Optionally you can create a directory that contains no
spaces and unzip the archive file in that directory.
