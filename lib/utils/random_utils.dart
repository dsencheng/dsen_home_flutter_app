import 'dart:math';

import 'package:flutter/material.dart';

class RandomUtils {
  static final Random _random = Random();

  static int getRandomInt(int max) {
    return _random.nextInt(max);
  }

  static double getRandomDouble(double max) {
    return _random.nextDouble() * max;
  }

  static List getRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(length, (index) => chars[getRandomInt(chars.length)]);
  }

  static Color get getRandomColor {
    return Color.fromARGB(
      getRandomInt(255),
      getRandomInt(255),
      getRandomInt(255),
      getRandomInt(255),
    );
  }
}