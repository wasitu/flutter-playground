import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import 'curve_painter.dart';

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  AnimatedWave({required this.height, required this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: height,
          width: constraints.biggest.width,
          child: LoopAnimation(
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween<double>(begin: 0.0, end: 2 * pi),
            builder: (context, child, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter((value as double) + offset),
              );
            },
          ),
        );
      },
    );
  }
}
