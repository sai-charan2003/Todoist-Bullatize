import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;

  static const String _apiKey = "apiKey";

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }


  static Future<void> setTODOISTKey(String apiKey) async {
    await _preferences?.setString(_apiKey, apiKey);
  }

  static Future<void> clearAll() async {
    await _preferences?.clear();
  }

  static String? getTODOISTKey() {
    return _preferences?.getString(_apiKey);
  }
}