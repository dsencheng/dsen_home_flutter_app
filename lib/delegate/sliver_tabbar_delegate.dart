import 'package:flutter/material.dart';

class SliverTabbarDelegate extends SliverPersistentHeaderDelegate {
  SliverTabbarDelegate({
    required this.child, 
    this.backgroundColor = Colors.white, 
    required this.minHeight, 
    required this.maxHeight,
    required this.offset,});

  final TabBar child;
  Color? backgroundColor;
  final double minHeight;
  final double maxHeight;
  final double offset;
  double shrink = 0.0;

  @override
  double get minExtent {
    // print("请求的minExtent");
    return _getHeight();
  } 

  @override
  double get maxExtent {
    // print("请求的maxExtent");
    return _getHeight();
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // print("shrinkOffset: $shrinkOffset");
    // double effectiveExtent = (maxHeight - shrinkOffset).clamp(minHeight, maxHeight);
    // double effectiveExtent = this.offset + minHeight;
    // print("effectiveExtent: $effectiveExtent");
    shrink = shrinkOffset;
    return Container(
      color: backgroundColor,
      height: _getHeight(),
      child: Padding(
        padding: EdgeInsets.only(top: offset),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(SliverTabbarDelegate old) {
    return old.offset != offset;
  }

  double _getHeight() {
    return (minHeight + offset).clamp(minHeight, maxHeight);
  }
}