import 'package:shared_preferences/shared_preferences.dart';

class AuthLogState {
  static late final SharedPreferences prefs;
  static final String loginKey = 'isUserLogIn';

  static Future<void> sharedPrefsInit() async {
    prefs = await SharedPreferences.getInstance();
    print('SharedPrefs Init');
  }

  static Future<void> saveLoginStatus(bool state) async {
    await prefs.setBool(loginKey, state);
  }

  static Future<bool> getLoginState() async {
    return prefs.getBool(loginKey) ?? false;
  }
}