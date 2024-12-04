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
                IconButton(
                  icon:Icon (
                    Icons.flutter_dash,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalPage()));
                  },
                ),
                SizedBox(
                  width: 6,
                ),
                Flexible(
                  child: Text(
                    '用户昵称${RandomUtils.getRandomInt(100)}',
                    style: TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  label: Text(
                    "关注",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  icon: Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    // padding: EdgeInsets.all(10),
                  ),
                ),
                // Spacer(flex: 1,),
              ],
            ),
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
