# 手动执行指南 - 逐步运行命令

请按照以下步骤，在**新的 PowerShell 窗口**中逐条执行：

## 步骤 1: 打开新的 PowerShell
1. 按 Win + X
2. 选择"Windows PowerShell (管理员)"或"终端 (管理员)"

## 步骤 2: 进入项目目录
```powershell
cd d:\D\国学\suanming\suanming_app
```

## 步骤 3: 验证 Node.js
```powershell
node -v
npm -v
```
**预期结果**: 应该显示 v24.11.1 和 11.6.2

如果显示"找不到命令"，说明环境变量问题，需要完全重启电脑。

## 步骤 4: 安装 Capacitor（约 2-3 分钟）
```powershell
npm install @capacitor/core @capacitor/cli @capacitor/android
```

**等待安装完成**，会显示很多下载信息。

## 步骤 5: 添加 Android 平台
```powershell
npx cap add android
```

## 步骤 6: 同步资源
```powershell
npx cap sync
```

## 步骤 7: 打开 Android Studio
```powershell
npx cap open android
```

---

## 如果任何步骤出错：
请复制完整的红色错误信息发给我！

## 如果步骤 3 就失败（找不到 node）：
说明需要重启电脑让环境变量生效。
