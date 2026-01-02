@echo off
chcp 65001 >nul
echo ================================================
echo    天纪算命 - Android APK 自动打包脚本
echo ================================================
echo.

echo [1/5] 检查 Node.js 环境...
node -v
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 错误：Node.js 未找到！
    echo 请重启命令行窗口后再试
    pause
    exit /b 1
)

npm -v
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 错误：npm 未找到！
    pause
    exit /b 1
)
echo ✅ Node.js 环境正常
echo.

echo [2/5] 安装 Capacitor 依赖...
echo 这可能需要 2-3 分钟，请稍候...
call npm install @capacitor/core @capacitor/cli @capacitor/android
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 依赖安装失败！
    pause
    exit /b 1
)
echo ✅ Capacitor 依赖安装成功
echo.

echo [3/5] 添加 Android 平台...
call npx cap add android
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Android 平台添加失败！
    pause
    exit /b 1
)
echo ✅ Android 平台添加成功
echo.

echo [4/5] 同步资源文件...
call npx cap sync
if %ERRORLEVEL% NEQ 0 (
    echo ❌ 资源同步失败！
    pause
    exit /b 1
)
echo ✅ 资源同步成功
echo.

echo [5/5] 准备打开 Android Studio...
echo.
echo ================================================
echo ✅ 所有配置完成！
echo ================================================
echo.
echo 接下来将打开 Android Studio。
echo 请在 Android Studio 中：
echo   1. 等待 Gradle 同步完成（约 5-10 分钟）
echo   2. Build ^> Generate Signed Bundle / APK
echo   3. 选择 APK ^> 创建签名密钥 ^>  生成
echo.
echo 按任意键打开 Android Studio...
pause >nul

call npx cap open android
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ⚠️ 自动打开失败，请手动操作：
    echo 1. 打开 Android Studio
    echo 2. 选择 Open an Existing Project
    echo 3. 选择目录: %cd%\android
    echo.
)

echo.
echo 脚本执行完毕！
pause
