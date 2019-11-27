import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_explorer/generated/i18n.dart';
import 'package:flutter_file_explorer/pages/home_page.dart';
import 'package:flutter_file_explorer/utils/sp_util.dart';
import 'package:flutter_file_explorer/utils/theme_util.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:analog_clock/analog_clock_painter.dart';
//import 'package:flutter_file_explorer/widgets/analog_clock.dart';
//import 'package:flutter_file_explorer/widgets/analog_clock_painter.dart';

class SplashPage extends StatefulWidget {
  static const navigationName = '/splash';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final List<String> hourNumbers = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII'];
//  final List<String> hourNumbers = ['', '', '3', '', '', '6', '', '', '9', '', '', '12'];
  Timer _timer;
  DateTime _dateTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //修改主题后，需要在app的第一个页面设置状态栏。
    SystemChrome.setSystemUIOverlayStyle(ThemeUtil.getSystemUiOverlayStyle(context));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                SpUtil.getThemeMode();
                Navigator.pushReplacementNamed(context, HomePage.navigationName);
              },
              child: Text(
                S.current.appTitle,
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.zero,
                child: CustomPaint(
                  painter: AnalogClockPainter(
                    DateTime.now(),
                    dialPlateColor: Colors.white,
                    borderColor: Colors.blue,
                    hourHandColor: Colors.blue[900],
                    minuteHandColor: Colors.purple[900],
                    secondHandColor: Colors.red[900],
                    tickColor: Colors.purple[900],
                    numberColor: Colors.red[900],
                    centerPointColor: Colors.green[900],
//                    showBorder: false,
//                    showTicks: false,
//                    showMinuteHand: false,
//                    showSecondHand: false,
//                    showNumber: false,
//                    hourNumbers: hourNumbers,
//                    borderWidth: 50,
                  ),
//                child: Container(
//                  width: 350,
//                  height: 350,
//                  child: Text('Clock'),
//                ),
//                size: Size(200.0, 200.0),
                ),
              ),
            ),
            Container(
//              color: Colors.blue[200],
//              width: 300,
//              height: 200,
              child: AnalogClock(
                width: 200,
                height: 200,
                dateTime: DateTime(2019, 1, 1, 18, 22, 45),
                isLive: true,
                dialPlateColor: Colors.white,
                borderColor: Colors.blue,
                hourHandColor: Colors.blue[900],
                minuteHandColor: Colors.purple[900],
                secondHandColor: Colors.red[900],
                tickColor: Colors.purple[900],
                numberColor: Colors.red[900],
                centerPointColor: Colors.green[900],
//                    showBorder: false,
//                    showTicks: false,
//                    showMinuteHand: false,
//                    showSecondHand: false,
//                    showNumber: false,
//                    hourNumbers: hourNumbers,
//                    borderWidth: 50,
              ),
            ),
//            Container(
//              color: Colors.blue[200],
//              child: CustomPaint(
//                painter: ClockPainter2(DateTime.now(),
//                    numberColor: Colors.black,
//                    handColor: Colors.black,
//                    borderColor: Colors.black,
//                    radius: 150),
//                size: Size(150.0 * 2, 150.0 * 2),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}