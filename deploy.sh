#!/bin/bash

echo "================================================"
echo "   天纪算命 - 快速部署到云服务器"
echo "================================================"
echo ""

# 1. 更新系统
echo "📦 步骤 1: 更新系统包..."
sudo apt-get update
sudo apt-get upgrade -y

# 2. 安装 Python3 和 pip
echo "🐍 步骤 2: 安装 Python 环境..."
sudo apt-get install -y python3 python3-pip python3-venv

# 3. 创建虚拟环境
echo "🔧 步骤 3: 创建虚拟环境..."
python3 -m venv venv
source venv/bin/activate

# 4. 安装依赖
echo "📚 步骤 4: 安装项目依赖..."
pip install -r requirements.txt
pip install gunicorn

# 5. 测试运行
echo "🧪 步骤 5: 测试应用..."
echo "启动测试服务器（Ctrl+C 停止）..."
python app.py &
sleep 5
curl http://localhost:5000
kill %1

# 6. 配置 Gunicorn
echo "⚙️ 步骤 6: 配置 Gunicorn..."
cat > gunicorn_config.py << EOF
bind = "0.0.0.0:5000"
workers = 4
worker_class = "sync"
timeout = 120
accesslog = "access.log"
errorlog = "error.log"
EOF

# 7. 创建系统服务
echo "🔐 步骤 7: 创建系统服务..."
sudo tee /etc/systemd/system/tianji-bazi.service > /dev/null << EOF
[Unit]
Description=Tianji Bazi Fortune Telling App
After=network.target

[Service]
User=$USER
WorkingDirectory=$(pwd)
Environment="PATH=$(pwd)/venv/bin"
ExecStart=$(pwd)/venv/bin/gunicorn -c gunicorn_config.py app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 8. 启动服务
echo "🚀 步骤 8: 启动服务..."
sudo systemctl daemon-reload
sudo systemctl enable tianji-bazi
sudo systemctl start tianji-bazi
sudo systemctl status tianji-bazi

echo ""
echo "================================================"
echo "✅ 部署完成！"
echo "================================================"
echo ""
echo "服务已在后台运行，访问地址："
echo "http://$(hostname -I | cut -d' ' -f1):5000"
echo ""
echo "管理命令："
echo "  启动服务: sudo systemctl start tianji-bazi"
echo "  停止服务: sudo systemctl stop tianji-bazi"
echo "  重启服务: sudo systemctl restart tianji-bazi"
echo "  查看状态: sudo systemctl status tianji-bazi"
echo "  查看日志: tail -f access.log error.log"
echo ""
echo "下一步：配置 Nginx 和 HTTPS（可选）"
echo "================================================"
