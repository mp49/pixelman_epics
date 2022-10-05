@echo OFF
setlocal
set MYDIR=%~dp0
set MYDIRROOT=%MYDIR:~0,-1%
REM Restrict IOC channel access requests to localhost - at ISIS we use an EPICS gateway for all external access 
set EPICS_CAS_INTF_ADDR_LIST=10.111.103.30
set EPICS_CAS_BEACON_ADDR_LIST=10.111.103.255
set IOCEXE=pixelman.exe
set EPICSPIXELMAN=%MYDIR:\=/%
if exist "%MYDIR%config_local.bat" (
    call %MYDIR%config_local.bat
) else (
    call %MYDIR%config.bat
)
set EPIXELMANDIR=%PIXELMANDIR:\=/%
call %MYDIR%..\..\..\..\config_env_base.bat
call %MYDIR%dllPath.bat
REM at ISIS MYPVPREFIX is set in config_env_base.bat
if "%MYPVPREFIX%" == "" (
    set MYPVPREFIX=CG1D:Det:
)
set OLDCWD=%CWD%
cd /d %PIXELMANDIR%
taskkill /f /im pixelman.exe
taskkill /f /im jpixelman.exe
copy /y %MYDIR%epics.dll plugins
copy /y %MYDIR%caRepeater.exe .
REM %HIDEWINDOW% m
%IOCEXE% %*
cd /d %OLDCWD%
