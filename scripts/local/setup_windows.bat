@echo off
setlocal
if not exist .venv (
  python -m venv .venv
)
call .venv\Scripts\activate.bat
pip install -r requirements.txt
if not exist .env copy .env.example .env

echo.
echo Projet local prepare.
echo Pensez a configurer .env puis a executer les scripts SQL MySQL.
endlocal
