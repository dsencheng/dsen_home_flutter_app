import 'package:DsenHome/childWidget/short_video_screen.dart';
import 'package:flutter/material.dart';

class ShortVideoPage extends StatefulWidget {
  const ShortVideoPage({super.key});

  @override
  State<ShortVideoPage> createState() => _ShortVideoPageState();
}

class _ShortVideoPageState extends State<ShortVideoPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(_onScroll);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
            color: const Color.fromARGB(255, 184, 65, 65),
            child: PageView.builder(
                // controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: 10,
                // itemExtent: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
                itemBuilder: (BuildContext context, int index) {
                  return ShortVideoScreen();
                })),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {

  }
}
