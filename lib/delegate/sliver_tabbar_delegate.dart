import 'package:flutter/material.dart';

class SliverTabbarDelegate extends SliverPersistentHeaderDelegate {
  SliverTabbarDelegate({required this.child, this.backgroundColor = Colors.white});

  final TabBar child;
  Color? backgroundColor;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(SliverTabbarDelegate oldDelegate) {
    return false;
  }
}