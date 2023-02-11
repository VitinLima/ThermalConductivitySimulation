@echo off
set LOCALHOST=%COMPUTERNAME%
if /i "%LOCALHOST%"=="DESKTOP-71B23Q0" (taskkill /f /pid 12384)
if /i "%LOCALHOST%"=="DESKTOP-71B23Q0" (taskkill /f /pid 9100)

del /F cleanup-ansys-DESKTOP-71B23Q0-9100.bat
