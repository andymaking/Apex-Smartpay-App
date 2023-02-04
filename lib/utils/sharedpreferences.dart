import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class SharedPreference extends ChangeNotifier {
  final String tokenKey = 'token';
  final String firstLaunch = 'firstLaunch';


  // clear shared preferences
  Future<void> clear() async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.clear();
  }


  /// cache token
  void saveToken(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(tokenKey, id);
    notifyListeners();
  }
  /// get user token
  Future<String> getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(tokenKey) ?? '';
  }

  /// cache token
  void saveAppFirstLaunch(bool id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setBool(firstLaunch, id);
    notifyListeners();
  }
  /// get user token
  Future<bool> getAppFirstLaunch() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getBool(firstLaunch) ?? false;
  }


}
