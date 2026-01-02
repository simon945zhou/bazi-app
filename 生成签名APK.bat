@echo off
chcp 65001 >nul
echo ================================================
echo    天纪算命 - 生成可安装的 APK (Debug 版本)
echo ================================================
echo.

echo [1/3] 检查 Java 环境...
echo.

:: 尝试多个可能的 Java 路径
set "JAVA_HOME="

:: 检查 D 盘的 Android Studio 自带的 JDK
if exist "D:\Program Files\Android\Android Studio\jbr" (
    set "JAVA_HOME=D:\Program Files\Android\Android Studio\jbr"
    goto :java_found
)

:: 检查 D 盘的系统安装的 JDK
for /d %%i in ("D:\Program Files\Java\jdk*") do (
    set "JAVA_HOME=%%i"
    goto :java_found
)

for /d %%i in ("D:\Java\jdk*") do (
    set "JAVA_HOME=%%i"
    goto :java_found
)

for /d %%i in ("D:\jdk*") do (
    set "JAVA_HOME=%%i"
    goto :java_found
)

:: 如果 D 盘没找到，再检查 C 盘
if exist "C:\Program Files\Android\Android Studio\jbr" (
    set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"
    goto :java_found
)

for /d %%i in ("C:\Program Files\Java\jdk*") do (
    set "JAVA_HOME=%%i"
    goto :java_found
)

echo ❌ 找不到 Java！
echo 请在 Android Studio 中手动生成：
echo Build ^> Build Bundle(s) / APK(s) ^> Build APK(s)
echo.
pause
exit /b 1

:java_found
echo ✅ Java 路径: %JAVA_HOME%
set "PATH=%JAVA_HOME%\bin;%PATH%"
echo.

echo [2/3] 生成 Debug 签名版 APK...
echo Debug 版本会自动使用 Android 调试签名
echo 这将需要 3-5 分钟，请耐心等待...
echo.

cd android
call gradlew.bat assembleDebug

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ❌ 编译失败！
    echo.
    pause
    exit /b 1
)

echo.
echo ================================================
echo [3/3] ✅ APK 生成成功！
echo ================================================
echo.

if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo ✅ APK 文件：app-debug.apk
    echo 完整路径：
    echo %cd%\app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo ✅ 此 APK 已签名，可以直接安装！
    echo.
    echo 按任意键打开 APK 所在文件夹...
    pause >nul
    explorer app\build\outputs\apk\debug
) else (
    echo ⚠️ 找不到 APK 文件
    echo 请手动查看：android\app\build\outputs\apk\debug\
    pause
)

echo.
echo ================================================
echo 完成！将 app-debug.apk 传到手机安装即可。
echo ================================================
pause
