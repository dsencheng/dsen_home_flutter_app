import 'package:DsenHome/pages/personal_page.dart';
import 'package:DsenHome/utils/random_utils.dart';
import 'package:flutter/material.dart';

class ShortVideoInfoWidget extends StatefulWidget {
  const ShortVideoInfoWidget({super.key});

  @override
  State<ShortVideoInfoWidget> createState() => _ShortVideoInfoWidgetState();
}

class _ShortVideoInfoWidgetState extends State<ShortVideoInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      // height: 80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            
            Row(
              children: [
                Flexible(
                  child: Text(
                    "视频简介啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦",
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
