import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static  SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool>? putData({required String key, required bool value}) {
    return sharedPreferences?.setBool(key, value);
  }

  static dynamic getData({required String key}) {
    return sharedPreferences?.get(key);

  }
  static String? getString({required String key}) {
    return sharedPreferences?.getString(key);
  }
  static Future<bool?> removeData({required String key}) async {
    return await sharedPreferences?.remove(key);
  }
  static Future<bool?> putBoolean({
    required String key,
    required bool value,
  }) async {return await sharedPreferences?.setBool(key, value);}


  static Future<bool?> saveData({required String key, required dynamic value}) async {
    if (sharedPreferences != null) {
      if (value != null) {
        if (value is String) {
          return await sharedPreferences?.setString(key, value);
        } else if (value is bool) {
          return await sharedPreferences?.setBool(key, value);
        } else if (value is int) {
          return await sharedPreferences?.setInt(key, value);
        }
        return await sharedPreferences?.setDouble(key, value);
      }}
  }}