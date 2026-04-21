# 多设备音乐界面开发指南

## 📋 目录

- [项目概述](#项目概述)
- [技术架构](#技术架构)
- [开发环境配置](#开发环境配置)
- [项目结构详解](#项目结构详解)
- [核心功能实现](#核心功能实现)
- [多设备适配方案](#多设备适配方案)
- [开发规范](#开发规范)
- [常见问题](#常见问题)

## 项目概述

本项目是一个基于 HarmonyOS 开发的多设备音乐播放应用，采用自适应和响应式布局，实现一次开发、多端部署。支持直板机、双折叠设备、平板和智能穿戴设备。

### 主要特性

- ✅ 多设备自适应布局
- ✅ 音乐播放控制
- ✅ 歌词显示功能
- ✅ 音乐评论功能
- ✅ 直播页面展示

## 技术架构

### 分层架构设计

```
┌─────────────────────────────────────┐
│        产品定制层 (Products)          │
│   phone / watch 设备特定实现          │
├─────────────────────────────────────┤
│        基础特性层 (Features)          │
│   live / musicComment / musicList    │
├─────────────────────────────────────┤
│        公共能力层 (Common)            │
│   constantsCommon / mediaCommon      │
└─────────────────────────────────────┘
```

### 技术栈

- **开发语言**: ArkTS
- **UI框架**: ArkUI
- **布局方案**: 栅格布局 + 响应式布局
- **状态管理**: @State, @Prop, @Link 等装饰器

## 开发环境配置

### 环境要求

| 工具 | 版本要求 |
|------|---------|
| DevEco Studio | 6.0.2 Release 及以上 |
| HarmonyOS SDK | 6.0.2 Release SDK 及以上 |
| HarmonyOS 系统 | 5.1.0 Release 及以上 |

### 配置步骤

1. 安装 DevEco Studio
2. 配置 HarmonyOS SDK
3. 打开项目并同步依赖
4. 选择目标设备进行调试

## 项目结构详解

### 公共能力层 (Common)

```
common/
├── constantsCommon/          # 公共常量
│   └── src/main/ets/constants/
└── mediaCommon/              # 公共媒体方法
    └── src/main/ets/
        ├── utils/            # 工具类
        └── viewmodel/        # 视图模型
```

### 基础特性层 (Features)

```
features/
├── live/                     # 直播功能模块
│   ├── constants/            # 常量定义
│   ├── view/                 # 视图组件
│   └── viewmodel/            # 业务逻辑
├── musicComment/             # 音乐评论模块
└── musicList/                # 歌曲列表模块
    ├── components/           # 子组件
    ├── lyric/                # 歌词处理
    ├── view/                 # 视图组件
    └── viewmodel/            # 业务逻辑
```

### 产品定制层 (Products)

```
products/
├── phone/                    # 手机/平板设备
│   ├── common/               # 公共组件
│   ├── pages/                # 页面
│   └── viewmodel/            # 视图模型
└── watch/                    # 智能穿戴设备
    ├── pages/                # 页面
    └── view/                 # 视图组件
```

## 核心功能实现

### 1. 音乐播放控制

```typescript
// 播放控制示例
@Component
struct PlayerControls {
  @State isPlaying: boolean = false

  build() {
    Row() {
      // 上一首
      Button($r('app.media.ic_previous'))
        .onClick(() => this.playPrevious())
      
      // 播放/暂停
      Button(this.isPlaying ? $r('app.media.ic_pause') : $r('app.media.ic_play'))
        .onClick(() => this.togglePlay())
      
      // 下一首
      Button($r('app.media.ic_next'))
        .onClick(() => this.playNext())
    }
  }
}
```

### 2. 响应式布局实现

```typescript
// 使用栅格布局监听断点变化
GridRow({
  columns: {
    sm: 4,   // 小屏设备
    md: 8,   // 中屏设备
    lg: 12   // 大屏设备
  },
  onBreakpointChange: (breakpoint: string) => {
    this.currentBreakpoint = breakpoint
  }
}) {
  // 根据断点显示不同布局
}
```

### 3. 歌词显示

```typescript
@Component
struct LyricView {
  @Prop lyrics: LyricLine[]
  @State currentLine: number = 0

  build() {
    List() {
      ForEach(this.lyrics, (line: LyricLine, index: number) => {
        ListItem() {
          Text(line.content)
            .fontColor(index === this.currentLine ? Color.Blue : Color.Black)
        }
      })
    }
  }
}
```

## 多设备适配方案

### 设备类型判断

| 设备类型 | 断点范围 | 布局特点 |
|---------|---------|---------|
| 智能穿戴 | - | 圆形表盘，简化UI |
| 直板机 | sm | 单列布局 |
| 双折叠 | md | 双列布局 |
| 平板 | lg | 多列布局，侧边栏 |

### 自适应布局技巧

1. **使用 Blank 组件**
   ```typescript
   Row() {
     Text('左侧')
     Blank()  // 自动填充空白区域
     Text('右侧')
   }
   ```

2. **使用百分比布局**
   ```typescript
   Column() {
     Text('内容')
   }
   .width('80%')
   .height('60%')
   ```

3. **智能穿戴圆形表盘**
   ```typescript
   Column() {
     // 内容
   }
   .borderRadius('50%')  // 设置圆形
   ```

## 开发规范

### 命名规范

- **组件命名**: 大驼峰命名法，如 `MusicPlayer`
- **变量命名**: 小驼峰命名法，如 `currentSong`
- **常量命名**: 全大写下划线，如 `MAX_VOLUME`
- **资源命名**: 小写下划线，如 `ic_play`

### 目录规范

```
模块名/
├── constants/        # 常量定义
├── components/       # 子组件
├── view/            # 视图组件
├── viewmodel/       # 业务逻辑
└── utils/           # 工具函数
```

### 代码规范

1. 使用 `@Component` 装饰器定义组件
2. 使用 `@State` 管理组件内部状态
3. 使用 `@Prop` 接收父组件传递的数据
4. 使用 `@Link` 实现双向数据绑定

## 常见问题

### Q1: 如何选择运行设备？

**A**: 在 DevEco Studio 中，根据连接的设备设置：
- 智能穿戴选择 "watch"
- 其他设备选择 "phone"

### Q2: 如何处理不同屏幕尺寸？

**A**: 使用栅格布局系统，通过 `onBreakpointChange` 回调监听断点变化，动态调整布局。

### Q3: 如何实现圆形表盘效果？

**A**: 智能穿戴设备设置 `borderRadius` 为 50% 实现圆形表盘效果。

### Q4: 项目需要哪些权限？

**A**: 本项目不涉及特殊权限申请。

## 相关资源

- [HarmonyOS 开发文档](https://developer.harmonyos.com/cn/docs/)
- [ArkUI 组件参考](https://developer.harmonyos.com/cn/docs/documentation/doc-references/ts-components-summary-0000001158081360)
- [DevEco Studio 下载](https://developer.harmonyos.com/cn/develop/deveco-studio)

## 更新日志

### v1.0.0
- 初始版本发布
- 支持多设备自适应布局
- 实现基础音乐播放功能
- 添加歌词显示功能
- 实现音乐评论功能

---

**开发者**: HarmonyOS Team  
**最后更新**: 2026-04-21