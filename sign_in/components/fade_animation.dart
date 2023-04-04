import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double? delay;
  final Widget? child;

  const FadeAnimation({super.key, this.delay, this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(
        AniProps.opacity,
        Tween(begin: 0.0, end: 1.0),
         begin: Duration(milliseconds: 500),
        end: Duration(milliseconds: 500),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      )
      ..tween(
        AniProps.translateY,
        Tween(begin: -30.0, end: 0.0),
        begin: Duration(milliseconds: 500),
        end: Duration(milliseconds: 500),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );

    return PlayAnimationBuilder(
      delay: Duration(milliseconds: (500 * delay!).round()),
      duration: tween.duration,
      tween: tween,
      child: child!,
      builder: (context, child, animation) => Opacity(
        opacity: 0.5,
        child:
            Transform.translate(offset: Offset(0, 50), child: child as Widget),
      ),
    );
  }
}