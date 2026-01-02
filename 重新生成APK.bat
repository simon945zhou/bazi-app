@echo off
chcp 65001 >nul
echo ================================================
echo    快速重新生成 APK（已修复网络连接）
echo ================================================
echo.

echo 已将服务器地址配置为：http://192.168.3.194:5000
echo.
echo ⚠️ 重要提示：
echo 1. 确保电脑上的 Flask 正在运行（python app.py）
echo 2. 确保手机和电脑连接到同一个 WiFi
echo 3. 如果电脑 IP 变化，需要重新修改配置
echo.

echo [1/4] 查找 Java...
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

echo [2/4] 同步配置到 Android 项目...
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
echo [4/4] ✅ 新 APK 生成成功！
echo ================================================
echo.
echo APK 位置：
echo %cd%\app\build\outputs\apk\debug\app-debug.apk
echo.
echo 现在请：
echo 1. 将新的 app-debug.apk 传到手机
echo 2. 卸载旧版本（如果已安装）
echo 3. 安装新版本
echo 4. 确保电脑上运行着：python app.py
echo 5. 确保手机和电脑在同一 WiFi
echo 6. 打开 APP！
echo.

pause
explorer app\build\outputs\apk\debug
