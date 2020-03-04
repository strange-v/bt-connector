@echo off

rem Install bluetooth-command-line-tools first
rem http://bluetoothinstaller.com/bluetooth-command-line-tools/

rem Set the default address here if you don't want to specify it for each connect/disconnect command
set address=01:01:01:01:01:01

if "%~1" == "" (goto help)
if %~1==connect (goto connect)
if %~1==disconnect (goto disconnect)
if %~1==discover (goto discover)
goto showhelp

:connect
	if not "%~2" == "" set address=%~2
	echo Connecting...
	"C:\Program Files (x86)\Bluetooth Command Line Tools\bin\btcom" -b %address% -c -s111e
	if errorlevel 1 goto reconnect
	"C:\Program Files (x86)\Bluetooth Command Line Tools\bin\btcom" -b %address% -c -s110b
	echo Done
	goto exit
:reconnect
	if not "%~2" == "" set address=%~2
	echo Reconnecting...
	"C:\Program Files (x86)\Bluetooth Command Line Tools\bin\btcom" -b %address% -r -s111e
	"C:\Program Files (x86)\Bluetooth Command Line Tools\bin\btcom" -b %address% -r -s110b
	"C:\Program Files (x86)\Bluetooth Command Line Tools\bin\btcom" -b %address% -c -s111e
	"C:\Program Files (x86)\Bluetooth Command Line Tools\bin\btcom" -b %address% -c -s110b
	echo Done
	goto exit
:disconnect
	if not "%~2" == "" set address=%~2
	echo Disconnecting...
	"C:\Program Files (x86)\Bluetooth Command Line Tools\bin\btcom" -b %address% -r -s111e
	"C:\Program Files (x86)\Bluetooth Command Line Tools\bin\btcom" -b %address% -r -s110b
	echo Done
	goto exit
:discover
	echo Discovering by name: %~2
	"C:\Program Files (x86)\Bluetooth Command Line Tools\bin\btdiscovery" -n "%~2"
	goto exit
:help
	echo Script to easy connect/disconnect bluetooth headphones.
	echo.
	echo Use:
	echo bt-connector connect [device address]
	echo to connect to the bluetooth device
	echo.
	echo bt-connector disconnect [device address]
	echo to disconnect from the bluetooth device
	echo.
	echo bt-connector discover device_name
	echo to discover the address of the bluetooth device
	goto exit
:exit
