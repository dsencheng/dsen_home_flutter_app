#### 目前仅支持iOS，Android未适配。

- 仿短剧、抖音页面
- 仿AI聊天，支持流式/非流失接口，使用豆包API
- 支持播放音乐
- 直播(待开发)
- 商城页面(待开发)
- 个人主页，悬浮吸顶tabbar，继承SliverPersistentHeaderDelegate，重写布局，实现上滑增高，下滑恢复。
- 底部tabbar增加左右滑动，切换tab功能。

页面截图

<p align="left">
  <img src="./snapshot/Simulator Screenshot - iPhone 16 Pro - 2024-12-16 at 15.58.14.png" alt="首页" width="200"/>
  <img src="./snapshot/Simulator Screenshot - iPhone 16 Pro - 2024-12-16 at 10.13.57.png" alt="设备控制" width="200"/>
  <img src="./snapshot/Simulator Screenshot - iPhone 16 Pro - 2024-12-16 at 10.07.54.png" alt="短视频" width="200"/>
  <img src="./snapshot/Simulator Screenshot - iPhone 16 Pro - 2024-12-16 at 15.58.19.png" alt="视频列表" width="200"/>
</p>
<p align="left">
  <img src="./snapshot/Simulator Screenshot - iPhone 16 Pro - 2024-12-16 at 16.00.01.png" alt="AI聊天" width="200"/>
  <img src="./snapshot/Simulator Screenshot - iPhone 16 Pro - 2024-12-16 at 10.07.59.png" alt="AI聊天评论" width="200"/>
  <img src="./snapshot/Simulator Screenshot - iPhone 16 Pro - 2024-12-16 at 16.00.08.png" alt="个人主页" width="200"/>
  
</p>


#### 音乐播放

使用`just_audio`库，播放音乐。

iOS运行前，在`info.plist`添加权限。
```
<key>NSMicrophoneUsageDescription</key>
<string>播放音乐用了麦克风权限</string>
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

#### just_audio报错 

在widget中初始化后，监听里调用了setState，在快速切换widget时，会出现错误。增加了mount判断。


```
[ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Invalid argument: Cannot complete a future with itself: Instance of 'Future<AudioPlayerPlatform>'
```
播放状态时，切换页面，widget执行生命周期流程，deactivate中释放资源，出现上面报错。
原因是在dispose之前，调用了stop停止播放，去掉之后就没有问题了。


