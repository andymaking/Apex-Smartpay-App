import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// A class for managing sessions, handles saving and retrieving of data
class SessionManager {
  SessionManager();

  SharedPreferences? sharedPreferences;

  Future<void> initilize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String token = 'token';
  static const String refresh = 'refresh';
  static const String loggedin = 'isLoggedIn';
  static const String userInfoKey = 'userInfoKey';

  bool? get hasUser => null;

  String get authToken => sharedPreferences?.getString(token) ?? '';

  set authToken(String authToken) =>
      sharedPreferences?.setString(token, authToken);

  String get authRefreshToken => sharedPreferences?.getString(refresh) ?? '';

  set authRefreshToken(String refreshToken) =>
      sharedPreferences?.setString(refresh, refreshToken);

  bool get isLoggedIn => sharedPreferences?.getBool(loggedin) ?? false;

  set isLoggedIn(bool login) => sharedPreferences?.setBool(loggedin, login);

  set userInfo(Map<String, dynamic>? map) =>
      sharedPreferences?.setString(userInfoKey, json.encode(map));

  Map<String, dynamic> get userInfo => _isfound(userInfoKey)
      ? json.decode(sharedPreferences?.getString(userInfoKey) ?? '')
      : {};

  bool _isfound(String key) => sharedPreferences?.containsKey(key) ?? false;

  Future<bool> logOut() async => await sharedPreferences!.clear();
}
