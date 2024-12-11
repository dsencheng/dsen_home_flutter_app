import 'package:DsenHome/pages/personal/personal_page_header.dart';
import 'package:DsenHome/utils/random_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../delegate/sliver_simple_header_delegate.dart';
import '../../delegate/sliver_tabbar_delegate.dart';
import 'personal_header_tabbar.dart';
import 'tab_indicator_widget.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final _tabs = <String>['作品', '关注', '喜欢'];
  double _headerHeight = 300.0;
  double _tabbarOffset = 0.0;
  double _headerOffset = 0.0;
  bool _showBack = false;
  double safeAreaTop = 0;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Map<String,dynamic> args = Get.arguments ?? {};
    if (args.containsKey("showNavigationBar")) {
      _showBack = args["showNavigationBar"];
    }
    _scrollController.addListener(() {
      _headerOffset =  _headerHeight - _scrollController.offset;
      // print("_headerOffset：${_headerOffset}");
      // offset 上滑增加，下滑减少
      if (_headerOffset <= safeAreaTop) {
        _tabbarOffset = (safeAreaTop - _headerOffset).clamp(0, safeAreaTop);
        // print("_currentExtent:${_tabbarOffset}");
      }
      setState(() {});
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
    safeAreaTop = MediaQuery.of(context).padding.top;
    var tabbar = TabBar(tabs: _tabs.map((String name) => Tab(text: name)).toList(),);
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
                  height: _headerHeight,
                  child: PersonalPageHeader(
                    maxExtent: _headerHeight, 
                    offset: _headerOffset,
                    back: _showBack,),
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
                  child: tabbar,
                  offset: _tabbarOffset,
                  minHeight: 48,
                  maxHeight: 48+62,
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
