@echo off
chcp 65001 >nul
echo ================================================
echo    天纪算命 - 生成手机安装包 (最终版)
echo ================================================
echo.

echo [1/4] 同步最新代码...
if not exist "web_build" mkdir web_build
if not exist "web_build\static" mkdir web_build\static
xcopy /Y /E templates\index.html web_build\ >nul
xcopy /Y /E static\*.* web_build\static\ >nul
echo ✅ 代码同步完成
echo.

echo [2/4] 查找编译环境...
set "JAVA_HOME="
if exist "D:\Program Files\Android\Android Studio\jbr" set "JAVA_HOME=D:\Program Files\Android\Android Studio\jbr"
if exist "C:\Program Files\Android\Android Studio\jbr" set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"

if "%JAVA_HOME%"=="" (
    echo ❌ 未找到 Java 环境，请确认 Android Studio 已安装
    pause
    exit /b 1
)
set "PATH=%JAVA_HOME%\bin;%PATH%"
echo ✅ 环境检查通过

echo.
echo [3/4] 开始编译 (约 2-3 分钟)...
cd android
call gradlew.bat assembleDebug >nul

if %ERRORLEVEL% NEQ 0 (
    echo ❌ 编译失败，请检查日志
    cd ..
    pause
    exit /b 1
)
cd ..

echo.
echo [4/4] 处理安装包...
set "SOURCE_APK=android\app\build\outputs\apk\debug\app-debug.apk"
set "DEST_APK=天纪算命_最新版.apk"

if exist "%SOURCE_APK%" (
    copy /Y "%SOURCE_APK%" "%DEST_APK%" >nul
    echo.
    echo ================================================
    echo ✅ 生成成功！
    echo ================================================
    echo.
    echo 文件名: %DEST_APK%
    echo 位置:   %CD%\%DEST_APK%
    echo.
    echo 👉 请将此文件发送到手机即可安装！
    echo.
    explorer /select,"%DEST_APK%"
) else (
    echo ❌ 未找到生成的 APK 文件
)

pause
