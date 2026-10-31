@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title JavaWork - GitHub Paneli
mode con: cols=78 lines=36

:: ============================================================
::  AYARLAR
:: ============================================================
set "PROJECT_PATH=E:\keremsalman\Java\odevler"
set "REPO_URL=https://github.com/kremsanti111111/Javawork.git"
set "WEB_URL=https://github.com/kremsanti111111/Javawork"
set "BRANCH=main"

:: ============================================================
::  RENKLER (ANSI)
:: ============================================================
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "RESET=%ESC%[0m"
set "GREEN=%ESC%[92m"
set "RED=%ESC%[91m"
set "YELLOW=%ESC%[93m"
set "CYAN=%ESC%[96m"
set "WHITE=%ESC%[97m"
set "GRAY=%ESC%[90m"

call :setup
if errorlevel 1 goto fatal
goto menu


:: ============================================================
::  ANA MENÜ
:: ============================================================
:menu
cls
call :header
call :count
echo.
echo   %GRAY%Klasör :%RESET% %PROJECT_PATH%
echo   %GRAY%Repo   :%RESET% %REPO_URL%
echo   %GRAY%Branch :%RESET% !CUR!
if "!CHANGES!"=="0" (
    echo   %GRAY%Durum  :%RESET% %GREEN%Temiz, bekleyen değişiklik yok%RESET%
) else (
    echo   %GRAY%Durum  :%RESET% %YELLOW%!CHANGES! dosyada değişiklik var%RESET%
)
if defined LASTMSG echo   %GRAY%Son commit:%RESET% !LASTMSG!
echo.
echo   %CYAN%----------------------------------------------------------%RESET%
echo.
echo     %CYAN%[1]%RESET%  Durumu göster
echo     %CYAN%[2]%RESET%  Değişiklikleri GitHub'a yükle
echo     %CYAN%[3]%RESET%  GitHub'dan güncellemeleri çek
echo     %CYAN%[4]%RESET%  Commit geçmişini göster
echo     %CYAN%[5]%RESET%  Ayarlar
echo     %CYAN%[6]%RESET%  GitHub sayfasını tarayıcıda aç
echo     %CYAN%[0]%RESET%  Çıkış
echo.
choice /c 1234560 /n /m "  Seçimin: "
if errorlevel 7 goto bye
if errorlevel 6 goto openweb
if errorlevel 5 goto settings
if errorlevel 4 goto history
if errorlevel 3 goto pull
if errorlevel 2 goto upload
if errorlevel 1 goto status
goto menu


:: ============================================================
::  1) DURUM
:: ============================================================
:status
cls
call :header
call :count
echo.
echo   %YELLOW%Dosya değişiklikleri:%RESET%
echo.
git status --short
if "!CHANGES!"=="0" echo   %GREEN%Temiz, yüklenecek değişiklik yok.%RESET%
echo.
echo   %YELLOW%Uzak depoya göre durum:%RESET%
git status -sb | findstr /b "##"
goto back


:: ============================================================
::  2) YÜKLE
:: ============================================================
:upload
cls
call :header
call :count
echo.
if "!CHANGES!"=="0" (
    call :warn "Yeni değişiklik yok. Sadece senkronizasyon ve push denenecek."
    goto do_push
)
echo   %YELLOW%Yüklenecek değişiklikler:%RESET%
echo.
git status --short
echo.
choice /c EH /n /m "  Bu dosyalar yüklensin mi? [E/H]: "
if errorlevel 2 (
    call :warn "İşlem iptal edildi."
    goto back
)

call :ensure_identity
if errorlevel 1 goto back
call :ensure_gitignore

git add .
if errorlevel 1 (
    call :fail "git add başarısız oldu."
    goto back
)

git diff --cached --quiet
if not errorlevel 1 (
    call :warn "Commit edilecek bir şey yok."
    goto do_push
)

echo.
set "MSG="
set /p "MSG=  Commit mesajı (boş bırakırsan otomatik): "
if not defined MSG set "MSG=Java ödevleri güncellendi - %date:~0,10%"
set "MSG=!MSG:"='!"

git commit -m "!MSG!"
if errorlevel 1 (
    call :fail "Commit başarısız oldu."
    goto back
)
call :ok "Commit oluşturuldu."

:do_push
echo.
call :info "GitHub ile senkronize ediliyor..."
call :sync
if errorlevel 1 (
    echo.
    call :fail "Senkronizasyon başarısız oldu."
    call :conflict_help
    goto back
)

echo.
call :info "GitHub'a yükleniyor..."
git push -u origin %BRANCH%
if errorlevel 1 (
    echo.
    call :fail "Push başarısız oldu. İnternet bağlantını ve GitHub girişini kontrol et."
    goto back
)

echo.
echo   %GREEN%========================================%RESET%
echo   %GREEN%   YÜKLEME BAŞARIYLA TAMAMLANDI         %RESET%
echo   %GREEN%========================================%RESET%
echo.
echo   %GRAY%Görüntüle:%RESET% %WEB_URL%
goto back


:: ============================================================
::  3) ÇEK
:: ============================================================
:pull
cls
call :header
echo.
call :info "GitHub'dan güncellemeler çekiliyor..."
call :sync
if errorlevel 1 (
    echo.
    call :fail "Çekme işlemi başarısız oldu."
    call :conflict_help
    goto back
)
echo.
call :ok "Yerel klasör güncel."
goto back


:: ============================================================
::  4) GEÇMİŞ
:: ============================================================
:history
cls
call :header
echo.
echo   %YELLOW%Son 15 commit:%RESET%
echo.
git log --oneline --graph --decorate -15 2>nul
if errorlevel 1 call :warn "Henüz hiç commit yok."
goto back


:: ============================================================
::  5) AYARLAR
:: ============================================================
:settings
cls
call :header
set "GN="
set "GE="
for /f "delims=" %%i in ('git config user.name 2^>nul') do set "GN=%%i"
for /f "delims=" %%i in ('git config user.email 2^>nul') do set "GE=%%i"
echo.
echo   %GRAY%Git kullanıcı adı :%RESET% !GN!
echo   %GRAY%Git e-posta      :%RESET% !GE!
echo   %GRAY%Repo adresi      :%RESET% %REPO_URL%
echo.
echo     %CYAN%[1]%RESET%  Git kullanıcı adı ve e-postayı değiştir
echo     %CYAN%[2]%RESET%  Repo adresini değiştir
echo     %CYAN%[0]%RESET%  Geri
echo.
choice /c 120 /n /m "  Seçimin: "
if errorlevel 3 goto menu
if errorlevel 2 goto set_repo
if errorlevel 1 goto set_ident
goto settings

:set_ident
echo.
set "GN="
set "GE="
set /p "GN=  Kullanıcı adı : "
set /p "GE=  E-posta       : "
if defined GN git config --global user.name "!GN!"
if defined GE git config --global user.email "!GE!"
call :ok "Kimlik kaydedildi."
goto back_settings

:set_repo
echo.
set "NEWURL="
set /p "NEWURL=  Yeni repo adresi (.git ile biten): "
if not defined NEWURL goto settings
set "REPO_URL=!NEWURL!"
set "WEB_URL=!NEWURL:.git=!"
git remote set-url origin "!REPO_URL!"
call :ok "Repo adresi güncellendi (sadece bu oturum için; kalıcı yapmak istersen dosyanın başındaki REPO_URL satırını düzenle)."
goto back_settings

:back_settings
echo.
pause >nul
goto settings


:: ============================================================
::  6) TARAYICIDA AÇ
:: ============================================================
:openweb
start "" "%WEB_URL%"
goto menu


:: ============================================================
::  ÇIKIŞ / HATA / DEVAM
:: ============================================================
:bye
cls
echo.
echo   %CYAN%Görüşürüz!%RESET%
echo.
timeout /t 1 >nul
endlocal
exit /b 0

:fatal
echo.
echo   %RED%Program başlatılamadı.%RESET%
echo.
pause
endlocal
exit /b 1

:back
echo.
echo   %GRAY%Menüye dönmek için bir tuşa bas...%RESET%
pause >nul
goto menu


:: ============================================================
::  ALT RUTİNLER
:: ============================================================

:header
echo.
echo   %CYAN%==========================================================%RESET%
echo   %WHITE%        J A V A W O R K   -   G I T H U B   P A N E L İ%RESET%
echo   %CYAN%==========================================================%RESET%
exit /b 0

:ok
echo   %GREEN%[OK]%RESET%     %~1
exit /b 0

:warn
echo   %YELLOW%[UYARI]%RESET%  %~1
exit /b 0

:fail
echo   %RED%[HATA]%RESET%    %~1
exit /b 0

:info
echo   %CYAN%[..]%RESET%     %~1
exit /b 0

:count
set "CHANGES=0"
set "CUR="
set "LASTMSG="
for /f %%i in ('git status --short 2^>nul ^| find /c /v ""') do set "CHANGES=%%i"
for /f "delims=" %%i in ('git branch --show-current 2^>nul') do set "CUR=%%i"
if not defined CUR set "CUR=%BRANCH%"
for /f "delims=" %%i in ('git log -1 --format^=%%s 2^>nul') do set "LASTMSG=%%i"
exit /b 0

:setup
where git >nul 2>&1
if errorlevel 1 (
    call :fail "Git bulunamadı. https://git-scm.com adresinden kur."
    exit /b 1
)
if not exist "%PROJECT_PATH%\" (
    call :fail "Proje klasörü bulunamadı: %PROJECT_PATH%"
    exit /b 1
)
cd /d "%PROJECT_PATH%"
if not exist ".git\" git init >nul 2>&1
git branch -M %BRANCH% >nul 2>&1
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    git remote add origin "%REPO_URL%"
) else (
    git remote set-url origin "%REPO_URL%"
)
exit /b 0

:ensure_identity
set "GN="
set "GE="
for /f "delims=" %%i in ('git config user.name 2^>nul') do set "GN=%%i"
for /f "delims=" %%i in ('git config user.email 2^>nul') do set "GE=%%i"
if not defined GN (
    echo.
    call :warn "Git kullanıcı adı ayarlı değil."
    set /p "GN=  Kullanıcı adı : "
    if not defined GN (
        call :fail "Kullanıcı adı boş olamaz."
        exit /b 1
    )
    git config --global user.name "!GN!"
)
if not defined GE (
    echo.
    call :warn "Git e-posta ayarlı değil."
    set /p "GE=  E-posta       : "
    if not defined GE (
        call :fail "E-posta boş olamaz."
        exit /b 1
    )
    git config --global user.email "!GE!"
)
exit /b 0

:ensure_gitignore
if exist ".gitignore" exit /b 0
(
    echo *.class
    echo bin/
    echo out/
    echo .idea/
    echo *.iml
    echo .vscode/
    echo .metadata/
) > .gitignore
call :ok ".gitignore oluşturuldu: derlenmiş dosyalar yüklenmeyecek."
exit /b 0

:sync
git ls-remote --exit-code --heads origin %BRANCH% >nul 2>&1
set "RC=%errorlevel%"
if "%RC%"=="2" exit /b 0
if not "%RC%"=="0" exit /b %RC%
git pull --rebase origin %BRANCH%
if not errorlevel 1 exit /b 0
git rebase --abort >nul 2>&1
call :warn "Rebase olmadı, birleştirme yöntemi deneniyor..."
git pull origin %BRANCH% --allow-unrelated-histories --no-edit
exit /b %errorlevel%

:conflict_help
echo.
echo   %YELLOW%Ne yapmalı?%RESET%
echo     1. Çakışan dosyayı aç, ^<^<^<^<^<^<^< ve ^>^>^>^>^>^>^> satırlarını temizle.
echo     2. Komut satırında: git add . ^&^& git commit
echo     3. Bu paneli tekrar çalıştır.
exit /b 0