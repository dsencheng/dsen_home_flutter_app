import 'package:flutter/material.dart';

class Animation01 extends StatefulWidget {
  const Animation01({super.key});

  @override
  State<Animation01> createState() => _Animation01State();
}

class _Animation01State extends State<Animation01>
    with SingleTickerProviderStateMixin {
  final Animation<double> _animation =
      Tween(begin: 50.0, end: 300.0) as Animation<double>;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("简单动画-缩放"),
      ),
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Center(
            child: Image.asset(
              "images/storm.png",
              width: _animation.value,
              height: _animation.value,
            ),
          );
        },
      ),
    );
  }
}
