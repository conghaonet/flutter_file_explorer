import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_explorer/generated/i18n.dart';
import 'package:flutter_file_explorer/pages/home_page.dart';
import 'package:flutter_file_explorer/utils/sp_util.dart';
import 'package:flutter_file_explorer/utils/theme_util.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashPage extends StatefulWidget {
  static const navigationName = '/splash';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  void initState() {
    super.initState();

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
            InkWell(
              onTap: () async {
                try {
                  GoogleSignInAccount account = await _googleSignIn.signIn();
                  print(account?.email);
                } catch (error) {
                  print(error);
                }
              },
              child: Text('Google singin',
              ),
            ),
            InkWell(
              onTap: () async {
                try {
                  GoogleSignInAccount account = await _googleSignIn.signOut();
                  print(account?.email);
                } catch (error) {
                  print(error);
                }
              },
              child: Text('Google signout',
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}