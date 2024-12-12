#### 目前仅支持iOS，Android未适配。

- 仿抖音首页
- 仿AI聊天
- 支持播放音乐、直播
- 个人主页悬浮吸顶tabbar，继承SliverPersistentHeaderDelegate，重写布局，实现上滑增高，下滑恢复。


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


