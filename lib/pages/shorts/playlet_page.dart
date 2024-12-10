import 'package:flutter/material.dart';

class PlayletPage extends StatefulWidget {
  const PlayletPage({super.key});

  @override
  State<PlayletPage> createState() => _PlayletPageState();
}

class _PlayletPageState extends State<PlayletPage> {
  final List<String> _category = ["电影","电视剧","听书","小说","漫画"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index){
              return Text(_category[index]);
          },
          itemCount: _category.length,)
        ],
        
      ),
    );
  }
}