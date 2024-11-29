import 'package:flutter/material.dart';

import '../utils/random_utils.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({super.key});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: RandomUtils.getRandomColor,
      height: RandomUtils.getRandomDouble(100),
    );
  }
}