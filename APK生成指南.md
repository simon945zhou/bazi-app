# 天纪算命 APK 一键生成指南

## 🚀 最简单的方法（推荐）

### 方法 1：使用自动脚本

1. 打开文件夹：`d:\D\国学\suanming\suanming_app`
2. **双击运行**：`一键生成APK.bat`
3. 等待 5-10 分钟
4. 完成后会自动打开 APK 所在文件夹
5. 将 **`app-release-unsigned.apk`** 传到手机安装即可

**注意**：此 APK 未签名，安装时手机可能提示"未知来源"，点击"仍然安装"即可。

---

### 方法 2：在 Android Studio 中生成（签名版，更正式）

**在 Android Studio 中**：

1. 点击菜单：**Build** → **Generate Signed Bundle / APK**

2. 选择：**APK** → Next

3. **创建密钥**：
   - 点击 **Create new...**
   - Key store path: 桌面 `tianji.jks`
   - Password: `tianji2024`（记住！）
   - Alias: `tianji`
   - Validity: `25` 年
   - 填写任意信息
   - 点击 OK

4. **签名配置**：
   - 确认信息
   - Next

5. **构建类型**：
   - 勾选 **release**
   - 勾选 **V1** 和 **V2** 签名
   - Finish

6. **等待编译**（3-5 分钟）

7. **获取 APK**：
   - 点击弹出的 **locate** 链接
   - 或到：`android\app\build\outputs\apk\release\`
   - 文件：**`app-release.apk`**（已签名）

---

## 📱 安装到手机

### 步骤：

1. 将 APK 文件传到手机（微信、QQ、数据线等）
2. 在手机上找到 APK 文件
3. 点击安装
4. 如提示"未知来源"：
   - 点击"设置"
   - 允许安装未知应用
   - 返回继续安装
5. 安装完成！

---

## ⚠️ 重要提示

### APK 使用限制

当前生成的 APK 需要：
- ✅ 可以独立安装到手机
- ⚠️ **使用时需要 Flask 后端正在运行**：
  - 在电脑上运行 `python app.py`
  - 手机和电脑在同一 WiFi
  - 或将后端部署到云服务器

### 如需完全离线的 APK

需要将 Python 后端也打包进 APK（更复杂）：
- 使用 Chaquopy 框架（需重新开发）
- 或使用 Kivy/BeeWare（需完全重写）

---

## 🎯 推荐执行

**双击运行 `一键生成APK.bat`**，最简单快速！

如果脚本运行失败，请：
1. 截图错误信息给我
2. 或使用 Android Studio 手动生成（更稳定）
