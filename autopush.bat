@echo off
:: ========================================
:: 1. GIT BACKUP
:: ========================================
echo Dang thuc hien Git Backup...
git add .
git commit -m "Auto backup: %DATE% %TIME%"
git push
