import 'package:flutter/material.dart';
import '../childWidget/movie_card.dart';
import '../childWidget/music_card.dart';
import '../extension/theme_extension.dart';
import '../childWidget/device_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorf5,
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
                child: (double scale) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).colorf5,
                    child: _header(scale),
                  );
                },
                maxHeight: 70,
                minHeight: 70),
          ),
          SliverToBoxAdapter(
            child: Container(
              // color: Colors.pink,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: _room()),
                  SizedBox(
                    height: 20,
                  ),
                  _devices(),
                  SizedBox(
                    height: 20,
                  ),
                  _music(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    color: Colors.indigo,
                    alignment: Alignment.center,
                    child: Text("直播"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _movies(),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget _header(double scale) {
    print("scale:$scale");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "欢迎回家",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).color4c),
            ),
            Text(
              "业主",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).largeTitleColor),
            )
          ],
        ),
        //裁成圆形
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage("images/storm.png"),
        ),
      ],
    );
  }

  Widget _room() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "客厅",
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).largeTitleColor),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Icon(Icons.search),
      ],
    );
  }

  Widget _devices() {
    return Container(
        height: 120,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: DeviceCard(
                    title: "灯光设备一",
                    iconName: "",
                    isActive: true,
                    toggleDeviceState: () {
                      print("toggle");
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: DeviceCard(
                    title: "窗帘设备二",
                    iconName: "",
                    isActive: false,
                    toggleDeviceState: () {
                      print("toggle");
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: DeviceCard(
                    title: "清洁设备三",
                    iconName: "",
                    isActive: true,
                    toggleDeviceState: () {
                      print("toggle");
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: DeviceCard(
                    title: "清洁设备三",
                    iconName: "",
                    isActive: false,
                    toggleDeviceState: () {
                      print("toggle");
                    },
                  ),
                ),
              ],
            ),
        );
  }

  Widget _music() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: MusicCard());
  }

  Widget _movies() {
    return Container(
      height: 300,
      
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget Function(double) child;
  final double maxHeight;
  final double minHeight;

  _SliverAppBarDelegate(
      {required this.child, required this.maxHeight, required this.minHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child((shrinkOffset / (maxHeight - minHeight)).clamp(0, 1));
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}