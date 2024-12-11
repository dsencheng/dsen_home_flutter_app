import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShortVideoInfoWidget extends StatefulWidget {
  const ShortVideoInfoWidget({super.key});

  @override
  State<ShortVideoInfoWidget> createState() => _ShortVideoInfoWidgetState();
}

class _ShortVideoInfoWidgetState extends State<ShortVideoInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Row(
            children: [
              Text("@TikTok官方频道", style: TextStyle(color: Colors.white, fontSize: 16),),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(child: Icon(Icons.music_note, size: 16, color: Colors.white,)),
                      const TextSpan(text:"啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦",
                      style: TextStyle(
                        fontSize: 14, 
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                        ), 
                      ),
                      TextSpan(
                        text: "#TikTok",
                        style: TextStyle(
                          color: Colors.grey[100]!, 
                          fontWeight: FontWeight.bold, 
                          fontSize: 14),
                        recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          Get.snackbar("提示", "点击了#TikTok", colorText: Colors.grey);
                        })
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
