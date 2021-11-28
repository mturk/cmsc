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
rem Downloads and compiles Tcl8.6
rem
set "PATH=%~dp0;%PATH%"
pushd %~dp0
set "VSToolsDir=%cd%"
popd
rem
call cmsc15_versions.bat
set "TclName=tcl%TclVer%"
set "TclTar=%TclName%-src.tar"
set "TclArch=%TclTar%.gz"
if not exist "%TclArch%" (
    echo.
    echo Downloading %TclArch% ... this can take a while.
    curl %CurlOpts% -o %TclArch% https://downloads.sourceforge.net/project/tcl/Tcl/%TclVer%/%TclArch%
)
rem
7za t %TclArch% >NUL 2>&1 && ( goto Exp )
echo.
echo Failed to download %TclArch%
del /F /Q %TclArch% 2>NUL
exit /B 1
rem
:Exp
rem
pushd ..\dist
set "MSVCDIR=%cd%\msvc"
rem Remove previous stuff
rd /S /Q tclsh >NUL 2>&1
md tclsh
rem Decompress
pushd tclsh
set "TclshRoot=%cd%"
7za x -y -bd %VSToolsDir%\%TclArch%
7za x -y -bd %TclTar%
del /F /Q %TclTar% 2>NUL
rem
md bin
md lib
pushd %TclName%\win
rem
rem
rem Set local environment
rem
set "WINVER=0x0601"
set "MACHINE=x%CmscSys%"
set "PATH=%MSVCDIR%\bin\%MACHINE%;%MSVCDIR%\bin;%PATH%"
set "LIB=%MSVCDIR%\lib\%MACHINE%"
set "INCLUDE=%MSVCDIR%\include\crt;%MSVCDIR%\include;%MSVCDIR%\include\mfc;%MSVCDIR%\include\atl"
rem
rem Compile Tcl
echo.
echo Compiling %TclName% ... this can take a while.
nmake -f makefile.vc release INSTALLDIR=%SystemDrive%\cmsc-%CmscVer%\tclsh OPTS=static >build.log 2>&1
if not ERRORLEVEL 0 goto Failed
rem Install to localdir
rem
nmake -f makefile.vc install INSTALLDIR=%cd%\distr-%MACHINE% OPTS=static >install.log 2>&1
if not ERRORLEVEL 0 goto Failed
rem
copy /Y distr-%MACHINE%\bin\tclsh86ts.exe "%TclshRoot%\bin\tclsh.exe" >NUL
xcopy /I /Y /Q /S distr-%MACHINE%\lib\tcl8.6 "%TclshRoot%\lib\tcl8.6\" >NUL
xcopy /I /Y /Q /S distr-%MACHINE%\lib\tcl8 "%TclshRoot%\lib\tcl8\" >NUL
rem
popd
rem
rd /S /Q %TclName% 2>NUL
rem
popd
popd
echo Tcl    : %TclName% >>compile.log
echo.
echo Finished.
:End
exit /B 0

:Failed
echo.
echo Compilation of %TclName% failed!
echo Check build.log and install.log files for errors
exit /B 1
