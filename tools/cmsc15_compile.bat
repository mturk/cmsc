@echo off
rem
rem Copyright (c) 2012 The MyoMake Project <http://www.myomake.org>
rem
rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem
rem     http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.
rem
rem Directory Layout creator for Microsoft Compiler Toolkit
rem
rem Prerequisites...
set "PATH=%~dp0;%PATH%"
set "ProgramFiles32=%ProgramFiles(x86)%"
set "ProgramFiles64=%SystemDrive%\Program Files"
if not exist "%ProgramFiles32%\Windows NT" set "ProgramFiles32=%ProgramFiles%"
set "DDK71=c:\WinDDK\7600.16385.1"
set "PSDK6=%ProgramFiles64%\Microsoft Platform SDK for Windows Server 2003 R2"
set "SDK70=%ProgramFiles64%\Microsoft SDKs\Windows\v7.0"
set "SDK71=%ProgramFiles64%\Microsoft SDKs\Windows\v7.1"
set "MSC90=%ProgramFiles32%\Microsoft Visual Studio 9.0"
set "MSC10=%ProgramFiles32%\Microsoft Visual Studio 10.0"
rem
set CVER=msvc
set X86T=wlh
set XCOPYD=xcopy /K /I /Y
set FCOPYF=copy /Y
set WIN2K3SDK=0
rem
pushd ..
rem Remove previous stuff
rm -rf %CVER% 2>NUL
if not "%~1" == "" (
    if /i "%~1" == "clean" goto End
    if /i "%~1" == "sdk6" set WIN2K3SDK=1
    shift
)
if not "%~1" == ""  set "X86T=%~1"
mkdir %CVER%
pushd %CVER%
rem Binaries
mkdir bin
mkdir bin\1033
mkdir bin\amd64
mkdir bin\i386
mkdir bin\ia64
rem
rem Library
mkdir lib
mkdir lib\amd64
mkdir lib\i386
mkdir lib\ia64
rem
rem Includes
mkdir include
mkdir include\atl
mkdir include\crt
mkdir include\gl
mkdir include\mfc

set "WINDDK=%DDK71%"
if not exist "%WINDDK%\bin" (
    echo.
    echo Cannot find "%WINDDK%" directory.
    echo Set this variable to point to the
    echo Windows Driver Kit version 7.1.0 installation directory
    goto End
)
if "%WIN2K3SDK%" == "0" goto SkipSdk6Test
if not exist "%PSDK6%\bin" (
    echo.
    echo Cannot find "%PSDK6%" directory.
    echo Set this variable to point to the
    echo Windows Server 2003 R2 Platform SDK installation directory
    goto End
)
:SkipSdk6Test

if exist "%SDK71%\bin" (
    set "WINSDK=%SDK71%"
    set "WINMSC=%MSC10%"
) else (
    set "WINSDK=%SDK70%"
    set "WINMSC=%MSC90%"
)

if not exist "%WINSDK%\bin" (
    echo.
    echo Cannot find "%WINSDK%" directory.
    echo Set this variable to point to the
    echo Windows Software Development Kit installation directory.
    echo "%SDK71%\bin"
    dir "%SDK71%\bin"
    goto End
)

if not exist "%WINMSC%\VC\bin" (
    echo.
    echo Cannot find "%WINMSC%" directory.
    echo Set this variable to point to the
    echo Microsoft Visual Studio installation directory
    goto End
)

if not exist "%PSDK6%\include\atl" (
    echo.
    echo Cannot find "%PSDK6%" directory.
    echo ATL 3.0 support will be disabled
)

echo Built  : %DATE% - %TIME% >..\tools\compile.log
echo Target : %X86T%  >>..\tools\compile.log
echo WinDDK : %WINDDK:c:\WinDDK\=% >>..\tools\compile.log
echo WinSDK : %WINSDK:c:\Program Files\Microsoft SDKs\Windows\=% >>..\tools\compile.log
echo MSC    : %WINMSC:c:\Program Files\=% >>..\tools\compile.log
echo Copying files ...
rem
rem Platform SDK includes and libraries
if "%WIN2K3SDK%" == "1" (
%XCOPYD% "%PSDK6%\include" include\
%XCOPYD% "%PSDK6%\lib" lib\i386\
%XCOPYD% "%PSDK6%\lib\amd64" lib\amd64\
%XCOPYD% "%PSDK6%\lib\ia64" lib\ia64\
) else (
%XCOPYD% "%WINSDK%\include" include\
%XCOPYD% "%WINSDK%\lib" lib\i386\
%XCOPYD% "%WINSDK%\lib\x64" lib\amd64\
%XCOPYD% "%WINSDK%\lib\ia64" lib\ia64\
)
%XCOPYD% "%WINDDK%\lib\%X86T%\i386" lib\i386\
%XCOPYD% "%WINDDK%\lib\crt\i386" lib\i386\
%XCOPYD% "%WINDDK%\lib\mfc\i386" lib\i386\
%XCOPYD% "%WINDDK%\lib\atl\i386" lib\i386\

%XCOPYD% "%WINDDK%\lib\%X86T%\amd64" lib\amd64\
%XCOPYD% "%WINDDK%\lib\crt\amd64" lib\amd64\
%XCOPYD% "%WINDDK%\lib\mfc\amd64" lib\amd64\
%XCOPYD% "%WINDDK%\lib\atl\amd64" lib\amd64\

%XCOPYD% "%WINDDK%\lib\%X86T%\ia64" lib\ia64\
%XCOPYD% "%WINDDK%\lib\crt\ia64" lib\ia64\
%XCOPYD% "%WINDDK%\lib\mfc\ia64" lib\ia64\
%XCOPYD% "%WINDDK%\lib\atl\ia64" lib\ia64\

rem DDK Specific Files
%XCOPYD% /S "%WINDDK%\inc\crt" include\crt\
%XCOPYD% /S "%WINDDK%\inc\api\crt\stl60" include\crt\
%XCOPYD% /S "%WINDDK%\inc\atl71" include\atl\
%XCOPYD% /S "%WINDDK%\inc\mfc42" include\mfc\
%FCOPYF% "%WINDDK%\inc\api\driverspecs.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\sdv_driverspecs.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\sal.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\sal_supp.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\sal_driverspecs.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\SpecStrings.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\SpecStrings_strict.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\SpecStrings_supp.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\SpecStrings_undef.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\delayimp.h" include\crt\ >NUL
%FCOPYF% include\crt\ctype.h include\crt\wctype.h >NUL
rem Path crtdefs.h and delayimp.h
patch -fp0 -i ..\tools\crt\crtdefs.patch
patch -fp0 -i ..\tools\crt\delayimp.patch
echo "/* EMPTY */" > include\intrin.h
rem Cleanup
rm -rf include\gl >NUL
%FCOPYF% ..\tools\crt\sys\stat.* include\crt\sys\ >NUL
%XCOPYD% /S ..\tools\mfc include\mfc\

rem Copy Binaries
%XCOPYD% "%WINDDK%\bin\x86" bin\
%XCOPYD% "%WINDDK%\bin\x86\1033" bin\
%XCOPYD% /S "%WINDDK%\bin\x86\x86" bin\i386\
%XCOPYD% /S "%WINDDK%\bin\x86\amd64" bin\amd64\
%XCOPYD% /S "%WINDDK%\bin\x86\ia64" bin\ia64\
%FCOPYF% "%WINDDK%\bin\x86\amd64\ml64.exe" bin\amd64\ml.exe >NUL
%FCOPYF% "%WINSDK%\bin\mt.exe" bin\ >NUL
%FCOPYF% "%WINSDK%\bin\guidgen.exe" bin\guidgen.exe >NUL
%FCOPYF% "%WINSDK%\bin\rebase.exe" bin\rebase.exe >NUL
%FCOPYF% bin\ml.exe bin\i386\ml.exe >NUL

%FCOPYF% "%WINMSC%\VC\bin\lib.exe" bin\i386\ >NUL
%FCOPYF% "%WINMSC%\VC\bin\x86_amd64\lib.exe" bin\amd64\ >NUL
%FCOPYF% "%WINMSC%\VC\bin\x86_ia64\lib.exe" bin\ia64\ >NUL
rem Copy CRT redistributables
if exist "%SDK71%\Redist\VC\vcredist_x86.exe" (
    mkdir bin\redist\vc10
    %XCOPYD% "%SDK71%\Redist\VC" bin\redist\vc10
)

if not exist "%PSDK6%\include\atl" goto CopyFinished
%XCOPYD% /S "%PSDK6%\include\atl" include\atl30\
:CopyFinished

popd
popd
call msvcrt_compat.bat
echo.
:ParseCmd
if "%~1" == "" goto Finished
set "CMDOPT=%~1"
shift
echo Calling %CMDOPT%
if /i "%CMDOPT%" == "cygwin" call cmsc15_cygwin.bat
if /i "%CMDOPT%" == "perl" call cmsc15_perl5.bat
goto ParseCmd
:Finished
echo Finished.
:End
