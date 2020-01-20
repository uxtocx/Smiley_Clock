import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:rive/rive.dart';

class SmileSeconds extends StatelessWidget {
  const SmileSeconds({
    Key key,
    @required AnimationController secondsController,
    @required Animation<double> secondsAnimation,
    @required this.mouthHeight,
    @required this.mouthWidth,
    @required this.secondsSize,
  })  : _secondsController = secondsController,
        _secondsAnimation = secondsAnimation,
        super(key: key);

  final AnimationController _secondsController;
  final Animation<double> _secondsAnimation;
  final double mouthHeight;
  final double secondsSize;
  final double mouthWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0x00FFFFFF),
            shape: BoxShape.circle,
          ),
          width: secondsSize,
          height: secondsSize,
          child: AnimatedBuilder(
            animation: _secondsController,
            child: Column(
              children: <Widget>[
                Container(
//                      decoration: BoxDecoration(
//                        color: Colors.amber,
//                        shape: BoxShape.circle,
//                      ),
                  width: mouthWidth,
                  height: mouthHeight,
                  child: Transform.rotate(
                    angle: pi,
                    child: Rive(
                      filename: 'assets/SmileyMouth.flr',
                    ),
                  ),
                ),
              ],
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: _secondsAnimation.value,
                child: child,
              );
            },
          ),
        ),
//        Positioned(
//          left: 180,
//          top: 100,
//          child: Container(
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color: Colors.brown,
//            ),
//            width: 60,
//            height: 60,
//          ),
//        ),
      ],
    );
  }
}
