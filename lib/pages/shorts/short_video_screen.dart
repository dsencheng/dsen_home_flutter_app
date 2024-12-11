import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'short_video_info_widget.dart';
import 'short_video_side_bar.dart';
import 'video_share_controller.dart';
import 'video_player_widget.dart';

class ShortVideoScreen extends StatefulWidget {
  final String url;

  const ShortVideoScreen({super.key, required this.url});

  @override
  State<ShortVideoScreen> createState() => _ShortVideoScreenState();
}

class _ShortVideoScreenState extends State<ShortVideoScreen> {
  final VideoShareController _videoShareController = Get.put(VideoShareController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Container(
              color: Colors.black, //RandomUtils.getRandomColor,
              child: VideoPlayerWidget(
                videoUrl: widget.url,
              ),
            ),
          ),
          Positioned(
            child: GestureDetector(
              onTap: () {
                print("播放状态");
                    _videoShareController.changePlaying();
                    setState(() {});
              },
              child: Obx(() => _videoShareController.isPlaying.value ?
                Container(color: Colors.transparent,)
                : const Center(child: Icon(Icons.play_circle_outline, size: 60, color: Colors.white,))
                ),
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 80,
            child: ShortVideoSideBar(),
          ),
          const Positioned(
              left: 0, 
              bottom: 0, 
              right: 80, 
              child: ShortVideoInfoWidget()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print("短视频页面销毁了");
    Get.delete<VideoShareController>();
    super.dispose();
  }
}
