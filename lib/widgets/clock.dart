import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class ClockPainter extends CustomPainter {
  DateTime datetime;
  TextPainter textPainter;
  final double borderWidth = 4;
  final TextPainter hourTextPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.rtl,
  );

  ClockPainter(this.datetime);

  @override
  void paint(Canvas canvas, Size size) {
    datetime = DateTime.now();
    final _radius = min(size.width, size.height) / 2;

    canvas.translate(size.width /2, size.height /2);

    //draw border
    final borderPaint = Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = borderWidth;
    canvas.drawCircle(Offset(0,0), _radius, borderPaint);

    final double _secondRadius = _radius - borderWidth * 3;
    List<Offset> _secondPoints = [];
    List<Offset> _hourPoints = [];

    final _numberRadius = _radius - borderWidth * 8;
    final _hourHandRadius = _numberRadius - borderWidth * 12;

//    _secondPoints.add(Offset(0, 0));
    for (var i = 0; i < 60; i++) {
      double _angle = i * 6.0;
      if(i % 5 !=0) {
        double x = cos(getRadians(_angle)) * _secondRadius;
        double y = sin(getRadians(_angle)) * _secondRadius;
        _secondPoints.add(Offset(x, y));
      } else {
        double x = cos(getRadians(_angle)) * _secondRadius;
        double y = sin(getRadians(_angle)) * _secondRadius;
        _hourPoints.add(Offset(x, y));
      }
    }
    Paint secondPaint = Paint()..color=Colors.white..strokeWidth=4..strokeCap=StrokeCap.round;
    canvas.drawPoints(PointMode.points, _secondPoints, secondPaint);

    Paint hourPaint = Paint()..color=Colors.white..strokeWidth=8..strokeCap=StrokeCap.round;
    canvas.drawPoints(PointMode.points, _hourPoints, hourPaint);
    for (var i = 0; i < 60; i++) {
      double _angle = i * 6.0;
      if(i % 5 ==0) {
        canvas.save();
        double hourNumberX = cos(getRadians(_angle)) * _numberRadius;
        double hourNumberY = sin(getRadians(_angle)) * _numberRadius;
        canvas.translate(hourNumberX, hourNumberY);
        int intHour = (i ~/ 5) + 3;
        if(intHour > 12) intHour = intHour - 12;

        hourTextPainter.text = TextSpan(text: '$intHour', style: TextStyle(fontSize: 24),);
        hourTextPainter.layout();
        hourTextPainter.paint(canvas, Offset(-hourTextPainter.width / 2, -hourTextPainter.height / 2));
        canvas.restore();
      }
    }
    _paintHourHand(canvas, _hourHandRadius);
    _paintMinuteHand(canvas, _hourHandRadius+20);
    _paintSecondHand(canvas, _hourHandRadius+20);

    canvas.drawPoints(PointMode.points, [Offset(0, 0)], Paint()..strokeWidth=12..strokeCap=StrokeCap.round..color=Colors.yellow);
    canvas.drawPoints(PointMode.points, [Offset(0, 0)], Paint()..strokeWidth=8..strokeCap=StrokeCap.round);
  }

  _paintHourHand(Canvas canvas, double radius) {
    double hourAngle = datetime.hour % 12 + datetime.minute / 60.0 - 3;
//    if(hourAngle > 12) hourAngle = hourAngle - 12;
    Offset handOffset = Offset(cos(getRadians(hourAngle * 30)) * radius, sin(getRadians(hourAngle * 30)) * radius);
    final hourHandPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 8;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);

  }
  _paintMinuteHand(Canvas canvas, double radius) {
    double hourAngle = datetime.minute - 15.0;
    Offset handOffset = Offset(cos(getRadians(hourAngle * 6.0)) * radius, sin(getRadians(hourAngle * 6.0)) * radius);
    final hourHandPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 8;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }
  _paintSecondHand(Canvas canvas, double radius) {
    double hourAngle = datetime.second - 15.0;
    Offset handOffset = Offset(cos(getRadians(hourAngle * 6.0)) * radius, sin(getRadians(hourAngle * 6.0)) * radius);
    final hourHandPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
    return (this.datetime.second != oldDelegate.datetime.second
        || this.datetime.minute != oldDelegate.datetime.minute
        || this.datetime.hour != oldDelegate.datetime.hour);
  }

  static double getRadians(double angle) {
    return angle * pi / 180;
  }
}