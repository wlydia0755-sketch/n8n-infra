@echo off
chcp 65001 > nul
title n8n Infrastructure Console

for /f "tokens=1,2 delims==" %%a in (.env) do (
    if not "%%a"=="" set "%%a=%%b"
)

:menu
cls
echo =========================================
echo    n8n Infrastructure Console
echo =========================================
echo 1. Start
echo 2. Stop
echo 3. Restart
echo 4. Backup
echo 5. Status
echo 6. Versions
echo 7. Logs
echo 0. Exit
echo =========================================
set /p choice=Enter choice:

if "%choice%"=="1" docker compose up -d
if "%choice%"=="2" docker compose down
if "%choice%"=="3" docker compose restart
if "%choice%"=="4" goto backup
if "%choice%"=="5" docker compose ps
if "%choice%"=="6" goto version
if "%choice%"=="7" goto logs
if "%choice%"=="0" exit

pause
goto menu

:backup
if not exist backup mkdir backup
for /f %%i in ('powershell -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set TS=%%i
docker compose exec -T postgres pg_dump -U %POSTGRES_USER% -d %POSTGRES_DB% -Fc > backup\n8ndb_%TS%.dump
if %errorlevel% equ 0 (
    echo Backup successful! File: backup\n8ndb_%TS%.dump
) else (
    echo Backup failed!
)
pause
goto menu

:version
docker compose images
pause
goto menu

:logs
docker compose logs -f
pause
goto menu