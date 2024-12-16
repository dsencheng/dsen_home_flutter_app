import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import '../pages/home_page.dart';
import 'pages/chat/chat_page.dart';
import 'pages/personal/personal_page.dart';
import 'pages/shop/shop_page.dart';
import 'pages/shorts/short_video_page.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final bool _showTabBar = true;

  late TabController _tabController;
  final _bottomNavigationKey = GlobalKey();
  double _swipeOffset = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    // 添加监听器
    _tabController.addListener(() {
      print("Tab changed to: ${_tabController.index}");
      tabToIndex(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void tabToIndex(int index) {
    final barState =
        _bottomNavigationKey.currentState as CurvedNavigationBarState;
    barState.setPage(index.clamp(0, _tabController.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        // useMaterial3: true,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(onPressed: (){
        //     setState(() {
        //       _showTabBar = !_showTabBar;【
        //     });
        //   }, icon: Icon(Icons.change_circle)),
        // ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            HomePage(),
            ShortVideoPage(),
            ChatPage(),
            ShopPage(),
            PersonalPage(),
          ],
        ),
        bottomNavigationBar: _showTabBar
            ? SafeArea(
                bottom: false,
                child: Builder(builder: (context) {
                  return GestureDetector(
                    onHorizontalDragStart: (details) {
                      _swipeOffset = 0;
                    },
                    onHorizontalDragCancel: () {
                      _swipeOffset = 0;
                    },
                    onHorizontalDragUpdate: (details) {
                      _swipeOffset = details.delta.dx;
                      print("delta:${details.delta.dx}");
                      // print("update _swipeOffset: $_swipeOffset");
                      // if (details.delta.dx > 0) {
                      //   // 向右滑动
                      // } else {
                      //   // 向左滑动
                      // }
                      // print("details.delta.dx: ${details.delta.dx}");
                    },
                    onHorizontalDragEnd: (details) {
                      // print("end _swipeOffset: $_swipeOffset");
                      if (_swipeOffset > 1) {
                        // 向右滑动
                        tabToIndex((_tabController.index - 1)
                          ..clamp(0, _tabController.length));
                      } else if (_swipeOffset < -1) {
                        // 向左滑动
                        tabToIndex((_tabController.index + 1)
                            .clamp(0, _tabController.length));
                      }

                      // 检测滑动的速度和方向
                      if (details.velocity.pixelsPerSecond.dx > 0) {
                        // 右滑
                        // print("Swiped Right");
                      } else if (details.velocity.pixelsPerSecond.dx < 0) {
                        // 左滑
                        // print("Swiped Left");
                      }
                    },
                    child: CurvedNavigationBar(
                      key: _bottomNavigationKey,
                      items: const [
                        Icon(
                          Icons.home,
                          size: 30,
                        ),
                        Icon(
                          Icons.subscriptions,
                          size: 30,
                        ),
                        Icon(
                          Icons.chat,
                          size: 30,
                        ),
                        Icon(
                          Icons.shop,
                          size: 30,
                        ),
                        Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ],
                      onTap: (value) {
                        _tabController.animateTo(
                            value.clamp(0, _tabController.length - 1));
                      },
                    ),
                  );
                }),
              )
            : null,
      ),
      initialRoute: "/",
      getPages: RoutePages,
    );
  }
}
