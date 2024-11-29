import 'package:flutter/material.dart';
import '../extension/theme_extension.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard(
      {super.key,
      required this.toggleDeviceState,
      required this.title,
      required this.iconName,
      required this.isActive});
  final String title;
  final String iconName;
  final bool isActive;
  final VoidCallback toggleDeviceState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        // constraints: BoxConstraints(
        //   minWidth: 0,
        //   maxWidth: double.infinity,
        // ),
        padding: EdgeInsets.all(10),
        // margin: EdgeInsets.all(10),
        // height: 150,
        // width: 150,
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.light_mode,
              color: isActive ? Colors.orange : Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 30,
                  color: Colors.orange.withOpacity(0.8),
                )
              ],
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: isActive
                      ? Theme.of(context).largeTitleColor
                      : Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.power_settings_new,
                  color: isActive ? Colors.orange : Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 30,
                      color: Colors.orange.withOpacity(0.8),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
