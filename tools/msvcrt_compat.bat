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
rem Creates missing exports from DDK msvcrt.lib
rem
@echo off
setlocal
pushd %~dp0..
set VSBaseDir=%cd%\dist\msvc
popd
rem
set "THUNK=msvcrt_compat"
set "BinPath=%VSBaseDir%\bin;%PATH%"
set "LIB=%VsBaseDir%\lib"
set "INCLUDE=%VsBaseDir%\include\crt"
set "CFLAGS=/nologo /c /MD"
rem Delete old versions
del /Q %LIB%\x86\%THUNK%.* 2>NUL
del /Q %LIB%\x64\%THUNK%.* 2>NUL
rem
set "PATH=%VSBaseDir%\bin\x86;%BinPath%"
lib /NOLOGO /NODEFAULTLIB /DEF:%THUNK%.def /MACHINE:X86 /NAME:msvcrt.dll /OUT:%LIB%\x86\%THUNK%.lib
cl %CFLAGS% crt\fp10.c /Fo%LIB%\x86\fp10.obj
cl %CFLAGS% crt\binmode.c /Fo%LIB%\x86\binmode.obj
cl %CFLAGS% crt\commode.c /Fo%LIB%\x86\commode.obj
cl %CFLAGS% crt\newmode.c /Fo%LIB%\x86\newmode.obj
cl %CFLAGS% crt\noarg.c /Fo%LIB%\x86\noarg.obj
cl %CFLAGS% crt\noenv.c /Fo%LIB%\x86\noenv.obj
cl %CFLAGS% crt\setargv.c /Fo%LIB%\x86\setargv.obj
cl %CFLAGS% crt\wsetargv.c /Fo%LIB%\x86\wsetargv.obj
rem
set "PATH=%VSBaseDir%\bin\x64;%BinPath%"
lib /NOLOGO /NODEFAULTLIB /DEF:%THUNK%.def /MACHINE:X64 /NAME:msvcrt.dll /OUT:%LIB%\x64\%THUNK%.lib
cl %CFLAGS% crt\binmode.c /Fo%LIB%\x64\binmode.obj
cl %CFLAGS% crt\commode.c /Fo%LIB%\x64\commode.obj
cl %CFLAGS% crt\newmode.c /Fo%LIB%\x64\newmode.obj
cl %CFLAGS% crt\noarg.c /Fo%LIB%\x64\noarg.obj
cl %CFLAGS% crt\noenv.c /Fo%LIB%\x64\noenv.obj
cl %CFLAGS% crt\setargv.c /Fo%LIB%\x64\setargv.obj
cl %CFLAGS% crt\wsetargv.c /Fo%LIB%\x64\wsetargv.obj
rem
rem Delete export files
del /Q %LIB%\x64\%THUNK%.exp
del /Q %LIB%\x86\%THUNK%.exp
copy /Y %LIB%\x86\msvcrt_win2003.obj %LIB%\x86\%THUNK%.obj
copy /Y %LIB%\x64\msvcrt_win2003.obj %LIB%\x64\%THUNK%.obj
rem
exit /B 0
