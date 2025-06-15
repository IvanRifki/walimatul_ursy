import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';

class WeddingDecorationOverlay extends StatelessWidget {
  final double? lebarLayar;
  final List<Widget> children;

  const WeddingDecorationOverlay({
    Key? key,
    this.lebarLayar,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double w = lebarLayar ?? MediaQuery.of(context).size.width;

    return Center(
      child: Tilt(
        shadowConfig: const ShadowConfig(disable: true),
        childLayout: ChildLayout(
          behind: [
            _buildLeafTopRight(w),
            _buildLeafBottomLeft(w),
            _buildSplashBottomLeft(w),
            _buildSplashTopRight(w),
            _buildFlowerBottomLeft(w),
            _buildFlowerTopRight(w),
          ],
          outer: children,
        ),
        child: Container(),
      ),
    );
  }

  Widget _buildLeafTopRight(double w) {
    return Positioned(
      top: 10,
      right: 0,
      child: FadeInRight(
        child: TiltParallax(
          size: const Offset(10, 15),
          child: Transform.flip(
            flipX: true,
            child: Image.asset(
              'assets/weddingassets/outline_leaf_gold.png',
              scale: w /
                  (w < 350
                      ? 60
                      : w < 414
                          ? 80
                          : 100),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeafBottomLeft(double w) {
    return Positioned(
      bottom: 10,
      left: 0,
      child: FadeInLeft(
        child: TiltParallax(
          size: const Offset(10, 15),
          child: Image.asset(
            'assets/weddingassets/outline_leaf_gold.png',
            scale: w /
                (w < 350
                    ? 60
                    : w < 414
                        ? 80
                        : 100),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSplashBottomLeft(double w) {
    return Positioned(
      bottom: 10,
      left: 0,
      child: FadeInLeft(
        child: TiltParallax(
          size: const Offset(20, 20),
          child: Image.asset(
            'assets/weddingassets/splash_gold_bottomleft.png',
            scale: w /
                (w < 350
                    ? 90
                    : w < 414
                        ? 150
                        : 200),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSplashTopRight(double w) {
    return Positioned(
      top: 10,
      right: 0,
      child: FadeInRight(
        child: TiltParallax(
          size: const Offset(20, 20),
          child: Transform.flip(
            flipX: true,
            child: Image.asset(
              'assets/weddingassets/splash_gold_topleft.png',
              scale: w /
                  (w < 350
                      ? 90
                      : w < 414
                          ? 110
                          : 160),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFlowerBottomLeft(double w) {
    return Positioned(
      bottom: 10,
      left: 0,
      child: FadeInLeft(
        child: TiltParallax(
          size: const Offset(5, 20),
          child: Image.asset(
            'assets/weddingassets/flower_bottomleft.png',
            scale: w /
                (w < 350
                    ? 50
                    : w < 414
                        ? 70
                        : 90),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildFlowerTopRight(double w) {
    return Positioned(
      top: 10,
      right: 0,
      child: FadeInRight(
        child: TiltParallax(
          size: const Offset(5, 20),
          child: Transform.flip(
            flipX: true,
            flipY: true,
            child: Image.asset(
              'assets/weddingassets/flower_bottomleft.png',
              scale: w /
                  (w < 350
                      ? 50
                      : w < 414
                          ? 70
                          : 90),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
