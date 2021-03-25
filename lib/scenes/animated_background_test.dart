import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/animated_background.dart';
import 'package:flutter_playground/widget/animated_wave.dart';

class AnimatedBackgroundTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned.fill(child: AnimatedBackground()),
          onBottom(
            AnimatedWave(
              height: 180,
              speed: 1.0,
            ),
          ),
          onBottom(
            AnimatedWave(
              height: 120,
              speed: 0.9,
              offset: pi,
            ),
          ),
          onBottom(
            AnimatedWave(
              height: 220,
              speed: 1.2,
              offset: pi / 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 128.0),
            child: Center(
              child: Text(
                'HELLO FLUTTER',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}
