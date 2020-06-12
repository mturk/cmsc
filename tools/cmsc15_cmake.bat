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
rem Dowloads Cmake
rem
rem Prerequisites...
set "PATH=%~dp0;%PATH%"
pushd %~dp0
set "VSToolsDir=%cd%"
popd
rem
call ..\versions.bat
rem
set "CmakeName=cmake-%CmakeVer%-win%CmscSys%-x%CmscSys%"
set "CmakeArch=%CmakeName%.zip"
if not exist "%CmakeArch%" (
	echo.
	echo Downloading %CmakeArch% ...
	curl -qkL --retry 5 -o %CmakeArch% https://github.com/Kitware/CMake/releases/download/v%CmakeVer%/%CmakeArch%
)
rem
if not exist "%CmakeArch%" (
	echo.
	echo Failed to download %CmakeArch%
	exit /B 1
)
echo Cmake  : %CmakeName% >>compile.log
pushd ..
md dist 2>NUL
pushd dist
rem Remove previous stuff
rd /S /Q cmake 2>NUL
rem Uncopress
7za x -bd %VSToolsDir%\%CmakeArch%
rem
move /Y %CmakeName% cmake
popd
popd
echo.
echo Finished.
:End
