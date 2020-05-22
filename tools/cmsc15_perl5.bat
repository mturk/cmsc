@echo off
@setlocal
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
rem
call ..\versions.bat
set PZIP=strawberry-perl-%PerlVer%-32bit.zip
if exist %PZIP% goto HasPerlDist
wget -q --no-config http://strawberryperl.com/download/%PerlVer%/%PZIP%
rem
if exist %PZIP% goto HasPerlDist
echo.
echo Failed to download %PZIP%
exit /B 1
:HasPerlDist
echo Perl   : %PerlVer%  >>compile.log
pushd ..\dist
rem Remove previous stuff
RD /S /Q perl-%PerlVer% 2>NUL
MD perl-%PerlVer%
rem Uncopress
pushd perl-%PerlVer%
7za x ..\..\tools\%PZIP%
@copy /Y /B perl\bin\perl.exe perl\bin\perlw.exe
@del /F /Q c\bin\*.exe

popd
popd
echo.
echo Finished.
:End
