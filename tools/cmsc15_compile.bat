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
set "SDK71=%ProgramFiles64%\Microsoft SDKs\Windows\v7.1"
set "MSC10=%ProgramFiles32%\Microsoft Visual Studio 10.0"
rem
set CVER=msvc
set X86T=win7
set XCOPYD=xcopy /K /I /Y
set FCOPYF=copy /Y
rem
pushd ..
rem Remove previous stuff
rm -rf %CVER% 2>NUL
if not "%~1" == "" (
    if /i "%~1" == "clean" goto End
    shift
)
if not "%~1" == ""  set "X86T=%~1"
mkdir %CVER%
pushd %CVER%
rem Binaries
mkdir bin
mkdir bin\1033
mkdir bin\x64
mkdir bin\x86
rem
rem Library
mkdir lib
mkdir lib\x64
mkdir lib\x86
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

set "WINSDK=%SDK71%"
set "WINMSC=%MSC10%"
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
%XCOPYD% "%WINSDK%\include" include\
%XCOPYD% "%WINSDK%\lib" lib\x86\
%XCOPYD% "%WINSDK%\lib\x64" lib\x64\

%XCOPYD% "%WINDDK%\lib\%X86T%\i386" lib\x86\
%XCOPYD% "%WINDDK%\lib\crt\i386" lib\x86\
%XCOPYD% "%WINDDK%\lib\mfc\i386" lib\x86\
%XCOPYD% "%WINDDK%\lib\atl\i386" lib\x86\

%XCOPYD% "%WINDDK%\lib\%X86T%\amd64" lib\x64\
%XCOPYD% "%WINDDK%\lib\crt\amd64" lib\x64\
%XCOPYD% "%WINDDK%\lib\mfc\amd64" lib\x64\
%XCOPYD% "%WINDDK%\lib\atl\amd64" lib\x64\

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
patch -fp0 -i ..\tools\crt\errno.patch
echo "/* EMPTY */" > include\intrin.h
rem Cleanup
rm -rf include\gl >NUL
%FCOPYF% ..\tools\crt\sys\stat.* include\crt\sys\ >NUL
%XCOPYD% /S ..\tools\mfc include\mfc\

rem Copy Binaries
%XCOPYD% "%WINDDK%\bin\x86" bin\
%XCOPYD% "%WINDDK%\bin\x86\1033" bin\
%XCOPYD% /S "%WINDDK%\bin\x86\x86" bin\x86\
%XCOPYD% /S "%WINDDK%\bin\x86\amd64" bin\x64\
%FCOPYF% "%WINDDK%\bin\x86\amd64\ml64.exe" bin\x64\ml.exe >NUL
%FCOPYF% "%WINSDK%\bin\mt.exe" bin\ >NUL
%FCOPYF% "%WINSDK%\bin\guidgen.exe" bin\guidgen.exe >NUL
%FCOPYF% "%WINSDK%\bin\rebase.exe" bin\rebase.exe >NUL
%FCOPYF% bin\ml.exe bin\x86\ml.exe >NUL

%FCOPYF% "%WINMSC%\VC\bin\lib.exe" bin\x86\ >NUL
%FCOPYF% "%WINMSC%\VC\bin\x86_amd64\lib.exe" bin\x64\ >NUL
%FCOPYF% "%WINMSC%\VC\include\time.inl" include\crt\ >NUL
%FCOPYF% "%WINMSC%\VC\include\wtime.inl" include\crt\ >NUL

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
