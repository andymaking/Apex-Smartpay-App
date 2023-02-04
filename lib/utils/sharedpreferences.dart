import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class SharedPreference extends ChangeNotifier {
  final String tokenKey = 'token';
  final String firstLaunchKey = 'firstLaunch';
  final String emailKey = 'emailKey';


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

  /// cache app first launch
  void saveAppFirstLaunch(bool id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setBool(firstLaunchKey, id);
    notifyListeners();
  }
  /// get app first launch
  Future<bool> getAppFirstLaunch() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getBool(firstLaunchKey) ?? false;
  }

  /// cache user email
  void saveEmail(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(emailKey, id);
    notifyListeners();
  }
  /// get user email
  Future<String> getEmail() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(emailKey) ?? '';
  }


}