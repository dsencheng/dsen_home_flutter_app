import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PersonalPageHeader extends StatefulWidget {
  PersonalPageHeader(
      {super.key, this.offset = 0, required this.maxExtent, this.back = false});

  double offset;
  double maxExtent;

  bool back;

  @override
  State<PersonalPageHeader> createState() => _PersonalPageHeaderState();
}

class _PersonalPageHeaderState extends State<PersonalPageHeader> {
  double radius = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/background.png",
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              // Image.asset("images/background.png", fit: BoxFit.fill,height: 100, width: MediaQuery.of(context).size.width),
              SizedBox(
                height: 100,
                child: Center(
                  child: CircleAvatar(
                    radius: (radius * _persentage()).clamp(20, radius),
                    foregroundImage: const AssetImage(
                      "images/storm.png",
                    ),
                  ),
                ),
              ),
              // Row(children: [
              //   IconButton(
              //             onPressed: () {}, icon: Icon(Icons.notifications, color: Colors.white,)),
              //         IconButton(
              //             onPressed: () {}, icon: Icon(Icons.person_add_alt, color: Colors.white)),
              //         TextButton(onPressed: () {}, child: Text("正在关注"))
              // ],),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      "用户昵称",
                      style: TextStyle(
                        color: Colors.white,
                        shadows: _shadows,
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.verified)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      "个性签名",
                      style: TextStyle(color: Colors.white,
                      shadows: _shadows,),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      "0 关注",
                      style: TextStyle(color: Colors.white,
                      shadows: _shadows,),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "18万粉丝",
                      style: TextStyle(color: Colors.white,
                      shadows: _shadows,),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "329.5万点赞",
                      style: TextStyle(color: Colors.white,
                      shadows: _shadows,),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 10,
              child: widget.back
                  ? IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ))
                  : Container()),
        ],
      ),
    );
  }

  double _persentage() {
    return (1 - (widget.maxExtent - widget.offset) / widget.maxExtent)
        .clamp(0, 1);
  }

  List<Shadow> get _shadows {
    return const [
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 1,
        color: Colors.black,
      ),
      Shadow(
        offset: Offset(-1, -1),
        blurRadius: 1,
        color: Colors.black,
      ),
      Shadow(
        offset: Offset(1, -1),
        blurRadius: 1,
        color: Colors.black,
      ),
      Shadow(
        offset: Offset(-1, 1),
        blurRadius: 1,
        color: Colors.black,
      ),
    ];
  }
}
