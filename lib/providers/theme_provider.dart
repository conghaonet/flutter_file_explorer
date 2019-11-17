import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => this._isDark;

  void updateTheme(bool isDark) {
    this._isDark = isDark;
    notifyListeners();
  }

}