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
  final DateTime _datetime;
  final TextPainter _hourTextPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.rtl,
  );

  ClockPainter(this._datetime);

  @override
  void paint(Canvas canvas, Size size) {
    //表盘半径
    final radius = min(size.width, size.height) / 2;
    //圆周长
    final double circumference = 2 * radius * pi;
    //表边框宽度
    final double borderWidth = radius / 20;

    canvas.translate(size.width /2, size.height /2);

    //绘制表盘边框
    Paint borderPaint = Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = borderWidth;
    canvas.drawCircle(Offset(0,0), radius, borderPaint);

    final double minutePointWidth = circumference / 180;
    final double minuteBigPointWidth = circumference / 120;
    final double minutePointRadius = (radius - borderWidth - minuteBigPointWidth);
    _paintMinutePoints(canvas, minutePointRadius, minutePointWidth, minuteBigPointWidth);

    final double numberRadius = minutePointRadius - minuteBigPointWidth * 2.5;
    final double hourTextHeight = _paintHourText(canvas, numberRadius, radius / 50 * 8);

    _paintHourHand(canvas, numberRadius - hourTextHeight, radius / 20);
    _paintMinuteHand(canvas, numberRadius - hourTextHeight / 2, radius / 40);
    _paintSecondHand(canvas, numberRadius + hourTextHeight / 2, radius / 80);

    //绘制中心圆点
    canvas.drawPoints(PointMode.points, [Offset(0, 0)], Paint()..strokeWidth=(radius / 10)..strokeCap=StrokeCap.round..color=Colors.yellow);
    canvas.drawPoints(PointMode.points, [Offset(0, 0)], Paint()..strokeWidth=(radius / 15)..strokeCap=StrokeCap.round);
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
    Paint minutePointPaint = Paint()..color=Colors.white..strokeWidth=pointWidth..strokeCap=StrokeCap.round;
    canvas.drawPoints(PointMode.points, _minutePoints, minutePointPaint);

    Paint minuteBigPointPaint = Paint()..color=Colors.white..strokeWidth=bigPointWidth..strokeCap=StrokeCap.round;
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

      _hourTextPainter.text = TextSpan(text: '$intHour', style: TextStyle(fontSize: fontSize),);
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
    final hourHandPaint = Paint()..color = Colors.blue..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  /// 绘制分针
  void _paintMinuteHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.minute - 15.0;
    Offset handOffset = Offset(cos(getRadians(angle * 6.0)) * radius, sin(getRadians(angle * 6.0)) * radius);
    final hourHandPaint = Paint()..color = Colors.green..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  /// 绘制秒针
  void _paintSecondHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.second - 15.0;
    Offset handOffset = Offset(cos(getRadians(angle * 6.0)) * radius, sin(getRadians(angle * 6.0)) * radius);
    final hourHandPaint = Paint()..color = Colors.red..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
//    return (this.datetime.second != oldDelegate.datetime.second
//        || this.datetime.minute != oldDelegate.datetime.minute
//        || this.datetime.hour != oldDelegate.datetime.hour);
    return _datetime != oldDelegate._datetime;
  }

  static double getRadians(double angle) {
    return angle * pi / 180;
  }
}