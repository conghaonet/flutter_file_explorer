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
  final DateTime datetime;
  TextPainter textPainter;
  final double borderWidth = 4;
  final TextPainter hourTextPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.rtl,
  );

  ClockPainter(this.datetime);

  @override
  void paint(Canvas canvas, Size size) {
    final _radius = min(size.width, size.height) / 2;

    canvas.translate(size.width /2, size.height /2);

    //draw border
    final borderPaint = Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = borderWidth;
    canvas.drawCircle(Offset(0,0), _radius, borderPaint);

    final double _secondRadius = _radius - borderWidth * 3;
    List<Offset> _secondPoints = [];
    List<Offset> _hourPoints = [];

    final _numberRadius = _radius - borderWidth * 8;

    _secondPoints.add(Offset(0, 0));
    for (var i = 0; i < 60; i++) {
      int _angle = i * 6;
      double _radians =  _angle * pi / 180;
      if(i % 5 !=0) {
        double x = cos(_radians) * _secondRadius;
        double y = sin(_radians) * _secondRadius;
        _secondPoints.add(Offset(x, y));
      } else {
        double x = cos(_radians) * _secondRadius;
        double y = sin(_radians) * _secondRadius;
        _hourPoints.add(Offset(x, y));
      }
    }
    Paint secondPaint = Paint()..color=Colors.white..strokeWidth=4..strokeCap=StrokeCap.round;
    canvas.drawPoints(PointMode.points, _secondPoints, secondPaint);

    Paint hourPaint = Paint()..color=Colors.white..strokeWidth=8..strokeCap=StrokeCap.round;
    canvas.drawPoints(PointMode.points, _hourPoints, hourPaint);
    for (var i = 0; i < 60; i++) {
      int _angle = i * 6;
      double _radians =  _angle * pi / 180;
      if(i % 5 ==0) {
        canvas.save();
        double hourNumberX = cos(_radians) * _numberRadius;
        double hourNumberY = sin(_radians) * _numberRadius;
        canvas.translate(hourNumberX, hourNumberY);
        int intHour = (i ~/ 5) + 3;
        if(intHour > 12) intHour = intHour - 12;

        hourTextPainter.text = TextSpan(text: '$intHour', style: TextStyle(fontSize: 24),);
        hourTextPainter.layout();
        hourTextPainter.paint(canvas, Offset(-hourTextPainter.width / 2, -hourTextPainter.height / 2));
        canvas.restore();
      }
    }
    final hour = datetime.hour;
    // draw hour hand
//    Offset hourHand1 = Offset(
//        radius - cos(degToRad(360 / 12 * hour - 90)) * (radius * 0.2),
//        radius - sin(degToRad(360 / 12 * hour - 90)) * (radius * 0.2));
//    Offset hourHand2 = Offset(
//        radius + cos(degToRad(360 / 12 * hour - 90)) * (radius * 0.5),
//        radius + sin(degToRad(360 / 12 * hour - 90)) * (radius * 0.5));
    final hourHandPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 8;
//    canvas.drawLine(hourHand1, hourHand2, hourPaint);
    canvas.drawLine(Offset(0, 0), Offset(0, 50), hourHandPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}