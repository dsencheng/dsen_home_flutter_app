import 'package:flutter/material.dart';

import '../../utils/random_utils.dart';

class PersonnalWidget extends StatefulWidget {
  const PersonnalWidget({super.key});

  @override
  State<PersonnalWidget> createState() => _PersonnalWidgetState();
}

class _PersonnalWidgetState extends State<PersonnalWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('个人中心'),
          ),
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
            childCount:
                20, // Adjust this to the number of items you want to display
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio:
                1.0, // Adjust this to control the aspect ratio of your tiles
          ),
        ),
      ]
    );
  }
}