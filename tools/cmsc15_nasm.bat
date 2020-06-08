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
rem Dowloads Netwide assembler
rem
rem Prerequisites...
set "PATH=%~dp0;%PATH%"
pushd %~dp0
set "VSToolsDir=%cd%"
popd
rem
call ..\versions.bat
set "NasmArch=nasm-%NasmVer%-win%CmscSys%.zip"
if not exist "%NasmArch%" (
	wget -q --no-config https://www.nasm.us/pub/nasm/releasebuilds/%NasmVer%/win%CmscSys%/%NasmArch%
)
rem
if not exist "%NasmArch%" (
	echo.
	echo Failed to download %NasmArch%
	exit /B 1

)
echo Nasm   : %NasmVer%-win%CmscSys%  >>compile.log
pushd ..\dist
rem Remove previous stuff
rd /S /Q nasm 2>NUL
rem Uncopress
7za x -bd %VSToolsDir%\%NasmArch%
rem
move /Y nasm-%NasmVer% nasm
popd
echo.
echo Finished.
:End
