import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_explorer/generated/i18n.dart';
import 'package:flutter_file_explorer/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  static const navigationName = '/splash';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SystemUiOverlayStyle _overlayStyle;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _overlayStyle = SystemUiOverlayStyle.light.copyWith(
//      statusBarBrightness: Theme.of(context).primaryColorBrightness,
////      statusBarBrightness: ThemeData.estimateBrightnessForColor(Theme.of(context).primaryColor),
//      statusBarIconBrightness: Theme.of(context).primaryColorBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Theme.of(context).accentColor, //系统导航栏（虚拟按键）背景色
      systemNavigationBarIconBrightness: ThemeData.estimateBrightnessForColor(Theme.of(context).accentColor) == Brightness.dark ? Brightness.light : Brightness.dark,

    );
    //修改主题后，需要在app的第一个页面设置状态栏。
//    SystemChrome.setSystemUIOverlayStyle(_overlayStyle);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: InkWell(
            onTap: () {
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