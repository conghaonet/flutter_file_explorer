import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_explorer/generated/i18n.dart';
import 'package:flutter_file_explorer/pages/home_page.dart';
import 'package:flutter_file_explorer/utils/sp_util.dart';
import 'package:flutter_file_explorer/utils/theme_util.dart';

class SplashPage extends StatefulWidget {
  static const navigationName = '/splash';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //修改主题后，需要在app的第一个页面设置状态栏。
    SystemChrome.setSystemUIOverlayStyle(ThemeUtil.getSystemUiOverlayStyle(context));
//    FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).primaryColor);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: InkWell(
            onTap: () {
              SpUtil.getThemeMode();
              Navigator.pushNamed(context, HomePage.navigationName);
            },
            child: Text(
              S.current.appTitle,
            ),
          ),
        ),
      ),
    );
  }
}