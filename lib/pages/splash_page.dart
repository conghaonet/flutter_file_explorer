import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_explorer/generated/i18n.dart';
import 'package:flutter_file_explorer/pages/home_page.dart';
import 'package:flutter_file_explorer/utils/sp_util.dart';
import 'package:flutter_file_explorer/utils/theme_util.dart';
import 'package:flutter_file_explorer/widgets/clock.dart';
import 'package:flutter_file_explorer/widgets/clock_painter.dart';

class SplashPage extends StatefulWidget {
  static const navigationName = '/splash';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final List<String> hourNumbers = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII'];
//  final List<String> hourNumbers = ['', '', '3', '', '', '6', '', '', '9', '', '', '12'];
  Timer _timer;
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
              height: 250,
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.zero,
                child: CustomPaint(
                  painter: ClockPainter(
                    DateTime.now(),
                    dialPlateColor: Colors.white,
                    hourHandColor: Colors.blue[900],
                    minuteHandColor: Colors.purple[900],
                    secondHandColor: Colors.red[900],
                    numberColor: Colors.red[900],
                    borderColor: Colors.yellow[900],
                    minutePointColor: Colors.purple[900],
                    centerPointColor: Colors.green[900],
//                    showBorder: false,
//                    showTicks: false,
//                    showMinuteHand: false,
//                    showSecondHand: false,
//                    showNumber: false,
//                    hourNumbers: hourNumbers,
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
            CustomPaint(
              painter: ClockPainter2(DateTime.now(),
                  numberColor: Colors.black,
                  handColor: Colors.black,
                  borderColor: Colors.black,
                  radius: 150),
              size: Size(150.0 * 2, 150.0 * 2),
            ),
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