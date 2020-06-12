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
rem Dowloads Strawberry Perl
rem
rem Prerequisites...
set "PATH=%~dp0;%PATH%"
pushd %~dp0
set "VSToolsDir=%cd%"
popd
rem
call cmsc15_versions.bat
set "PerlName=strawberry-perl-%PerlVer%-%CmscSys%bit-portable"
set "PerlArch=%PerlName%.zip"
if not exist "%PerlArch%" (
	echo.
	echo Downloading %PerlArch% ... this can take a while.
	curl -qkL --retry 5 -o %PerlArch% http://strawberryperl.com/download/%PerlVer%/%PerlArch%
)
rem
if not exist "%PerlArch%" (
	echo.
	echo Failed to download %PerlArch%
	exit /B 1
)
echo Perl   : %PerlName% >>compile.log
pushd ..\dist
rem Remove previous stuff
rd /S /Q perl 2>NUL
md perl
rem Uncopress
pushd perl
7za x -bd %VSToolsDir%\%PerlArch%
copy /Y /B perl\bin\perl.exe perl\bin\perlw.exe >NUL
rem
popd
popd
echo.
echo Finished.
:End
