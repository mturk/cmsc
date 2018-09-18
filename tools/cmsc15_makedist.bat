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
rem Creates and signs distribution zip file
rem
rem Prerequisites...
set "PATH=%~dp0;%PATH%"
rem
set DVER=15.0_27
set DNAM=windows-x86_x64_ia64
pushd ..
echo Custom Microsoft Compiler Toolkit Compilation >VERSION.txt
echo. >>VERSION.txt
echo Version: %DVER% >>VERSION.txt
type tools\compile.log >>VERSION.txt
rem Remove previous stuff
rm -rf cmsc-*-%DNAM%.* 2>NUL
rem Create distribution .zip
7za a cmsc-%DVER%-%DNAM%.zip msvc perl tools\amd64 tools\i386 tools\ia64 *.bat *.txt -xr!.svn
md5sum -b cmsc-%DVER%-%DNAM%.zip >cmsc-%DVER%-%DNAM%.zip.md5
sha1sum -b cmsc-%DVER%-%DNAM%.zip >cmsc-%DVER%-%DNAM%.zip.sha1
rm VERSION.txt
popd
echo.
echo Finished.
:End
