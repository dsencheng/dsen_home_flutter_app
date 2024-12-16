import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../childWidget/music_card.dart';
import '../extension/theme_extension.dart';
import '../childWidget/device_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Color _lampColor = Colors.orange;
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  void _readData() async {
    int? color = await prefs.getInt("lampColor");
    if (color != null) {
      print("读取数据成功");
      setState(() {
        _lampColor = Color(color);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _readData();
  }

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
                    padding: const EdgeInsets.all(10),
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
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: _room()),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  _devices(),
                  const SizedBox(
                    height: 20,
                  ),
                  _music(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    color: Colors.indigo[100],
                    alignment: Alignment.center,
                    child: const Text("直播待开发"),
                  ),
                  const SizedBox(
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
              "Dsen",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).largeTitleColor),
            )
          ],
        ),
        //裁成圆形
        const CircleAvatar(
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "客厅",
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).largeTitleColor),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        const Icon(Icons.search),
      ],
    );
  }

  Widget _devices() {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
              foregroundColor: _lampColor,
              tapCardEvent: () async {
                final result = await Get.toNamed("/lamp",
                    arguments: {"title": "灯光设备一", "color": _lampColor});
                if (result != null && result is Map) {
                  setState(() {
                    _lampColor = result["color"];
                  });
                  prefs.setInt("lampColor", _lampColor.value);
                }
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: DeviceCard(
              title: "窗帘设备二",
              iconName: "",
              isActive: false,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: DeviceCard(
              title: "清洁设备三",
              iconName: "",
              isActive: true,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: DeviceCard(
              title: "其他设备四",
              iconName: "",
              isActive: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _music() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: const MusicCard());
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
