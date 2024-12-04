import 'package:flutter/material.dart';

typedef SliverBuilder = Widget Function(BuildContext context, double percentage);

class SliverSimpleHeaderDelegate extends SliverPersistentHeaderDelegate {
  final SliverBuilder builder;
  final double maxHeight;
  final double minHeight;

  SliverSimpleHeaderDelegate({
    required this.maxHeight,
    this.minHeight = 0, 
    required this.builder}) : assert(maxHeight >= minHeight && maxHeight >= 0);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double percentage = (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);
    // print(percentage);
    return SizedBox.expand(child: builder(context, percentage));
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate old) {
    return old.maxExtent != maxExtent || old.minExtent != minExtent;
  }
}