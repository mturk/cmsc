# ChangeLog file for cmsc

This is a high-level summary of the most important changes.
For a full list of changes, see the [git commit log][log]

  [log]: https://github.com/mturk/cmsc/commits/


## cmsc 15.0_48

 * Rebase cygwrun to 1.2.2
 * Rebase nasm to 2.16.01
 * Rebase perl to 5.38.2.2
 * No need for EXTRA_LIBS any more

## cmsc 15.0_47

 * Update cygwrun dependency

## cmsc 15.0_46

 * Drop tcl
 * Update cygwrun dependency

## cmsc 15.0_45

 * Add missing _ftelli64
 * Fix faulty sys/utime.h
 * Update cygwrun dependency

## cmsc 15.0_44

 * Update cygwrun dependency

## cmsc 15.0_43

 * Update cygwrun dependency
 * Add option to compile minimal Tcl8.6 package

## cmsc 15.0_42

 * Not released

## cmsc 15.0_41

 * Update cygwrun dependency

## cmsc 15.0_40

 * Use amd64/lib.exe
 * Add dumpbin.exe

## cmsc 15.0_39

 * Update cygwrun dependency

## cmsc 15.0_37

 * Update dependencies
 * Use cygwrun instead posix2wx

## cmsc 15.0_36

 * Add missing snprintf and vsnprintf function declarations
 * Add CMSC_VERSION to setenv.bat

## cmsc 15.0_35

 * Update dependencies
 * Add simple stdbool.h and stdint.h files

## cmsc 15.0_34

 * Update dependencies

## cmsc 15.0_33

 * Update dependencies
 * Drop Cmake since it does not work
   with our compiler


## cmsc 15.0_32

 * Update dependencies

## cmsc 15.0_31

 * Update dependencies

## cmsc 15.0_30

 * Update dependencies

## cmsc 15.0_29

 * Cleanup unused tools
 * Make setup.bat standalone
 * Update dependencies

## cmsc 15.0_28

 * Use 64bit-portable perl since it doesn't require
   calling rellocation.bat after post install.
 * Use curl instead old wget
 * Add cmake toolkit
 * Download nasm instead having the binaries here
 * Update dependencies
 * Use win7 as default target
 * Drop Itanium platform
 * Cleanup unused tools
 * Use x86 instead i386
 * Use x64 instead amd64
 * Use posix2wx instead cygspawn
   cygspawn was in collision with existing project on github.
 * Use SHA-512 hashing

## cmsc 15.0_27

 * Update dependencies
 * Use wlh as default target

## cmsc 15.0_25

 * Update dependencies

## cmsc 15.0_24

 * Add empty intrin.h
 * Support for mingw32
 * Added nsinstall

## cmsc 15.0_20

 * Moved to github
 * Fix stat/fstat
 * Updated StrawberryPerl to 5.14.2.1-32-bit
