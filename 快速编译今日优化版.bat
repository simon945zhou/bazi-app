@echo off
chcp 65001 >nul
echo ================================================
echo    天纪算命 - 快速重新编译APK（今日优化版）
echo ================================================
echo.

echo [1/3] 同步最新代码到 web_build...
xcopy /Y /E templates\index.html web_build\
xcopy /Y /E static\*.* web_build\static\
echo ✅ 代码同步完成
echo.

echo [2/3] 查找 Java...
set "JAVA_HOME="

:: 检查 D 盘的 Android Studio 自带的 JDK
if exist "D:\Program Files\Android\Android Studio\jbr" (
    set "JAVA_HOME=D:\Program Files\Android\Android Studio\jbr"
    goto :java_found
)

:: 检查 C 盘
if exist "C:\Program Files\Android\Android Studio\jbr" (
    set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"
    goto :java_found
)

echo ❌ 找不到 Java！
pause
exit /b 1

:java_found
echo ✅ Java: %JAVA_HOME%
set "PATH=%JAVA_HOME%\bin;%PATH%"
echo.

echo [3/3] 编译 APK（约3-5分钟）...
cd android
call gradlew.bat assembleDebug

if %ERRORLEVEL% NEQ 0 (
    echo ❌ 编译失败！
    pause
    exit /b 1
)

echo.
echo ================================================
echo ✅ APK 编译成功！
echo ================================================
echo.

if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo APK 位置：
    echo %cd%\app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo 打开文件夹...
    explorer app\build\outputs\apk\debug
) else (
    echo ⚠️ 找不到 APK 文件
)

pause
