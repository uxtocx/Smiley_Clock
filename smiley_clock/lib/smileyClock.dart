import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'smileSeconds.dart';
import 'clockEye.dart';

class SmileyClock extends StatefulWidget {
  const SmileyClock(this.model);

  final ClockModel model;

  @override
  _SmileyClockState createState() => _SmileyClockState();
}

class _SmileyClockState extends State<SmileyClock>
    with TickerProviderStateMixin {
  AnimationController _hourController;
  AnimationController _minuteController;
  AnimationController _secondsController;
  Animation<double> _hourAnimation;
  Animation<double> _minuteAnimation;
  Animation<double> _secondsAnimation;
  DateTime _dateTime = DateTime.now();
  Timer _hourTimer;
  Timer _minuteTimer;
  Timer _secondsTimer;
  double _hour;
  double clockHour;
  double _minute;
  double clockMinute;
  double _seconds;
  double clockSeconds;
  Tween<double> _hourTween;
  Tween<double> _minuteTween;
  Tween<double> _secondsTween;
  String _temperature = '';
  String _temperatureRange = '';
  String _condition = '';
  String _location = '';

  double getHourRadian() {
    return _hour * 0.524;
  }

  double getMinuteRadian() {
    return _minute * 0.104;
  }

  double getSecondsRadian() {
    return _seconds * 0.104;
  }

//  void _incrementCounter() {
//    _hourTween.begin = _hourTween.end;
//    _hourController.reset();
//    _hour = _hour + 1;
//    _hourTween.end = getHourRadian();
//    _hourController.value = 0;
//    _hourController.forward();
//  }

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);

    _seconds = 0;
    _secondsController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _secondsTween = Tween(begin: 2.5, end: 3.75);
    _secondsAnimation = _secondsTween.animate(_secondsController);
    _secondsController.repeat(reverse: true);

    _hourController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    clockHour = double.parse(DateFormat('HH').format(_dateTime));
    _hour = clockHour;
    print('currenHour = $_hour');
    _hourTween = Tween(begin: 0.524 * _hour, end: getHourRadian());
    _hourAnimation = _hourTween.animate(_hourController);
    _updateHour();

    _minuteController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    clockMinute = double.parse(DateFormat('mm').format(_dateTime));
    _minute = clockMinute;
    print('curren minute = $_minute');
    _minuteTween = Tween(begin: 0.104 * _minute, end: getMinuteRadian());
    _minuteAnimation = _minuteTween.animate(_minuteController);
    _updateMinute();
    _updateModel();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      print('temperature = $_temperature');
      _temperatureRange = '(${widget.model.low} - ${widget.model.highString})';
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  String _updateWeatherIcon(String weather) {
    switch (weather) {
      case 'sunny':
        return weather = 'assets/sunny.png';
        break;
      case 'cloudy':
        return weather = 'assets/cloudy.png';
        break;
      case 'foggy':
        return weather = 'assets/foggy.png';
        break;
      case 'rainy':
        return weather = 'assets/rainy.png';
        break;
      case 'snowy':
        return weather = 'assets/snowy.png';
        break;
      case 'thunderstorm':
        return weather = 'assets/thunderstorm.png';
        break;
      default:
        return weather = 'assets/cloudy.png';
    }
  }

  void _updateHourModel() {
    _hourTween.begin = _hourTween.end;
    _hourController.reset();
    _hour = _hour + 1;
    _hourTween.end = getHourRadian();
    _hourController.value = 0;
    _hourController.forward();
    _updateHour();
  }

  void _updateMinuteModel() {
    _minuteTween.begin = _minuteTween.end;
    _minuteController.reset();
    _minute = _minute + 1;
    _minuteTween.end = getMinuteRadian();
    //print(getMinuteRadian());
    _minuteController.value = 0;
    _minuteController.forward();
    _updateMinute();
  }

  void _updateHour() {
    _dateTime = DateTime.now();
    _hourTimer = Timer(
      Duration(hours: 1) -
          Duration(minutes: _dateTime.minute) -
          Duration(seconds: _dateTime.second) -
          Duration(milliseconds: _dateTime.millisecond),
      _updateHourModel,
    );

    setState(() {
      clockHour = double.parse(DateFormat('HH').format(_dateTime));
    });
  }

  void _updateMinute() {
    _dateTime = DateTime.now();
    _minuteTimer = Timer(
      Duration(minutes: 1) -
          Duration(seconds: _dateTime.second) -
          Duration(milliseconds: _dateTime.millisecond),
      _updateMinuteModel,
    );
    print('minute =$_minute');
    setState(() {
      clockMinute = double.parse(DateFormat('mm').format(_dateTime));
    });
  }

  @override
  void didUpdateWidget(SmileyClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _minuteTimer?.cancel();
    _secondsTimer?.cancel();
    _hourTimer?.cancel();
    _hourController.dispose();
    _minuteController.dispose();
    _secondsController.dispose();
    _secondsAnimation.isDismissed;
    _hourAnimation.isDismissed;
    _minuteAnimation.isDismissed;
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var hourToDisplay =
        (clockHour > 12 ? clockHour - 12 : clockHour).floor().toString();
    print(clockHour);
    print(hourToDisplay);
    var minuteToDisplay = (clockMinute > 59 ? clockMinute - 60 : clockMinute)
        .floor()
        .toString()
        .padLeft(2, '0');
    //print('hour:$_hour');
    //print(_minuteTween.begin);
    // print(_minuteTween.end);
    print(_secondsTween.begin);
    print(_secondsTween.end);
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    var width = screenWidth / 2.25;
    //var height = screenHeight / 2.25;
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: AspectRatio(
          aspectRatio: 5 / 3,
          child: Stack(
            children: <Widget>[
//background
              Container(color: Colors.blueGrey[900]),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Colors.blueGrey[800],
                    height: screenHeight * 20 / 100,
                  )),
//Face
              Container(
                width: screenWidth,
                height: screenHeight,
                child: Image.asset('assets/SmileyFace.png'),
              ),
//Eyes
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, width * 10 / 100, 0, width * 40 / 100),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: SizedBox(width: 50),
                    ),
                    Expanded(
                      flex: 5,
                      child: ClockEye(
                        controller: _hourController,
                        animation: _hourAnimation,
                        eyeBallSize: width,
                        pupilSize: width * 60 / 100,
                        pupilGlossSize: width * 20 / 100,
                        //time: hourToDisplay,
                        time: '',
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ClockEye(
                        controller: _minuteController,
                        animation: _minuteAnimation,
                        eyeBallSize: width,
                        pupilSize: width * 60 / 100,
                        pupilGlossSize: width * 20 / 100,
                        //time: minuteToDisplay,
                        time: '',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(width: 50),
                    ),
                  ],
                ),
              ),
//Mouth Seconds
              Positioned(
                left:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? screenWidth / 2 - (width * 90 / 100) / 2
                        : screenWidth / 2 - (width * 105 / 100) / 2,
                top: MediaQuery.of(context).orientation == Orientation.landscape
                    ? screenHeight * 28 / 100
                    : screenHeight * 15 / 100,
                child: SmileSeconds(
                  secondsController: _secondsController,
                  secondsAnimation: _secondsAnimation,
                  secondsSize: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? screenWidth * 40 / 100
                      : screenHeight * 40 / 100,
                  mouthHeight: screenHeight * 20 / 100,
                  mouthWidth: screenWidth * 20 / 100,
                ),
              ),
              Positioned(
                right: 20,
                bottom: 5,
                child: Text(
                  '$hourToDisplay:$minuteToDisplay',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: screenWidth * 8 / 100,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _temperature,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: screenWidth * 3 / 100,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _condition,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: screenWidth * 3 / 100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 18,
                          height: 18,
                          //color: Colors.white,
                          child: Image.asset(_updateWeatherIcon(_condition)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
//          Positioned(
//            left: screenWidth / 2 - (width * 40 / 100) / 2,
//            top: screenHeight * 70 / 100,
//            child: Seconds(
//                controller: _secondsController,
//                animation: _secondsAnimation,
//                noseSize: width * 40 / 100,
//                secondsSize: width * 10 / 100,
//                timeMins: minuteToDisplay,
//                timeHour: hourToDisplay),
//          ),
            ],
          ),
        ),
      ),
//          Positioned(
//            left: screenWidth / 2 - (width * 10 / 100) / 2,
//            top: screenHeight * 68 / 100,
//            child: Container(
//              decoration: BoxDecoration(
//                color: Colors.black,
//                shape: BoxShape.circle,
//              ),
//              width: width * 10 / 100,
//              height: width * 10 / 100,
//            ),
//          )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
