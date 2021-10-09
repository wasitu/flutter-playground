import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AnimationProps {
  color1,
  color2,
}

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tweens = MultiTween<AnimationProps>()
      ..add(
          AnimationProps.color1,
          ColorTween(
              begin: const Color(0xffD38312), end: Colors.lightBlue.shade900),
          const Duration(seconds: 3))
      ..add(
          AnimationProps.color2,
          ColorTween(begin: const Color(0xffA83279), end: Colors.blue.shade600),
          const Duration(seconds: 3));

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
                value.get(AnimationProps.color1),
                value.get(AnimationProps.color2)
              ],
            ),
          ),
        );
      },
    );
  }
}
