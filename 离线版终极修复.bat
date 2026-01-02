@echo off
chcp 65001 >nul
echo ================================================
echo    天纪算命 - 离线版终极修复
echo ================================================
echo.

set "APP_ROOT=d:\D\国学\suanming\suanming_app"
cd /d "%APP_ROOT%"

echo [1/5] 重建 web_build 目录...
if exist "web_build" rd /s /q "web_build"
mkdir web_build
mkdir web_build\static

echo [2/5] 复制并修复 index.html...
:: 读取 index.html
set "SRC_FILE=templates\index.html"
set "DST_FILE=web_build\index.html"

:: 使用 PowerShell 进行路径修复 (关键步骤)
:: 1. 移除 {{ url_for... }}
:: 2. 将 /static/ 替换为 ./static/ (解决路径问题)
:: 3. 移除 Flask 的其他标签
powershell -Command "$c = Get-Content '%SRC_FILE%' -Encoding UTF8; $c = $c -replace '\{\{ url_for\(''static'', filename=''(.+?)''\) \}\}', './static/$1'; $c = $c -replace '/static/', './static/'; $c = $c -replace '\?v=[^""]*', ''; $c | Set-Content '%DST_FILE%' -Encoding UTF8"

echo [3/5] 复制静态资源...
xcopy /Y /E static\*.* web_build\static\ >nul
copy /Y "static\sw.js" "web_build\sw.js" >nul
copy /Y "static\manifest.json" "web_build\manifest.json" >nul

echo [4/5] 验证文件...
if not exist "web_build\index.html" (
    echo ❌ index.html 生成失败！
    pause
    exit /b 1
)
echo ✅ index.html 已生成

echo [5/5] 同步并编译 APK...
cd android
:: 清理旧资源
if exist "app\src\main\assets\public" rd /s /q "app\src\main\assets\public"
:: 手动复制确保万无一失
xcopy /Y /E ..\web_build\*.* app\src\main\assets\public\ >nul

echo 正在编译...
call gradlew.bat clean assembleDebug
cd ..

set "APK_PATH=android\app\build\outputs\apk\debug\app-debug.apk"
set "FINAL_NAME=天纪算命_离线修复版.apk"

if exist "%APK_PATH%" (
    copy /Y "%APK_PATH%" "%FINAL_NAME%" >nul
    echo.
    echo ================================================
    echo ✅ 修复版 APK 已生成！
    echo ================================================
    echo.
    echo 文件: %FINAL_NAME%
    echo.
    echo ⚠️ 安装前请务必卸载旧版本！
    echo.
    explorer /select,"%FINAL_NAME%"
) else (
    echo ❌ 编译失败
)

pause
