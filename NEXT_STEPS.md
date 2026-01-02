# Android APK 打包 - 下一步操作指南

## ✅ 已完成的配置

我已经为您创建了所有必需的配置文件：

1. ✅ **package.json** - Node.js 项目配置
2. ✅ **capacitor.config.json** - Capacitor 配置（已设置连接到本地后端）
3. ✅ **web_build/** - 打包用的静态文件目录
4. ✅ 复制了所有 HTML、CSS、JS 和图标文件

## 🔧 环境变量问题

当前检测到 Node.js 可能未正确添加到系统 PATH。

### 解决方法：

**方法 1：重启 PowerShell（推荐）**
1. 关闭当前所有 PowerShell 窗口
2. **重新打开 PowerShell**（以管理员身份）
3. 运行以下命令验证：
   ```powershell
   node -v
   npm -v
   ```
4. 如果显示版本号，说明环境变量已生效

**方法 2：手动添加到 PATH**
1. 右键"此电脑" → 属性 → 高级系统设置 → 环境变量
2. 在"系统变量"中找到"Path"，点击编辑
3. 添加：`C:\Program Files\nodejs\`
4. 确定保存，重启 PowerShell

## 📱 接下来的步骤

### 环境变量生效后，请按顺序运行：

```powershell
# 1. 进入项目目录
cd d:\D\国学\suanming\suanming_app

# 2. 安装 Capacitor 依赖
npm install @capacitor/core @capacitor/cli @capacitor/android

# 3. 添加 Android 平台
npx cap add android

# 4. 同步资源文件
npx cap sync

# 5. 在 Android Studio 中打开项目
npx cap open android
```

### 在 Android Studio 中生成 APK：

1. 等待 Gradle 同步完成（首次较慢，5-10 分钟）
2. 点击菜单：**Build** → **Generate Signed Bundle / APK**
3. 选择：**APK**
4. 创建密钥库（首次需要）：
   - Key store path: 选择保存路径
   - Password: 设置密码（记住！）
   - Alias: tianji-bazi
   - Validity: 25 years
5. 点击 Next → Finish
6. 等待编译完成，APK 会保存在 `android/app/build/outputs/apk/release/`

## ⚠️ 重要提示

### 后端服务器设置

当前配置连接到 `http://127.0.0.1:5000`，这意味着：

- ✅ **优点**：打包后的 APK 可以独立安装
- ⚠️ **限制**：使用 app时，Flask 后端必须在同一设备上运行

### 如需连接到远程服务器：

编辑 `capacitor.config.json`，修改 `server.url`：

```json
"server": {
  "url": "http://您的服务器IP:5000",
  "cleartext": true
}
```

然后重新运行 `npx cap sync`。

## 🐛 常见问题

**Q: npm 命令无法识别**
A: 重启 PowerShell 或手动添加 PATH

**Q: Android Studio 同步失败**
A: 检查网络，首次需要下载 Gradle 和依赖包

**Q: APK 编译失败**
A: 确保 JDK 版本 >= 17，JAVA_HOME 已配置

**Q: APK 安装后无法连接**
A: 确保 Flask 后端正在运行，或修改配置连接远程服务器

---

## 📞 下一步行动

1. **重启 PowerShell**
2. 运行 `node -v` 确认环境变量生效
3. 告诉我结果，我会继续协助后续步骤！

如果遇到任何错误，请把错误信息发给我。
