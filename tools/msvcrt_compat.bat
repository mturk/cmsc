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
rem Creates missing exports from DDK msvcrt.lib
rem
pushd %~dp0..
set "VSBaseDir=%cd%\dist\msvc"
popd
rem
set "THUNK=msvcrt_compat"
set "BinPath=%VSBaseDir%\bin;%PATH%"
set "INCLUDE=%VsBaseDir%\include\crt"
set "CLCOMPC=cl /nologo -c -EHs -EHc -GR- -GF -GS -Ox -Os -MD -D_WIN32_WINNT=%WINVER% -DWINVER=%WINVER% -DWIN32_LEAN_AND_MEAN=1 -DNDEBUG"

echo "Copmiling %CLCOMPC%"
rem
set "PATH=%VSBaseDir%\bin\x86;%BinPath%"
set "LIBD=%VsBaseDir%\lib\x86"
lib /NOLOGO /NODEFAULTLIB /DEF:%THUNK%.def /MACHINE:X86 /NAME:msvcrt.dll /OUT:%LIBD%\%THUNK%.lib
%CLCOMPC% crt\fp10.c /Fo%LIBD%\fp10.obj
%CLCOMPC% crt\binmode.c /Fo%LIBD%\binmode.obj
%CLCOMPC% crt\commode.c /Fo%LIBD%\commode.obj
%CLCOMPC% crt\newmode.c /Fo%LIBD%\newmode.obj
%CLCOMPC% crt\noarg.c /Fo%LIBD%\noarg.obj
%CLCOMPC% crt\noenv.c /Fo%LIBD%\noenv.obj
%CLCOMPC% crt\setargv.c /Fo%LIBD%\setargv.obj
%CLCOMPC% crt\wsetargv.c /Fo%LIBD%\wsetargv.obj
rem
del /Q %LIBD%\%THUNK%.exp
copy /Y %LIBD%\msvcrt_win2003.obj %LIBD%\%THUNK%.obj
rem
rem Setup x64 target
rem
set "PATH=%VSBaseDir%\bin\x64;%BinPath%"
set "LIBD=%VsBaseDir%\lib\x64"
lib /NOLOGO /NODEFAULTLIB /DEF:%THUNK%.def /MACHINE:X64 /NAME:msvcrt.dll /OUT:%LIBD%\%THUNK%.lib
%CLCOMPC% crt\binmode.c /Fo%LIBD%\binmode.obj
%CLCOMPC% crt\commode.c /Fo%LIBD%\commode.obj
%CLCOMPC% crt\newmode.c /Fo%LIBD%\newmode.obj
%CLCOMPC% crt\noarg.c /Fo%LIBD%\noarg.obj
%CLCOMPC% crt\noenv.c /Fo%LIBD%\noenv.obj
%CLCOMPC% crt\setargv.c /Fo%LIBD%\setargv.obj
%CLCOMPC% crt\wsetargv.c /Fo%LIBD%\wsetargv.obj
rem
del /Q %LIBD%\%THUNK%.exp
copy /Y %LIBD%\msvcrt_win2003.obj %LIBD%\%THUNK%.obj
rem
