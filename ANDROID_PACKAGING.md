# Android APK 打包指南

由于您的系统未安装 Node.js/npm，我提供两种打包方案：

## 方案 1：在线打包服务（最简单，推荐）⭐

### 使用 PWABuilder（微软官方）

1. **访问**: [https://www.pwabuilder.com/](https://www.pwabuilder.com/)

2. **输入网址**: 
   - 先将您的应用部署到公网（见下方"部署指南"）
   - 在 PWABuilder 输入您的公网地址
   
3. **生成 APK**:
   - 点击 "Build My PWA"
   - 选择 "Android" 平台
   - 下载生成的 APK 文件

4. **安装到手机**:
   - 将 APK 传输到 Android 手机
   - 开启"允许安装未知来源应用"
   - 点击 APK 安装

### 优点：
- ✅ 无需安装任何开发工具
- ✅ 全自动化，3 分钟完成
- ✅ 支持 Google Play 上架

---

## 方案 2：手动打包（需要安装工具）

### 前置要求：
1. 安装 **Node.js**: [https://nodejs.org/](https://nodejs.org/) (下载 LTS 版本)
2. 安装 **Android Studio**: [https://developer.android.com/studio](https://developer.android.com/studio)
3. 配置 **Java JDK 17+**

### 打包步骤：

```bash
# 1. 安装 Capacitor CLI
npm install -g @capacitor/cli

# 2. 在项目目录初始化 Capacitor
cd d:\D\国学\suanming\suanming_app
npm init -y
npm install @capacitor/core @capacitor/cli
npx cap init "天纪算命" "com.tianji.bazi" --web-dir="templates"

# 3. 添加 Android 平台
npm install @capacitor/android
npx cap add android

# 4. 配置后端地址（修改 capacitor.config.json）
# 将 "server": { "url": "http://你的服务器IP:5000" }

# 5. 同步文件
npx cap sync

# 6. 打开 Android Studio 编译
npx cap open android

# 7. 在 Android Studio 中：
#    - Build > Generate Signed Bundle / APK
#    - 选择 APK
#    - 创建签名密钥
#    - 生成 Release APK
```

---

## 部署后端到云服务器

### 方案 A：使用内网穿透（临时测试）

```bash
# 安装 ngrok
# 到 https://ngrok.com/ 注册并下载

# 运行穿透
ngrok http 5000

# 会得到一个公网地址，如：https://xxxx.ngrok.io
# 将此地址用于打包
```

### 方案 B：云服务器部署（永久方案）

1. **购买云服务器**（阿里云/腾讯云，最低配置即可）

2. **上传代码**：
```bash
# 在服务器上
git clone 你的仓库
# 或使用 FTP 上传整个项目文件夹
```

3. **安装依赖**：
```bash
cd suanming_app
pip3 install -r requirements.txt
```

4. **使用 Gunicorn 运行**：
```bash
pip3 install gunicorn
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

5. **配置 Nginx 反向代理**（可选，用于 HTTPS）

6. **配置域名**（可选）

---

## 纯离线 APK 方案（高级）

如果想让 APK **完全独立运行**（不依赖服务器），需要：

1. 使用 **Chaquopy** 将 Python 代码嵌入 Android
2. 或使用 **BeeWare** / **Kivy** 重新开发原生应用

这需要较多的开发工作，建议先使用方案 1 快速测试效果。

---

## 推荐流程（最快上手）

1. ✅ 使用 **ngrok** 将本地服务暴露到公网（5 分钟）
2. ✅ 访问 **PWABuilder.com** 输入 ngrok 地址（3 分钟）
3. ✅ 下载生成的 APK 并安装到手机（2 分钟）

总计：**10 分钟内完成！**

---

需要我帮您执行哪个方案？如果选择方案 2，请先安装 Node.js 后告诉我。
