@echo off
chcp 65001 >nul
echo ================================================
echo    天纪算命 - 一键生成 APK
echo ================================================
echo.

echo [1/4] 检查 Java 环境...
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

for /d %%i in ("D:\Program Files\Eclipse Adoptium\jdk*") do (
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

:: 如果都没找到
echo ❌ 找不到 Java！
echo.
echo 请手动操作：
echo 1. 打开 PowerShell（管理员）
echo 2. 运行以下命令：
echo.
echo    cd d:\D\国学\suanming\suanming_app\android
echo    $env:JAVA_HOME = "D:\Program Files\Android\Android Studio\jbr"
echo    .\gradlew.bat assembleRelease
echo.
echo 如果 Java 安装在其他位置，请修改 JAVA_HOME 路径
echo 常见 D 盘路径：
echo   - D:\Program Files\Java\jdk-17
echo   - D:\Java\jdk-17
echo   - D:\jdk-17
echo.
pause
exit /b 1

:java_found
echo ✅ Java 路径: %JAVA_HOME%
set "PATH=%JAVA_HOME%\bin;%PATH%"
echo.

echo [2/4] 检查项目是否存在...
if not exist "android\gradlew.bat" (
    echo ❌ 找不到 Android 项目！
    echo 请确保已经运行过 "npx cap add android"
    echo.
    pause
    exit /b 1
)
echo ✅ 项目文件正常
echo.

echo [3/4] 开始编译 APK...
echo 这将需要 5-10 分钟，请耐心等待...
echo 编译过程中会显示很多英文信息（正常现象）
echo.

cd android
call gradlew.bat assembleRelease

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ================================================
    echo ❌ 编译失败！
    echo ================================================
    echo.
    echo 常见问题：
    echo 1. 网络问题：首次编译需要下载很多依赖
    echo 2. Java 版本问题：需要 JDK 17+
    echo 3. 路径问题：已通过配置文件解决
    echo.
    echo 建议：在 Android Studio 中手动生成 APK
    echo.
    pause
    exit /b 1
)

echo.
echo ================================================
echo [4/4] ✅ APK 编译成功！
echo ================================================
echo.

:: 检查是否生成了未签名版本
if exist "app\build\outputs\apk\release\app-release-unsigned.apk" (
    echo APK 文件：app-release-unsigned.apk
    echo 完整路径：
    echo %cd%\app\build\outputs\apk\release\app-release-unsigned.apk
    echo.
    echo ⚠️ 此 APK 未签名，安装时手机会提示"未知来源"
    echo    点击"仍然安装"即可正常使用
) else if exist "app\build\outputs\apk\release\app-release.apk" (
    echo APK 文件：app-release.apk
    echo 完整路径：
    echo %cd%\app\build\outputs\apk\release\app-release.apk
) else (
    echo ⚠️ 找不到 APK 文件，但编译成功了
    echo 请手动查看：android\app\build\outputs\apk\release\
)

echo.
echo 按任意键打开 APK 所在文件夹...
pause >nul

if exist "app\build\outputs\apk\release" (
    explorer app\build\outputs\apk\release
)

echo.
echo ================================================
echo 完成！将 APK 传到手机即可安装使用。
echo ================================================
pause
