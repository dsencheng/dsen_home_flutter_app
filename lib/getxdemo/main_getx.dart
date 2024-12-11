
import 'package:DsenHome/getxdemo/demo_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(List<String> args) {
  runApp(GetMaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("GetX"),
      ),
      body: const DemoList(),
    ),
  ));
}