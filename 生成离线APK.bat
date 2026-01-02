@echo off
chcp 65001 >nul
echo ================================================
echo    天纪算命 - 生成完全离线版 APK
echo ================================================
echo.

echo [1/4] 检查 Java 环境...
set "JAVA_HOME="

if exist "D:\Program Files\Android\Android Studio\jbr" (
    set "JAVA_HOME=D:\Program Files\Android\Android Studio\jbr"
    goto :java_found
)

for /d %%i in ("D:\Program Files\Java\jdk*") do (
    set "JAVA_HOME=%%i"
    goto :java_found
)

for /d %%i in ("D:\Java\jdk*") do (
    set "JAVA_HOME=%%i"
    goto :java_found
)

if exist "C:\Program Files\Android\Android Studio\jbr" (
    set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"
    goto :java_found
)

for /d %%i in ("C:\Program Files\Java\jdk*") do (
    set "JAVA_HOME=%%i"
    goto :java_found
)

echo ❌ 找不到 Java
pause
exit /b 1

:java_found
echo ✅ Java: %JAVA_HOME%
set "PATH=%JAVA_HOME%\bin;%PATH%"
echo.

echo [2/4] 同步离线资源...
call npx cap sync
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 同步失败
    pause
    exit /b 1
)
echo ✅ 同步完成
echo.

echo [3/4] 编译 APK...
echo 请耐心等待 3-5 分钟...
echo.

cd android
call gradlew.bat assembleDebug

if %ERRORLEVEL% NEQ 0 (
    echo ❌ 编译失败
    pause
    exit /b 1
)

echo.
echo ================================================
echo [4/4] ✅ 离线版 APK 生成成功！
echo ================================================
echo.
echo APK 位置：
echo %cd%\app\build\outputs\apk\debug\app-debug.apk
echo.
echo 此版本为【完全离线版】：
echo 1. 不需要连接电脑
echo 2. 不需要联网
echo 3. 随时随地可用
echo.
echo 请将 app-debug.apk 传到手机安装即可。
echo.

pause
explorer app\build\outputs\apk\debug
