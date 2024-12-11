
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
      child: Text("发现了未知页面哦~ \n ${Get.currentRoute} \n${Get.arguments.toString()},"),
    ),
    );
  }
}