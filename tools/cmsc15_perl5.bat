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
call ..\versions.bat
set PerlArch=strawberry-perl-%PerlVer%-32bit.zip
if exist %PerlArch% goto HasPerlDist
wget -q --no-config http://strawberryperl.com/download/%PerlVer%/%PerlArch%
rem
if exist %PerlArch% goto HasPerlDist
echo.
echo Failed to download %PerlArch%
exit /B 1
:HasPerlDist
echo Perl   : %PerlVer%  >>compile.log
pushd ..\dist
rem Remove previous stuff
rd /S /Q perl-%PerlVer% 2>NUL
md perl-%PerlVer%
rem Uncopress
pushd perl-%PerlVer%
7za x %VSToolsDir%\%PerlArch%
copy /Y /B perl\bin\perl.exe perl\bin\perlw.exe
xcopy /Y /Q /I c\bin\*.dll perl\bin
rem
popd
popd
echo.
echo Finished.
:End
