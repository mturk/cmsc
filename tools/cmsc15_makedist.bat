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
rem Creates and signs distribution zip file
rem
rem Prerequisites...
set "PATH=%~dp0;%PATH%"
call ..\versions.bat
rem
set DVER=15.0_%CmscVer%
set CVER=C:\cmsc%CmscVer%
set DNAM=windows-x86_x64
RD /S /Q %CVER% 2>NUL
pushd ..

echo Custom Microsoft Compiler Toolkit Compilation >dist\VERSION.txt
echo. >>dist\VERSION.txt
echo Version: %DVER% >>dist\VERSION.txt
type tools\compile.log >>dist\VERSION.txt
mkdir dist\tools
for %%i in (nasm nsinstall cygwpexec) do  copy /Y tools\%%i.exe  dist\tools\
for %%i in (setenv.bat versions.bat README.md CHANGELOG.txt) do copy /Y %%i  dist\

move /Y dist %CVER%
pushd %CVER%\perl-%PerlVer%
call relocation.pl.bat
popd
rem Create distribution .zip
del /F /Q cmsc-%DVER%-%DNAM%.* 2>NUL
7za a cmsc-%DVER%-%DNAM%.zip %CVER%
set "PATH=%CVER%\perl-%PerlVer%\perl\bin;%PATH"
call shasum.bat -a 512 cmsc-%DVER%-%DNAM%.zip > cmsc-%DVER%-%DNAM%.sha512

popd
echo.
echo Finished.
