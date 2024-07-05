@echo off
setlocal enabledelayedexpansion


:: Backup keys
set "RegPath=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}"
set "BackupFile=C:\ProgramData\ShadowWhisperer\nics.reg"

if not exist "%BackupFile%" (
 mkdir "C:\ProgramData\ShadowWhisperer" >nul 2>&1
 reg export "%RegPath%" "%BackupFile%" /y >nul 2>&1
)



for /F "tokens=1*" %%A in ('reg query "%RegPath%" ^| findstr "000"') do (


:: Disable - Power Saving
reg add %%A /t REG_SZ /v "*EEE" /d 0 /f >nul 2>&1
reg add %%A /t REG_SZ /v AdvancedEEE /d 0 /f >nul 2>&1
reg add %%A /t REG_SZ /v AutoPowerSaveModeEnabled /d 0 /f >nul 2>&1
reg add %%A /t REG_SZ /v EnableEDT /d 0 /f >nul 2>&1
reg add %%A /t REG_SZ /v EnableGreenEthernet /d 0 /f >nul 2>&1
reg add %%A /t REG_SZ /v EEELinkAdvertisement /d 0 /f >nul 2>&1
reg add %%A /t REG_SZ /v ENPWMode /d 0 /f >nul 2>&1
reg add %%A /t REG_SZ /v GPPSW /d 0 /f >nul 2>&1
reg add %%A /t REG_SZ /v PowerSavingMode /d 0 /f >nul 2>&1
reg add %%A /t REG_SZ /v ULPMode /d 0 /f >nul 2>&1

:: Disable - Reduce network speed to 10/100
reg add %%A /t REG_SZ /v GigaLite /d 0 /f >nul 2>&1

:: Disable - Allow the computer to turn off this device to save power
reg add %%A /t REG_DWORD /v PnPCapabilities /d 18 /f >nul 2>&1

:: Disable - Logging of Adapter State
reg add %%A /t REG_SZ /v LogDisconnectEvent /d 0 /f >nul 2>&1
reg add %%A /t REG_SZ /v LogLinkStateEvent /d 16 /f >nul 2>&1
)


:: Stop logging when the network cable is disconnected
reg add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v DisableMediaSenseEventLog /t REG_DWORD /d 1 /f >nul 2>&1
