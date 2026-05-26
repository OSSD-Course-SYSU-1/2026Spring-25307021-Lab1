@echo off
echo ============================================
echo 音乐应用运行脚本
echo ============================================
echo.

echo 1. 检查模拟器状态...
netstat -ano | findstr :5555 >nul
if %errorlevel% equ 0 (
    echo [✓] 模拟器正在运行 (127.0.0.1:5555)
) else (
    echo [✗] 模拟器未运行
    echo 请先启动DevEco Studio模拟器
    pause
    exit /b 1
)

echo.
echo 2. 检查应用构建状态...
if exist "products\phone\build\default\outputs\default\phone-default-unsigned.hap" (
    echo [✓] 应用已构建完成
    for %%F in ("products\phone\build\default\outputs\default\phone-default-unsigned.hap") do (
        echo    文件大小: %%~zF 字节
        echo    修改时间: %%~tF
    )
) else (
    echo [✗] 应用未构建
    echo 请在DevEco Studio中构建应用
)

echo.
echo 3. 启动DevEco Studio...
if exist "D:\eco\DevEco Studio\bin\devecostudio64.exe" (
    echo [✓] 找到DevEco Studio
    echo 正在启动DevEco Studio并打开项目...
    start "" "D:\eco\DevEco Studio\bin\devecostudio64.exe" "D:\huawei\MusicHome-master"
) else (
    echo [✗] 未找到DevEco Studio
    echo 请手动启动DevEco Studio并打开项目
)

echo.
echo ============================================
echo 操作说明：
echo 1. 在DevEco Studio中，选择 'phone' 模块
echo 2. 点击绿色运行按钮 (或按 Shift+F10)
echo 3. 选择模拟器设备 (127.0.0.1:5555)
echo 4. 等待应用部署到模拟器
echo ============================================
echo.

echo 新增功能清单：
echo [✓] 音乐榜单功能 (features/musiccharts/)
echo [✓] 听歌历史功能 (features/userprofile/)
echo [✓] 测试页面 (products/phone/src/main/ets/pages/TestPage.ets)
echo.

echo 按任意键查看详细说明...
pause >nul

start notepad "如何在DevEco Studio中运行应用.md"

echo.
echo 脚本执行完成！
pause