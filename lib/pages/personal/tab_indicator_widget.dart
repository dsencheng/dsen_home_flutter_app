import 'package:flutter/material.dart';

class TabIndicatorWidget extends StatefulWidget {
  const TabIndicatorWidget({super.key});

  @override
  State<TabIndicatorWidget> createState() => _TabIndicatorWidgetState();
}

class _TabIndicatorWidgetState extends State<TabIndicatorWidget> {
  int _selectedIndex = 0;
  double _indicatorLeft = 0.0;


  final List<GlobalKey> _tabKeys = List.generate(3, (_) =>  GlobalKey());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _updateIndicatorPosition(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            TextButton(
              key: _tabKeys[0],
              child: const Text("作品"),
              onPressed: () => _onTap(0),
            ),
            const Spacer(),
            TextButton(
              key: _tabKeys[1],
              child: const Text("动态"),
              onPressed: () => _onTap(1),
            ),
            const Spacer(),
            TextButton(
              key: _tabKeys[2],
              child: const Text("资料"),
              onPressed: () => _onTap(2),
            ),
            const Spacer()
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: 
          AnimatedPositioned(
              left: _indicatorLeft,
              curve: Curves.bounceInOut,
              duration: const Duration(milliseconds: 300),
              child: Container(
                height: 4,
                width: 20,
                color: Colors.red,
              )),
          
        )
      ],
    );
  }

  void _onTap(int index) {
    _updateIndicatorPosition(index);
  }

  void _updateIndicatorPosition(int index) {
    final RenderBox renderBox = _tabKeys[index].currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    setState(() {
      _selectedIndex = index;
      _indicatorLeft = position.dx + renderBox.size.width / 2 - 10;
      print("$_selectedIndex, ${position.dx},${renderBox.size.width}");
    });
  }
}
