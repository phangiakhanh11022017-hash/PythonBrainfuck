@echo off
echo [1/4] Kiem tra moi truong Python...
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Khong tim thay Python! Dang tai trinh cai dat Python 3.11 (amd64)...
    curl -sSL "https://www.python.org/ftp/python/3.11.8/python-3.11.8-amd64.exe" -o python_installer.exe
    
    echo Dang cai dat Python (ngam) va cap nhat PATH...
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_pip=1
    del python_installer.exe
    
    echo [!] Da cai dat Python! De cmd nhan dien lenh pip, ban hay tat cua so nay va chay lai file install.bat (Run as Administrator) mot lan nua.
    pause
    exit /b
)

echo [2/4] Dang cai dat PyInstaller...
pip install pyinstaller -q

echo [3/4] Dang bien dich file run_bf.py o thu muc hien tai...
pyinstaller --onefile \src\run_bf.py

echo [4/4] Dang thiet lap lenh pybf toan cuc...
move dist\run_bf.exe %WINDIR%\System32\pybf.exe

echo Dang don dep file tam...
rmdir /s /q build dist __pycache__ >nul 2>&1
del run_bf.spec >nul 2>&1

echo ✅ Cai dat thanh cong! Hay mo cmd moi va thu lenh: pybf code.bf
pause
