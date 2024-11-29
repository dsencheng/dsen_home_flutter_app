import 'package:flutter/material.dart';

class PlayerButton extends StatelessWidget {
  const PlayerButton({super.key, required this.icon, required this.callback});
  
  final VoidCallback callback;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: icon,
      
    );
  }
}