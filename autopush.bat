:: Thêm tất cả thay đổi
git add .

:: Commit với ngày tháng
git commit -m "Auto backup: %DATE% %TIME%"

:: Push lên branch hiện tại
git push

@echo off
:: Khai bao thong tin ket noi SMB
set "SMB_SERVER=100.89.4.111"
set "SMB_USER=cuong"
set "SMB_PASS=@thienhadenhatbang123"
set "DRIVE_LETTER=Z:"

:: Duong dan thu muc /home/cuong tren máy chủ SMB
set "REMOTE_PATH=\\%SMB_SERVER%\RootServer\home\cuong"

echo Dang ket noi toi /home/cuong qua SMB...
net use %DRIVE_LETTER% "%REMOTE_PATH%" /user:%SMB_USER% "%SMB_PASS%" >nul 2>&1

if %ERRORLEVEL% NEQ 0 (
    echo [LOI] Khong the ket noi toi %REMOTE_PATH%. Vui long kiem tra lai IP, username hoac password!
    pause
    exit /b
)

echo Dang sao chep cac tep PDF sang /home/cuong...
:: Chi copy cac file *.pdf (bao gom ca trong cac thu muc con neu co)
xcopy "*.pdf" "Z:\" /S /E /C /I /Y /Q /B
echo Dang ngat ket noi SMB...
net use %DRIVE_LETTER% /delete /yes >nul 2>&1

echo ========================================
echo   Hoan thanh sao chep file PDF qua SMB!
echo ========================================
pause