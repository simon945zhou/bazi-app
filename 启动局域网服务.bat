@echo off
chcp 65001
title 天纪算命 - 局域网服务
cls

echo =======================================================
echo           天纪算命 - iPhone/iPad 安装服务
echo =======================================================
echo.
echo 正在启动局域网服务...
echo.

:: 获取本机IP
for /f "tokens=16" %%i in ('ipconfig ^| findstr /i "ipv4"') do set ip=%%i

echo -------------------------------------------------------
echo  请使用 iPhone/iPad 的 Safari 浏览器访问以下地址：
echo.
echo      http://%ip%:8000
echo.
echo -------------------------------------------------------
echo.
echo  【安装步骤】：
echo  1. 在 Safari 中打开上面的网址。
echo  2. 点击底部中间的【分享按钮】(带箭头的方框)。
echo  3. 向下滑动，点击【添加到主屏幕】。
echo  4. 点击右上角的【添加】。
echo.
echo  完成后，桌面上就会出现【天纪算命】的图标，点击即可使用！
echo.
echo  (注意：请保持此窗口开启，直到您在手机上打开网页)
echo.

cd web_build
python -m http.server 8000
pause
