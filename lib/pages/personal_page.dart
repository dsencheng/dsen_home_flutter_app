import 'package:DsenHome/pages/personal/personal_page_header.dart';
import 'package:DsenHome/utils/random_utils.dart';
import 'package:flutter/material.dart';

import '../delegate/sliver_simple_header_delegate.dart';
import '../delegate/sliver_tabbar_delegate.dart';
import 'personal/personal_header_tabbar.dart';
import 'personal/tab_indicator_widget.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final _tabs = <String>['作品', '关注', '喜欢'];
  double _appBarHeight = 200.0;
  double _currentExtent = 0.0;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print("偏移量${_scrollController.offset}");
      double offset = _scrollController.offset.clamp(0, 200);
      setState(() {
        _currentExtent = offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length, // tab的数量.
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      top: false,
      child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // SliverOverlapAbsorber(
            //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            //   sliver:
            //       SliverAppBar(
            //         pinned: true,
            //         // foregroundColor: Colors.amber,
            //         expandedHeight: _appBarHeight,
            //         flexibleSpace:
            //         PersonalPageHeader(offset: _currentExtent,maxExtent: _appBarHeight,),
            //       ),

            // ),

            SliverToBoxAdapter(
              child: Container(
                color: Colors.amber,
                child: SizedBox(
                  height: 300,
                  child: PersonalPageHeader(maxExtent: 300),
                ),
              ),
            ),

            // SliverPersistentHeader(
            //     delegate: SliverSimpleHeaderDelegate(maxHeight: 300, minHeight: 100 ,builder: (context,persentage){
            //       return PersonalPageHeader(maxExtent: 300);
            //     }),
            //     pinned: true, // 使 TabBar 固定在顶部
            //   ),

            // SliverPersistentHeader(
            //   delegate: SliverSimpleHeaderDelegate(
            //       maxHeight: _currentExtent >= 200 ? 100 : 00,
            //       minHeight: _currentExtent >= 200 ? 100 : 00,
            //       builder: (context, persentage) {
            //         return Container(
            //           color: Colors.blue,
            //           child: Text('我是一个固定在顶部的Bar'),
            //         );
            //       }),
            //   pinned: true, // 使 TabBar 固定在顶部
            // ),

            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                delegate: SliverTabbarDelegate(
                  child: TabBar(
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
                pinned: true, // 使 TabBar 固定在顶部
              ),
            ),
          ];
        },
        body: TabBarView(
          children: _tabs.map((String name) {
            return Builder(
              builder: (BuildContext context) {
                return CustomScrollView(
                  key: PageStorageKey<String>(name),
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: buildSliverList(50, name),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildSliverList(int count, String name) {
    return SliverGrid(
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
            child: Text('$name item $index'),
          );
        },
        childCount: count,
      ),
    );
  }
}
