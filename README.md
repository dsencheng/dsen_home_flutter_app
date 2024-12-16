#### 目前仅支持iOS，Android未适配。

- 仿短剧、抖音页面
- 仿AI聊天，支持流式/非流失接口，使用豆包API
- 支持播放音乐
- 直播(待开发)
- 商城页面(待开发)
- 个人主页，悬浮吸顶tabbar，继承SliverPersistentHeaderDelegate，重写布局，实现上滑增高，下滑恢复。

页面截图

![首页](snapshot/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202024-12-16%20at%2010.07.41.png)
![短视频](snapshot/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202024-12-16%20at%2010.07.54.png)
![AI聊天](snapshot/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202024-12-16%20at%2010.09.20.png)
![AI聊天评论](snapshot/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202024-12-16%20at%2010.07.59.png)
![个人主页](snapshot/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202024-12-16%20at%2010.09.20.png)
![视频列表](snapshot/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202024-12-16%20at%2010.08.12.png)
![设备控制](snapshot/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202024-12-16%20at%2010.13.57.png)

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


