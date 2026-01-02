# 天纪算命 - Android APK 自动打包脚本
# PowerShell 版本

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "   天纪算命 - Android APK 自动打包脚本" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# 1. 检查环境
Write-Host "[1/5] 检查 Node.js 环境..." -ForegroundColor Yellow
try {
    $nodeVersion = node -v
    $npmVersion = npm -v
    Write-Host "✅ Node.js: $nodeVersion" -ForegroundColor Green
    Write-Host "✅ npm: $npmVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ 错误：Node.js 未找到！请重启 PowerShell 后再试" -ForegroundColor Red
    Read-Host "按 Enter 键退出"
    exit 1
}
Write-Host ""

# 2. 安装依赖
Write-Host "[2/5] 安装 Capacitor 依赖..." -ForegroundColor Yellow
Write-Host "这可能需要 2-3 分钟，请稍候..." -ForegroundColor Gray
npm install @capacitor/core @capacitor/cli @capacitor/android
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ 依赖安装失败！" -ForegroundColor Red
    Read-Host "按 Enter 键退出"
    exit 1
}
Write-Host "✅ Capacitor 依赖安装成功" -ForegroundColor Green
Write-Host ""

# 3. 添加 Android 平台
Write-Host "[3/5] 添加 Android 平台..." -ForegroundColor Yellow
npx cap add android
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Android 平台添加失败！" -ForegroundColor Red
    Read-Host "按 Enter 键退出"
    exit 1
}
Write-Host "✅ Android 平台添加成功" -ForegroundColor Green
Write-Host ""

# 4. 同步资源
Write-Host "[4/5] 同步资源文件..." -ForegroundColor Yellow
npx cap sync
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ 资源同步失败！" -ForegroundColor Red
    Read-Host "按 Enter 键退出"
    exit 1
}
Write-Host "✅ 资源同步成功" -ForegroundColor Green
Write-Host ""

# 5. 打开 Android Studio
Write-Host "[5/5] 准备打开 Android Studio..." -ForegroundColor Yellow
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "✅ 所有配置完成！" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "接下来将打开 Android Studio。" -ForegroundColor White
Write-Host "请在 Android Studio 中：" -ForegroundColor White
Write-Host "  1. 等待 Gradle 同步完成（约 5-10 分钟）" -ForegroundColor Gray
Write-Host "  2. Build > Generate Signed Bundle / APK" -ForegroundColor Gray
Write-Host "  3. 选择 APK > 创建签名密钥 > 生成" -ForegroundColor Gray
Write-Host ""
Read-Host "按 Enter 键打开 Android Studio"

npx cap open android
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "⚠️ 自动打开失败，请手动操作：" -ForegroundColor Yellow
    Write-Host "1. 打开 Android Studio" -ForegroundColor Gray
    Write-Host "2. 选择 Open an Existing Project" -ForegroundColor Gray
    Write-Host "3. 选择目录: $(Get-Location)\android" -ForegroundColor Gray
    Write-Host ""
}

Write-Host ""
Write-Host "脚本执行完毕！" -ForegroundColor Green
Read-Host "按 Enter 键退出"
