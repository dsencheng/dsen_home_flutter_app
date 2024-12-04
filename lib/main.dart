import 'package:flutter/material.dart';
import '../extension/theme_extension.dart';
import '../pages/automation_page.dart';
import '../pages/home_page.dart';
import '../pages/lamp_page.dart';
import 'pages/short_video_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIdx = 0;
  final List<Widget> _pages = [
    HomePage(),
    ShortVideoPage(),
    LampPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffff5f5f5),
      body: _pages[_currentIdx],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "家",
              backgroundColor: Theme.of(context).colorf5),
          BottomNavigationBarItem(
              icon: Icon(Icons.flutter_dash),
              label: "短视频",
              backgroundColor: Theme.of(context).colorf5),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: "灯光",
              backgroundColor: Theme.of(context).colorf5),
        ],
        backgroundColor: Color(0xfff5f5f5),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIdx,
        onTap: (value) {
          setState(() {
            _currentIdx = value;
          });
        },
      ),
    );
  }
}
