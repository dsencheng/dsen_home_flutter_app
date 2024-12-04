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
    final double opacity = 1 - (shrinkOffset / (maxExtent - minExtent));
    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Container(
        color: Colors.blue.withOpacity(opacity.clamp(0.0, 1.0)),
        child: builder(context, opacity),
      ),
    );
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