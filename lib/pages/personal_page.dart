import 'package:flutter/material.dart';

import '../delegate/sliver_simple_header_delegate.dart';
import 'personal/tab_indicator_widget.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
          SliverAppBar(
            pinned: true, // 滑动到顶端时会固定住
            expandedHeight: 250.0,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset(
                "images/music_cover.png",
                fit: BoxFit.cover,
              ),
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
            ),
          ),

          SliverPersistentHeader(
            delegate: SliverSimpleHeaderDelegate(
              //有最大和最小高度
              maxHeight: 50,
              minHeight: 50,
              builder: (context, percentage) {
                return Container(
                  color: Colors.blue,
                  child: TabIndicatorWidget(),
                );
              },
            ),
            pinned: true,
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 20,
            ),
          ),

          // SliverToBoxAdapter(
          //   child: Container(
          //     color: Colors.amber,
          //     child: SizedBox(
          //       height: 300,
          //       child: PageView(
          //         children: [Text("水平滑动1111"), Text("水平滑动2222")],
          //       ),
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }
}
