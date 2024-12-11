import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Circular PageView')),
        body: CircularPageView(),
      ),
    );
  }
}

class CircularPageView extends StatefulWidget {
  const CircularPageView({super.key});

  @override
  _CircularPageViewState createState() => _CircularPageViewState();
}

class _CircularPageViewState extends State<CircularPageView> {
  final PageController _pageController = PageController(initialPage: 1);
  final int _itemCount = 3; // 假设有3个页面
  final List<String> _items = ['Page 1', 'Page 2', 'Page 3'];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    int nextPage = (_pageController.page ?? 0).round();
    if (nextPage == 0) {
      _pageController.jumpToPage(_itemCount);
    } else if (nextPage == _itemCount + 1) {
      _pageController.jumpToPage(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: _itemCount + 2, // 添加两个虚拟页面
      itemBuilder: (context, index) {
        if (index == 0 || index == _itemCount + 1) {
          // 返回第一个或最后一个页面作为虚拟页面
          return _buildPage(_items[index == 0 ? _itemCount - 1 : 0]);
        } else {
          return _buildPage(_items[index - 1]);
        }
      },
    );
  }

  Widget _buildPage(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}