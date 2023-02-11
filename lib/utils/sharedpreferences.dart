import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class SharedPreference extends ChangeNotifier {
  final String firstLaunchKey = 'firstLaunch';
  static const String loggedIn = 'isLoggedIn';
  static const String userInfoKey = 'userInfoKey';
  final String emailKey = 'emailKey';
  final String passwordKey = 'password';
  final String tokenKey = 'token';
  final String nameKey = 'name';
  final String pinKey = 'pin';

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

  /// cache app first launch
  void saveIsLoggedIn(bool id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setBool(loggedIn, id);
    notifyListeners();
  }
  /// get app first launch
  Future<bool> getIsLoggedIn() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getBool(loggedIn) ?? false;
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

  /// cache user email
  void savePassword(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(passwordKey, id);
    notifyListeners();
  }
  /// get user email
  Future<String> getPassword() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(passwordKey) ?? '';
  }

  /// cache user name
  void saveFulName(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(nameKey, id);
    notifyListeners();
  }

  /// get user email
  Future<String> getFullName() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(nameKey) ?? '';
  }

  /// cache user name
  void savePin(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(pinKey, id);
    notifyListeners();
  }

  /// get user email
  Future<String> getPin() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(pinKey) ?? '';
  }
}
