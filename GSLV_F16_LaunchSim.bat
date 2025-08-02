@echo off
setlocal EnableDelayedExpansion
title GSLV F16 Trajectory Simulator
color 0A

:: Output file
set "outfile=trajectory_full_output.txt"
del "%outfile%" >nul 2>&1

echo -------------------------------------------------- > "%outfile%"
echo           GSLV F16 -  TRAJECTORY LOG          >> "%outfile%"
echo -------------------------------------------------- >> "%outfile%"
echo Time(s)   Altitude(km)   Velocity(m/s)   Accel(m/s^2)   Stage >> "%outfile%"
echo -------------------------------------------------- >> "%outfile%"

:: Simulate trajectory values for 0 to 120 seconds
set /a time=0
set /a altitude=0
set /a velocity=0
set /a accel=15
set /a stage=1

:loop
if !time! GTR 120 goto end

:: Simulate stage change
if !time! EQU 45 (
    set /a stage=2
    set /a accel=12
)
if !time! EQU 90 (
    set /a stage=3
    set /a accel=8
)

:: Update values
set /a velocity+=!accel!
set /a altitude+=(!velocity!/10)

:: Format stage name
set "stageLabel=Stage !stage!"

:: Print to console
echo T+!time!s    Alt: !altitude! km    Vel: !velocity! m/s    Accel: !accel! m/s^2    ^(!stageLabel!^)

:: Write to file
>>"%outfile%" echo T+!time!s    !altitude! km    !velocity! m/s    !accel! m/s^2    !stageLabel!

:: Increment time
set /a time+=5
timeout /t 1 >nul
goto loop

:end
echo -------------------------------------------------- >> "%outfile%"
echo Simulation Complete at T+!time!s >> "%outfile%"
echo Output saved to "%outfile%"
echo.
echo >>> TRAJECTORY SIMULATION COMPLETE <<<
echo Data saved to: %outfile%
pause
