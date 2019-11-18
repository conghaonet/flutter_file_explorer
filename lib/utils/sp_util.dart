import 'app_shared_preferences.dart';

class SpUtil {
  static const String _darkMode = 'darkMode';
  static const String _themeColorIndex = 'themeColorIndex';
  static const String _accentColorIndex = 'accentColorIndex';

  static bool isDarkMode() => appSP.getBool(_darkMode) ?? false;
  static Future<bool> setDarkMode(bool isDark) => appSP.setBool(_darkMode, isDark);

  static int getThemeColorIndex() => appSP.getInt(_themeColorIndex) ?? -1;
  static Future<bool> setThemeColorIndex(int colorIndex) => appSP.setInt(_themeColorIndex, colorIndex);

  static int getAccentColorIndex() => appSP.getInt(_accentColorIndex) ?? -1;
  static Future<bool> setAccentColorIndex(int colorIndex) => appSP.setInt(_accentColorIndex, colorIndex);
}