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
call %CmscRootDir%\versions.bat
set "CmscVcDir=%CmscRootDir%\msvc"
rem
if not exist "%CmscVcDir%\bin\build.exe" (
    echo.
    echo Cannot find build tools.
    echo Make sure the %CmscRootDir% points to
    echo correct cmsc installation
    exit /B 1
)
rem
rem Check arguments
rem
set "TargetParam=%~1"
shift
if "%TargetParam%" == "" (
  echo "No platform parameter provided. Using %PROCESSOR_ARCHITECTURE%"
  set "TargetParam=/%PROCESSOR_ARCHITECTURE%"
)
if /I "%TargetParam%" == "/x86"  goto TargetX86
if /I "%TargetParam%" == "/i386" goto TargetX86
rem
rem Default target is 64-bit Windows
rem
set BUILD_CPU=x64
goto SetupEnvars
:TargetX86
set BUILD_CPU=x86
rem
rem Additional targets
rem
:SetupEnvars
echo.
echo Seting build environment for %BUILD_CPU%
set "CMSC_PATH=%CmscVcDir%\bin\%BUILD_CPU%;%CmscVcDir%\bin;%CmscRootDir%\tools;%CmscRootDir%\nasm;%CmscRootDir%\perl\perl\bin;%CmscRootDir%\cmake\bin"
set "PATH=%CMSC_PATH%;%PATH%"
set "LIB=%CmscVcDir%\lib\%BUILD_CPU%"
set "INCLUDE=%CmscVcDir%\include\crt;%CmscVcDir%\include;%CmscVcDir%\include\mfc;%CmscVcDir%\include\atl"
set "EXTRA_LIBS=msvcrt_compat.lib msvcrt_compat.obj"
set "TERM=dumb"
rem
set CmscRootDir=
set CmscVcDir=
set TargetParam=
set NasmVer=
set PerlVer=
set CmscVer=
set CmscOsv=
set CmscSys=
set CmakeVer=
set Posix2wxVer=
