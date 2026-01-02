@echo off
chcp 65001 >nul
echo ================================================
echo    天纪算命 - 深度清理与构建 (修复版)
echo ================================================
echo.

set "APP_ROOT=d:\D\国学\suanming\suanming_app"
cd /d "%APP_ROOT%"

echo [1/5] 清理旧文件...
if exist "web_build" rd /s /q "web_build"
if exist "android\app\src\main\assets\public" rd /s /q "android\app\src\main\assets\public"
mkdir web_build
mkdir web_build\static

echo [2/5] 转换 HTML 为静态版本...
:: 使用 PowerShell 精准替换 Flask 标签，确保手机能加载
powershell -Command "(Get-Content 'templates\index.html' -Encoding UTF8) -replace '\{\{ url_for\(''static'', filename=''(.+?)''\) \}\}', 'static/$1' -replace '\?v=[a-zA-Z0-9_]+', '?v=' + (Get-Date -Format 'yyyyMMddHHmmss') | Set-Content 'web_build\index.html' -Encoding UTF8"

echo [3/5] 复制最新静态资源...
xcopy /Y /E static\*.* web_build\static\ >nul

echo [4/5] 同步资源到 Android 项目...
:: 这一步非常关键，确保 Capacitor 拿到的是 web_build 里的新文件
call npx cap copy android
if %ERRORLEVEL% NEQ 0 (
    echo ⚠️ npx copy 失败，尝试手动复制...
    xcopy /Y /E web_build\*.* android\app\src\main\assets\public\ >nul
)

echo [5/5] 开始编译 APK...
cd android
call gradlew.bat clean assembleDebug
cd ..

echo.
echo ================================================
echo    构建完成！
echo ================================================
echo.

set "APK_PATH=android\app\build\outputs\apk\debug\app-debug.apk"
set "NEW_APK_NAME=天纪算命_修复版_%date:~0,4%%date:~5,2%%date:~8,2%.apk"

if exist "%APK_PATH%" (
    copy /Y "%APK_PATH%" "%NEW_APK_NAME%" >nul
    echo ✅ 新 APK 已生成: %NEW_APK_NAME%
    echo.
    echo 👉 请卸载手机上的旧版本，然后安装此版本！
    echo.
    explorer /select,"%NEW_APK_NAME%"
) else (
    echo ❌ APK 生成失败，请检查日志。
)

pause
