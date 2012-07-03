@echo off
@setlocal
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
rem Downloads Mingw32 ditribution
rem
rem Prerequisites...
set "PATH=%~dp0;%PATH%"
rem
set PVER=0.5-mingw32-beta-20120426-1-bin
if exist mingw-get-%PVER%.zip goto HasMingwGetDist
wget http://prdownloads.sourceforge.net/mingw/mingw-get-%PVER%.zip
rem
if exist mingw-get-%PVER%.zip goto HasMingwGetDist
echo.
echo Failed to download mingw-get-%PVER%.zip
exit /B 1
:HasMingwGetDist
echo MingwGet: %PVER%  >>compile.log
pushd ..
rm -rf mingw32 2>NUL
mkdir mingw32
pushd mingw32
rem Uncopress
7za x ..\tools\mingw-get-%PVER%.zip
pushd bin
mingw-get.exe update
mingw-get.exe install msys-system-builder
mingw-get.exe install mingw-developer-toolkit
mingw-get.exe install mingw32-base
mingw-get.exe install mingw32-utils
mingw-get.exe install mingw32-make
mingw-get.exe install mingw32-mgwport
mingw-get.exe install mingw32-lua
popd
popd
popd
