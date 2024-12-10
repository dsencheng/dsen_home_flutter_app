import 'dart:math';

import 'package:DsenHome/childWidget/waterfakk_flow.dart';
import 'package:DsenHome/utils/random_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class LampPage extends StatefulWidget {

  @override
  State<LampPage> createState() => _LampPageState();
}

class _LampPageState extends State<LampPage> {
  final Map<String, dynamic>? args = Get.arguments;
  String? title;
  Color _lampColor = Colors.white;
  double _colorOpacity = 1.0;
  double _iconPositionY = 0.0;
  double _iconPositionMax = 300.0;
  int _colorIndex = 0;

  List<Color> _colors = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.pink
  ];

  @override
  Widget build(BuildContext context) {
    title = args?["title"];
    _lampColor = args?["color"];
    _colorIndex = _colors.indexOf(_lampColor);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back(result: {"color":_lampColor});
        }, icon: Icon(Icons.arrow_back)),

      ),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10),
                child: 
                  Text(title ?? "", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10, right: 10),
                child: Text("by ggggg"),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 30),
                child: Stack(
                  children: [
                    Positioned(
                      top: 130,
                      child: SizedBox(
                        width: 240,
                        height: 350,
                        child: CustomPaint(
                          painter: TrapezoidClipper(color: _lampColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Image.asset(
                          "images/floor_lamp.png",
                          width: 200,
                          height: 500,
                        ),
                    ),
                   
                  ],
                ),
              ),
              Spacer(),
              Column(
                children: 
                _colors.asMap().entries.map((e) {
                  return IconButton(
                      onPressed: () {
                        setState(() {
                          _colorIndex = e.key;
                          _lampColor = e.value;
                        });
                      },
                      icon: Icon(
                        _colorIndex == e.key ? Icons.check_circle : Icons.circle,
                        color: e.value,
                      ));
                }).toList(),
                
              ),
              Spacer(),
              // Stack(children: [
              //   Container(
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 10, right: 10),
              //       child: SizedBox(
              //         width: 50,
              //         height: _iconPositionMax,
              //         child: CustomPaint(
              //           painter: OvalPainter(color: _lampColor.withOpacity(_colorOpacity)),
              //         ),
              //       ),
              //     ),
              //   ),
              //   Positioned(
              //     top: _iconPositionY,//.clamp(0, _iconPositionMax),
              //     left: 0,
              //     child: GestureDetector(
              //       child: Icon(Icons.circle, size: 70,),
              //       onVerticalDragUpdate: (details) {
              //         print(details.delta.dy);

              //         setState(() {
              //           _iconPositionY += details.delta.dy;
              //           _colorOpacity =
              //               (_iconPositionY / _iconPositionMax).clamp(0, 1);
              //         });
              //       },
              //     ),
              //   ),
              // ]),
            ],
          )
        ],
      )),
    );
  }
}

class TrapezoidClipper extends CustomPainter {

  final Color color;
  TrapezoidClipper({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width * 0.2, 0);
    path.lineTo(size.width * 0.8, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // 创建线性渐变对象
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [color, color.withOpacity(0)],
    );

    // 创建一个Shader对象，用于将渐变应用到绘制区域
    final shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    // 创建一个Paint对象，用于设置绘制的样式，并将Shader应用到Paint上
    final paint = Paint()
   ..shader = shader
   ..style = PaintingStyle.fill;

    // 使用canvas绘制路径，传入路径和Paint对象
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OvalPainter extends CustomPainter {
  final Color color;
  OvalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color // 设置椭圆的填充颜色
      ..style = PaintingStyle.fill; // 设置绘制样式为填充

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(size.width / 2),
      // center: Offset(size.width / 2, size.height / 2),
      // width: size.width,
      // height: size.height,
    );
    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
