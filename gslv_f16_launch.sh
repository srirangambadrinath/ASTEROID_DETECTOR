@echo off
title GSLV F16 :: Trajectory Configuration Simulator
color 0A
setlocal EnableDelayedExpansion

echo --------------------------------------------------
echo         GSLV F16 TRAJECTORY CONTROL CONSOLE       
echo --------------------------------------------------
echo Initializing launch control systems...
timeout /t 2 >nul

echo Verifying telemetry link...
ping localhost -n 2 >nul
echo Telemetry uplink: OK

echo.
echo [INFO] Loading trajectory settings...
timeout /t 1 >nul

:: Simulate saving settings to a file
set "file=trajectory_settings.txt"
echo Mission: GSLV F16 > %file%
echo Launch Time: 05:32:15 UTC >> %file%
echo Target Orbit: GTO (Geosynchronous Transfer Orbit) >> %file%
echo Apogee: 35,786 km >> %file%
echo Perigee: 180 km >> %file%
echo Inclination: 21.5 degrees >> %file%
echo Payload Mass: 2,000 kg >> %file%
echo Guidance System: FAKE-SIM-2048 >> %file%

echo [OK] Trajectory settings saved to %file%
timeout /t 1 >nul

echo.
echo Starting simulation of telemetry data...
timeout /t 1 >nul

:: Simulate telemetry output
for /L %%i in (1,1,5) do (
    set /a alt=180+%%i*100
    set /a vel=7800+%%i*25
    echo [TELEMETRY] Altitude: !alt! km | Velocity: !vel! m/s | T+%%i sec
    timeout /t 1 >nul
)

echo.
echo Stage Separation: Success
timeout /t 1 >nul
echo Upper Stage Ignition: Confirmed
timeout /t 1 >nul
echo Trajectory Lock Achieved
timeout /t 1 >nul
echo.
echo >>> SIMULATION COMPLETE: TRAJECTORY STABLE <<<
echo Output file: %file%
echo.

pause
