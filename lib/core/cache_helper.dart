import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late final SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveBool(bool flag) async {
    return await prefs.setBool('introduction', flag);
  }

  static bool? getBool (String key) {
    return prefs.getBool(key);
  }
}
