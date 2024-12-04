import 'package:DsenHome/getxdemo/animation01.dart';
import 'package:DsenHome/pages/personal_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DemoList extends StatelessWidget {
  const DemoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('简单动画'),
          onTap: () {
            Get.to(Animation01());
          },
        ),
        ListTile(
          title: Text('个人主页'),
          onTap: () {
            // Get.to(PersonalPage());
            Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalPage()));
          },
        ),
        ListTile(
          title: Text('List Item 3'),
        ),
      ],
    );
  }
}