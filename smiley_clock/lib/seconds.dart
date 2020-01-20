import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Seconds extends StatelessWidget {
  Seconds({
    Key key,
    @required AnimationController controller,
    @required this.animation,
    @required this.noseSize,
    @required this.secondsSize,
    this.timeHour,
    this.timeMins,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;
  final Animation<double> animation;
  final double noseSize;
  final double secondsSize;
  final String timeHour;
  final String timeMins;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 20,
          top: 20,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.brown,
              shape: BoxShape.circle,
            ),
            width: noseSize,
            height: noseSize,
            child: Align(
              child: Text(
                '$timeHour:$timeMins',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0x00222222),
            shape: BoxShape.circle,
          ),
          width: noseSize + 40,
          height: noseSize + 40,
          child: AnimatedBuilder(
            animation: _controller,
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  width: secondsSize,
                  height: secondsSize,
                ),
              ],
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: animation.value + pi / 2,
                child: child,
              );
            },
          ),
        ),
      ],
    );
  }
}
