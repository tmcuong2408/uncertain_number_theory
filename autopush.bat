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
set "SMB_SERVER=100.89.4.111"
set "SMB_USER=cuong"
set "SMB_PASS=@thienhadenhatbang123"
set "DRIVE_LETTER=Z:"
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
:: Da sua "Z:\" thanh "%DRIVE_LETTER%" de tranh loi Invalid Parameter #2
robocopy "." "%DRIVE_LETTER%" *.pdf /S /IS /IT /R:1 /W:1 /NDL /NFL

echo.
echo Dang ngat ket noi SMB...
net use %DRIVE_LETTER% /delete /yes >nul 2>&1

echo ========================================
echo    Hoan thanh sao chep file PDF qua SMB!
echo ========================================
pause