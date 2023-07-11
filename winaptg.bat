@echo off
title WinApt by ZVDXC

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------    

echo Vorbereiten...
winget search hfjkhfkjhfkjhskjdsfhjkdhfjkhdsfjksfdhjkfsdhfjkdshkjsfdhkfsjdhkjfdshfskjdhfjkhsjdkhfskhsfkjhdskjhhsdfjdhjkdsfhjksdfhjkdshjkhsfjkhsdfjhdjhsjkhsfdjhsjkhfsjkfdhjdhfsjsdhjsd
cls
echo Fertig!
timeout 2 >> NUL
:code
cls
echo Paket installieren (1),deinstallieren (2),aktualisieren (3) oder suchen (4)?
timeout 1 > NUL
set /P auswahl="auswahl  "
if "%auswahl%"=="1" goto install
if "%auswahl%"=="2" goto uninstall
if "%auswahl%"=="3" goto update
if "%auswahl%"=="4" goto search
goto code
:install
set /P package="paket   "
winget install %package%
goto done
:done
echo Fertig! Infos von winget oben was jetzt tun?
timeout 1 > NUL
echo 1 weitermachen
timeout 1 > NUL
echo 2 Schliessen
timeout 1 > NUL
set /P aktion="auswahl  "
if "%aktion%"=="1" goto code
if "%aktion%"=="2" exit
goto done
:uninstall
set /P packageu="paket   "
winget uninstall %packageu%
goto done
:update
set /P packageup="paket   "
winget upgrade %packageup%
goto done
:search
set /P packagets="paket   "
winget search %packagets%
goto done