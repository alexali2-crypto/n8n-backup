@echo off
cd /d C:\Users\ehs-hrdc\n8n-backup
call n8n export:workflow --all --separate --output=./workflows >> backup.log 2>&1
findstr /s /i /m “api_key apikey api-key token secret password authorization” workflows*.json >> backup.log 2>&1
if %errorlevel%==0 (echo POSSIBLE SECRET - PUSH SKIPPED >> backup.log & exit /b 1)
git add -A >> backup.log 2>&1
git commit -m “Auto backup” >> backup.log 2>&1
git push >> backup.log 2>&1