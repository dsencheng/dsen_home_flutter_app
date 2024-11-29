import 'dart:math';

import 'package:flutter/material.dart';
import '../childWidget/device_card.dart';
import '../childWidget/waterfakk_flow.dart';

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
    return Container(
      child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                        
                        return IntrinsicHeight(
                          child: Container(
                              height: getRandomDouble(),
                              color: Colors.blue,
                              child: Center(
                                  child: Text("A much longer text that should cause the height to increase significantly. This is item $index and we are testing the dynamic height feature in GridView."),
                              ),
                          ),
                        );
                    },
                ),
      // child: WaterfallFlow(
      //     columnCount: 2,
      //     children: List.generate(random.nextInt(255), (index) {
      //       return Container(
      //         // width: MediaQuery.of(context).size.width / 2 - 30,
      //         // height: getRandomDouble() + 30,
      //         color: Color.fromRGBO(random.nextInt(255), random.nextInt(255),
      //             random.nextInt(255), 0.8),
      //       );
      //     })),
    );
  }

  double getRandomDouble() {
    Random random = Random();
    return random.nextDouble() * 100;
  }
}
