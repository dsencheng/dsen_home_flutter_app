import 'package:flutter/material.dart';
import '../extension/theme_extension.dart';

class DeviceCard extends StatefulWidget {
  DeviceCard(
      {super.key,
      this.tapCardEvent,
      required this.title,
      required this.iconName,
      required this.isActive,
      this.foregroundColor = Colors.orange,});
  final String title;
  final String iconName;
  bool isActive;
  VoidCallback? tapCardEvent;
  Color foregroundColor;

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.tapCardEvent,
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
          color: widget.isActive ? Colors.white : Colors.black,
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
              color: widget.isActive ? widget.foregroundColor : Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 30,
                  color: widget.foregroundColor.withOpacity(0.8),
                )
              ],
            ),
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 18,
                  color: widget.isActive
                      ? Theme.of(context).largeTitleColor
                      : Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isActive = !widget.isActive;
                    });
                  },
                  icon: Icon(Icons.power_settings_new,
                  color: widget.isActive ? widget.foregroundColor : Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 30,
                      color: widget.foregroundColor.withOpacity(0.8),
                    )
                  ],)
                  
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
