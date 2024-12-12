
import 'package:flutter/material.dart';

class WaterfallFlow extends StatelessWidget {
  final List<Widget> children;
  final int columnCount;

  const WaterfallFlow({super.key, required this.children, required this.columnCount});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
          gridDelegate: MySliverWaterfallFlowDelegate(
            crossAxisCount: columnCount,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return children[index];
            },
            childCount: children.length,
          ),
        ),
      ],
    );
  }
}

class MySliverWaterfallFlowDelegate extends SliverGridDelegateWithFixedCrossAxisCount {
  
  MySliverWaterfallFlowDelegate({
    required super.crossAxisCount,
    super.crossAxisSpacing,
    super.mainAxisSpacing,
    super.mainAxisExtent
  });

  // double? maxCrossAxisExtent(BuildContext context, int index) {
  //   return (MediaQuery.of(context).size.width - (crossAxisCount - 1) * super.crossAxisSpacing) / crossAxisCount;
  // }

  // double? minCrossAxisExtent(BuildContext context, int index) {
  //   return maxCrossAxisExtent(context, index);
  // }


  @override
  bool shouldRelayout(MySliverWaterfallFlowDelegate oldDelegate) {
    return oldDelegate.crossAxisCount != crossAxisCount ||
        oldDelegate.crossAxisSpacing != crossAxisSpacing ||
        oldDelegate.mainAxisSpacing != mainAxisSpacing;
  }
}