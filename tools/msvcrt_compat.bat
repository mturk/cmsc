@echo off
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
rem Creates missing exports from DDK msvcrt.lib
rem
@echo off
setlocal
pushd %~dp0..
set VSBaseDir=%cd%\msvc
popd
if not exist "%VSBaseDir%\bin\i386\lib.exe" goto Failed
rem
set THUNK=msvcrt_compat
set BinPath=%VSBaseDir%\bin;%PATH%
set LIB=%VsBaseDir%\lib
set INCLUDE=%VsBaseDir%\include\crt
set CFLAGS=/nologo /c /MD 
rem Delete old versions
del /Q %LIB%\i386\%THUNK%.* 2>NUL
del /Q %LIB%\amd64\%THUNK%.* 2>NUL
del /Q %LIB%\ia64\%THUNK%.* 2>NUL
rem
set PATH=%VSBaseDir%\bin\i386;%BinPath%
lib /NOLOGO /NODEFAULTLIB /DEF:%THUNK%.def /MACHINE:X86 /NAME:msvcrt.dll /OUT:%LIB%\i386\%THUNK%.lib
cl %CFLAGS% crt\fp10.c /Fo%LIB%\i386\fp10.obj
cl %CFLAGS% crt\binmode.c /Fo%LIB%\i386\binmode.obj
cl %CFLAGS% crt\commode.c /Fo%LIB%\i386\commode.obj
cl %CFLAGS% crt\newmode.c /Fo%LIB%\i386\newmode.obj
cl %CFLAGS% crt\noarg.c /Fo%LIB%\i386\noarg.obj
cl %CFLAGS% crt\noenv.c /Fo%LIB%\i386\noenv.obj
cl %CFLAGS% crt\setargv.c /Fo%LIB%\i386\setargv.obj
cl %CFLAGS% crt\wsetargv.c /Fo%LIB%\i386\wsetargv.obj
rem
set PATH=%VSBaseDir%\bin\amd64;%BinPath%
lib /NOLOGO /NODEFAULTLIB /DEF:%THUNK%.def /MACHINE:X64 /NAME:msvcrt.dll /OUT:%LIB%\amd64\%THUNK%.lib
cl %CFLAGS% crt\binmode.c /Fo%LIB%\amd64\binmode.obj
cl %CFLAGS% crt\commode.c /Fo%LIB%\amd64\commode.obj
cl %CFLAGS% crt\newmode.c /Fo%LIB%\amd64\newmode.obj
cl %CFLAGS% crt\noarg.c /Fo%LIB%\amd64\noarg.obj
cl %CFLAGS% crt\noenv.c /Fo%LIB%\amd64\noenv.obj
cl %CFLAGS% crt\setargv.c /Fo%LIB%\amd64\setargv.obj
cl %CFLAGS% crt\wsetargv.c /Fo%LIB%\amd64\wsetargv.obj
rem
set PATH=%VSBaseDir%\bin\ia64;%BinPath%
lib /NOLOGO /NODEFAULTLIB /DEF:%THUNK%.def /MACHINE:IA64 /NAME:msvcrt.dll /OUT:%LIB%\ia64\%THUNK%.lib
cl %CFLAGS% crt\binmode.c /Fo%LIB%\ia64\binmode.obj
cl %CFLAGS% crt\commode.c /Fo%LIB%\ia64\commode.obj
cl %CFLAGS% crt\newmode.c /Fo%LIB%\ia64\newmode.obj
cl %CFLAGS% crt\noarg.c /Fo%LIB%\ia64\noarg.obj
cl %CFLAGS% crt\noenv.c /Fo%LIB%\ia64\noenv.obj
cl %CFLAGS% crt\setargv.c /Fo%LIB%\ia64\setargv.obj
cl %CFLAGS% crt\wsetargv.c /Fo%LIB%\ia64\wsetargv.obj
rem
rem Delete export files
del /Q %LIB%\amd64\%THUNK%.exp
del /Q %LIB%\i386\%THUNK%.exp
del /Q %LIB%\ia64\%THUNK%.exp
if exist %LIB%\i386\msvcrt_win2003.obj copy /Y %LIB%\i386\msvcrt_win2003.obj %LIB%\i386\%THUNK%.obj
if exist %LIB%\i386\msvcrt_winxp.obj copy /Y %LIB%\i386\msvcrt_winxp.obj %LIB%\i386\%THUNK%.obj
copy /Y %LIB%\amd64\msvcrt_win2003.obj %LIB%\amd64\%THUNK%.obj
copy /Y %LIB%\ia64\msvcrt_win2003.obj %LIB%\ia64\%THUNK%.obj

rem
goto ProgramExit
:Failed
echo.
echo Creating compat library failed!
echo.
echo Cannot find Microsoft Compiler toolkit inside "%VSBaseDir%"!
:ProgramExit
exit /B 0
