@echo off
pushd %0\..

if "%2"=="delvs" (
  call :remove_folder .vs
  for /d /r "." %%i in (bin, obj, .vs) do (
    if exist %%i call :remove_folder %%i
  )
) else (
  for /d /r "." %%i in (bin, obj) do (
    if exist %%i call :remove_folder %%i
  )
)

if "%1"=="" pause
popd
exit /B
rem -----------------------------------------------------------------------------
:remove_folder

if exist %1 (
  echo Removing %1 ...
  rd /S /Q %1
)

exit /B
rem -----------------------------------------------------------------------------
:clean_folder

if not exist %1 goto exitcall
echo Cleaning %1 ...

pushd %1
if %ERRORLEVEL% gtr 0 goto exitcall
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
popd

:exitcall
exit /B
rem -----------------------------------------------------------------------------
