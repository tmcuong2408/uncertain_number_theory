@echo off
:: ========================================
:: 1. GIT BACKUP
:: ========================================
echo Dang thuc hien Git Backup...
git add .
git commit -m "Auto backup: %DATE% %TIME%"
git push

echo.
:: ========================================
:: 2. KẾT NỐI VÀ COPY OVERWRITE FILE PDF
:: ========================================
:: Khai bao thong tin ket noi SMB
set "SMB_SERVER=100.89.4.111"
set "SMB_USER=cuong"
set "SMB_PASS=@thienhadenhatbang123"
set "DRIVE_LETTER=Z:"

:: Duong dan thu muc /home/cuong tren may chu SMB
set "REMOTE_PATH=\\%SMB_SERVER%\RootServer\home\cuong"

echo Dang ngat ket noi cu (neu co)...
net use %DRIVE_LETTER% /delete /yes >nul 2>&1

echo Dang ket noi toi /home/cuong qua SMB...
net use %DRIVE_LETTER% "%REMOTE_PATH%" /user:%SMB_USER% "%SMB_PASS%" >nul 2>&1

if %ERRORLEVEL% NEQ 0 (
    echo [LOI] Khong the ket noi toi %REMOTE_PATH%. Vui long kiem tra lai IP, username hoac password!
    pause
    exit /b
)

echo Dang sao chep va ghi de cac tep PDF sang /home/cuong...
:: Dung robocopy chong treo: /IS /IT (bat buoc ghi de 100%), /R:1 /W:1 (neu loi chi cho 1 giay)
robocopy "." "%DRIVE_LETTER%\" *.pdf /S /IS /IT /R:1 /W:1 /NDL /NFL

echo.
echo Dang ngat ket noi SMB...
net use %DRIVE_LETTER% /delete /yes >nul 2>&1

echo ========================================
echo    Hoan thanh sao chep file PDF qua SMB!
echo ========================================
pause