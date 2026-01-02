# 天纪算命 - Android 手动打包详细步骤

## 前置要求安装

### 1. 安装 Node.js（必需）
- 访问：https://nodejs.org/
- 下载：LTS 版本（推荐 20.x）
- 安装：一路 Next，记得勾选"Add to PATH"
- 验证：打开新的命令行窗口，运行 `node -v` 和 `npm -v`

### 2. 安装 JDK 17+（必需）
- 访问：https://www.oracle.com/java/technologies/downloads/
- 下载：Java SE Development Kit 17 或更高版本
- 安装：配置 JAVA_HOME 环境变量
- 验证：`java -version`

### 3. 安装 Android Studio（必需）
- 访问：https://developer.android.com/studio
- 下载：最新稳定版
- 安装组件：
  - Android SDK
  - Android SDK Platform
  - Android Virtual Device（可选，用于模拟器测试）
- 配置 ANDROID_HOME 环境变量

---

## 打包步骤

安装完上述工具后，请执行以下命令：

### 步骤 1: 初始化 Node.js 项目
```bash
cd d:\D\国学\suanming\suanming_app
npm init -y
```

### 步骤 2: 安装 Capacitor
```bash
npm install @capacitor/core @capacitor/cli
npm install @capacitor/android
```

### 步骤 3: 初始化 Capacitor（需要我帮您配置）
运行命令后我会帮您创建配置文件

### 步骤 4: 添加 Android 平台
```bash
npx cap add android
```

### 步骤 5: 同步资源
```bash
npx cap sync
```

### 步骤 6: 在 Android Studio 中编译
```bash
npx cap open android
```

然后在 Android Studio 中：
- Build > Generate Signed Bundle / APK
- 选择 APK
- 创建密钥库（首次）
- 生成 APK

---

## 当前状态

请先完成以下安装：
☐ Node.js (https://nodejs.org/)
☐ JDK 17+ (https://www.oracle.com/java/technologies/downloads/)
☐ Android Studio (https://developer.android.com/studio)

安装完成后，在新的命令行窗口运行：
```bash
node -v
npm -v
java -version
```

确认都能正常显示版本号，然后告诉我，我会继续下一步！
