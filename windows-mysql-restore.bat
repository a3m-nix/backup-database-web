@ECHO OFF
setlocal enabledelayedexpansion
for %%f in (E:\backup\mysql\*.sql) do (
  set /p val=<%%f
  echo "fullname: %%f"
  echo "name: %%~nf"
  mysql -uroot -pYourPass -e "create database %%~nfs"
  mysql -uroot -pYourPass %%~nf < %%f
)