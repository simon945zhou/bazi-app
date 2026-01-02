@echo off
chcp 65001 >nul
echo ================================================
echo    生成电脑预览版 (Preview)
echo ================================================
echo.

set "SRC_HTML=templates\index.html"

echo.
echo ✅ 预览已在浏览器中打开！
echo 文件位置: web_build\preview.html
echo.
pause
