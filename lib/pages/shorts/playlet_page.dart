import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayletPage extends StatefulWidget {
  const PlayletPage({super.key});

  @override
  State<PlayletPage> createState() => _PlayletPageState();
}

class _PlayletPageState extends State<PlayletPage> {
  final List<String> _category = [
    "电影",
    "电视剧",
    "听书",
    "小说",
    "漫画",
    "经典",
    "音乐",
    "短剧",
    "鬼畜",
    "游戏",
    "美食",
  ];
  final List<String> _tags = [
    "推荐",
    "热门",
    "最新",
    "排行榜",
    "标签1",
    "标签2",
    "标签3",
    "标签4",
    "标签5",
    "标签6",
    "标签7",
    "标签8",
    "标签9",
    "标签10"
  ];

  late ScrollController _categoryController;
  late ScrollController _tagsController;
  late ScrollController _gridController;
  late PageController _pageController;
  int _currentPage = 0;
  late Map<String, GlobalKey> _categoryKeys;

  @override
  void initState() {
    super.initState();
    _categoryKeys = {};
    for (var key in _category) {
      _categoryKeys[key] = GlobalKey();
    }
    _categoryController = ScrollController();
    _gridController = ScrollController();
    _tagsController = ScrollController();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _gridController.dispose();
    _tagsController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    int currentPage = _pageController.page?.round() ?? 0;
    print('Current page: $currentPage');
    if (currentPage == _currentPage) {
      return;
    }
    _currentPage = currentPage;
    setState(() {});
    final box = _categoryKeys[_category[currentPage]]
        ?.currentContext
        ?.findRenderObject() as RenderBox?;
    if (box != null) {
      final dx = box.localToGlobal(Offset.zero).dx;

      // 可见视图起点
      final start = _categoryController.offset;
      // 可见视图距离
      final dimension = _categoryController.position.viewportDimension;
      print("item位置$dx,可见视图起点: $start, 可见视图距离: $dimension");

      // 更新分类位置
      if (dx < start || dx > start + dimension) {
        _categoryController.jumpTo(
          dx < start ? dx - 20 : dx + box.size.width + 20,
          // duration: const Duration(milliseconds: 300),
          // curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        // color: Colors.amber,
        child: Column(
          children: [
            _buildNavigationBar(context),
            Expanded(child: _buildPageView(context)),
          ],
        ),
      )),
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
        Expanded(
          child: Container(
            height: 50,
            child: ListView.builder(
                controller: _categoryController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final text = _category[index];
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                          child: Text(
                        key: _categoryKeys[text],
                        text,
                        style: TextStyle(
                            fontSize: _currentPage == index ? 16 : 14,
                            fontWeight: _currentPage == index
                                ? FontWeight.bold
                                : FontWeight.normal),
                      )),
                    ),
                  );
                },
                itemCount: _category.length),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _buildPageView(BuildContext context) {
    return PageView.builder(
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return _buildBody(context, _category[index]);
        },
        itemCount: _category.length);
  }

  Widget _buildBody(BuildContext context, String category) {
    return Column(
      children: [
        SizedBox.fromSize(
          size: Size(MediaQuery.of(context).size.width - 16, 40),
          child: ListView.builder(
            controller: _tagsController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  // color: Colors.amber,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(_tags[index]),
                          ))));
            },
            itemCount: _tags.length,
          ),
        ),
        Expanded(
          child: GridView.builder(
              controller: _gridController,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10, crossAxisSpacing: 8, crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _buildGridItem(context, index),
                );
              }),
        )
      ],
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    return Container(
      // color: Colors.red,
      child: Column(
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                "images/movies_cover.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("嫌疑人第${index + 1}集"),
              Text("9.8分"),
            ],
          ),
        ],
      ),
    );
  }
}
