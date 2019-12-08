import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_explorer/generated/i18n.dart';
import 'package:flutter_file_explorer/pages/home_page.dart';
import 'package:flutter_file_explorer/utils/sp_util.dart';
import 'package:flutter_file_explorer/utils/theme_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
            RaisedButton(
              onPressed: () {
                SpUtil.getThemeMode();
                Navigator.pushReplacementNamed(context, HomePage.navigationName);
              },
              child: Text(
                S.current.appTitle,
              ),
            ),
            RaisedButton(
              onPressed: () async {
                try {
                  GoogleSignInAccount account = await _googleSignIn.signIn();
                  Fluttertoast.showToast(msg: account?.email ?? '登陆失败！');
                } catch (error) {
                  print(error);
                }
              },
              child: Text('Google singin',
              ),
            ),
            RaisedButton(
              onPressed: () async {
                try {
                  await _googleSignIn.signOut();
                  Fluttertoast.showToast(msg: 'Logout');
                } catch (error) {
                  print(error);
                }
              },
              child: Text('Google signout',
              ),
            ),
            RaisedButton(
              onPressed: () async {
                final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
                final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

                final AuthCredential credential = GoogleAuthProvider.getCredential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken,
                );

                final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
                Fluttertoast.showToast(msg: "signed in " + user.displayName);
                print("signed in " + user.displayName);
              },
              child: Text('FirebaseAuth',),
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