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
set "ProgramFiles64=%ProgramFiles%"
set "WINDDK=c:\WinDDK\7600.16385.1"
set "WPSDK6=%ProgramFiles64%\Microsoft Platform SDK for Windows Server 2003 R2"
set "WINSDK=%ProgramFiles64%\Microsoft SDKs\Windows\v7.1"
rem
set MSCVCD=dist\msvc
set XCOPYD=xcopy /I /Y /Q
set FCOPYF=copy /Y
rem
pushd ..
rem Remove previous stuff
rd /S /Q dist 2>NUL
if /i "%~1" == "/clean" goto End
md %MSCVCD%
pushd %MSCVCD%
rem Directories
for %%i in (x64 x86) do md bin\%%i >NUL
for %%i in (x64 x86) do md lib\%%i >NUL
for %%i in (atl crt mfc) do md include\%%i >NUL
rem
if not exist "%WINDDK%\bin" (
    echo.
    echo Cannot find "%WINDDK%" directory.
    echo Set this variable to point to the
    echo Windows Driver Kit version 7.1.0 installation directory
    exit /B 1
)
rem
if not exist "%WINSDK%\bin" (
    echo.
    echo Cannot find "%WINSDK%" directory.
    echo Set this variable to point to the
    echo Windows Software Development Kit installation directory.
    exit /B 1
)
rem
echo Built  : %DATE% - %TIME% >%VSToolsDir%\compile.log
echo Target : %CmscOsv%  >>%VSToolsDir%\compile.log
echo WinDDK : %WINDDK:c:\WinDDK\=% >>%VSToolsDir%\compile.log
echo WinSDK : %WINSDK:c:\Program Files\Microsoft SDKs\Windows\=% >>%VSToolsDir%\compile.log
rem
echo Copying files ...
rem
%XCOPYD% "%WINSDK%\include" include\ >NUL
%XCOPYD% "%WINSDK%\lib" lib\x86\ >NUL
%XCOPYD% "%WINSDK%\lib\x64" lib\x64\ >NUL
REM
%XCOPYD% "%WINDDK%\lib\%CmscOsv%\i386" lib\x86\ >NUL
%XCOPYD% "%WINDDK%\lib\crt\i386" lib\x86\ >NUL
%XCOPYD% "%WINDDK%\lib\mfc\i386" lib\x86\ >NUL
%XCOPYD% "%WINDDK%\lib\atl\i386" lib\x86\ >NUL
REM
%XCOPYD% "%WINDDK%\lib\%CmscOsv%\amd64" lib\x64\ >NUL
%XCOPYD% "%WINDDK%\lib\crt\amd64" lib\x64\ >NUL
%XCOPYD% "%WINDDK%\lib\mfc\amd64" lib\x64\ >NUL
%XCOPYD% "%WINDDK%\lib\atl\amd64" lib\x64\ >NUL
rem
%XCOPYD% /S "%WINDDK%\inc\crt" include\crt\ >NUL
%XCOPYD% /S "%WINDDK%\inc\api\crt\stl60" include\crt\ >NUL
%XCOPYD% /S "%WINDDK%\inc\atl71" include\atl\ >NUL
%XCOPYD% /S "%WINDDK%\inc\mfc42" include\mfc\ >NUL
%FCOPYF% "%WINDDK%\inc\api\delayimp.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\driverspecs.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\sdv_driverspecs.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\sal.h" include\crt\ >NUL
%FCOPYF% "%WINDDK%\inc\api\sal_supp.h" include\crt\ >NUL
%XCOPYD% "%WINDDK%\inc\api\SpecString*.h" include\crt\ >NUL
%FCOPYF% include\crt\ctype.h include\crt\wctype.h >NUL
rem Path crtdefs.h and delayimp.h
patch -fp0 -i %VSToolsDir%\crt\crtdefs.patch
patch -fp0 -i %VSToolsDir%\crt\delayimp.patch
patch -fp0 -i %VSToolsDir%\crt\errno.patch
%XCOPYD% /S "%VSToolsDir%\include" include\ >NUL
rem Copy Binaries
%XCOPYD% "%WINDDK%\bin\x86" bin\ >NUL
%XCOPYD% "%WINDDK%\bin\x86\1033" bin\ >NUL
%XCOPYD% /S "%WINDDK%\bin\x86\x86" bin\x86\ >NUL
%XCOPYD% /S "%WINDDK%\bin\x86\amd64" bin\x64\ >NUL
for %%i in (mt guidgen rebase) do copy /Y "%WINSDK%\bin\%%i.exe" bin\ >NUL
for %%i in (ml nmake) do del bin\%%i.exe >NUL
rem
%XCOPYD% /S "%VSToolsDir%\bin" bin\ >NUL
rem
if not exist "%WPSDK6%\include\atl" (
    echo Cannot find "%WPSDK6%" directory >>%VSToolsDir%\compile.log
    echo ATL 3.0 support will be disabled >>%VSToolsDir%\compile.log
)
%XCOPYD% /S "%WPSDK6%\include\atl" include\atl30\ >NUL
rem
popd
popd
call msvcrt_compat.bat
set "DF=posix2wx.exe"
rem del /F /Q %DF% 2>NUL
curl -qksL -o %DF% https://github.com/mturk/posix2wx/releases/download/%Posix2wxVer%/%DF%
echo.
echo Finished.
:End
