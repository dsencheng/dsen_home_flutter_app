import 'package:DsenHome/pages/personal/personal_page_header.dart';
import 'package:flutter/material.dart';

class PersonalHeaderTabbar extends StatefulWidget {
  const PersonalHeaderTabbar({super.key, required this.tabs,});

  final List<Widget> tabs;

  @override
  State<PersonalHeaderTabbar> createState() => _PersonalHeaderTabbarState();
}

class _PersonalHeaderTabbarState extends State<PersonalHeaderTabbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        children: [
          PersonalPageHeader(maxExtent: 200),
          TabBar(tabs: widget.tabs,)
        ],
      ),
    );
  }
}