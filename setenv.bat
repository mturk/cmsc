@echo off
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
rem Setup environment for Microsoft Compiler Toolkit
rem
pushd %~dp0
set "CmscRootDir=%cd%"
popd
rem
if not exist "%CmscRootDir%\msvc\bin\build.exe" (
    echo.
    echo Cannot find build tools.
    echo Make sure the %CmscRootDir% points to
    echo correct cmsc installation
    exit /B 1
)
set "WINVER=0x0601"
set "CMSC_VERSION=15043"
rem
rem Default target is 64-bit Windows
rem
if /I ".%~1" == ".amd64" ( set "BUILD_CPU=x64" )
if /I ".%~1" == ".x64"   ( set "BUILD_CPU=x64" )
if /I ".%~1" == ".x86"   ( set "BUILD_CPU=x86" )
if /I ".%~1" == ".i386"  ( set "BUILD_CPU=x86" )
rem
if ".%BUILD_CPU%" == "." (
  echo Using default architecture: x64
  set "BUILD_CPU=x64"
)
rem
echo Seting build environment for win-%BUILD_CPU%/%WINVER%
set "CMSC_PATH=%CmscRootDir%\msvc\bin\%BUILD_CPU%;%CmscRootDir%\msvc\bin;%CmscRootDir%\tools;%CmscRootDir%\nasm;%CmscRootDir%\perl\perl\bin"
set "PATH=%CMSC_PATH%;%PATH%"
set "LIB=%CmscRootDir%\msvc\lib\%BUILD_CPU%"
set "INCLUDE=%CmscRootDir%\msvc\include\crt;%CmscRootDir%\msvc\include;%CmscRootDir%\msvc\include\mfc;%CmscRootDir%\msvc\include\atl"
set "EXTRA_LIBS=msvcrt_compat.lib msvcrt_compat.obj"
