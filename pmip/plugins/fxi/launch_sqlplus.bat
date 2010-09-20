@echo off
color %1

echo.
echo ********** This is: %7 **********
echo.
echo Connecting to %6 on %4:%5 as %2/%3
echo.
echo --------------------------------------------------------------------------------------------------

sqlplus %2/%3@(description=(address_list=(address=(protocol=TCP)(host=%4)(port=%5)))(connect_data=(service_name=%6)))