@echo off
REM 检查Python是否已安装
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 未找到Python。请先安装Python 3.6或更高版本。
    pause
    exit /b 1
)

REM 检查并安装依赖
pip install -r requirements.txt >nul 2>&1
if %errorlevel% neq 0 (
    echo 依赖安装失败，尝试使用管理员权限安装...
    echo 请注意：接下来可能会弹出用户账户控制(UAC)提示，请允许以继续。
    pause
    powershell -Command "Start-Process cmd -ArgumentList '/c pip install -r requirements.txt' -Verb RunAs"
)

REM 初始化知识库（首次运行时）
echo 正在初始化知识库...
python initialize_knowledge.py

REM 启动应用程序
echo 正在启动天纪算命系统...
python main_app.py

REM 如果应用程序异常退出，显示错误信息
if %errorlevel% neq 0 (
    echo 应用程序异常退出。
    pause
)
exit /b %errorlevel%