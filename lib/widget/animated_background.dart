import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AnimationProps {
  Color1,
  Color2,
}

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tweens = MultiTween<AnimationProps>()
      ..add(
          AnimationProps.Color1,
          ColorTween(begin: Color(0xffD38312), end: Colors.lightBlue.shade900),
          Duration(seconds: 3))
      ..add(
          AnimationProps.Color2,
          ColorTween(begin: Color(0xffA83279), end: Colors.blue.shade600),
          Duration(seconds: 3));

    return MirrorAnimation<MultiTweenValues<AnimationProps>>(
      tween: tweens, // Pass in tween
      duration:
          tweens.duration, // Pass in total duration obtained from MultiTween
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                value.get(AnimationProps.Color1),
                value.get(AnimationProps.Color2)
              ],
            ),
          ),
        );
      },
    );
  }
}
