@echo off
CHOICE /C ABCDN /N /T 10 /D C /M "Format drive A:, B:, C:, D: or None?"
IF ERRORLEVEL 1 SET DRIVE=drive A:
IF ERRORLEVEL 2 SET DRIVE=drive B:
IF ERRORLEVEL 3 SET DRIVE=drive C:
IF ERRORLEVEL 4 SET DRIVE=drive D:
IF ERRORLEVEL 5 SET DRIVE=None
ECHO You chose to format %DRIVE%
pause