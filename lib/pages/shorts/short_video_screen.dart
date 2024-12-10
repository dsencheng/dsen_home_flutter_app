import 'package:DsenHome/utils/random_utils.dart';
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
  final VideoShareController _videoController = Get.put(VideoShareController());


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            color: Colors.black,//RandomUtils.getRandomColor,
            child: VideoPlayerWidget(videoUrl: widget.url,),
          ),
          Positioned(
            child: Center(
              child: IconButton(
                onPressed: (){
                  print("播放状态");
                  _videoController.changePlaying();
                  setState(() {
                    
                  
                  });
                }, 
                icon: Obx(() => _videoController.isPlaying.value ? Icon(Icons.play_circle_fill) : Icon(Icons.pause_circle_filled)),
                ),
            ),),
          Positioned(
            child: ShortVideoSideBar(),
            right: 0,
            bottom: 100,
          ),
          Positioned(
              left: 0, bottom: 0, right: 0, child: ShortVideoInfoWidget()),
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
