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
rem Dowloads Strawberry Perl
rem
rem Prerequisites...
set "PATH=%~dp0;%PATH%"
rem
set PVER=5.30.2.1
set PZIP=strawberry-perl-%PVER%-32bit-portable.zip 
if exist %PZIP% goto HasPerlDist
wget http://strawberryperl.com/download/%PVER%/%PZIP%
rem
if exist %PZIP% goto HasPerlDist
echo.
echo Failed to download %PZIP%
exit /B 1
:HasPerlDist
echo Perl   : %PVER%  >>compile.log
pushd ..
rem Remove previous stuff
rm -rf perl c 2>NUL
rem Uncopress
7za x tools\%PZIP% perl c
copy /Y perl\bin\perl.exe perl\bin\perlw.exe 2>NUL
xcopy c\bin\*.dll perl\bin /I /Y /Q
rm -rf c 2>NUL

popd
echo.
echo Finished.
:End
