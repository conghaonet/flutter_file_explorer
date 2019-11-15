import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_explorer/generated/i18n.dart';
import 'package:flutter_file_explorer/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  static const navigationName = '/splash';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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