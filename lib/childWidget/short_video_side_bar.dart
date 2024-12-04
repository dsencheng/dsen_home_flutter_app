import 'package:flutter/material.dart';

class ShortVideoSideBar extends StatefulWidget {
  const ShortVideoSideBar({super.key});

  @override
  State<ShortVideoSideBar> createState() => _ShortVideoSideBarState();
}

class _ShortVideoSideBarState extends State<ShortVideoSideBar> {
  bool _icon01Active = false;

  bool _icon03Active = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Column(
        children: [
          IconButton(
            icon: _icon01Active
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
            onPressed: () {
              setState(() {
                _icon01Active = !_icon01Active;
              });
            },
          ),
          Text("432"),
          const SizedBox(height: 10,),
          IconButton(
            icon: const Icon(Icons.sms),
            onPressed: () {},
          ),
          Text("45"),
          const SizedBox(height: 10,),
          IconButton(
            icon: _icon03Active
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border),
            onPressed: () {
              setState(() {
                _icon03Active = !_icon03Active;
              });
            },
          ),
          Text("6"),
          const SizedBox(height: 10,),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
