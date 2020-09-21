@ECHO OFF
@SETLOCAL

::Set the address you wish to ping (default: google.com)
SET adress=216.58.208.238

::Set the speed between pings (In seconds)
SET speed=10

::Set the file name to save as - Can include location ex (C:\Users\%username%\Desktop\file.csv)
SET filename=logs.csv

echo Date, Time, Address, Ping >> %filename%

GOTO :ping

:ping
::Ping and extract time= into variable
for /F "tokens=7 delims== " %%G in ('ping -4 -n 1 %adress%^|findstr /i "time="') do set ping=%%G
echo Current ping for %adress%: %ping%

::Set Timestamp
set curTimestamp=%date:~4,2%-%date:~7,2%-%date:~10,4%,%time:~0,2%:%time:~3,2%:%time:~6,2%

::Create the logs file at the desired location
echo %curTimestamp%, %adress%, %ping% >> %filename%

:: UNCOMMENT AND EDIT THIS IF YOU WANT TO SHOW HIGH PINGS (>60 MS) IN THE LOGS FILE
::if %ping% geq 60 GOTO :disconnected

::Wait for x second before next ping
:wait
PING localhost -n %speed% >NUL

goto :ping

:::disconnected
:: UNCOMMENT THIS IF YOU WANT TO SHOW HIGH PINGS (>60 MS) IN THE LOGS FILE
::echo HIGH PING,---,---,--- >> %filename%
::goto :wait
