@echo off
setlocal enabledelayedexpansion

:: ========================================
:: 1. THỰC HIỆN BACKUP GIT
:: ========================================
echo [GIT] Dang them thay doi va commit...
git add .

:: Lay thoi gian an toan (khong chua ky tu dac biet nhu dấu :)
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "datetime=%%I"
set "TIMESTAMP=!datetime:~0,4!-!datetime:~4,2!-!datetime:~6,2! !datetime:~8,2!:!datetime:~10,2!:!datetime:~12,2!"

git commit -m "Auto backup: !TIMESTAMP!"
git push

echo.
echo ========================================
echo 2. KẾT NỐI VÀ SAO CHÉP FILE PDF QUA SMB
:: ========================================

:: Khai bao thong tin ket noi SMB
set "SMB_SERVER=100.89.4.111"
set "SMB_USER=cuong"
set "SMB_PASS=@thienhadenhatbang123"
set "DRIVE_LETTER=Z:"
set "REMOTE_PATH=\\%SMB_SERVER%\RootServer\home\cuong"

echo Dang ngat ket noi o Z: cu (neu co)...
net use %DRIVE_LETTER% /delete /yes >nul 2>&1

echo Dang ket noi toi %REMOTE_PATH% qua ổ %DRIVE_LETTER%...
net use %DRIVE_LETTER% "%REMOTE_PATH%" /user:%SMB_USER% "%SMB_PASS%"

if %ERRORLEVEL% NEQ 0 (
    echo [LOI] Khong the ket noi toi %REMOTE_PATH%. Vui long kiem tra lai IP, username hoac password!
    pause
    exit /b
)

echo Dang sao chep cac tep PDF sang ổ %DRIVE_LETTER%...
:: Su dung robocopy de copy file PDF duy nhat va giu nguyen thu muc con
robocopy "." "%DRIVE_LETTER%\" *.pdf /S /R:2 /W:3 /NP /NDL

echo.
echo Dang ngat ket noi SMB...
net use %DRIVE_LETTER% /delete /yes >nul 2>&1

echo ========================================
echo    Hoan thanh sao chep file PDF qua SMB!
echo ========================================
pause