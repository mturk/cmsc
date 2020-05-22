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
set "VSRootDir=%cd%"
popd
call %VSRootDir%\versions.bat
set VsPerl=perl-%PerlVer%
set "VSBaseDir=%VSRootDir%\msvc"
if not exist "%VSBaseDir%\bin\nmake.exe" (
    echo.
    echo Cannot find msvc tools.
    echo Make sure the %VSRootDir% points to 
    echo correct cmsc installation
    exit /B 1
)

rem
rem Check arguments
rem
set "PBuildCpu=%~1"
shift
if "%PBuildCpu%" == "" (
  echo "No platform parameter provided. Using %PROCESSOR_ARCHITECTURE%"
  set "PBuildCpu=/%PROCESSOR_ARCHITECTURE%"
)
if /I "%PBuildCpu%" == "/x86"     goto TargetX86
if /I "%PBuildCpu%" == "/i386"    goto TargetX86
if /I "%PBuildCpu%" == "/i686"    goto TargetX86
if /I "%PBuildCpu%" == "/x64"     goto TargetX64
if /I "%PBuildCpu%" == "/amd64"   goto TargetX64
goto Usage
rem
:TargetX86
set BUILD_CPU=x86
goto SetupDirs
:TargetX64
set BUILD_CPU=x64
goto SetupDirs
rem
rem Additional targets
rem
:SetupDirs
echo.
echo Seting build environment for %BUILD_CPU%
set "VSPath=%VSBaseDir%\bin\%BUILD_CPU%;%VSBaseDir%\bin;%VSRootDir%\tools"
if not exist "%VSRootDir%\%VsPerl%\perl\bin\perl.exe" (
    echo.
    echo Cannot find perl.exe.
    echo Make sure the %VSRootDir% points to 
    echo correct cmsc installation
    exit /B 1
)
rem Set perl path
set "VSPath=%VSPath%;%VSRootDir%\%VsPerl%\perl\bin;%VSRootDir%\%VsPerl%\c\bin"
set "PATH=%VSPath%;%PATH%"
set "LIB=%VSBaseDir%\lib\%BUILD_CPU%"
set "INCLUDE=%VsBaseDir%\include\crt;%VsBaseDir%\include;%VsBaseDir%\include\mfc;%VsBaseDir%\include\atl"
set "EXTRA_LIBS=msvcrt_compat.lib msvcrt_compat.obj"
set TERM=dumb
goto SetEnvExit

:Usage
echo.
echo Usage: setenv.bat ^< /x86 ^| /x64 ^>
echo.
echo        /x86 ^| /i386   - Create 32-bit X86 applications
echo        /x64 ^| /amd64  - Create 64-bit AMD64/EMT64 applications
echo.
exit /B 1
:SetEnvExit
set VSRootDir=
set VSBaseDir=
set VSPath=
set VSPerl=
set PBuildCpu=
exit /B 0
