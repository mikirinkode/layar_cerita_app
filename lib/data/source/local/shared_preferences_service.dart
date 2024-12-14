import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  static const String keyIsLoggedIn = "is_logged_in";
  static const String keyToken = "token";

  SharedPreferencesService({required SharedPreferences preferences})
      : _preferences = preferences;

  Future<bool> getIsLoggedIn() async {
    return _preferences.getBool(keyIsLoggedIn) ?? false;
  }

  Future<void> setIsLoggedIn(bool isLoggedIn) async {
    await _preferences.setBool(keyIsLoggedIn, isLoggedIn);
  }

  Future<String?> getToken() async {
    return _preferences.getString(keyToken);
  }

  Future<void> setToken(String token) async {
    await _preferences.setString(keyToken, token);
  }
}
