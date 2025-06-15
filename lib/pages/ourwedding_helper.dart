import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

Widget fadeTilt(Widget child,
    {Offset offset = const Offset(15, 20),
    required Widget Function(Widget)? animation}) {
  final animatedChild = animation?.call(child) ?? child;
  return TiltParallax(size: offset, child: animatedChild);
}

// Shortcut animasi
Widget Function(Widget) get fadeInDown => (child) => FadeInDown(child: child);
Widget Function(Widget) get fadeInLeft => (child) => FadeInLeft(child: child);
Widget Function(Widget) get fadeInRight => (child) => FadeInRight(child: child);
Widget Function(Widget) get fadeInUp => (child) => FadeInUp(child: child);
Widget Function(Widget) get fadeIn => (child) => FadeIn(child: child);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

List<Widget> buildDecorationElementsBehind(double lebarLayar) {
  double getScale(double small, double medium, double large) {
    return lebarLayar /
        (lebarLayar < 350
            ? small
            : lebarLayar < 414
                ? medium
                : large);
  }

  Widget buildImage({
    required String assetPath,
    required double scale,
    bool flipX = false,
    bool flipY = false,
    double angle = 0,
    Offset parallax = const Offset(10, 10),
  }) {
    Widget img = Image.asset(assetPath, scale: scale, fit: BoxFit.cover);
    if (flipX || flipY)
      img = Transform.flip(flipX: flipX, flipY: flipY, child: img);
    if (angle != 0) img = Transform.rotate(angle: angle, child: img);
    return FadeInDown(
      child: TiltParallax(
        size: parallax,
        child: img,
      ),
    );
  }

  return [
    // Top Right Leaf
    Positioned(
      top: lebarLayar < 350 ? 40 : 50,
      right: lebarLayar < 350 ? -100 : -120,
      child: buildImage(
        assetPath: 'assets/weddingassets/outline_leaf_gold.png',
        scale: getScale(90, 130, 150),
        flipY: true,
        angle: pi / 2,
        parallax: const Offset(20, 20),
      ),
    ),

    // Top Right Splash
    Positioned(
      top: lebarLayar < 350 ? 15 : 25,
      right: lebarLayar < 350 ? -20 : -50,
      child: buildImage(
        assetPath: 'assets/weddingassets/splash_gold_topleft.png',
        scale: getScale(100, 150, 200),
        flipX: true,
        parallax: const Offset(10, 10),
      ),
    ),

    // Bottom Left Leaf
    Positioned(
      bottom: lebarLayar < 350 ? 40 : 50,
      left: lebarLayar < 350 ? -100 : -120,
      child: buildImage(
        assetPath: 'assets/weddingassets/outline_leaf_gold.png',
        scale: getScale(90, 130, 150),
        flipX: true,
        angle: pi / 2,
        parallax: const Offset(5, 20),
      ),
    ),

    // Top Left Splash
    Positioned(
      top: -10,
      left: -50,
      child: buildImage(
        assetPath: 'assets/weddingassets/splash_gold_topleft.png',
        scale: lebarLayar < 350
            ? 3
            : lebarLayar < 414
                ? 2.5
                : 2,
        parallax: const Offset(30, 10),
      ),
    ),

    // Bottom Left Splash
    Positioned(
      bottom: -10,
      left: -20,
      child: buildImage(
        assetPath: 'assets/weddingassets/splash_gold_bottomleft.png',
        scale: getScale(100, 150, 200),
        parallax: const Offset(10, 10),
      ),
    ),

    // Bottom Right Splash
    Positioned(
      bottom: -20,
      right: -60,
      child: buildImage(
        assetPath: 'assets/weddingassets/splash_gold_topleft.png',
        scale: getScale(100, 150, 200),
        flipX: true,
        parallax: const Offset(30, 10),
      ),
    ),
  ];
}

Widget buildImage({
  required String assetPath,
  required double scale,
  bool flipX = false,
  bool flipY = false,
  double angle = 0,
  Offset parallax = const Offset(10, 10),
}) {
  Widget img = Image.asset(assetPath, scale: scale, fit: BoxFit.cover);
  if (flipX || flipY)
    img = Transform.flip(flipX: flipX, flipY: flipY, child: img);
  if (angle != 0) img = Transform.rotate(angle: angle, child: img);
  return FadeInDown(
    child: TiltParallax(
      size: parallax,
      child: img,
    ),
  );
}

double getScale(double small, double medium, double large, double lebarLayar) {
  return lebarLayar /
      (lebarLayar < 350
          ? small
          : lebarLayar < 414
              ? medium
              : large);
}

double getScalePC(
    double small, double medium, double large, double lebarLayar) {
  return lebarLayar /
      (lebarLayar < 850
          ? small
          : lebarLayar < 950
              ? medium
              : large);
}

List<Widget> buildFlowerDecorations(double lebarLayar) {
  return [
    // Flower Top Right
    Positioned(
      top: lebarLayar < 350 ? -60 : -130,
      right: lebarLayar < 350 ? 40 : 80,
      child: buildImage(
        assetPath: 'assets/weddingassets/flower_bottomleft.png',
        scale: getScale(50, 110, 150, lebarLayar),
        flipY: true,
        angle: pi / 2,
        parallax: const Offset(5, 20),
      ),
    ),

    // Flower Bottom Left
    Positioned(
      bottom: lebarLayar < 350
          ? -60
          : lebarLayar < 414
              ? -120
              : -150,
      left: lebarLayar < 350
          ? 40
          : lebarLayar < 414
              ? 80
              : 100,
      child: buildImage(
        assetPath: 'assets/weddingassets/flower_topright.png',
        scale: getScale(50, 110, 150, lebarLayar),
        flipY: true,
        angle: pi / 2,
        parallax: const Offset(5, 20),
      ),
    ),
  ];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

List<Widget> buildFlowerDecorationsOuter(double lebarLayar) {
  return [
    // Flower Top Right
    Positioned(
      top: lebarLayar < 350 ? -60 : -130,
      right: lebarLayar < 350 ? 40 : 80,
      child: buildImage(
        assetPath: 'assets/weddingassets/flower_bottomleft.png',
        scale: getScale(50, 110, 150, lebarLayar),
        flipY: true,
        angle: pi / 2,
        parallax: const Offset(5, 20),
      ),
    ),

    // Flower Bottom Left
    Positioned(
      bottom: lebarLayar < 350
          ? -60
          : lebarLayar < 414
              ? -120
              : -150,
      left: lebarLayar < 350
          ? 40
          : lebarLayar < 414
              ? 80
              : 100,
      child: buildImage(
        assetPath: 'assets/weddingassets/flower_topright.png',
        scale: getScale(50, 110, 150, lebarLayar),
        flipY: true,
        angle: pi / 2,
        parallax: const Offset(5, 20),
      ),
    ),
  ];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

List<Widget> buildFlowerDecorationsOuterPC(double lebarLayar) {
  return [
    // Flower Top Right
    Positioned(
      // top: lebarLayar < 350 ? -60 : -130,
      // right: lebarLayar < 350 ? 40 : 80,
      // top: lebarLayar < 850
      //     ? -80
      //     : lebarLayar < 950
      //         ? -70
      //         : -100,
      // right: lebarLayar < 850
      //     ? 90
      //     : lebarLayar < 950
      //         ? -10
      //         : -20,
      top: 0,
      right: 0,
      child: buildImage(
        assetPath: 'assets/weddingassets/flower_bottomleft.png',
        // scale: getScalePC(180, 250, 300, lebarLayar),
        scale: 5,
        flipY: true,
        angle: pi / 2,
        parallax: const Offset(5, 20),
      ),
    ),

    // Flower Bottom Left
    Positioned(
      // bottom: lebarLayar < 350
      //     ? -60
      //     : lebarLayar < 414
      //         ? -120
      //         : -150,
      // left: lebarLayar < 350
      //     ? 40
      //     : lebarLayar < 414
      //         ? 80
      //         : 100,
      bottom: 0,
      left: 0,
      child: buildImage(
        assetPath: 'assets/weddingassets/flower_topright.png',
        // scale: getScale(50, 110, 150, lebarLayar),
        scale: 5,
        flipY: true,
        angle: pi / 2,
        parallax: const Offset(5, 20),
      ),
    ),
  ];
}
