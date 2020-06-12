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
rem Creates and signs distribution zip file
rem
rem Prerequisites...
set "PATH=%~dp0;%PATH%"
pushd %~dp0
set "VSToolsDir=%cd%"
popd
call cmsc15_versions.bat
rem
set "CmscDist=%SystemDrive%\cmsc-%CmscVer%"
set "CmscArch=%CmscOsv%-x86_x64"
pushd ..
rem
echo Custom Microsoft Compiler Toolkit Compilation >dist\VERSIONS.txt
echo. >>dist\VERSIONS.txt
echo Version: %CmscVer% >>dist\VERSIONS.txt
type %VSToolsDir%\compile.log >>dist\VERSIONS.txt
md dist\tools 2>NUL
for %%i in (cmsc15_versions.bat README.txt posix2wx.exe 7za.exe) do copy /Y %VSToolsDir%\%%i dist\tools\
for %%i in (setenv.bat README.md CHANGELOG.txt) do copy /Y %%i dist\
rem
echo Creating Distibution ....
rem
rd /S /Q %CmscDist% 2>NUL
move /Y dist %CmscDist%
rem
rem Uncomment if non portable perl is used
rem
rem pushd %CmscDist%\perl
rem call relocation.pl.bat --quiet
rem del /F /Q update_env.pl.bat 2>NUL
rem popd
rem
rem Create distribution .zip
del /F /Q cmsc-* 2>NUL
7za a -bd cmsc-%CmscVer%-%CmscArch%.zip %CmscDist%
set "PATH=%CmscDist%\perl\perl\bin;%PATH%"
call shasum.bat -a 512 cmsc-%CmscVer%-%CmscArch%.zip > cmsc-%CmscVer%-%CmscArch%.sha512
rem
popd
echo.
echo Finished.
