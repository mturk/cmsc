@echo off
@setlocal
rem
rem WARNING: This script has some problems with latest setup.exe
rem          It seems that cmdline interface to setup.exe is broken.
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
rem Dowloads Cygwin ditribution
rem
rem Prerequisites...
set "PATH=%~dp0;%PATH%"
rem
set CYGWINROOT=C:\cygwin
mkdir %CYGWINROOT% 2>NULL
pushd %CYGWINROOT%
if not "%~1" == "/f" goto StdCygwinSetup
shift
goto GetCygwinSetup
:StdCygwinSetup
if exist setup.exe goto HasCygwinSetup
:GetCygwinSetup
wget -O setup.exe http://cygwin.com/setup.exe
if exist setup.exe goto HasCygwinSetup
echo.
echo Failed to download Cygwin setup
exit /B 1
:HasCygwinSetup
set "P0=asciidoc,chere,curl,cvs,diffutils,dos2unix,doxygen,flex,git"
set "P1=git-svn,gnupg,patch,python,subversion,time,wget,w3m"
set "P2=bzip,bsdiff,cpio,rpm,rpm-build,unzip,xz,p7zip,zip"
set "P3=autoconf,automake,bison,byacc,cmake,make,makedepend,mingw-gcc"
set "P4=mingw-gcc-g++,mingw64-i686-gcc,mingw64-i686-gcc-g++,xdelta"

set DLMIRROR=http://ftp.heanet.ie/pub/cygwin
echo Running cygwin setup ...
start /B /MIN /WAIT setup.exe -qnOAX -D -P "%P0%,%P1%,%P2%,%P3%,%P4%" -l "%CYGWINROOT%\.setup" -s "%DLMIRROR%" -R "%CYGWINROOT%"
if not "%~1" == "/i" goto Installed
echo Installing in %CD%
start /B /MIN /WAIT setup.exe -qnOAX -L -P "%P0%,%P1%,%P2%,%P3%,%P4%" -l "%CYGWINROOT%\.setup" -s "%DLMIRROR%" -R "%CYGWINROOT%"
:Installed
echo.
echo Finished.
rm -rf setup.log
rm -rf setup.log.full
popd
:End
