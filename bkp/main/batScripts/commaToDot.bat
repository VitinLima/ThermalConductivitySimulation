echo off
SETLOCAL ENABLEDELAYEDEXPANSION
(
for /f "usebackqdelims=" %%a in (%1) do (
set line=%%a
set line=!line:,=.!
echo !line!
)
)>%2