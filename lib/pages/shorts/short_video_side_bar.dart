import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      // color: Colors.amber,
      child: Column(
        children: [
          Stack(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: _buildHeaderWidget(),
            ),
            Positioned(
              top: 45,
              left: 0,
              right: 0,
              child: _buildFocusButton())
          ],),
          
          MyIconButton(
            icon: _icon01Active
                ? const Icon(Icons.favorite, color: Colors.pink,)
                : const Icon(Icons.favorite_border),
            title: const Text("432"),
            onTap: () {
              setState(() {
                _icon01Active = !_icon01Active;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          MyIconButton(
            icon: const Icon(Icons.sms),
            title: const Text("45"),
            onTap: () {},
          ),
          
          const SizedBox(
            height: 10,
          ),
          MyIconButton(
            icon: _icon03Active
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border),
            title: const Text("6"),
            onTap: () {
              setState(() {
                _icon03Active = !_icon03Active;
              });
            },
          ),
          
          const SizedBox(
            height: 10,
          ),
          MyIconButton(
            icon: const Icon(Icons.share),
            onTap: () {},
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderWidget() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white, // 边框颜色
          width: 2.0, // 边框宽度
        ),
      ),
      child: 
      GestureDetector(
        onTap: () {
          print("点击头像");
        },
        child: const CircleAvatar(
              radius: 30.0, // 头像半径
              foregroundImage: AssetImage("images/avatar.png"), // 头像图片
            ),
      ),
      
    );
  }

  Widget _buildFocusButton() {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Colors.pink,
        shape: BoxShape.circle,
      ),
      child: 
      GestureDetector(
        onTap: () {
          print("点击加号");
        },
        child: 
        const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            )
            ),
      ),
    );
  }
}

class MyIconButton extends StatefulWidget {
  final Icon icon;
  
  final Text? title;
  
  final VoidCallback onTap;

  const MyIconButton({super.key, required this.icon, this.title, required this.onTap});

  @override
  State<MyIconButton> createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
            child: widget.title == null ? widget.icon : Column(
              children: [
                widget.icon,
                widget.title!,
              ],
            ),
          ),
    );
  }
}
