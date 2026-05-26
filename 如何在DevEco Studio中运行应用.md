# 如何在DevEco Studio中运行音乐应用

## 步骤1：启动DevEco Studio
1. DevEco Studio已自动启动
2. 如果未启动，请手动运行：`D:\eco\DevEco Studio\bin\devecostudio64.exe`
3. 打开项目：`D:\huawei\MusicHome-master`

## 步骤2：选择运行配置
1. 在DevEco Studio顶部工具栏，找到运行按钮
2. 确保选择`phone`模块
3. 选择模拟器设备（应该是`127.0.0.1:5555`）

## 步骤3：运行应用
1. 点击绿色运行按钮（▶️）
2. 或者使用快捷键：`Shift + F10`
3. 等待应用构建和部署

## 步骤4：验证新功能
应用已成功添加以下新功能：

### ✅ 音乐榜单功能
- 热门榜
- 新歌榜  
- 飙升榜
- 实时数据刷新
- 响应式设计

### ✅ 听歌历史功能
- 最近播放记录
- 收藏歌曲管理
- 播放统计数据
- 筛选和排序功能

## 步骤5：测试页面
应用中包含一个测试页面，可用于验证所有功能：
1. 在模拟器中打开应用
2. 点击"音乐榜单"按钮测试榜单功能
3. 点击"听歌历史"按钮测试历史功能

## 模拟器状态
- 模拟器已在运行（端口5555监听）
- 应用已成功构建（HAP文件已生成）
- 所有新增功能模块已集成

## 文件位置
- 构建输出：`products/phone/build/default/outputs/default/phone-default-unsigned.hap`
- 测试页面：`products/phone/src/main/ets/pages/TestPage.ets`
- 音乐榜单模块：`features/musiccharts/`
- 用户历史模块：`features/userprofile/`

## 问题排查
如果遇到问题：
1. 检查模拟器是否正常运行
2. 确认构建配置正确
3. 查看DevEco Studio的日志输出
4. 确保所有依赖模块已正确配置

## 成功标志
- 应用在模拟器中成功启动
- 可以正常访问音乐榜单页面
- 可以正常访问听歌历史页面
- 所有按钮和功能正常工作