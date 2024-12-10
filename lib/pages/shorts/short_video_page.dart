import 'package:DsenHome/data/video_data.dart';
import 'package:DsenHome/pages/shorts/short_video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'playlet_page.dart';

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
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(PlayletPage());
      }, child: Text("找剧"),),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: GestureDetector(
        child: Container(
            color: const Color.fromARGB(255, 184, 65, 65),
            child: PageView.builder(
                // controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: videoList.length,
                // itemExtent: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom,
                itemBuilder: (BuildContext context, int index) {
                  return ShortVideoScreen(url: videoList[index],);
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
