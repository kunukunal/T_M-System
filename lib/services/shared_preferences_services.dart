import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  static Future<bool> setStringData({String? key, String? value}) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    return await sharedPreferencesinstance.setString(key!, value!);
  }

  static Future<bool> setIntData({String? key, int? value}) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    return await sharedPreferencesinstance.setInt(key!, value!);
  }

  static Future<bool> setBoolData({String? key, bool? value}) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    return await sharedPreferencesinstance.setBool(key!, value!);
  }

  static Future<bool> setDoubleData({String? key, double? value}) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    return await sharedPreferencesinstance.setDouble(key!, value!);
  }

  static Future<String?> getStringData({String? key}) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    return sharedPreferencesinstance.getString(key!);
  }

  static Future<int?> getIntData({String? key}) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    return sharedPreferencesinstance.getInt(key!);
  }

  static Future<bool?> getBoolData({String? key}) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    return sharedPreferencesinstance.getBool(key!);
  }

  static Future<double?> getDoubleData({String? key}) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    return sharedPreferencesinstance.getDouble(key!);
  }

  static Future<bool?> removeData({String? key}) async {
    SharedPreferences sharedPreferencesinstance =
        await SharedPreferences.getInstance();
    return sharedPreferencesinstance.remove(key!);
  }

  static Future clearSharedPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
