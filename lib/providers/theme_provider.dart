import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_explorer/utils/sp_util.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = SpUtil.getThemeMode();
  int _themeColorIndex = SpUtil.getThemeColorIndex();
  int _accentColorIndex = SpUtil.getAccentColorIndex();

  ThemeMode get themeMode => this._themeMode;
  int get themeColorIndex => this._themeColorIndex;
  int get accentColorIndex => this._accentColorIndex;


  Future setThemeMode(ThemeMode mode) async {
    this._themeMode = mode;
    await SpUtil.setThemeMode(this._themeMode);
    notifyListeners();
    return Future;
  }
  Future setThemeColorIndex(int colorIndex) async {
    this._themeColorIndex = colorIndex;
    await SpUtil.setThemeColorIndex(this._themeColorIndex);
    notifyListeners();
    return Future;
  }
  Future setAccentColorIndex(int colorIndex) async {
    this._accentColorIndex = colorIndex;
    await SpUtil.setAccentColorIndex(this._accentColorIndex);
    notifyListeners();
    return Future;
  }
}