import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import '../pages/home_page.dart';
import 'pages/chat_page.dart';
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

class _MyAppState extends State<MyApp> {
  final bool _showTabBar = true;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        // useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          // appBar: AppBar(
          //   leading: IconButton(onPressed: (){
          //     setState(() {
          //       _showTabBar = !_showTabBar;【
          //     });
          //   }, icon: Icon(Icons.change_circle)),
          // ),
          body: const TabBarView(
            children: [
              HomePage(),
              ShortVideoPage(),
              ChatPage(),
              ShopPage(),
              PersonalPage(),
            ],
          ),
          bottomNavigationBar: _showTabBar ? const SafeArea(
            child: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  // text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.subscriptions),
                  // text: "Shorts",
                ),
                Tab(
                  icon: Icon(Icons.chat),
                  // text: "Chat",
                ),
                Tab(
                  icon: Icon(Icons.shop),
                  // text: "Shop",
                ),
                Tab(
                  icon: Icon(Icons.person),
                  // text: "Personal",
                ),
              ],
            ),
          ) : null,
        ),
      ),
      initialRoute: "/",
      getPages: RoutePages,
    );
  }
}
