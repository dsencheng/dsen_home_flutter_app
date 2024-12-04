import 'package:DsenHome/utils/random_utils.dart';
import 'package:flutter/material.dart';

import 'short_video_info_widget.dart';
import 'short_video_side_bar.dart';

class ShortVideoScreen extends StatefulWidget {
  const ShortVideoScreen({super.key});

  @override
  State<ShortVideoScreen> createState() => _ShortVideoScreenState();
}

class _ShortVideoScreenState extends State<ShortVideoScreen> with AutomaticKeepAliveClientMixin {
  bool _isPlaying = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Stack(
        children: [
          Container(
            color: RandomUtils.getRandomColor,
            child: Center(
              child: IconButton(
                onPressed: (){
                  setState(() {
                    
                  _isPlaying = !_isPlaying;
                  });
                }, 
                icon: _isPlaying ? Icon(Icons.play_circle_fill) : Icon(Icons.play_circle_outline),
                ),
            ),
          ),
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
  bool get wantKeepAlive => true;
}
