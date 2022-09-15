<div align="center">
  <img
    src="assets/icon.png"
    alt="迷你哔哩"
  >
  <h1>
    迷你哔哩
  </h1>
  <p>
    一个 Mac 平台上的 BiliBili 第三方菜单栏工具应用
  </p>
  <p>
    <a href="#功能">功能</a> •
    <a href="#安装">安装</a> •
    <a href="#贡献">贡献</a>
  </p>
</div>

<div align="center">
  <img
    max-width="400"
    width="40%"
    src="assets/dark.png"
    margin="0, 10, 0, 00"
    alt="迷你哔哩深色模式"
  >
  <img
    max-width="400"
    width="40%"
    margin="0, 0, 0, 10"
    src="assets/light.png"
    alt="迷你哔哩浅色模式"
  >
</div>

## 功能

* 支持且仅支持扫码登录
* 支持显示用户基本信息和消息总数
* 支持获取最新的视频动态列表
* 支持获取全站排行榜
* 支持获取当天更新的动漫列表
* 支持获取热搜榜单

## 安装

*建议在 Mac OS 12.0 以上的系统中安装使用*

**Note**: 这个应用是我自己开发着自娱自乐的，并未通过 Apple Developer Program 的帐户签名，你可能会看到一条消息，说它不是来自受信任的开发人员，无法安装。你可以参考这篇文档解决:
[打开来自身份不明开发者的 Mac App](https://support.apple.com/guide/mac-help/mh40616/mac).

### 直接下载

你可以在 Github 的 [releases](https://github.com/Richasy/BIli.Mac.MenuBar/releases) 中找到最新版本下载。下载之后解压压缩包，将后缀为 **.app** 的文件直接拖拽到你的 *Applications* 文件夹即可

安装后可以在你的启动台中找到 **迷你哔哩**，点击即可启动，关闭说明窗口后，点开位于菜单栏的小电视图标，登录后就可以查看全部功能了

## 贡献

欢迎分享你对这个项目的看法，可以提出 issue，或者在讨论区讨论 :heart:

## 备注

项目脱胎自我的另一个 "烂尾" 项目 [Bili.Uwp](https://github.com/Richasy/Bili.Uwp)，在 UWP 谢幕而 Windows App SDK 尚未成熟的这个时间段，我正好可以换到苹果这边熟悉一下 SwiftUI，给自己的苹果设备开发点小玩意儿。

这个项目并不会长期维护，它只是我用来熟悉 SwiftUI 的一个练手项目。

SwiftUI 似乎并不适合 MVVM 的开发范式。在经过一些调研后，我选择了 [Composable-Architecture](https://github.com/pointfreeco/swift-composable-architecture) 这种架构来组织代码，并通过 [Swinject](https://github.com/Swinject/Swinject) 来进行初步的依赖注入尝试。整体耗费的时间大概是一周多，最后的结果我个人觉得还是 OK 的，至少也算有一定实用价值了。
