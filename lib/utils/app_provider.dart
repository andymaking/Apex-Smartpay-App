import 'package:flutter/material.dart';
import 'package:Smartpay/theme/theme_config.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  //AppProvider() {}

  ThemeData theme = ThemeConfig.lightTheme;
  Key? key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }

}