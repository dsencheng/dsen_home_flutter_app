import 'package:DsenHome/getxdemo/animation01.dart';
import 'package:DsenHome/pages/chat_page.dart';
import 'package:DsenHome/pages/personal/personal_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sliver_ramming.dart';

class DemoList extends StatelessWidget {
  const DemoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('简单动画'),
          onTap: () {
            Get.to(const Animation01());
          },
        ),
        ListTile(
          title: const Text('个人主页'),
          onTap: () {
            // Get.to(PersonalPage());
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalPage()));
          },
        ),
        ListTile(
          title: const Text('List Item 3'),
          onTap: () {
            Get.to(const SliverFillRemainingExampleApp());
          },
        ),
        ListTile(
          title: const Text('个人主页布局2'),
          onTap: () {
            
          },
        ),
        ListTile(
          title: const Text('ChatGPT'),
          onTap: () {
            Get.to(const ChatPage());
          },
        ),
      ],
    );
  }
}