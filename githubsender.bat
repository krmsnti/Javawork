
@echo off
chcp 65001 >nul
title JavaWork - GitHub Automation
color 0A

echo ========================================
echo       JAVAWORK GITHUB AUTOMATION
echo ========================================
echo.

set "PROJECT_PATH=E:\keremsalman\Java\odevler"
set "REPO_URL=https://github.com/kremsanti111111/Javawork.git"

:: Check Git installation
echo [1/7] Checking Git installation...

where git >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed!
    goto error
)

echo Git found!
echo.

:: Check project directory
echo [2/7] Checking project directory...

if not exist "%PROJECT_PATH%\" (
    echo ERROR: Project directory not found!
    goto error
)

cd /d "%PROJECT_PATH%"
echo Project directory found!
echo.

:: Initialize repository if needed
echo [3/7] Checking repository...

if not exist ".git\" (
    git init
    if errorlevel 1 goto error
)

git branch -M main

:: Configure remote
git remote get-url origin >nul 2>&1

if errorlevel 1 (
    git remote add origin "%REPO_URL%"
) else (
    git remote set-url origin "%REPO_URL%"
)

if errorlevel 1 goto error

echo Repository configured!
echo.

:: Check Git identity
echo [4/7] Checking Git identity...

git config user.name >nul 2>&1
if errorlevel 1 (
    echo Please configure your Git username first.
    goto error
)

git config user.email >nul 2>&1
if errorlevel 1 (
    echo Please configure your Git email first.
    goto error
)

:: Show changes
echo [5/7] Checking project changes...
echo.
git status --short

echo.
set /p CONFIRM=Do you want to upload these files? (Y/N):

if /i not "%CONFIRM%"=="Y" (
    echo Upload cancelled.
    goto end
)

git add .
if errorlevel 1 goto error

git diff --cached --quiet

if not errorlevel 1 (
    echo No changes to upload.
    goto end
)

:: Commit
echo.
set /p COMMIT_MSG=Enter commit message:

if "%COMMIT_MSG%"=="" set "COMMIT_MSG=Update Java projects"

git commit -m "%COMMIT_MSG%"
if errorlevel 1 goto error

:: Push
echo.
echo [6/7] Uploading to GitHub...

git push -u origin main
if errorlevel 1 goto error

echo.
echo ========================================
echo      UPLOAD COMPLETED SUCCESSFULLY!
echo ========================================
goto end

:error
echo.
echo ========================================
echo             ERROR OCCURRED!
echo ========================================

:end
echo.
pause
