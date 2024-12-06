import 'package:flutter/material.dart';

import '../../utils/random_utils.dart';

class PersonalPageHeader extends StatefulWidget {
  PersonalPageHeader({super.key, this.offset = 0, required this.maxExtent});

  double offset;
  double maxExtent;

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
          Image.asset("images/background.png", fit: BoxFit.fill,),
          Column(
          children: [
            SizedBox(height: 100,),
            // Image.asset("images/background.png", fit: BoxFit.fill,height: 100, width: MediaQuery.of(context).size.width),
            Padding(
              padding: const EdgeInsets.only(left:  8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: (radius * _persentage()).clamp(20, radius),
                    child: Image.asset("images/storm.png",),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.person_add_alt)),
                  TextButton(onPressed: (){}, child: Text("正在关注"))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text("用户昵称"),
                  IconButton(onPressed: (){}, icon: Icon(Icons.verified)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text("个性签名"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text("0 关注"),
                  SizedBox(width: 10,),
                  Text("18万粉丝"),
                  SizedBox(width: 10,),
                  Text("329.5万点赞"),
                ],
              ),
            ),
          ],
                  )],
      ),
    );
  }

  double _persentage() {
    return (1 - widget.offset / widget.maxExtent).clamp(0, 1);
  }
}
