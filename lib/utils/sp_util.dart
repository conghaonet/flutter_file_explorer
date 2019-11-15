import 'app_shared_preferences.dart';

class SpUtil {
  static String searchHistory = 'searchHistory';
  static String userName = 'userName';
  static String gitHubAuthorizationBasic = 'gitHubAuthorizationBasic';
  static String gitHubAuthorizationToken = 'gitHubAuthorizationToken';
  static String themeIndex = 'themeIndex';
  static String language = 'language';
  static String userEntity = 'userEntity';

  static List<String> getSearchHistory() => appSP.getStringList(searchHistory);
  static Future<bool> setSearchHistory(List<String> value) => appSP.setStringList(searchHistory, value);
  static Future<bool> removeSearchHistory() => appSP.remove(searchHistory);

  static String getUserName() => appSP.getString(userName);
  static Future<bool> setUserName(String value) => appSP.setString(userName, value);

  static String getGitHubAuthorizationBasic() => appSP.getString(gitHubAuthorizationBasic);
  static Future<bool> setGitHubAuthorizationBasic(String value) => appSP.setString(gitHubAuthorizationBasic, value);

  static String getGitHubAuthorizationToken() => appSP.getString(gitHubAuthorizationToken);
  static Future<bool> setGitHubAuthorizationToken(String value) => appSP.setString(gitHubAuthorizationToken, value);

  static int getThemeIndex() => appSP.getInt(themeIndex);
  static Future<bool> setThemeIndex(int value) => appSP.setInt(themeIndex, value);

  static String getLanguage() => appSP.getString(language);
  static Future<bool> setLanguage(String value) => appSP.setString(language, value);

}