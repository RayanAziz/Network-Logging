@echo OFF
@setlocal
 
title Ping Logging
 
:: Set the ip address for the modem/router in the local network
set ip1=192.168.100.1
 
:: Set the ip address you wish to ping for comparison, default: google.com
set ip2=172.217.19.46
 
:: Set the interval between pings (in seconds)
set interval=5
 
:: Set the logs file name (must have the .csv extension)
set file=pings.csv
 
echo.    Date and Time       ^|  %ip1%  ^|  %ip2%
echo.
:: Write the table column headers to the file
echo. Date, Time, Ping to %ip1%, Ping to %ip2% >> %file%
 
:ping
:: Ping and extract time into variables
for /F "tokens=7 delims== " %%G in ('ping -4 -n 1 %ip1%^|findstr /i "time="') do set ping1=%%G
for /F "tokens=7 delims== " %%G in ('ping -4 -n 1 %ip2%^|findstr /i "time="') do set ping2=%%G
 
:: Set timestamp
set timestamp=%date:~4,2%-%date:~7,2%-%date:~10,4%, %time:~0,2%:%time:~3,2%:%time:~6,2%
 
:: Write the timestamp and results to the file
echo %timestamp%    ^|       %ping1%       ^|      %ping2%
 
:: Write the timestamp and results to the file
echo %timestamp%, %ping1:~0,-2%, %ping2:~0,-2% >> %file%
 
:: Wait for x seconds before the next ping
:wait
ping localhost -n %interval% >NUL
 
:: Repeat
goto :ping
