import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ClockEye extends StatelessWidget {
  ClockEye({
    Key key,
    @required AnimationController controller,
    @required this.animation,
    @required this.eyeBallSize,
    @required this.pupilSize,
    @required this.pupilGlossSize,
    this.time,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;
  final Animation<double> animation;
  final double eyeBallSize;
  final double pupilSize;
  final double pupilGlossSize;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //color: Colors.blue,
        decoration: BoxDecoration(
//          gradient: RadialGradient(colors: [
//            Color(0xFF2336C4),
//            Color(0xFF4758D7),
//          ]),
          color: Color(0xFF4758D7),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(0.0, 0.0),
              spreadRadius: eyeBallSize * 2 / 100,
              blurRadius: eyeBallSize * .2 / 100,
            )
          ],
        ),
        width: eyeBallSize,
        height: eyeBallSize,
        child: AnimatedBuilder(
            animation: _controller,
            child: Padding(
              padding: EdgeInsets.all(eyeBallSize * 2 / 100),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    height: pupilSize,
                    width: pupilSize,
                    child: Padding(
                      padding: EdgeInsets.all(eyeBallSize * 2 / 100),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF98A4FF),
                              shape: BoxShape.circle,
                            ),
                            width: pupilGlossSize,
                            height: pupilGlossSize,
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Text(
//                                      time,
//                                      style: TextStyle(
//                                          color: Colors.black26,
//                                          fontSize: 50,
//                                          fontWeight: FontWeight.bold),
//                                    ),
//                                  ],
//                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: animation.value,
                child: child,
              );
            }),
      ),
    );
  }
}
