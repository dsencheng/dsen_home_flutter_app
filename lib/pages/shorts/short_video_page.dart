import 'package:DsenHome/data/video_data.dart';
import 'package:DsenHome/pages/shorts/short_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.toNamed("/playlet");
        },
        child: Icon(
          Icons.search,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
          color: Colors.black,
          child: PageView.builder(
              // controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: videoList.length,
              // itemExtent: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
              itemBuilder: (BuildContext context, int index) {
                return ShortVideoScreen(
                  url: videoList[index],
                );
              })),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {}
}
