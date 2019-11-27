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
  static const List<String> defaultHourNumbers = ['1','2','3','4','5','6','7','8','9','10','11','12'];
  final DateTime _datetime;
  final Color dialPlateColor;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color numberColor;
  final Color borderColor;
  final Color minutePointColor;
  final Color centerPointColor;
  final List<String> hourNumbers;
  final bool showBorder;
  final bool showTicks;
  final bool showMinuteHand;
  final bool showSecondHand;
  final bool showNumber;
  final TextPainter _hourTextPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  ClockPainter(this._datetime,
      {this.dialPlateColor = Colors.transparent,
        this.hourHandColor = Colors.black,
        this.minuteHandColor = Colors.black,
        this.secondHandColor = Colors.black,
        this.numberColor = Colors.black,
        this.borderColor = Colors.black,
        this.minutePointColor = Colors.black,
        this.centerPointColor = Colors.black,
        this.showBorder = true,
        this.showTicks = true,
        this.showMinuteHand = true,
        this.showSecondHand = true,
        this.showNumber = true,
        this.hourNumbers = defaultHourNumbers,
      }) : assert(hourNumbers == null || hourNumbers.length==12);

  @override
  void paint(Canvas canvas, Size size) {
    //clock radius
    final radius = min(size.width, size.height) / 2;
    //clock circumference
    final double circumference = 2 * radius * pi;
    final double borderWidth = showBorder ? radius / 20.0 : 0.0;

    canvas.translate(size.width /2, size.height /2);

    canvas.drawCircle(Offset(0,0), radius, Paint()..style=PaintingStyle.fill..color=dialPlateColor);

    // border style
    if(showBorder) {
      Paint borderPaint = Paint()
        ..color = this.borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..isAntiAlias = true;
      canvas.drawCircle(Offset(0,0), radius, borderPaint);
    }

    // setup minute point
    final double minutePointWidth = circumference / 180;
    final double minuteBigPointWidth = circumference / 120;
    final double minutePointRadius = (radius - borderWidth - minuteBigPointWidth);
    if(showTicks) _paintMinutePoints(canvas, minutePointRadius, minutePointWidth, minuteBigPointWidth);

    // setup numbers
    final double numberRadius = minutePointRadius - minuteBigPointWidth * 2.5;
    double hourTextHeight = radius / 50 * 8;
    if(showNumber) {
      hourTextHeight = _paintHourText(canvas, numberRadius, hourTextHeight);
    }

    _paintHourHand(canvas, numberRadius - hourTextHeight, radius / 20);
    if(showMinuteHand) _paintMinuteHand(canvas, numberRadius, radius / 40);
    if(showSecondHand) _paintSecondHand(canvas, numberRadius + hourTextHeight / 2, radius / 80);

    //draw center point
    canvas.drawPoints(PointMode.points, [Offset(0, 0)], Paint()..strokeWidth=(radius / 10)..strokeCap=StrokeCap.round..color=this.centerPointColor);
//    canvas.drawPoints(PointMode.points, [Offset(0, 0)], Paint()..strokeWidth=(radius / 15)..strokeCap=StrokeCap.round);
  }

  /// 绘制分钟圆点
  void _paintMinutePoints(Canvas canvas, double radius, double pointWidth, double bigPointWidth) {
    List<Offset> _minutePoints = [];
    List<Offset> _minuteBigPoints = [];
    for (var i = 0; i < 60; i++) {
      double _angle = i * 6.0;
      if(i % 5 !=0) {
        double x = cos(getRadians(_angle)) * radius;
        double y = sin(getRadians(_angle)) * radius;
        _minutePoints.add(Offset(x, y));
      } else {
        double x = cos(getRadians(_angle)) * radius;
        double y = sin(getRadians(_angle)) * radius;
        _minuteBigPoints.add(Offset(x, y));
      }
    }
    Paint minutePointPaint = Paint()..color=this.minutePointColor..strokeWidth=pointWidth..strokeCap=StrokeCap.round;
    canvas.drawPoints(PointMode.points, _minutePoints, minutePointPaint);

    Paint minuteBigPointPaint = Paint()..color=this.minutePointColor..strokeWidth=bigPointWidth..strokeCap=StrokeCap.round;
    canvas.drawPoints(PointMode.points, _minuteBigPoints, minuteBigPointPaint);
  }
  /// 绘制小时数字（1 - 12）
  double _paintHourText(Canvas canvas, double radius, double fontSize) {
    double maxTextHeight = 0;
    for (var i = 0; i < 12; i++) {
      double _angle = i * 30.0;
      canvas.save();
      double hourNumberX = cos(getRadians(_angle)) * radius;
      double hourNumberY = sin(getRadians(_angle)) * radius;
      canvas.translate(hourNumberX, hourNumberY);
      int intHour = i + 3;
      if(intHour > 12) intHour = intHour - 12;

      String hourText = hourNumbers[intHour-1];
      _hourTextPainter.text = TextSpan(text: hourText, style: TextStyle(fontSize: fontSize, color: this.numberColor),);
      _hourTextPainter.layout();
      if(_hourTextPainter.height > maxTextHeight) maxTextHeight = _hourTextPainter.height;
      _hourTextPainter.paint(canvas, Offset(-_hourTextPainter.width / 2, -_hourTextPainter.height / 2));
      canvas.restore();
    }
    return maxTextHeight;
  }
  /// 绘制时针
  void _paintHourHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.hour % 12 + _datetime.minute / 60.0 - 3;
    Offset handOffset = Offset(cos(getRadians(angle * 30)) * radius, sin(getRadians(angle * 30)) * radius);
    final hourHandPaint = Paint()..color = this.hourHandColor..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  /// 绘制分针
  void _paintMinuteHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.minute - 15.0;
    Offset handOffset = Offset(cos(getRadians(angle * 6.0)) * radius, sin(getRadians(angle * 6.0)) * radius);
    final hourHandPaint = Paint()..color = this.minuteHandColor..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  /// 绘制秒针
  void _paintSecondHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.second - 15.0;
    Offset handOffset = Offset(cos(getRadians(angle * 6.0)) * radius, sin(getRadians(angle * 6.0)) * radius);
    final hourHandPaint = Paint()..color = this.secondHandColor..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
    return _datetime != oldDelegate._datetime
        || dialPlateColor != oldDelegate.dialPlateColor
        || hourHandColor != oldDelegate.hourHandColor
        || numberColor != oldDelegate.numberColor
        || borderColor != oldDelegate.borderColor
        || minutePointColor != oldDelegate.minutePointColor
        || centerPointColor != oldDelegate.centerPointColor
        || showMinuteHand != oldDelegate.showMinuteHand
        || showSecondHand != oldDelegate.showSecondHand;
  }

  static double getRadians(double angle) {
    return angle * pi / 180;
  }
}