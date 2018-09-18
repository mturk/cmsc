@echo off
@setlocal
rem
rem Copyright (c) 2011 The MyoMake Project <http://www.myomake.org>
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
rem
set PVER=5.28.0.1
if exist relocation.pl.bat goto HasPerlReloc
if exist perl\bin\perl.exe echo Perl already relocated!
goto CRTRedist
:HasPerlReloc
if not exist relocation.pl.bat goto CRTRedist
call relocation.pl.bat
del /Q relocation.pl.bat 2>NUL
del /Q strawberry-merge-module.reloc.txt 2>NUL
:CRTRedist
rem Install redistributables
if not exist msvc\bin\redist\vc10\vcredist_x86.exe goto Done
pushd msvc\bin\redist\vc10
echo Installing VC10 CRT redistributables
if exist "%SystemRoot%\SysWOW64" vcredist_x64.exe /passive
vcredist_x86.exe /passive /promptrestart
popd
:Done
echo.
echo Finished.
:End
