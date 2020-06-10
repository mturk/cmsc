@echo off
setlocal
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
pushd %~dp0
set "VSToolsDir=%cd%"
popd
call ..\versions.bat
set "ProgramFiles32=%ProgramFiles(x86)%"
set "ProgramFiles64=%ProgramFiles%"
if not exist "%ProgramFiles32%\Windows NT" set "ProgramFiles32=%ProgramFiles%"
set "WINDDK=c:\WinDDK\7600.16385.1"
set "WPSDK6=%ProgramFiles64%\Microsoft Platform SDK for Windows Server 2003 R2"
set "WINSDK=%ProgramFiles64%\Microsoft SDKs\Windows\v7.1"
set "WINMSC=%ProgramFiles32%\Microsoft Visual Studio 10.0"
rem
set MSCVCD=dist\msvc
set XCOPYD=xcopy /I /Y /Q
set FCOPYF=copy /Y
rem
pushd ..
rem Remove previous stuff
rd /S /Q dist 2>NUL
if /i "%~1" == "/clean" goto End
mkdir %MSCVCD%
pushd %MSCVCD%
rem Binaries
mkdir bin\x64
mkdir bin\x86
rem
rem Library
mkdir lib\x64
mkdir lib\x86
rem
rem Includes
mkdir include\atl
mkdir include\crt
mkdir include\mfc

if not exist "%WINDDK%\bin" (
    echo.
    echo Cannot find "%WINDDK%" directory.
    echo Set this variable to point to the
    echo Windows Driver Kit version 7.1.0 installation directory
    exit /B 1
)

if not exist "%WINSDK%\bin" (
    echo.
    echo Cannot find "%WINSDK%" directory.
    echo Set this variable to point to the
    echo Windows Software Development Kit installation directory.
    exit /B 1
)

if not exist "%WINMSC%\VC\bin" (
    echo.
    echo Cannot find "%WINMSC%" directory.
    echo Set this variable to point to the
    echo Microsoft Visual Studio installation directory
    exit /B 1
)

echo Built  : %DATE% - %TIME% >%VSToolsDir%\compile.log
echo Target : %CmscOsv%  >>%VSToolsDir%\compile.log
echo WinDDK : %WINDDK:c:\WinDDK\=% >>%VSToolsDir%\compile.log
echo WinSDK : %WINSDK:c:\Program Files\Microsoft SDKs\Windows\=% >>%VSToolsDir%\compile.log
echo MSC    : %WINMSC:c:\Program Files\=% >>%VSToolsDir%\compile.log
echo Copying files ...
rem
%XCOPYD% "%WINSDK%\include" include\ >NUL
%XCOPYD% "%WINSDK%\lib" lib\x86\ >NUL
%XCOPYD% "%WINSDK%\lib\x64" lib\x64\ >NUL

%XCOPYD% "%WINDDK%\lib\%CmscOsv%\i386" lib\x86\ >NUL
%XCOPYD% "%WINDDK%\lib\crt\i386" lib\x86\ >NUL
%XCOPYD% "%WINDDK%\lib\mfc\i386" lib\x86\ >NUL
%XCOPYD% "%WINDDK%\lib\atl\i386" lib\x86\ >NUL

%XCOPYD% "%WINDDK%\lib\%CmscOsv%\amd64" lib\x64\ >NUL
%XCOPYD% "%WINDDK%\lib\crt\amd64" lib\x64\ >NUL
%XCOPYD% "%WINDDK%\lib\mfc\amd64" lib\x64\ >NUL
%XCOPYD% "%WINDDK%\lib\atl\amd64" lib\x64\ >NUL

rem DDK Specific Files
%XCOPYD% /S "%WINDDK%\inc\crt" include\crt\ >NUL
%XCOPYD% /S "%WINDDK%\inc\api\crt\stl60" include\crt\ >NUL
%XCOPYD% /S "%WINDDK%\inc\atl71" include\atl\ >NUL
%XCOPYD% /S "%WINDDK%\inc\mfc42" include\mfc\ >NUL
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
patch -fp0 -i %VSToolsDir%\crt\crtdefs.patch
patch -fp0 -i %VSToolsDir%\crt\delayimp.patch
patch -fp0 -i %VSToolsDir%\crt\errno.patch
echo "/* EMPTY */" > include\intrin.h
%XCOPYD% %VSToolsDir%\crt\sys\stat.* include\crt\sys\ >NUL
%XCOPYD% /S %VSToolsDir%\mfc include\mfc\ >NUL

rem Copy Binaries
%XCOPYD% "%WINDDK%\bin\x86" bin\ >NUL
%XCOPYD% "%WINDDK%\bin\x86\1033" bin\ >NUL
%XCOPYD% /S "%WINDDK%\bin\x86\x86" bin\x86\ >NUL
%XCOPYD% /S "%WINDDK%\bin\x86\amd64" bin\x64\ >NUL
%FCOPYF% "%WINDDK%\bin\x86\amd64\ml64.exe" bin\x64\ >NUL
%FCOPYF% "%WINSDK%\bin\mt.exe" bin\ >NUL
%FCOPYF% "%WINSDK%\bin\guidgen.exe" bin\ >NUL
%FCOPYF% "%WINSDK%\bin\rebase.exe" bin\ >NUL
%FCOPYF% bin\ml.exe bin\x86\ml.exe >NUL

%FCOPYF% "%WINMSC%\VC\bin\lib.exe" bin\x86\ >NUL
%FCOPYF% "%WINMSC%\VC\bin\x86_amd64\lib.exe" bin\x64\ >NUL
%FCOPYF% "%WINMSC%\VC\include\time.inl" include\crt\ >NUL
%FCOPYF% "%WINMSC%\VC\include\wtime.inl" include\crt\ >NUL
rem
if not exist "%WPSDK6%\include\atl" (
    echo.
    echo Cannot find "%WPSDK6%" directory.
    echo ATL 3.0 support will be disabled
)
rem
%XCOPYD% /S "%WPSDK6%\include\atl" include\atl30\ >NUL
rem
rem
popd
popd
call msvcrt_compat.bat
del /F /Q posix2wx.exe 2>NUL
wget -q --no-config https://github.com/mturk/posix2wx/releases/download/%Posix2wxVer%/posix2wx.exe
echo.
echo Finished.
:End
