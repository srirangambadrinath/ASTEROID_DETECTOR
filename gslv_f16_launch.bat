@echo off
title GSLV F-16 Launch Control Simulation
color 0A
cls

echo =====================================================
echo             ISRO MISSION CONTROL CENTER
echo               GSLV-F16 :: LAUNCH PROTOCOL
echo =====================================================
echo Mission ID   : GSLV-F16
echo Vehicle      : GSLV Mk II
echo Payload      : INSAT-4CR
echo Launch Pad   : SDSC SHAR, Sriharikota
echo Flight Mode  : Automated
echo -----------------------------------------------------
ping localhost -n 2 >nul

echo [SYSCHK] Initializing vehicle systems...
ping localhost -n 2 >nul
echo [OK] Guidance & Navigation Systems
ping localhost -n 1 >nul
echo [OK] Propellant Systems
ping localhost -n 1 >nul
echo [OK] Avionics
ping localhost -n 1 >nul
echo [OK] Telemetry & Tracking
ping localhost -n 1 >nul
echo [OK] Weather Conditions - GREEN
ping localhost -n 2 >nul
echo -----------------------------------------------------
echo [TRAJECTORY] Uploading flight trajectory parameters...
ping localhost -n 2 >nul
echo   > Perigee   : 170 km
echo   > Apogee    : 35800 km
echo   > Inclination: 21.5 degrees
ping localhost -n 2 >nul
echo -----------------------------------------------------
echo Entering Terminal Countdown Phase
ping localhost -n 1 >nul

set /a T=10
:countdown
if %T%==0 goto liftoff
echo T-%T% seconds
set /a T=%T%-1
ping localhost -n 2 >nul >nul
goto countdown

:liftoff
echo -----------------------------------------------------
echo 🔥 Ignition of L40 Strap-ons
ping localhost -n 1 >nul
echo 🚀 Core Stage Ignition Confirmed
ping localhost -n 1 >nul
echo 📡 LIFTOFF! GSLV F-16 is lifting off from SHAR
ping localhost -n 2 >nul
echo -----------------------------------------------------
echo [FLIGHT] T+50s :: Max-Q
ping localhost -n 2 >nul
echo [FLIGHT] T+110s :: L40 Separation
ping localhost -n 2 >nul
echo [FLIGHT] T+150s :: Core Stage Burnout
ping localhost -n 2 >nul
echo [FLIGHT] T+155s :: Second Stage Ignition
ping localhost -n 2 >nul
echo [FLIGHT] T+220s :: Payload Fairing Separation
ping localhost -n 2 >nul
echo [FLIGHT] T+305s :: Cryogenic Stage Ignition
ping localhost -n 2 >nul
echo -----------------------------------------------------
echo 🛰️  Injecting into Geostationary Transfer Orbit...
ping localhost -n 3 >nul
echo ✅ Payload successfully deployed in GTO
ping localhost -n 1 >nul
echo -----------------------------------------------------
echo MISSION COMPLETE: GSLV F-16 launch simulation ended.
echo =====================================================
pause
