import 'dart:math';

import 'package:DsenHome/utils/random_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LampPage extends StatefulWidget {
  const LampPage({super.key});

  @override
  State<LampPage> createState() => _LampPageState();
}

class _LampPageState extends State<LampPage> {
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _test(context)),
    );
  }

  Widget _test(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        // AppBar，包含一个导航栏.
        SliverAppBar(
          pinned: true, // 滑动到顶端时会固定住
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Demo'),
            background: Image.asset(
              "images/music_cover.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            //Grid
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //Grid按两列显示
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //创建子widget
                return Container(
                  alignment: Alignment.center,
                  color: Colors.cyan[100 * (index % 9)],
                  child: Text('固定网格 item $index'),
                );
              },
              childCount: 20,
            ),
          ),
        ),

        SliverPersistentHeader(
          delegate: SliverHeaderDelegate(
            //有最大和最小高度
            maxHeight: 80,
            minHeight: 50,
            child: Container(
              color: Colors.green,
              child: Center(
                child: Text("吸顶1111"),
              ),
            ),
          ),
          pinned: true,
        ),

        SliverToBoxAdapter(
          child: Container(
            color: Colors.amber,
            child: SizedBox(
              height: 300,
              child: PageView(
                children: [Text("水平滑动1111"), Text("水平滑动2222")],
              ),
            ),
          ),
        ),

        SliverPersistentHeader(
          delegate: SliverHeaderDelegate.fixedHeight(
            //固定高度
            height: 50,
            child: Container(
              color: Colors.brown,
              child: Center(
                child: Text("吸顶222"),
              ),
            ),
          ),
          pinned: true,
        ),

        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              // Create a grid tile for each item
              return Container(
                height: RandomUtils.getRandomDouble(200),
                alignment: Alignment.center,
                color: Colors.cyan[100 * (index % 9)],
                child: Text('瀑布流 item $index'),
              );
            },
            childCount:20, // Adjust this to the number of items you want to display
            ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0, // Adjust this to control the aspect ratio of your tiles
          ),
        ),

        SliverPersistentHeader(
          delegate: SliverHeaderDelegate(
            maxHeight: 80,
            minHeight: 50,
            child: Container(
              color: Colors.brown,
              child: Center(
                child: Text("不吸顶222"),
              ),
            ),
          ),
          pinned: false,
        ),

        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              //创建列表项
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('无限列表 item $index'),
              );
            },
            // childCount: 20,
          ),
        ),
      ],
    );
  }

  double getRandomDouble() {
    Random random = Random();
    return random.nextDouble() * 100;
  }
}

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  // child 为 header
  SliverHeaderDelegate({
    required this.maxHeight,
    this.minHeight = 0,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  //最大和最小高度相同
  SliverHeaderDelegate.fixedHeight({
    required double height,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  //需要自定义builder时使用
  SliverHeaderDelegate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  });

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    Widget child = builder(context, shrinkOffset, overlapsContent);
    //测试代码：如果在调试模式，且子组件设置了key，则打印日志
    assert(() {
      if (child.key != null) {
        print('${child.key}: shrink: $shrinkOffset，overlaps:$overlapsContent');
      }
      return true;
    }());
    // 让 header 尽可能充满限制的空间；宽度为 Viewport 宽度，
    // 高度随着用户滑动在[minHeight,maxHeight]之间变化。
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverHeaderDelegate old) {
    return old.maxExtent != maxExtent || old.minExtent != minExtent;
  }
}
