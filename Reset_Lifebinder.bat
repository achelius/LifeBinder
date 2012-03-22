:: LifeBinder_Clean_WTF.bat
::
:: Deletes All LifeBinder's text files from SavedVariables
::
:: This must be run from the main LifeBinder addon directory
::
:: Use this if your getting nil errors with LifeBinder.

@ECHO OFF
set WD=%CD:~-9,9%
set LBDIR=s\LifeBinder


if /i NOT %WD%==%HBDIR% goto ERRLB

CLS
ECHO.
ECHO.
ECHO  Press D - Clean LifeBinder files in your SavedVariables directory
ECHO.
ECHO  Any other key - Does NOTHING and exits
ECHO.

SET /P GOWHERE=Enter D to Delete: 

if /i %GOWHERE%==D goto DELLB

goto SKIP

:DELLB

cls

del /s ..\..\Saved\LifeBinder.*

echo ^ Above files deleted from all active accounts ^
echo.
echo.
echo Deleted all LifeBinder SavedVariables files from Saved sub-directories ** Completed **
echo.

goto DONE

:SKIP

echo.
echo  D NOT pressed - NOTHING DELETED
echo.

goto DONE

:ERRLB

echo.
echo ERROR - Running in the wrong Directory
echo ERROR - Run this in the addons own directory .\Interface\AddOns%LBDIR%
echo.

goto DONE

:DONE

pause
EXIT