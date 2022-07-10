@echo off
cd %~dp0

echo %~dp0
xcopy /e .\WindowsPowerShell %USERPROFILE%\Documents\WindowsPowerShell
xcopy /e .\bin %USERPROFILE%\Documents\bin
pause